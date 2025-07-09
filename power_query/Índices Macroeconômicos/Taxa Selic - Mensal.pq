let
    Source = Json.Document(Web.Contents("https://api.bcb.gov.br/dados/serie/bcdata.sgs.4390/dados?formato=json&dataInicial=01/01/" & Text.From(pqRefYear) & "&dataFinal=31/12/" & Text.From(pqRefYear), [Timeout=#duration(0,0,3,0)])),
    #"Converted to Table" = Table.FromList(Source, Record.ToList, {"MONTH", "RATE"}, null, ExtraValues.Error),
    #"Replaced Value" = Table.ReplaceValue(#"Converted to Table",".",",",Replacer.ReplaceText,{"RATE"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Replaced Value",{{"MONTH", type date}, {"RATE", Percentage.Type}}, "pt-BR"),
    #"Divided Column" = Table.TransformColumns(#"Changed Type", {{"RATE", each _ / 100, Percentage.Type}}),
    #"Added IPCA Variation" = 
    let 
        MonthlyIPCA = Table.TransformColumnTypes(Excel.CurrentWorkbook(){[Name="tblMonthlyIPCA"]}[Content], {{"MONTH", type date}, {"VAR", Percentage.Type}}),
        MergedQueries = Table.NestedJoin(#"Divided Column", {"MONTH"}, MonthlyIPCA, {"MONTH"}, "IPCA - Mensal", JoinKind.LeftOuter),
        ExpandedTableColumn = Table.ExpandTableColumn(MergedQueries, "IPCA - Mensal", {"VAR"}, {"IPCA_VAR"})
    in  
        ExpandedTableColumn,
    #"Added Real Rate" = Table.AddColumn(#"Added IPCA Variation", "REAL_RATE", each (1 + [RATE])/(1 + [IPCA_VAR]) - 1, Percentage.Type),
    #"Sorted Rows" = Table.Sort(#"Added Real Rate",{{"MONTH", Order.Ascending}})
in
    #"Sorted Rows"