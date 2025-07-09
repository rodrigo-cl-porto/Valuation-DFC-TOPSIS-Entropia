let
    Source = Web.Page(Web.Contents("http://www.ipeadata.gov.br/ExibeSerie.aspx?serid=1184389725&module=M", [Timeout=#duration(0,0,3,0)])),
    Data0 = Source{0}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Data0, [PromoteAllScalars=true]),
    #"Renamed Columns" = Table.RenameColumns(#"Promoted Headers",{{"Data", "YEAR"}, {"PIB - preços de mercado - variação real anual", "REAL_VAR"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"YEAR", Int64.Type}, {"REAL_VAR", Percentage.Type}}),
    #"Fixed Real Variation" = Table.TransformColumns(#"Changed Type", {{"REAL_VAR", each _ / 100, Percentage.Type}}),
    #"Filtered Rows" = Table.SelectRows(#"Fixed Real Variation", each ([YEAR] >= pqRefYear-99 and [YEAR] <= pqRefYear)),
    #"Sorted Rows" = Table.Sort(#"Filtered Rows",{{"YEAR", Order.Ascending}})
in
    #"Sorted Rows"