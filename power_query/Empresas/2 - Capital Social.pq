let
    Source = Web.Contents("https://dados.cvm.gov.br/dados/CIA_ABERTA/DOC/FRE/DADOS/fre_cia_aberta_" & Text.From(pqRefYear) & ".zip"),
    UnzippedFile = fxBinaryUnzip(Source),
    #"Selected CSV Content" = UnzippedFile{[FileName="fre_cia_aberta_capital_social_" & Text.From(pqRefYear) & ".csv"]}[Content],
    ExtractedContent = 
    let
        OpenedFile = Csv.Document(#"Selected CSV Content", [Delimiter=";", Encoding=1252, QuoteStyle=QuoteStyle.None]),
        PromotedHeaders = Table.PromoteHeaders(OpenedFile, [PromoteAllScalars=true])
    in 
        PromotedHeaders
    ,
    #"Fixed Capital Values" = Table.ReplaceValue(ExtractedContent,".",",",Replacer.ReplaceText,{"Valor_Capital"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Fixed Capital Values",{{"CNPJ_Companhia", type text}, {"Data_Referencia", type date}, {"Versao", Int64.Type}, {"ID_Documento", Int64.Type}, {"ID_Capital_Social", Int64.Type}, {"Tipo_Capital", type text}, {"Data_Autorizacao_Aprovacao", type date}, {"Valor_Capital", Currency.Type}, {"Prazo_Integralizacao", type text}, {"Quantidade_Acoes_Ordinarias", Int64.Type}, {"Quantidade_Acoes_Preferenciais", Int64.Type}, {"Quantidade_Total_Acoes", Int64.Type}}),
    #"Added Year" = Table.AddColumn(#"Changed Type", "YEAR", each Date.Year([Data_Referencia]), Int64.Type),
    #"Get the Latest Data" = 
    let 
        GroupedRows = Table.Group(
            #"Added Year",
            {"CNPJ_Companhia"},
            {{
                "DATA",
                each Table.Max(_, {"Data_Referencia", "Versao", "Data_Autorizacao_Aprovacao"}),
                type [Data_Referencia=date, Valor_Capital=Currency.Type, Quantidade_Acoes_Preferenciais=Int64.Type, Quantidade_Acoes_Ordinarias=Int64.Type, Quantidade_Total_Acoes=Int64.Type, YEAR=Int64.Type]
            }}
        ),
        ExpandedData = Table.ExpandRecordColumn(GroupedRows, "DATA", {"YEAR", "Valor_Capital", "Quantidade_Acoes_Ordinarias", "Quantidade_Acoes_Preferenciais", "Quantidade_Total_Acoes"}, {"YEAR", "MARKET_VALUE", "ON", "PN", "QTD_TOTAL"})
    in 
        ExpandedData,
    #"Unpivoted Share Types" = Table.UnpivotOtherColumns(#"Get the Latest Data", {"YEAR", "CNPJ_Companhia", "MARKET_VALUE", "QTD_TOTAL"}, "TYPE_SHARE", "QTD_TYPE_SHARE"),
    #"Filtered Rows" = Table.SelectRows(#"Unpivoted Share Types", each ([QTD_TYPE_SHARE] > 0)),
    #"Merged Queries" = Table.NestedJoin(Excel.CurrentWorkbook(){[Name="tblListaEmpresas"]}[Content], {"CNPJ_CIA", "YEAR"}, #"Filtered Rows", {"CNPJ_Companhia", "YEAR"}, "DADOS", JoinKind.Inner),
    #"Expanded DADOS" = Table.ExpandTableColumn(#"Merged Queries", "DADOS", {"MARKET_VALUE", "QTD_TOTAL", "QTD_TYPE_SHARE", "TYPE_SHARE"}),
    #"Added Ticker" = Table.AddColumn(#"Expanded DADOS", "TICKER", each if [TYPE_SHARE] = "ON" then [CODEMP] & "3" else if [TYPE_SHARE] = "PN" then [CODEMP] & "4" else null, type text),
    #"Added Last Price and Volume" =
    let 
        AddedData = Table.AddColumn(
            #"Added Ticker",
            "YAHOO_FINANCE_DATA",
            each let
                StartUnixTime = Text.From(fxUnixTimeFormat(#datetime(pqRefYear, 1, 1, 0, 0, 0))),
                EndUnixTime = Text.From(fxUnixTimeFormat(#datetime(pqRefYear, 12, 31, 0, 0, 0))),
                DataSource = Csv.Document(Web.Contents("https://query1.finance.yahoo.com/v7/finance/download/" & [TICKER] & ".SA?period1=" & StartUnixTime & "&period2=" & EndUnixTime & "&interval=1mo&events=history&includeAdjustedClose=true"),[Delimiter=",", Columns=7, Encoding=65001, QuoteStyle=QuoteStyle.None]),
                PromotedHeaders = Table.PromoteHeaders(DataSource, [PromoteAllScalars=true]),
                ReplacedToComma = Table.ReplaceValue(PromotedHeaders,".",",",Replacer.ReplaceText,{"Close"}),
                ChangedType = Table.TransformColumnTypes(ReplacedToComma, {{"Date", type date}, {"Close", type number}, {"Volume", Currency.Type}}, "pt-BR"),
                LatestQuotation = Table.Max(ChangedType, {"Date"})
            in
                try LatestQuotation otherwise null,
            type [Date=date, Close=Currency.Type, Volume=Currency.Type]
        ),
        ExpandedRecords = Table.ExpandRecordColumn(AddedData, "YAHOO_FINANCE_DATA", {"Close", "Volume"}, {"LAST_PRICE", "LAST_MONTHLY_VOLUME"})
    in 
        ExpandedRecords,
    #"Removed Null Prices" = Table.SelectRows(#"Added Last Price and Volume", each ([LAST_PRICE] <> null)),
    #"Added Total Share Value" = Table.AddColumn(#"Removed Null Prices", "TOTAL_SHARE_VALUE", each [LAST_PRICE] * [QTD_TYPE_SHARE], Currency.Type),
    #"Grouped Rows" = Table.Group(
        #"Added Total Share Value",
        {"CNPJ_CIA", "YEAR", "DENOM_CIA", "CD_CVM", "CODEMP", "SECTOR", "SUBSECTOR", "SEGMENT"},
        {
            {
                "MARKET_VALUE",
                each if [MARKET_VALUE]{0} = 0 then
                    List.Sum([TOTAL_SHARE_VALUE])
                else 
                    [MARKET_VALUE]{0},
                Currency.Type
            },
            {
                "DATA",
                each _,
                type table [CNPJ_CIA=text, YEAR=Int64.Type, DENOM_CIA=text, CD_CVM=text, CODEMP=text, SECTOR=text, SUBSECTOR=text, SEGMENT=text, MARKET_VALUE=number, QTD_TOTAL=Int64.Type, QTD_TYPE_SHARE=Int64.Type, TYPE_SHARE=text, TICKER=text, LAST_PRICE=Currency.Type, LAST_MONTHLY_VOLUME=Currency.Type, TOTAL_SHARE_VALUE=Currency.Type]
            }
        }
    ),
    #"Expanded DATA" = Table.ExpandTableColumn(#"Grouped Rows", "DATA", {"QTD_TOTAL", "TYPE_SHARE", "TICKER", "LAST_PRICE", "LAST_MONTHLY_VOLUME"}, {"QTD_TOTAL", "TYPE_SHARE", "TICKER", "LAST_PRICE", "LAST_MONTHLY_VOLUME"})
in
    #"Expanded DATA"