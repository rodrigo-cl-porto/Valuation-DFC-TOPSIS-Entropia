let
    Source = Table.AddColumn(Excel.CurrentWorkbook(){[Name="tblMonthlyIPCA"]}[Content], "YEAR", each Date.Year([MONTH]), Int64.Type),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"MONTH", type date}, {"VAR", Percentage.Type}}),
    #"Sorted Rows by Month" = Table.Sort(#"Changed Type",{{"MONTH", Order.Ascending}}),
    #"Added Annual Variation" = Table.Group(
        #"Sorted Rows by Month",
        {"YEAR"},
        {{
            "VAR",
            each List.Accumulate(
                [VAR],
                0,
                (state as number, current as number) as number =>
                (1 + state) * (1 + current) - 1
            ),
            Percentage.Type
        }}
    ),
    #"Added Accumulated Variation" = Table.AddColumn(
        #"Added Annual Variation",
        "ACCUMULATED_VAR",
        each let 
            CurrentYear = [YEAR],
            FilteredRows = Table.SelectRows(#"Added Annual Variation", each [YEAR] >= CurrentYear and [YEAR] <= pqRefYear),
            AccumulatedFactor = List.Accumulate(
                List.Buffer(FilteredRows[VAR]),
                1,
                (factor as number, inflation as number) as number =>
                factor * (1 + inflation)
            )
        in  
            AccumulatedFactor - 1,
        Percentage.Type
    )
in
    #"Added Accumulated Variation"