let
    Source = {pqRefYear-pqHistoricalRange+1..pqRefYear},
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), type table [ANO=Int64.Type], ExtraValues.Error),
    #"Added CVM Content" = Table.AddColumn(
        #"Converted to Table",
        "CVM_Content",
        each let
            CvmUrl = "https://dados.cvm.gov.br/dados/CIA_ABERTA/DOC/DFP/DADOS/dfp_cia_aberta_",
            ZipFile = Web.Contents(CvmUrl & Text.From([ANO]) & ".zip"),
            UnzippedFile = fxBinaryUnzip(ZipFile)
        in
            UnzippedFile,
        type table
    ),
    #"Expanded CVM Content" = Table.ExpandTableColumn(#"Added CVM Content", "CVM_Content", {"FileName", "Content"}, {"FileName", "CSV_Content"}),
    #"Filtered Consolidated CFS" = Table.SelectRows(#"Expanded CVM Content", each Text.Contains([FileName], "DFC_MI_con")),
    #"Extracted CSV Content" = Table.TransformColumns(
        #"Filtered Consolidated CFS",
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
    #"Filtered Accounts" = Table.SelectRows(#"Changed Type", each List.Contains({"6.01", "6.02", "6.03"}, [CD_CONTA])),
    #"Get the Latest Data" = let
        GroupedRows = Table.Group(
            #"Filtered Accounts",
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
                type table [CD_CONTA=nullable text, DS_CONTA=nullable text, VL_CONTA=Currency.Type]
            }}
        ),
        ExpandedCvmData = Table.ExpandTableColumn(GroupedRows, "CVM_DATA", {"CD_CONTA", "VL_CONTA"}, {"CD_CONTA", "VL_CONTA"})
    in  
        ExpandedCvmData
    ,
    #"Pivoted CD_CONTA" = Table.Pivot(#"Get the Latest Data", {"6.01", "6.02", "6.03"}, "CD_CONTA", "VL_CONTA", List.Sum),
    #"Renamed Columns" = Table.RenameColumns(#"Pivoted CD_CONTA", {{"6.01", "FCO"}, {"6.02", "FCI"}, {"6.03", "FCF"}}),
    #"Added FCFE" = Table.AddColumn(#"Renamed Columns", "FCFE", each [FCO]+[FCI]+[FCF], Currency.Type)
in
    #"Added FCFE"