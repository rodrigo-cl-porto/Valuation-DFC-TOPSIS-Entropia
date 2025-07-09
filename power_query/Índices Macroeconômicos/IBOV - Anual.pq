let
    Source = Web.Page(Web.Contents("http://www.ipeadata.gov.br/ExibeSerie.aspx?serid=31875&module=M", [Timeout=#duration(0,0,10,0)])),
    Data0 = Source{0}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Data0, [PromoteAllScalars=true]),
    #"Renamed Columns" = Table.RenameColumns(#"Promoted Headers",{{"Data", "MONTH"}, {"Índice de ações - Ibovespa - fechamento", "VAR"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"MONTH", type date}, {"VAR", Percentage.Type}}, "pt-BR"),
    #"Filtered Rows" = 
    let 
        FirstYear = pqRefYear-29,
        FilteredRows = Table.SelectRows(#"Changed Type", each [MONTH] >= #date(FirstYear, 1, 1) and [MONTH] <= #date(pqRefYear, 12, 1))
    in   
        FilteredRows,
    #"Fixed Variation" = Table.TransformColumns(#"Filtered Rows", {{"VAR", each _ / 100, Percentage.Type}}),
    #"Sorted Rows" = Table.Sort(#"Fixed Variation",{{"MONTH", Order.Ascending}}),
    #"Added IPCA Variation" = 
    let
        MonthlyIPCA = Table.TransformColumnTypes(Excel.CurrentWorkbook(){[Name="tblMonthlyIPCA"]}[Content], {{"MONTH", type date}, {"VAR", Percentage.Type}}),
        MergedQueries = Table.NestedJoin(#"Sorted Rows", {"MONTH"}, MonthlyIPCA, {"MONTH"}, "IPCA - Mensal", JoinKind.LeftOuter),
        ExpandedTableColumn = Table.ExpandTableColumn(MergedQueries, "IPCA - Mensal", {"VAR"}, {"IPCA_VAR"})
    in  
        ExpandedTableColumn,
    #"Added Real Variation" = Table.AddColumn(#"Added IPCA Variation", "REAL_VAR", each (1 + [VAR])/(1 + [IPCA_VAR]) - 1, Percentage.Type)
in
    #"Added Real Variation"