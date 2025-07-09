let
    Source = Json.Document(Web.Contents("https://olinda.bcb.gov.br/olinda/servico/IFDATA/versao/v1/odata/IfDataValores(AnoMes=@AnoMes,TipoInstituicao=@TipoInstituicao,Relatorio=@Relatorio)?@AnoMes=" & Text.From(pqRefYear) & "12&@TipoInstituicao=1&@Relatorio='1'&$top=10000&$filter=Conta%20eq%20'79664'%20or%20Conta%20eq%20'79662'&$format=json&$select=CodInst,AnoMes,NomeColuna,Saldo", [Timeout=#duration(0,0,3,0)])),
    value = Source[value],
    #"Converted to Table" = Table.FromList(value, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to Table", "Column1", {"CodInst", "AnoMes", "NomeColuna", "Saldo"}, {"BACEN_COD", "YEAR", "ATTRIBUTE", "VALUE"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded Column1",{{"BACEN_COD", type text}, {"YEAR", type text}, {"ATTRIBUTE", type text}, {"VALUE", Percentage.Type}}),
    #"Fixed Year" = Table.TransformColumns(#"Changed Type", {{"YEAR", each Number.FromText(Text.Start(_, 4)), Int64.Type}}),
    #"Fixed Attribute" = Table.TransformColumns(#"Fixed Year",{{"ATTRIBUTE", each if Text.Contains(_, "Basileia") then "BASILEIA_INDEX" else "IMMOBILIZATION_INDEX", type text}}),
    #"Pivoted Attribute Column" = Table.Pivot(#"Fixed Attribute", {"BASILEIA_INDEX", "IMMOBILIZATION_INDEX"}, "ATTRIBUTE", "VALUE", List.Sum),
    #"Added Company Info" = 
    let  
        MergedQueries = Table.NestedJoin(#"Pivoted Attribute Column", {"BACEN_COD", "YEAR"}, #"Instituições Financeiras", {"BACEN_COD", "YEAR"}, "Instituições Financeiras", JoinKind.Inner),
        ExpandedTableColumn = Table.ExpandTableColumn(MergedQueries, "Instituições Financeiras", {"DENOM_CIA", "CNPJ"}, {"DENOM_CIA", "CNPJ"})
    in  
        ExpandedTableColumn,
    #"Added Inverse of Immobilization Index" = Table.AddColumn(#"Added Company Info", "-IMMOBILIZATION_INDEX", each -[IMMOBILIZATION_INDEX], Percentage.Type),
    #"Reordered Columns" = Table.ReorderColumns(#"Added Inverse of Immobilization Index",{"DENOM_CIA", "BACEN_COD", "CNPJ", "YEAR", "BASILEIA_INDEX", "IMMOBILIZATION_INDEX", "-IMMOBILIZATION_INDEX"}),
    #"Sorted Rows" = Table.Sort(#"Reordered Columns",{{"DENOM_CIA", Order.Ascending}})
in
    #"Sorted Rows"