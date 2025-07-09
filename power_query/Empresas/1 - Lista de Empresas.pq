let
    Source = Web.Contents("https://dados.cvm.gov.br/dados/CIA_ABERTA/DOC/FRE/DADOS/fre_cia_aberta_" & Text.From(pqRefYear) & ".zip"),
    UnzippedFile = fxBinaryUnzip(Source),
    #"Selected CSV File" = UnzippedFile{[FileName="fre_cia_aberta_" & Text.From(pqRefYear) & ".csv"]}[Content],
    #"Opened CSV File" = 
    let 
        OpenedFile = Csv.Document(#"Selected CSV File", [Delimiter=";", Encoding=1252, QuoteStyle=QuoteStyle.None]),
        PromotedHeaders = Table.PromoteHeaders(OpenedFile, [PromoteAllScalars=true])
    in 
        PromotedHeaders
    ,
    #"Changed Type" = Table.TransformColumnTypes(#"Opened CSV File",{{"CNPJ_CIA", type text}, {"DT_REFER", type date}, {"VERSAO", Int64.Type}, {"DENOM_CIA", type text}, {"CD_CVM", type text}, {"CATEG_DOC", type text}, {"ID_DOC", Int64.Type}, {"DT_RECEB", type date}, {"LINK_DOC", type text}}),
    #"Got the Latest Data" = 
    let 
        GroupedRows = Table.Group(
            #"Changed Type",
            {"CNPJ_CIA"},
            {{
                "DATA",
                each Table.Max(_, {"DT_REFER", "VERSAO"}),
                type [CNPJ_CIA=nullable text, DT_REFER=nullable date, VERSAO=nullable number, DENOM_CIA=nullable text, CD_CVM=nullable text, CATEG_DOC=nullable text, ID_DOC=nullable number, DT_RECEB=nullable date, LINK_DOC=nullable text]
            }}
        ),
        ExpandedData = Table.ExpandRecordColumn(GroupedRows, "DATA", {"DT_REFER", "DENOM_CIA", "CD_CVM"}, {"YEAR", "DENOM_CIA", "CD_CVM"})
    in 
        ExpandedData,
    #"Extracted Year" = Table.TransformColumns(#"Got the Latest Data",{{"YEAR", Date.Year, Int64.Type}}),
    #"Got BVMF Data" = Table.AddColumn(
        #"Extracted Year",
        "DATA",
        each let 
            Source = Web.Page(Web.Contents("https://bvmf.bmfbovespa.com.br/pt-br/mercados/acoes/empresas/ExecutaAcaoConsultaInfoEmp.asp?CodCVM=" & [CD_CVM] & "&ViewDoc=1&AnoDoc=" & Text.From(pqRefYear))),
            Data0 = Source{0}[Data],
            ExtractedRecord = Record.FromList(List.FirstN(Data0[Column2], 5), {"PREGAO", "CODEMP", "CNPJ_CIA", "ATIVIDADE", "SETOR"})
        in
            try ExtractedRecord catch (r) => if r[Message] = "The column 'Column2' of the table wasn't found." then "NOT FOUND" else null
        ,
        type [PREGAO=text, CODEMP=text, CNPJ_CIA=text, ATIVIDADE=text, SETOR=text]
    ),
    #"Removed Null Records" = Table.SelectRows(#"Got BVMF Data", each [DATA] <> "NOT FOUND"),
    #"Expanded DATA" = Table.ExpandRecordColumn(#"Removed Null Records", "DATA", {"CODEMP", "SETOR"}, {"CODEMP", "SECTOR"}),
    #"Splitted Sector" = Table.SplitColumn(#"Expanded DATA", "SECTOR", Splitter.SplitTextByDelimiter(" / ", QuoteStyle.Csv), {"SECTOR", "SUBSECTOR", "SEGMENT"}),
    #"Preprocessed Columns" = fxPreprocessTextColumns(#"Splitted Sector", {"CODEMP", "SECTOR", "SUBSECTOR", "SEGMENT"}, "Upper", null, true, true),
    #"Extracted Code" = Table.TransformColumns(
        #"Preprocessed Columns",
        {{
            "CODEMP",
            each let 
                ExtractedAfterDelimiter = Text.AfterDelimiter(_, " ", 1),
                ExtractedFirstChars = Text.Start(ExtractedAfterDelimiter, 4)
            in 
                ExtractedFirstChars,
            type text
        }}
    ),
    #"Filtered Rows" = Table.SelectRows(#"Extracted Code", each ([CODEMP] <> "" and [CODEMP] <> "NENH"))
in
    #"Filtered Rows"