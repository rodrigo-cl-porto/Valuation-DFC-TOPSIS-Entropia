let
    Source = {pqRefYear-4},
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), type table [ANO=Int64.Type], ExtraValues.Error),
    #"Added CVM Content" = Table.AddColumn(
        #"Converted to Table",
        "CVM_Content",
        each let
            CvmUrl = "https://dados.cvm.gov.br/dados/CIA_ABERTA/DOC/DFP/DADOS/dfp_cia_aberta_",
            ZipFile = Web.Contents(CvmUrl & Text.From([ANO]) & ".zip"),
            UnzippedFile = fxBinaryUnzip(ZipFile)
        in 
            UnzippedFile
        ,
        type table
    ),
    #"Expanded CVM Content" = Table.ExpandTableColumn(#"Added CVM Content", "CVM_Content", {"FileName", "Content"}, {"FileName", "CSV_Content"}),
    #"Filtered Consolidated BSs" = Table.SelectRows(#"Expanded CVM Content", each Text.Contains([FileName], "_BP") and Text.Contains([FileName], "_con_")),
    #"Extracted CSV Content" = Table.TransformColumns(
        #"Filtered Consolidated BSs",
        {{
            "CSV_Content",
            each let
                OpenedFile = Csv.Document(_, [Delimiter=";", Encoding=1252, QuoteStyle=QuoteStyle.None]),
                PromotedHeaders = Table.PromoteHeaders(OpenedFile, [PromoteAllScalars=true]),
                FilteredLatestFiscalYear = Table.SelectRows(PromotedHeaders, each [ORDEM_EXERC] = "ÚLTIMO")
            in 
                FilteredLatestFiscalYear
            ,
            type table
        }}
    ),
    #"Selected Year and Content" = Table.SelectColumns(#"Extracted CSV Content",{"ANO", "CSV_Content"}),
    #"Expanded CSV Content" = Table.ExpandTableColumn(#"Selected Year and Content", "CSV_Content", {"CNPJ_CIA", "VERSAO", "DT_REFER", "DENOM_CIA", "CD_CVM", "DT_FIM_EXERC", "CD_CONTA", "DS_CONTA", "VL_CONTA"}, {"CNPJ_CIA", "VERSAO", "DT_REFER", "DENOM_CIA", "CD_CVM", "DT_FIM_EXERC", "CD_CONTA", "DS_CONTA", "VL_CONTA"}),
    #"Fixed Count Value" = Table.ReplaceValue(#"Expanded CSV Content",".",",",Replacer.ReplaceText,{"VL_CONTA"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Fixed Count Value",{{"ANO", Int64.Type}, {"CNPJ_CIA", type text}, {"VERSAO", Int64.Type}, {"DT_REFER", type date}, {"DENOM_CIA", type text}, {"CD_CVM", type text}, {"DT_FIM_EXERC", type date}, {"CD_CONTA", type text}, {"DS_CONTA", type text}, {"VL_CONTA", Currency.Type}}, "pt-BR"),
    #"Preprocessed Account Description" = Table.TransformColumns(
        #"Changed Type",
        {{
            "DS_CONTA",
            each let
                CleanedText = Text.Clean(_),
                TrimmedText = Text.Trim(CleanedText),
                RemovedPunctuations = fxRemovePunctuation(TrimmedText),
                RemovedAccents = fxRemoveAccents(RemovedPunctuations),
                RemovedStopwords = fxRemoveStopwords(RemovedAccents)
            in
                RemovedStopwords
            ,
            type text
        }}
    ),
    #"Get the Latest Data" = Table.Group(
        #"Preprocessed Account Description",
        {"ANO", "CNPJ_CIA", "DENOM_CIA", "CD_CVM"},
        {{
            "CVM_DATA",
            each let
                MaxDateRefer = List.Max([DT_REFER]),
                LastVersion = List.Max([VERSAO]),
                SelectedRows = Table.SelectRows(_, each [DT_REFER] = MaxDateRefer and [VERSAO]=LastVersion)
            in
                SelectedRows
            ,
            type table [CD_CONTA=nullable text, DS_CONTA=nullable text, VL_CONTA=Currency.Type]
        }}
    ),
    #"Added Financeira?" = Table.AddColumn(
        #"Get the Latest Data",
        "FINANCEIRA?",
        each let
            BufferedTable = Table.Buffer([CVM_DATA]),
            BufferedList = BufferedTable[CD_CONTA]
        in
            if List.ContainsAny(BufferedList, {"1.03", "1.04", "1.05", "1.06", "1.07", "2.04", "2.05", "2.06", "2.07"}) then
                true
            else 
                false
        ,
        type logical
    ),
    #"Expanded CVM Data" = Table.ExpandTableColumn(#"Added Financeira?", "CVM_DATA", {"CD_CONTA", "DS_CONTA", "VL_CONTA"}),
    #"Added NIVEL_CONTA" = Table.AddColumn(#"Expanded CVM Data", "NIVEL_CONTA", each try List.Count(Text.PositionOf([CD_CONTA], ".", Occurrence.All))+1 otherwise null, Int64.Type),
    #"Added Attribute" = Table.AddColumn(
        #"Added NIVEL_CONTA",
        "ATTRIBUTE",
        each if not [#"FINANCEIRA?"] then
            if [CD_CONTA] = "1" then
                "1 ATIVO_TOTAL"
            else if [CD_CONTA] = "1.01" then 
                "1.01 AC" // Ativo Circulante
            else if [CD_CONTA] = "1.01.01" then 
                "1.01.01 CAIXA"
            else if [CD_CONTA] = "1.01.02" then 
                "1.01.02 APLICACOES_FINANCEIRAS"
            else if [CD_CONTA] = "1.01.03" then 
                "1.01.03 CONTAS_RECEBER" // Contas a Receber
            else if [CD_CONTA] = "1.01.04" then 
                "1.01.04 ESTOQUE"
            else if [CD_CONTA] = "1.01.05" then 
                "1.01.05 ATIVO_BIOLOGICO"
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([DS_CONTA], "tributo") and Text.Contains([DS_CONTA], "recuperar") then
                "1.01.06 TRIBUTOS_RECUPERAR"
            else if [CD_CONTA] = "1.01.07" then 
                "1.01.07 DESPESAS_ANTECIPADAS"
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([CD_CONTA], "1.01") and Text.StartsWith([DS_CONTA], "outr") then
                "1.01.08 OUTROS_AC"
            else if [CD_CONTA] = "1.02" then 
                "1.02 ANC" // Ativo Não Circulante
            else if [CD_CONTA] = "1.02.01" then 
                "1.02.01 ATIVO_RLP" // Ativo Realizável no Lonog Prazo
            else if [NIVEL_CONTA] > 3 and Text.StartsWith([DS_CONTA], "tributo") and Text.Contains([DS_CONTA], "diferido") then
                "1.02.01.07 TRIBUTOS_DIFERIDOS"
            else if [CD_CONTA] = "1.02.02" then 
                "1.02.02 INVESTIMENTOS"
            else if [CD_CONTA] = "1.02.03" then 
                "1.02.03 IMOBILIZADO" 
            else if [CD_CONTA] = "1.02.04" then 
                "1.02.04 INTANGIVEL"
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([CD_CONTA], "1.02") and Text.StartsWith([DS_CONTA], "outr") then
                "1.02.05 OUTROS_ANC"
            else if [CD_CONTA] = "2" then
                "2 PASSIVO_TOTAL"
            else if [CD_CONTA] = "2.01" then
                "2.01 PC" // Passico Circulante
            else if [NIVEL_CONTA] = 3 and Text.Contains([DS_CONTA], "obrigac") and Text.Contains([DS_CONTA], "socia") then
                "2.01.01 OBRIGACOES_SOCIAIS_TRABALHISTAS"
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([CD_CONTA], "2.01") and Text.StartsWith([DS_CONTA], "fornecedor") then
                "2.01.02 FORNECEDORES_PC"
            else if [CD_CONTA] = "2.01.03" then
                "2.01.03 OBRIGACOES_FISCAIS"
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([CD_CONTA], "2.01") and Text.Contains([DS_CONTA], "emprestimo") and Text.Contains([DS_CONTA], "financiamento") then
                "2.01.04 DIVIDA_PC"
            //else if [NIVEL_CONTA] = 5 and Text.StartsWith([CD_CONTA], "2.01") and Text.Contains([DS_CONTA], "passivo") and Text.Contains([DS_CONTA], "financeiro") then
            //    "2.01.04 DIVIDA_PC"
            else if Text.StartsWith([CD_CONTA], "2") and [NIVEL_CONTA] = 3 and [DS_CONTA] = "provisoes" then 
                "2.01.06 PROVISOES"
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([CD_CONTA], "2.01") and Text.StartsWith([DS_CONTA], "outr") then
                "2.01.07 OUTROS_PC"
            else if [CD_CONTA] = "2.02" then
                "2.02 PNC" // Passivo Não Circulante
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([CD_CONTA], "2.02") and Text.Contains([DS_CONTA], "emprestimo") and Text.Contains([DS_CONTA], "financiamento") then
                "2.02.01 DIVIDA_PNC"
            //else if [NIVEL_CONTA] = 5 and Text.StartsWith([CD_CONTA], "2.02") and Text.Contains([DS_CONTA], "passivo") and Text.Contains([DS_CONTA], "financeiro") then
            //    "2.02.01 DIVIDA_PNC"
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([CD_CONTA], "2.02") and Text.StartsWith([DS_CONTA], "fornecedor") then
                "2.02.02 FORNECEDORES_PNC"
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([CD_CONTA], "2.02") and Text.StartsWith([DS_CONTA], "outr") then
                "2.02.05 OUTROS_PNC"
            else if [CD_CONTA] = "2.03" then
                "2.03 PATRIMONIO_LIQUIDO"
            else null
        else
            if [CD_CONTA] = "1" then
                "1 ATIVO_TOTAL"
            else if [CD_CONTA] = "1.01" then
                "1.01.01 CAIXA"
            else if [NIVEL_CONTA] = 2 and Text.Contains([DS_CONTA], "ativo") and Text.Contains([DS_CONTA], "financeiro") then
                "1.01.02 APLICACOES_FINANCEIRAS"
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([CD_CONTA], "1.") and Text.Contains([DS_CONTA], "imposto") and (Text.Contains([DS_CONTA], "corrente") or Text.Contains([DS_CONTA], "recupera")) then
                "1.01.06 TRIBUTOS_RECUPERAR"
            else if [CD_CONTA] = "1.04" then
                "1.01.08 OUTROS_AC"
            else if Text.StartsWith([CD_CONTA], "1") and [NIVEL_CONTA] = 2 and Text.StartsWith([DS_CONTA], "adiantament") and Text.Contains([DS_CONTA], "fornecedor") then
                "1.01.09 ADIANTAMENTO_FORNECEDORES"
            else if [NIVEL_CONTA] = 3 and Text.StartsWith([CD_CONTA], "1.") and Text.Contains([DS_CONTA], "imposto") and Text.Contains([DS_CONTA], "diferido") then
                "1.02.01.07 TRIBUTOS_DIFERIDOS"
            else if [CD_CONTA] = "1.05" then 
                "1.02.02 INVESTIMENTOS"
            else if [CD_CONTA] = "1.06" then 
                "1.02.03 IMOBILIZADO"
            else if [CD_CONTA] = "1.07" then 
                "1.02.04 INTANGIVEL"
            else if [CD_CONTA] = "2" then
                "2 PASSIVO_TOTAL"
            else if [NIVEL_CONTA] = 2 and Text.Contains([DS_CONTA], "obrigac") and Text.Contains([DS_CONTA], "socia") then
                "2.01.01 OBRIGACOES_SOCIAIS_TRABALHISTAS"
            else if Text.StartsWith([DS_CONTA], "fornecedor") then 
                "2.01.02 FORNECEDORES_PC"
            else if Text.StartsWith([DS_CONTA], "obrigac") and Text.Contains([DS_CONTA], "fisca") then
                "2.01.03 OBRIGACOES_FISCAIS"
            else if Text.StartsWith([DS_CONTA], "passivo") and Text.Contains([DS_CONTA], "fisca") then
                "2.01.03 OBRIGACOES_FISCAIS"
            else if [NIVEL_CONTA] = 2 and Text.Contains([DS_CONTA], "passivo") and Text.Contains([DS_CONTA], "financeiro") then
                "PASSIVO_FINANCEIRO"
            else if [NIVEL_CONTA] = 2 and [DS_CONTA] = "provisoes" then
                "2.01.06 PROVISOES"
            else if [NIVEL_CONTA] = 2 and Text.StartsWith([DS_CONTA], "outr") then
                "2.01.07 OUTROS_PC"
            else if [NIVEL_CONTA] = 2 and Text.StartsWith([DS_CONTA], "patrimonio liquido") then
                "2.03 PATRIMONIO_LIQUIDO"
            else null
        ,
        type text
    ),
    #"Removed Errors On Attribute" = Table.RemoveRowsWithErrors(#"Added Attribute", {"ATTRIBUTE"}),
    #"Filtered Non Null Attribute" = Table.SelectRows(#"Removed Errors On Attribute", each ([ATTRIBUTE] <> null)),
    #"Removed Columns" = Table.RemoveColumns(#"Filtered Non Null Attribute",{"CD_CONTA", "DS_CONTA", "NIVEL_CONTA", "FINANCEIRA?"}),
    #"Pivoted Column" = Table.Pivot(#"Removed Columns", List.Distinct(#"Removed Columns"[ATTRIBUTE]), "ATTRIBUTE", "VL_CONTA", List.Sum),
    #"Replaced Value" =
    let
        ColumnNames = Table.ColumnNames(#"Pivoted Column"),
        AccountColumnNames = List.RemoveItems(ColumnNames, {"ANO", "CNPJ_CIA", "DENOM_CIA", "CD_CVM"}),
        ReplecedValues = Table.ReplaceValue(#"Pivoted Column",null,0,Replacer.ReplaceValue, AccountColumnNames)
    in 
        ReplecedValues
in
    #"Replaced Value"