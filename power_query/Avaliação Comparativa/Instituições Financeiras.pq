let
    Source = Json.Document(Web.Contents("https://olinda.bcb.gov.br/olinda/servico/IFDATA/versao/v1/odata/IfDataCadastro(AnoMes=@AnoMes)?@AnoMes=" & Text.From(pqRefYear) & "12&$top=10000&$filter=Situacao%20eq%20'A'&$format=json&$select=CodInst,Data,NomeInstituicao,CnpjInstituicaoLider", [Timeout=#duration(0,0,3,0)])),
    value = Source[value],
    #"Converted to Table" = Table.FromList(value, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to Table", "Column1", {"CodInst", "Data", "NomeInstituicao", "CnpjInstituicaoLider"}, {"BACEN_COD", "YEAR", "DENOM_CIA", "CNPJ"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded Column1",{{"BACEN_COD", type text}, {"YEAR", type text}, {"DENOM_CIA", type text}, {"CNPJ", type text}}),
    #"Fixed Year" = Table.TransformColumns(#"Changed Type", {{"YEAR", each Int64.From(Text.Start(_, 4)), Int64.Type}})
in
    #"Fixed Year"