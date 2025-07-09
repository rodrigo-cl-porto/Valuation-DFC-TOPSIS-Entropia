let
    Source = {pqRefYear-pqHistoricalRange+1..pqRefYear},
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), type table [ANO=Int64.Type], ExtraValues.Error),
    #"Added CVM Content" = Table.AddColumn(
        #"Converted to Table",
        "CVM_Content",
        each let
            CvmUrl = "https://dados.cvm.gov.br/dados/CIA_ABERTA/DOC/DFP/DADOS",
            ZipFile = Web.Contents(CvmUrl & "/dfp_cia_aberta_" & Text.From([ANO]) & ".zip"),
            UnzippedFile = fxBinaryUnzip(ZipFile)
        in 
            UnzippedFile
    ),
    #"Expanded CVM Content" = Table.ExpandTableColumn(#"Added CVM Content", "CVM_Content", {"FileName", "Content"}, {"FileName", "CSV_Content"}),
    #"Filtered Consolidated DRE" = Table.SelectRows(#"Expanded CVM Content", each Text.Contains([FileName], "_DRE_con")),
    #"Extracted CSV Content" = Table.TransformColumns(
        #"Filtered Consolidated DRE",
        {{
            "CSV_Content",
            each let
                OpenedFile = Csv.Document(_, [Delimiter=";", Encoding=1252, QuoteStyle=QuoteStyle.None]),
                PromotedHeaders = Table.PromoteHeaders(OpenedFile, [PromoteAllScalars=true]),
                FilteredLatestFiscalYear = Table.SelectRows(PromotedHeaders, each [ORDEM_EXERC] = "ÚLTIMO")
            in 
                FilteredLatestFiscalYear,
            type table
        }}
    ),
    #"Selected Year and CSV Content" = Table.SelectColumns(#"Extracted CSV Content",{"ANO", "CSV_Content"}),
    #"Expanded CSV Content" = Table.ExpandTableColumn(#"Selected Year and CSV Content", "CSV_Content", {"CNPJ_CIA", "DT_REFER", "VERSAO", "DENOM_CIA", "CD_CVM", "DT_INI_EXERC", "DT_FIM_EXERC", "CD_CONTA", "DS_CONTA", "VL_CONTA"}, {"CNPJ_CIA", "DT_REFER", "VERSAO", "DENOM_CIA", "CD_CVM", "DT_INI_EXERC", "DT_FIM_EXERC", "CD_CONTA", "DS_CONTA", "VL_CONTA"}),
    #"Fixed Count Value" = Table.ReplaceValue(#"Expanded CSV Content",".",",",Replacer.ReplaceText,{"VL_CONTA"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Fixed Count Value",{{"ANO", Int64.Type}, {"CNPJ_CIA", type text}, {"DT_REFER", type date}, {"VERSAO", Int64.Type}, {"DENOM_CIA", type text}, {"CD_CVM", type text}, {"DT_INI_EXERC", type date}, {"DT_FIM_EXERC", type date}, {"CD_CONTA", type text}, {"DS_CONTA", type text}, {"VL_CONTA", Currency.Type}}, "pt-BR"),
    #"Get the Latest Data" = let
        GroupedRows = Table.Group(
            #"Changed Type",
            {"CNPJ_CIA", "DENOM_CIA", "CD_CVM", "ANO"},
            {{
                "CVM_DATA",
                each let
                    MaxDateRefer = List.Max([DT_REFER]),
                    LastVersion = List.Max([VERSAO]),
                    SelectedRows = Table.SelectRows(_, each [DT_REFER] = MaxDateRefer and [VERSAO]=LastVersion)
                in
                    SelectedRows
                ,
                type table [CD_CONTA=text, DS_CONTA=text, VL_CONTA=Currency.Type]
            }}
        ),
        ExpandedCvmData = Table.ExpandTableColumn(GroupedRows, "CVM_DATA", {"CD_CONTA", "DS_CONTA", "VL_CONTA"}, {"CD_CONTA", "DS_CONTA", "VL_CONTA"})
    in
        ExpandedCvmData,
    #"Preprocessed DS_CONTA" = Table.TransformColumns(
        #"Get the Latest Data",
        {{
            "DS_CONTA",
            each let
                LowerCased = Text.Lower(_),
                RemovedPunctuation = fxRemovePunctuation(LowerCased),
                RemovedAccents = fxRemoveAccents(RemovedPunctuation),
                TrimmedText = Text.Trim(RemovedAccents)
            in  
                TrimmedText,
            type text
        }}
    ),
    #"Added Attribute" = Table.AddColumn(
        #"Preprocessed DS_CONTA",
        "ATTRIBUTE",
        each if [CD_CONTA] = "3.01" then
            "3.01 RECEITA_LIQUIDA"
        else if [CD_CONTA] = "3.02" then
            "3.02 CUSTOS"
        else if [CD_CONTA] = "3.03" then
            "3.03 LUCRO_BRUTO"
        else if [CD_CONTA] = "3.04" then
            "3.04 RESULTADO_OPERACIONAL"
        else if Text.StartsWith([DS_CONTA], "resultado") and Text.Contains([DS_CONTA], "resultado financeiro") and Text.Contains([DS_CONTA], "tributo") then
            "3.05 EBIT"
        else if Text.StartsWith([DS_CONTA], "resultado financeiro") then
            "3.06 RESULTADO_FINANCEIRO"
        else if Text.StartsWith([DS_CONTA], "resultado") and Text.Contains([DS_CONTA], "tributo") and Text.Contains([DS_CONTA], "lucro") then
            "3.07 EBT"
        else if Text.StartsWith([DS_CONTA], "imposto") then
            "3.08 IMPOSTOS"
        else if Text.StartsWith([DS_CONTA], "lucro") and Text.Contains([DS_CONTA], "consolidad") then
            "3.09 NOPAT"
        else if Text.Contains([DS_CONTA], "atribu") and Text.Contains([DS_CONTA], "controlador") and not Text.Contains([DS_CONTA], "nao controlador") then
            "3.09.01 LUCRO_LIQUIDO"
        else 
            null,
        type text 
    ),
    #"Removed Errors" = Table.RemoveRowsWithErrors(#"Added Attribute", {"ATTRIBUTE"}),
    #"Filtered Non Null Attribute" = Table.SelectRows(#"Removed Errors", each [ATTRIBUTE] <> null),
    #"Removed Columns" = Table.RemoveColumns(#"Filtered Non Null Attribute", {"CD_CONTA", "DS_CONTA"}),
    #"Pivoted Column" = Table.Pivot(
        #"Removed Columns",
        {"3.01 RECEITA_LIQUIDA", "3.02 CUSTOS", "3.03 LUCRO_BRUTO", "3.04 RESULTADO_OPERACIONAL", "3.05 EBIT", "3.06 RESULTADO_FINANCEIRO", "3.07 EBT", "3.08 IMPOSTOS", "3.09 NOPAT", "3.09.01 LUCRO_LIQUIDO"},
        "ATTRIBUTE",
        "VL_CONTA",
        List.Sum
    ),
    #"Fixed EBIT" = let 
        AddedEbit2 = Table.AddColumn(#"Pivoted Column", "3.05 EBIT_2", each if [#"3.05 EBIT"] = null then [#"3.07 EBT"] else [#"3.05 EBIT"], Currency.Type),
        RemovedEbt = Table.RemoveColumns(AddedEbit2, {"3.05 EBIT"}),
        RenamedEbt2 = Table.RenameColumns(RemovedEbt, {{"3.05 EBIT_2", "3.05 EBIT"}}),
        ReorderedColumns = Table.ReorderColumns(RenamedEbt2, {"3.01 RECEITA_LIQUIDA", "3.02 CUSTOS", "3.03 LUCRO_BRUTO", "3.04 RESULTADO_OPERACIONAL", "3.05 EBIT", "3.06 RESULTADO_FINANCEIRO", "3.07 EBT", "3.08 IMPOSTOS", "3.09 NOPAT", "3.09.01 LUCRO_LIQUIDO"})
    in  
        ReorderedColumns,
    #"Sorted Rows" = Table.Sort(#"Fixed EBIT", {{"CNPJ_CIA", Order.Ascending}, {"ANO", Order.Ascending}}),
    #"Added Average Net Profit" = let
        GroupedRows = Table.Group(
            #"Sorted Rows",
            {"CNPJ_CIA", "DENOM_CIA", "CD_CVM"},
            {
                {"DATA", each _, type table [CNPJ_CIA=text, DENOM_CIA=text, CD_CVM=text, ANO=number, 3.01 RECEITA_LIQUIDA=number, 3.02 CUSTOS=number, 3.03 LUCRO_BRUTO=number, 3.04 RESULTADO_OPERACIONAL=number, 3.05 EBIT=number, 3.06 RESULTADO_FINANCEIRO=nullable number, 3.07 EBT=number, 3.08 IMPOSTOS=number, 3.09 NOPAT=number, 3.09.01 LUCRO_LIQUIDO=number]},
                {
                    "AVERAGE_NET_PROFIT",
                    each let 
                        Profits = [3.09.01 LUCRO_LIQUIDO],
                        ProfitVars = List.Accumulate(
                            {1..List.Count(Profits)-1}, 
                            {},
                            (state as list, i as number) as list => state & {Profits{i}/Profits{i-1} - 1}
                        ),
                        AverageProfit = List.Average(ProfitVars)
                    in  
                        try if List.Contains({Number.PositiveInfinity, Number.NegativeInfinity, null}, AverageProfit) then 0 else if Number.IsNaN(AverageProfit) then 0 else AverageProfit otherwise 0,
                    Percentage.Type
                }
            }
        ),
        ExpandedData = Table.ExpandTableColumn(GroupedRows, "DATA", {"ANO", "3.01 RECEITA_LIQUIDA", "3.02 CUSTOS", "3.03 LUCRO_BRUTO", "3.04 RESULTADO_OPERACIONAL", "3.05 EBIT", "3.06 RESULTADO_FINANCEIRO", "3.07 EBT", "3.08 IMPOSTOS", "3.09 NOPAT", "3.09.01 LUCRO_LIQUIDO"})
    in 
        ExpandedData,
    #"Added Net Margin" = Table.AddColumn(
        #"Added Average Net Profit",
        "NET_MARGIN",
        each if [3.01 RECEITA_LIQUIDA] <> 0 and [3.01 RECEITA_LIQUIDA] <> null then
            if [3.01 RECEITA_LIQUIDA] > 0 then
                [3.09.01 LUCRO_LIQUIDO] / [3.01 RECEITA_LIQUIDA]
            else if [3.09.01 LUCRO_LIQUIDO] > 0 then
                -3 * Number.Abs([3.09.01 LUCRO_LIQUIDO] / [3.01 RECEITA_LIQUIDA])
            else
                -5 * Number.Abs([3.09.01 LUCRO_LIQUIDO] / [3.01 RECEITA_LIQUIDA])
        else if [3.05 EBIT] <> 0 and [3.05 EBIT] <> null then
            if [3.05 EBIT] > 0 then
                [3.09.01 LUCRO_LIQUIDO] / [3.05 EBIT]
            else if [3.09.01 LUCRO_LIQUIDO] > 0 then
                -3 * Number.Abs([3.09.01 LUCRO_LIQUIDO] / [3.05 EBIT])
            else
                -5 * Number.Abs([3.09.01 LUCRO_LIQUIDO] / [3.05 EBIT])
        else 
            null,
        Percentage.Type
    )
in
    #"Added Net Margin"