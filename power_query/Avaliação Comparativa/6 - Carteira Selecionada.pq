let
    Source = Excel.CurrentWorkbook(){[Name="tblIndicadoresFundamentalistas"]}[Content],
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"CNPJ_CIA", type text}, {"DENOM_CIA", type text}, {"CD_CVM", type text}, {"SECTOR", type text}, {"TICKER", type text}, {"YEAR", Int64.Type}, {"LAST_PRICE", Currency.Type}, {"MARKET_VALUE", Currency.Type}, {"FAIR_MARKET_VALUE", Currency.Type}, {"LAST_MONTHLY_VOLUME", Currency.Type}, {"D.Y.", Percentage.Type}, {"L/P", type number}, {"VP/P", type number}, {"-DL/PL", type number}, {"-DL/EBIT", type number}, {"BASILEIA_INDEX", type number}, {"-IMMOBILIZATION_INDEX", type number}, {"ILC", type number}, {"ILG", type number}, {"NET_MARGIN", Percentage.Type}, {"ROE", Percentage.Type}, {"AVERAGE_NET_PROFIT", Percentage.Type}}),
    #"Applied TOPSIS" = let 
        GroupedRows = Table.Group(
            #"Changed Type",
            {"SECTOR"},
            {{
                "DATA",
                each let
                    ColumnNames =  
                    if [SECTOR]{0} <> "BANCOS" then
                        {"LAST_MONTHLY_VOLUME", "D.Y.", "L/P", "VP/P", "-DL/PL", "-DL/EBIT", "ILC", "NET_MARGIN", "ROE", "AVERAGE_NET_PROFIT"}
                    else
                        {"LAST_MONTHLY_VOLUME", "D.Y.", "L/P", "VP/P", "BASILEIA_INDEX", "-IMMOBILIZATION_INDEX", "ILG","NET_MARGIN", "ROE", "AVERAGE_NET_PROFIT"},
                    CriteriaWeights = fxEntropyMethod(_, ColumnNames),
                    AddedCC = fxTopsis(_, "TICKER", CriteriaWeights)
                in
                    AddedCC,
                type table [CNPJ_CIA=nullable text, CD_CVM=nullable text, DENOM_CIA=nullable text, SECTOR=nullable text, TICKER=nullable text, YEAR=Int64.Type, LAST_PRICE=Currency.Type, MARKET_VALUE=Currency.Type, FAIR_MARKET_VALUE=Currency.Type, CC=nullable number]
            }}
        ),
        ExpandedTableColumn = Table.ExpandTableColumn(GroupedRows, "DATA", {"CNPJ_CIA", "CD_CVM", "DENOM_CIA", "TICKER", "YEAR", "LAST_PRICE", "MARKET_VALUE", "FAIR_MARKET_VALUE", "CC"})
    in 
        ExpandedTableColumn,
    #"Added Goodwill Factor" = Table.AddColumn(#"Applied TOPSIS", "GOODWILL_FACTOR", each 2*[CC]-1, Percentage.Type),
    #"Added Adjusted Fair Market Value" = Table.AddColumn(#"Added Goodwill Factor", "ADJUSTED_FAIR_MARKET_VALUE", each [FAIR_MARKET_VALUE]*(1+[GOODWILL_FACTOR]), Currency.Type),
    #"Added Safety Margin" = Table.AddColumn(#"Added Adjusted Fair Market Value", "SAFETY_MARGIN", each [ADJUSTED_FAIR_MARKET_VALUE]/[MARKET_VALUE] - 1, Percentage.Type),
    #"Removed Columns" = Table.RemoveColumns(#"Added Safety Margin",{"FAIR_MARKET_VALUE", "CC", "GOODWILL_FACTOR"}),
    #"Best Shares by Sector" = 
    let 
        ListSectors = List.Distinct(#"Removed Columns"[SECTOR]),
        NumberSectors = List.Count(ListSectors),
        SharesPerSector = Number.RoundUp(pqNumberOfShares / NumberSectors),
        GroupedRows = Table.Group(
            #"Removed Columns",
            {"SECTOR"},
            {{
                "DATA", 
                each Table.MaxN(_, {"SAFETY_MARGIN"}, SharesPerSector + 1), 
                type table [SECTOR=nullable text, CNPJ_CIA=nullable text, CD_CVM=nullable text, DENOM_CIA=nullable text, TICKER=nullable text, YEAR=Int64.Type, LAST_PRICE=Currency.Type, MARKET_VALUE=Currency.Type, ADJUSTED_FAIR_MARKET_VALUE=Currency.Type, SAFETY_MARGIN=Percentage.Type]
            }}
        ),
        ExpandedTableColumn = Table.ExpandTableColumn(GroupedRows, "DATA", {"CNPJ_CIA", "CD_CVM", "DENOM_CIA", "TICKER", "YEAR", "LAST_PRICE", "MARKET_VALUE", "ADJUSTED_FAIR_MARKET_VALUE", "SAFETY_MARGIN"})
    in
        ExpandedTableColumn,
    #"Selected Portfolio" =
    if Table.RowCount(#"Best Shares by Sector") > pqNumberOfShares then
        let 
            NumberSharesToRemove = Table.RowCount(#"Best Shares by Sector") - pqNumberOfShares,
            ListSectors = List.Distinct(#"Best Shares by Sector"[SECTOR]),
            NumberSectors = List.Count(ListSectors),
            SharesPerSector = Number.RoundUp(pqNumberOfShares / NumberSectors),
            GroupedRows = Table.Group(
                #"Best Shares by Sector",
                {"SECTOR"},
                {{
                    "DATA",
                    each if Table.RowCount(_) > 1 then
                        Table.MinN(_, {"SAFETY_MARGIN"}, SharesPerSector)
                    else 
                        null,
                    type table [SECTOR=text, CNPJ_CIA=text, CD_CVM=text, DENOM_CIA=text, TICKER=text, YEAR=Int64.Type, LAST_PRICE=Currency.Type, ADJUSTED_FAIR_VALUE=Currency.Type, SAFETY_MARGIN=Percentage.Type]
                }}
            ),
            FilteredRows = Table.SelectRows(GroupedRows, each ([DATA] <> null)),
            ExpandedRecordColumn = Table.ExpandTableColumn(FilteredRows, "DATA", {"CNPJ_CIA", "CD_CVM", "DENOM_CIA", "TICKER", "YEAR", "LAST_PRICE", "ADJUSTED_FAIR_VALUE", "SAFETY_MARGIN"}),
            WorstShares = Table.MinN(ExpandedRecordColumn, {"SAFETY_MARGIN"}, NumberSharesToRemove),
            MergedQueries = Table.NestedJoin(
                #"Best Shares by Sector", {"SECTOR", "CNPJ_CIA", "CD_CVM", "DENOM_CIA", "TICKER", "YEAR"},
                WorstShares, {"SECTOR", "CNPJ_CIA", "CD_CVM", "DENOM_CIA", "TICKER", "YEAR"},
                "DATA", JoinKind.LeftAnti
            ),
            RemovedColumn = Table.RemoveColumns(MergedQueries,{"DATA"}),
            SortedRows = Table.Sort(RemovedColumn, {{"SAFETY_MARGIN", Order.Descending}})
        in 
            SortedRows
    else
        Table.Sort(#"Best Shares by Sector", {{"SAFETY_MARGIN", Order.Descending}})
in
    #"Selected Portfolio"