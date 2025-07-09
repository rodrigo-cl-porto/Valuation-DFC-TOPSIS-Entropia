let
    Source = Excel.CurrentWorkbook(){[Name="tblCapitalSocial"]}[Content],
    #"Added Historical Quotation Series" = Table.AddColumn(
        Source,
        "HISTORICAL_QUOTATION_SERIES",
        each let
            StartUnixTime = Text.From(fxUnixTimeFormat(#datetime(pqRefYear-pqHistoricalRange, 12, 1, 0, 0, 0))),
            EndUnixTime = Text.From(fxUnixTimeFormat(#datetime(pqRefYear, 12, 31, 0, 0, 0))),
            DataSource = Csv.Document(Web.Contents("https://query1.finance.yahoo.com/v7/finance/download/" & [TICKER] & ".SA?period1=" & StartUnixTime & "&period2=" & EndUnixTime & "&interval=1mo&events=history&includeAdjustedClose=true"),[Delimiter=",", Columns=7, Encoding=65001, QuoteStyle=QuoteStyle.None]),
            PromotedHeaders = Table.PromoteHeaders(DataSource, [PromoteAllScalars=true]),
            ReplacedToComma = Table.ReplaceValue(PromotedHeaders,".",",",Replacer.ReplaceText,{"Adj Close"}),
            ChangedType = Table.TransformColumnTypes(ReplacedToComma,{{"Date", type date}, {"Adj Close", type number}}, "pt-BR"),
            AddedIndex = Table.AddIndexColumn(ChangedType, "INDEX", 0, 1),
            BufferedAdjClose = List.Buffer(AddedIndex[Adj Close]), 
            AddedReturn = Table.AddColumn(AddedIndex, "RETURN", each if [INDEX] = 0 then null else [Adj Close]/BufferedAdjClose{[INDEX]-1} - 1, Percentage.Type),
            RemovedNullReturns = Table.SelectRows(AddedReturn, each [RETURN] <> null)
        in
            RemovedNullReturns,
        type table [Date=date, RETURN=Percentage.Type]
    ),
    #"Removed Errors" = Table.RemoveRowsWithErrors(#"Added Historical Quotation Series", {"HISTORICAL_QUOTATION_SERIES"}),
    #"Got Tickers with the Highest Trading Volume" = 
    let
        GroupedRows = Table.Group(#"Removed Errors", {"CODEMP"}, {{"DATA", each Table.Max(_, {"LAST_MONTHLY_VOLUME"}), type [CNPJ_CIA=text, YEAR=Int64.Type, DENOM_CIA=text, CD_CVM=text, SECTOR=text, SUBSECTOR=text, SEGMENT=text, CODEMP=text, MARKET_VALUE=Currency.Type, QTD_TOTAL=Int64.Type, TYPE_SHARE=text, TICKER=text, LAST_PRICE=Currency.Type, LAST_MONTHLY_VOLUME=Currency.Type, HISTORICAL_QUOTATION_SERIES=table [Date=date, RETURN=Percentage.Type]]}}),
        ExpandedRecords = Table.ExpandRecordColumn(GroupedRows, "DATA", {"CNPJ_CIA", "CD_CVM", "DENOM_CIA", "SECTOR", "SUBSECTOR", "SEGMENT", "MARKET_VALUE", "QTD_TOTAL", "TYPE_SHARE", "TICKER", "LAST_PRICE", "LAST_MONTHLY_VOLUME", "HISTORICAL_QUOTATION_SERIES"})
    in
        ExpandedRecords
    ,
    #"Expanded Historical Series" = Table.ExpandTableColumn(#"Got Tickers with the Highest Trading Volume", "HISTORICAL_QUOTATION_SERIES", {"Date", "RETURN"}),
    #"Pivoted Date" = 
    let 
        ListDates = List.Accumulate(
            {0..pqHistoricalRange*12-2},
            {#date(pqRefYear-pqHistoricalRange+1, 1, 1)},
            (state as list, i as number) as list => List.Combine({state, {Date.AddMonths(state{i}, 1)}})
        ),
        ListMonthText = List.Transform(ListDates, Text.From),
        ChangedDateToText = Table.TransformColumnTypes(#"Expanded Historical Series",{{"Date", type text}}),
        PivotedDate = Table.Pivot(ChangedDateToText, ListMonthText, "Date", "RETURN", List.Sum)
    in
        PivotedDate
    ,
    #"Removed Tickers with Many Nulls" = 
    let 
        ColumnNames = Table.ColumnNames(#"Pivoted Date"),
        ListDates = List.Select(
            ColumnNames,
            each let
                value = try Date.FromText(_, "pt-BR") otherwise null
            in 
                value <> null
        ),
        N = pqHistoricalRange*12,
        FilteredRows = Table.SelectRows(
            #"Pivoted Date",
            each let
                Values = Record.ToList(Record.SelectFields(_, ListDates)),
                NumberOfNulls = List.Count(List.Select(Values, each _ = null))
            in 
                NumberOfNulls < N / 2
        )
    in 
        FilteredRows,
    #"Added Beta" = 
    let 
        ColumnNames = Table.ColumnNames(#"Pivoted Date"),
        ListDates = List.Select(ColumnNames, each let dt = try Date.FromText(_, "pt-BR") otherwise null in dt <> null),
        MarketReturns = List.Buffer(#"IBOV - Mensal"[REAL_VAR]),
        MergedToBeta = Table.CombineColumns(
            #"Removed Tickers with Many Nulls",
            ListDates,
            (values as list) as nullable number =>
            let 
                NonNullValues = List.LastN(values, each _ <> null),
                N = List.Count(NonNullValues),
                LastNMarketReturns = List.LastN(MarketReturns, N),
                Beta = List.Covariance(NonNullValues, LastNMarketReturns) / Number.Power(List.StandardDeviation(LastNMarketReturns), 2)
            in
                try Beta otherwise null,
            "BETA"
        )
    in 
        MergedToBeta,
    #"Filtered Non Null Beta" = Table.SelectRows(#"Added Beta", each ([BETA] <> null)),
    #"Added Beta Sector" =
    let  
        GroupedRows = Table.Group(
            #"Filtered Non Null Beta",
            {"SECTOR"},
            {
                {
                    "BETA_SECTOR",
                    each let 
                        ZippedList = List.Zip({[MARKET_VALUE], [BETA]}),
                        WeightedSum = List.Accumulate(
                            ZippedList,
                            0,
                            (state as number, current as list) as number =>
                            state + List.Product(current)
                        ),
                        BetaSector = WeightedSum  / List.Sum([MARKET_VALUE])
                    in  
                        BetaSector,
                    type number
                },
                {
                    "DATA",
                    each _,
                    type table [CODEMP=text, CNPJ_CIA=text, CD_CVM=text, DENOM_CIA=text, SECTOR=text, SUBSECTOR=text, SEGMENT=text, MARKET_VALUE=Currency.Type, QTD_TOTAL=Int64.Type, TYPE_SHARE=text, TICKER=text, LAST_PRICE=Currency.Type, LAST_MONTHLY_VOLUME=Currency.Type, BETA=nullable number]
                }
            }
        ),
        ExpandedTableColumn = Table.ExpandTableColumn(GroupedRows, "DATA", {"CODEMP", "CNPJ_CIA", "CD_CVM", "DENOM_CIA", "SUBSECTOR", "SEGMENT", "MARKET_VALUE", "QTD_TOTAL", "TYPE_SHARE", "TICKER", "LAST_PRICE", "LAST_MONTHLY_VOLUME", "BETA"}),
        ReorderedColumns = Table.ReorderColumns(ExpandedTableColumn,{"CODEMP", "CNPJ_CIA", "CD_CVM", "DENOM_CIA", "SECTOR", "SUBSECTOR", "SEGMENT", "MARKET_VALUE", "QTD_TOTAL", "TYPE_SHARE", "TICKER", "LAST_PRICE", "LAST_MONTHLY_VOLUME", "BETA", "BETA_SECTOR"})
    in 
        ReorderedColumns,
    #"Added Cost of Equity" = Table.AddColumn(#"Added Beta Sector", "COST_EQUITY", each Rf + [BETA] * (Rm - Rf), Percentage.Type),
    #"Added Cost of Equity Sector" = Table.AddColumn(#"Added Cost of Equity", "COST_EQUITY_SECTOR", each Rf + [BETA_SECTOR] * (Rm - Rf), Percentage.Type)
    //let  
        //MonthlyRf = List.Average(#"Taxa Selic - Mensal"[REAL_RATE]),
        //AnnualRf = Number.Power(1 + MonthlyRf, 12) - 1,
        //MonthlyRm = List.Average(#"Market Returns"),
        //AnnualRm = Number.Power(1 + MonthlyRm, 12) - 1,
        //RiskPremium = AnnualRm - AnnualRf,
        //AddedColumn = Table.AddColumn(#"Added Beta", "COST_EQUITY", each AnnualRf + [BETA] * RiskPremium, Percentage.Type)
    //in 
        //AddedColumn
in
    #"Added Cost of Equity Sector"