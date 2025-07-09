let
    Source = Excel.CurrentWorkbook(){[Name="tblDFC"]}[Content],
    #"Removed Other Columns" = Table.SelectColumns(Source,{"CNPJ_CIA", "CD_CVM", "DENOM_CIA", "ANO", "FCFE"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Removed Other Columns",{{"CNPJ_CIA", type text}, {"CD_CVM", type text}, {"DENOM_CIA", type text}, {"ANO", Int64.Type}, {"FCFE", Currency.Type}}),
    #"Sorted Rows" = Table.Sort(#"Changed Type",{{"DENOM_CIA", Order.Ascending}, {"ANO", Order.Ascending}}),
    #"Fixed FCFE" = Table.TransformColumns(#"Sorted Rows", {{"FCFE", each _ * 1000, Currency.Type}}),
    #"Discounted Inflation" = 
    let 
        AnnualInflation = Table.Buffer(Excel.CurrentWorkbook(){[Name="tblAnnualIPCA"]}[Content]),
        AddedRealFCFE = Table.AddColumn(
            #"Fixed FCFE",
            "REAL_FCFE",
            each let 
                InflationFactor = AnnualInflation{[YEAR=[ANO]]}[ACCUMULATED_VAR],
                RealFcfe = [FCFE] * (1 + InflationFactor)
            in  
                RealFcfe,
            Currency.Type
        )
    in  
        AddedRealFCFE,
    #"Removed FCFE" = Table.RemoveColumns(#"Discounted Inflation",{"FCFE"})
    ,
    #"Pivoted Year" = 
    let
        ChangedType = Table.TransformColumnTypes(#"Removed FCFE", {{"ANO", type text}}, "pt-BR"),
        YearList = List.Transform({pqRefYear-pqHistoricalRange+1..pqRefYear}, Text.From),
        PivotedTable = Table.Pivot(ChangedType, YearList, "ANO", "REAL_FCFE", List.Sum)
    in  
        PivotedTable,
    #"Removed Companies with Many Nulls" = 
    let 
        HistoricalYearsList = List.Transform({pqRefYear-pqHistoricalRange+1..pqRefYear}, Text.From),
        FilteredRows = Table.SelectRows(
            #"Pivoted Year",
            each let 
                Values = Record.ToList(Record.SelectFields(_, HistoricalYearsList)),
                NumberOfNulls = List.Count(List.Select(Values, each _ = null))
            in 
                not (NumberOfNulls >= pqHistoricalRange / 2)
        )
    in 
        FilteredRows,
    #"Replaced Nulls" =
    let 
        HistoricalYearsList = List.Transform({pqRefYear-pqHistoricalRange+1..pqRefYear}, Text.From),
        AddedColumn = Table.AddColumn(
            #"Removed Companies with Many Nulls",
            "Fill Nulls With",
            each let 
                Values = Record.ToList(Record.SelectFields(_, HistoricalYearsList)),
                Oultiers = fxOutliers(Values)
            in if List.IsEmpty(Oultiers) then
                List.Average(Values)
            else
                List.Median(Values),
            Currency.Type
        ),
        ReplacedNulls = Table.ReplaceValue(AddedColumn,null, each [Fill Nulls With], Replacer.ReplaceValue,HistoricalYearsList),
        RemovedColumn = Table.RemoveColumns(ReplacedNulls, {"Fill Nulls With"}),
        ChangedType = Table.TransformColumnTypes(RemovedColumn, List.Zip({HistoricalYearsList, List.Repeat({Currency.Type}, pqHistoricalRange)}))
    in
        ChangedType,
    #"Projected FCFEs" = 
    let 
        HistoricalYearsList = List.Transform({pqRefYear-pqHistoricalRange+1..pqRefYear}, Text.From),
        ProjectionYearsList = List.Transform({pqRefYear+1..pqRefYear+pqProjectionRange}, Text.From),
        AddedProjection = Table.AddColumn(
            #"Replaced Nulls",
            "Projection Range",
            each let
                HistoricalFCFEs = Record.ToList(Record.SelectFields(_, HistoricalYearsList)),

                //Método 1
                //A = fxIntercept({pqRefYear-pqHistoricalRange+1..pqRefYear}, HistoricalFCFEs),
                //B = fxSlope({pqRefYear-pqHistoricalRange+1..pqRefYear}, HistoricalFCFEs),
                //ProjectedFCFE = List.Transform({pqRefYear+1..pqRefYear+pqProjectionRange}, (x) => A + B*x)

                // Método 2
                MediumFCFE = if List.IsEmpty(fxOutliers(HistoricalFCFEs)) then List.Average(HistoricalFCFEs) else List.Median(HistoricalFCFEs),
                ProjectedFCFE = List.Transform({1..pqProjectionRange}, each MediumFCFE)
                
                //Método 3
                //WeightedAverage = fxWeightedAverage(HistoricalFCFEs),
                //ProjectedFCFE = List.Transform({1..pqProjectionRange}, (i) as number => WeightedAverage)
            in 
                Record.FromList(ProjectedFCFE, ProjectionYearsList),
            type record
        ), 
        ExpandedProjection = Table.ExpandRecordColumn(AddedProjection, "Projection Range", ProjectionYearsList),
        ChangedType = Table.TransformColumnTypes(ExpandedProjection, List.Zip({ProjectionYearsList, List.Repeat({Currency.Type}, pqProjectionRange)}))
    in 
        ChangedType,
    #"Removed Historical Period" = 
    let 
        HistoricalYearsList = List.Transform({pqRefYear-pqHistoricalRange+1..pqRefYear}, Text.From),
        RemovedHistoricalColumns = Table.RemoveColumns(#"Projected FCFEs", HistoricalYearsList)
    in 
        RemovedHistoricalColumns
    ,
    #"Added Cost of Equity Info" = 
    let 
        MergedQueries = Table.NestedJoin(#"Removed Historical Period", {"CNPJ_CIA"}, Excel.CurrentWorkbook(){[Name="tblCustoCapitalProprio"]}[Content], {"CNPJ_CIA"}, "Custo do Capital Próprio", JoinKind.Inner),
        ExpandedTables = Table.ExpandTableColumn(MergedQueries, "Custo do Capital Próprio", {"SECTOR", "SUBSECTOR", "SEGMENT", "TICKER", "COST_EQUITY_SECTOR", "MARKET_VALUE", "QTD_TOTAL", "LAST_PRICE", "LAST_MONTHLY_VOLUME"})
    in 
        ExpandedTables,
    #"Added Present FCFE Values" = 
    let 
        ProjectionYearsList = {pqRefYear+1..pqRefYear+pqProjectionRange},
        AddedPresentValues = List.Accumulate(
            {1..pqProjectionRange},
            #"Added Cost of Equity Info",
            (CurrentTable as table, i as number) as table => Table.AddColumn(
                CurrentTable,
                "PV_" & Text.From(pqRefYear+i),
                each let 
                    Fcfe = Record.Field(_, Text.From(pqRefYear+i)),
                    PV = Fcfe / Number.Power(1+[COST_EQUITY_SECTOR], i)
                in 
                    PV,
                Currency.Type
            )
        )
    in  
        AddedPresentValues,
    #"Added Present Terminal Value" = let 
        LastYear = Text.From(pqRefYear+pqProjectionRange),
        AddedColumn = Table.AddColumn(
            #"Added Present FCFE Values",
            "PV_TERMINAL_VALUE",
            each let 
                LastFcfe = Record.Field(_, LastYear),
                TerminalValue = LastFcfe*(1 + g)/([COST_EQUITY_SECTOR] - g),
                PresentTerminalValue = TerminalValue / Number.Power(1+[COST_EQUITY_SECTOR], pqProjectionRange+1)
            in  
                PresentTerminalValue,
            Currency.Type
        )
    in  
        AddedColumn
    ,
    #"Merged to Fair Market Value" = 
    let  
        ColumnNames = Table.ColumnNames(#"Added Present Terminal Value"),
        PvColumns = List.Select(ColumnNames, each Text.StartsWith(_, "PV_")),
        MergedToFairMarketValue = Table.CombineColumns(#"Added Present Terminal Value", PvColumns, (_) as number => List.Sum(_), "FAIR_MARKET_VALUE")
    in  
        MergedToFairMarketValue,
    #"Filtered Positive Fair Market Value" = Table.SelectRows(#"Merged to Fair Market Value", each [FAIR_MARKET_VALUE] > 0),
    #"Added Safety Margin" = Table.AddColumn(#"Filtered Positive Fair Market Value", "SAFETY_MARGIN", each [FAIR_MARKET_VALUE]/[MARKET_VALUE]-1, Percentage.Type),
    #"Added Year" = Table.AddColumn(#"Added Safety Margin", "YEAR", each pqRefYear, Int64.Type),
    #"Selected Columns" = Table.SelectColumns(#"Added Year",{"CNPJ_CIA", "DENOM_CIA", "CD_CVM", "SECTOR", "SUBSECTOR", "SEGMENT", "YEAR", "TICKER", "LAST_MONTHLY_VOLUME", "LAST_PRICE", "MARKET_VALUE","FAIR_MARKET_VALUE", "SAFETY_MARGIN"}),
    #"Sorted by Safety Margin" = Table.Sort(#"Selected Columns",{{"SAFETY_MARGIN", Order.Descending}})
in
    #"Sorted by Safety Margin"