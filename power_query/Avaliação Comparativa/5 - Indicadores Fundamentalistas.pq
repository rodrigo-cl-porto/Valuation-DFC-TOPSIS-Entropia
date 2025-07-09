let
    Source = Excel.CurrentWorkbook(){[Name="tblFairValue"]}[Content],
    #"Added Dividends" = Table.AddColumn(Source, "DIVIDEND",
        each let
            StartTime = Text.From(fxUnixTimeFormat(#datetime(pqRefYear, 1, 1, 0, 0, 0))),
            EndTime = Text.From(fxUnixTimeFormat(#datetime(pqRefYear, 12, 31, 0, 0, 0))),
            ExtractedCsvFile = Csv.Document(
                Web.Contents("http://query1.finance.yahoo.com/v7/finance/download/" & [TICKER] & ".SA?period1=" & StartTime & "&period2=" & EndTime & "&interval=1mo&events=div&includeAdjustedClose=true"),
                [Delimiter=",", Columns=2, Encoding=65001, QuoteStyle=QuoteStyle.None]
            ),
            PromotedHeaders = Table.PromoteHeaders(ExtractedCsvFile, [PromoteAllScalars=true]),
            FixedValues = Table.ReplaceValue(PromotedHeaders,".",",",Replacer.ReplaceText,{"Dividends"}),
            ChangedType = Table.TransformColumnTypes(FixedValues,{{"Dividends", type number}}),
            TotalDividend = List.Sum(ChangedType[Dividends])
        in  
            TotalDividend
        ,
        Currency.Type
    ),
    #"Replaced Null Dividends" = Table.ReplaceValue(#"Added Dividends",null,0,Replacer.ReplaceValue,{"DIVIDEND"}),
    #"Added Dividend Yield" = Table.AddColumn(#"Replaced Null Dividends", "D.Y.", each [DIVIDEND]/[LAST_PRICE], Percentage.Type),
    #"Added DRE Info" = 
    let 
        MergedQueries = Table.NestedJoin(#"Added Dividend Yield", {"CNPJ_CIA", "YEAR"}, Excel.CurrentWorkbook(){[Name="tblDRE"]}[Content], {"CNPJ_CIA", "ANO"}, "DRE", JoinKind.Inner),
        ExpandedTableColumn = Table.ExpandTableColumn(MergedQueries, "DRE", {"3.05 EBIT", "3.09.01 LUCRO_LIQUIDO", "NET_MARGIN", "AVERAGE_NET_PROFIT"}, {"EBIT", "NET_PROFIT", "NET_MARGIN", "AVERAGE_NET_PROFIT"})
    in  
        ExpandedTableColumn,
    #"Added L/P" = Table.AddColumn(#"Added DRE Info", "L/P", each [NET_PROFIT]*1000 / [MARKET_VALUE], Currency.Type),
    #"Added BP Info" = 
    let 
        MergedQueries = Table.NestedJoin(#"Added L/P", {"CNPJ_CIA", "YEAR"}, Excel.CurrentWorkbook(){[Name="tblBP"]}[Content], {"CNPJ_CIA", "ANO"}, "BP", JoinKind.Inner),
        ExpandedTableColumn = Table.ExpandTableColumn(MergedQueries, "BP", {"2.03 PATRIMONIO_LIQUIDO", "DIVIDA_LIQUIDA", "ILC", "ILG"}, {"EQUITY", "NET_DEBT", "ILC", "ILG"})
    in  
        ExpandedTableColumn
    ,
    #"Added VP/P" = Table.AddColumn(#"Added BP Info", "VP/P", each [EQUITY]*1000 / [MARKET_VALUE], Currency.Type),
    #"Added -DL/PL" = Table.AddColumn(
        #"Added VP/P",
        "-DL/PL",
        each if [EQUITY] = 0 or [EQUITY] = null then 
            null
        else if [EQUITY] > 0 then
            -[NET_DEBT] / [EQUITY]
        else if [NET_DEBT] > 0 then
            -3 * Number.Abs([NET_DEBT] / [EQUITY])
        else 
            -5 * Number.Abs([NET_DEBT] / [EQUITY]),
        type number
    ),
    #"Added -DL/EBIT" = Table.AddColumn(
        #"Added -DL/PL",
        "-DL/EBIT",
        each if [EBIT] = 0 or [EBIT] = null then 
            null
        else if [EBIT] > 0 then
            -[NET_DEBT] / [EBIT]
        else if [EBIT] > 0 then
            -3 * Number.Abs([NET_DEBT] / [EBIT])
        else
            -5 * Number.Abs([NET_DEBT] / [EBIT]),
        type number
    ),
    #"Added ROE" = Table.AddColumn(
        #"Added -DL/EBIT",
        "ROE",
        each if [EQUITY] = 0 or [EQUITY]= null then 
            null
        else if [EQUITY] > 0 then
            [NET_PROFIT] / [EQUITY]
        else if [NET_PROFIT] > 0 then
            -3 * Number.Abs([NET_PROFIT] / [EQUITY])
        else
            -5 * Number.Abs([NET_PROFIT] / [EQUITY]),
        Percentage.Type
    ),
    #"Added CNPJ" = Table.AddColumn(
        #"Added ROE",
        "CNPJ",
        each let
            ExtractedTextBeforeDelimiter = Text.BeforeDelimiter([CNPJ_CIA], "/"),
            RemovedDots = Text.Remove(ExtractedTextBeforeDelimiter, ".")
        in
            RemovedDots,
        type text
    ),
    #"Added Basileia and Immobilization" = 
    let 
        MergedQueries = Table.NestedJoin(#"Added CNPJ", {"CNPJ"}, #"Indicadores Financeiros", {"CNPJ"}, "Indicadores Financeiros", JoinKind.LeftOuter),
        ExpandedTableColumn = Table.ExpandTableColumn(MergedQueries, "Indicadores Financeiros", {"BASILEIA_INDEX", "-IMMOBILIZATION_INDEX"})
    in  
        ExpandedTableColumn,
    #"Fixed Sector" = Table.CombineColumns(
        #"Added Basileia and Immobilization",
        {"SECTOR", "SUBSECTOR", "SEGMENT"},
        (values as list) as text =>
        let  
            sector = values{0},
            segment = values{2}
        in if Text.StartsWith(segment, "BANCO") then
            segment
        else 
            sector
        ,
        "SECTOR"
    ),
    #"Selected Columns" = Table.SelectColumns(#"Fixed Sector",{"CNPJ_CIA", "DENOM_CIA", "CD_CVM", "SECTOR", "TICKER", "YEAR", "LAST_PRICE", "MARKET_VALUE", "FAIR_MARKET_VALUE", "LAST_MONTHLY_VOLUME", "D.Y.", "L/P","VP/P", "-DL/PL", "-DL/EBIT", "BASILEIA_INDEX", "-IMMOBILIZATION_INDEX", "ILC", "ILG", "NET_MARGIN", "ROE", "AVERAGE_NET_PROFIT"}),
    #"Replaced Nulls by Sector" =
    let
        NumberColumnNames = Table.ColumnsOfType(#"Selected Columns", {type number, type nullable number, Percentage.Type}),
        GroupedRows = Table.Group(
            #"Selected Columns",
            {"SECTOR"},
            {{
                "DATA",
                each List.Accumulate(
                    {"LAST_MONTHLY_VOLUME", "D.Y.", "L/P","VP/P", "-DL/PL", "-DL/EBIT", "BASILEIA_INDEX", "-IMMOBILIZATION_INDEX", "ILC", "ILG", "NET_MARGIN", "ROE", "AVERAGE_NET_PROFIT"},
                    _,
                    (tbl as table, columnName as text) as table =>
                    let 
                        ColumnValues = Table.Column(tbl, columnName),
                        MediumValue = if List.IsEmpty(fxOutliers(ColumnValues)) then List.Average(ColumnValues) else List.Median(ColumnValues),
                        ReplacedNulls = Table.ReplaceValue(tbl, null, MediumValue, Replacer.ReplaceValue, {columnName})
                    in
                        ReplacedNulls
                ),
                type table [CNPJ_CIA=text, DENOM_CIA=text, CD_CVM=text, SECTOR=text, TICKER=text, YEAR=Int64.Type, LAST_PRICE=Currency.Type, MARKET_VALUE=Currency.Type, FAIR_MARKET_VALUE=Currency.Type, LAST_MONTHLY_VOLUME=Currency.Type, #"D.Y."=Percentage.Type, #"L/P"=number, #"VP/P"=number, #"-DL/PL"=number, #"-DL/EBIT"=number, BASILEIA_INDEX=Percentage.Type, #"-IMMOBILIZATION_INDEX"=number, ILC=number, ILG=number, NET_MARGIN=Percentage.Type, ROE=Percentage.Type, AVERAGE_NET_PROFIT=Percentage.Type]
            }}
        ),
        ExpandedTableColumn = Table.ExpandTableColumn(GroupedRows, "DATA", {"CNPJ_CIA", "DENOM_CIA", "CD_CVM", "TICKER", "YEAR", "LAST_PRICE", "MARKET_VALUE", "FAIR_MARKET_VALUE", "LAST_MONTHLY_VOLUME", "D.Y.", "L/P", "VP/P", "-DL/PL", "-DL/EBIT", "BASILEIA_INDEX", "-IMMOBILIZATION_INDEX", "ILC", "ILG", "NET_MARGIN", "ROE", "AVERAGE_NET_PROFIT"})
    in 
        ExpandedTableColumn,
    #"Sorted Rows" = Table.Sort(#"Replaced Nulls by Sector",{{"SECTOR", Order.Ascending}, {"TICKER", Order.Ascending}})
in
    #"Sorted Rows"