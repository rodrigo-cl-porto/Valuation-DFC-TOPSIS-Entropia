let
    Source = Json.Document(Web.Contents("https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados?formato=json&dataInicial=01/01/" & Text.From(pqRefYear - 29) & "&dataFinal=31/12/" & Text.From(pqRefYear), [Timeout=#duration(0,0,3,0)])),
    #"Converted to Table" = Table.FromList(Source, Record.ToList, {"MONTH", "VAR"}, null, ExtraValues.Error),
    #"Replaced Value" = Table.ReplaceValue(#"Converted to Table",".",",",Replacer.ReplaceText,{"VAR"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Replaced Value",{{"MONTH", type date}, {"VAR", Percentage.Type}}, "pt-BR"),
    #"Divided Column" = Table.TransformColumns(#"Changed Type", {{"VAR", each _ / 100, Percentage.Type}})
in
    #"Divided Column"