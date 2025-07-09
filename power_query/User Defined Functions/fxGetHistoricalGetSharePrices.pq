(year as number, optional month as nullable number, optional day as nullable number) as table =>
let 
    BaseURL = "https://bvmf.bmfbovespa.com.br/InstDados/SerHist/COTAHIST_",
    Source =
        if day = null and month = null then
            try Web.Contents(BaseURL & "A" & Text.From(year) & ".ZIP") otherwise null
        else if day = null then 
            try Web.Contents(BaseURL & "M" & Text.PadStart(Text.From(month), 2, "0") & Text.From(year) & ".ZIP") otherwise null
        else if month <> null then
            try Web.Contents(BaseURL & "D" & Text.PadStart(Text.From(day), 2, "0") & Text.PadStart(Text.From(month), 2, "0") & Text.From(year) & ".ZIP") otherwise null
        else
            error [Reason="DateFormat.Error", Message="O mês não foi informado!", Detail="Por favor, informe um número válido do mês."]
    ,
    #"Extracted Raw Data" = 
    if Source <> null then let
        UnzippedFile = fxBinaryUnzip(Source),
        ExtractedRawDate = Table.FromColumns({Lines.FromBinary(UnzippedFile[Content]{0}, null, null, 1252)})
    in
        ExtractedRawDate
    else
        #table({"Column1"}, {})
    ,
    #"Extracted Records" = Table.TransformColumns(
        #"Extracted Raw Data",
        {{
            "Column1",
            each [
                //TIPREG = Text.Start(_, 2),       // Tipo de Registro
                DATPRE = Text.Middle(_,   2,  8), // Data do Pregão
                //CODBDI = Text.Middle(_,  10,  2), // Utilizado para classificar os papéis na emissão do boletim diário de informações
                CODNEG = Text.Middle(_,  12, 12), // Código de negociação do papel
                TPMERC = Text.Middle(_,  24,  3), // Tipo de mercado
                NOMRES = Text.Middle(_,  27, 12), // Nome Resumido da empresa emissora do papel
                ESPECI = Text.Middle(_,  39, 10), // Especificação do papel
                //PRAZOT = Text.Middle(_,  49,  3), // Prazo em dias do mercado a termo
                //MODREF = Text.Middle(_,  52,  4), // Moeda de referência
                //PREABE = Text.Middle(_,  56, 13), // Preço de abertura do papel - Mercado no pregão
                //PREMAX = Text.Middle(_,  69, 13), // Preço máximo do papel - Mercado no pregão
                //PREMIN = Text.Middle(_,  82, 13), // Preço mínimo do papel - Mercado no pregão
                //PREMED = Text.Middle(_,  95, 13), // Preço médio do papel - Mercado no pregão
                PREULT = Text.Middle(_, 108, 13), // Preço do último negócio do papel - Mercado no pregão
                //PREOFC = Text.Middle(_, 121, 13), // Preço da melhor oferta de compra do papel - Mercado
                //PREOFV = Text.Middle(_, 134, 13), // Preço da melhor oferta de venda do papel - Mercado
                //TOTNEG = Text.Middle(_, 147,  5), // Número de negócios efetuados com o papel - Mercado no Pregão
                //QUATOT = Text.Middle(_, 152, 18), // Quantidade de títulos negociados neste papel - Mercado
                //VOLTOT = Text.Middle(_, 170, 18), // Volume total de títulos negociados neste papel - Mercado
                //PREEXE = Text.Middle(_, 188, 13), // Preço de exercício para o mercado de opções ou valor do contrato para o mercado a termo secundário
                //INDOPC = Text.Middle(_, 201,  1), // Indicador de correção de preços de exercícios ou valores de contrato para os mercados de opções ou termo secundário
                //DATVEN = Text.Middle(_, 202,  8), // Data do vencimento para os mercados de opções ou termo secundário
                FATCOT = Text.Middle(_, 210,  7) // Fator de cotação do papel
                //PTOEXE = Text.Middle(_, 219,  9), // Preço de exercício em pontos para opções referenciadas em dólar ou valor de contrato em pontos para termo secundário
                //CODISI = Text.Middle(_, 230, 12), // Código do papel no sistema ISIN ou código interno do papel
                //DISMES = Text.End(_, 3)           // Número de distribuição do papel
            ],
            type record
        }}
    ),
    #"Expanded Records" = 
    let 
        ColumnNames = Record.FieldNames(#"Extracted Records"[Column1]{0}),
        ExpandedRecords = Table.ExpandRecordColumn(#"Extracted Records", "Column1", ColumnNames, ColumnNames)
    in 
        ExpandedRecords
    ,
    #"Filtered Rows" = Table.SelectRows(
        #"Expanded Records",
        each [TPMERC] = "010" and (Text.StartsWith([ESPECI], "ON ") or Text.StartsWith([ESPECI], "PN "))
    ),
    #"Transformed ESPECI" = Table.TransformColumns(
        #"Filtered Rows",
        {{
            "ESPECI",
            each if Text.StartsWith(_, "ON ") then "ON"
            else if Text.StartsWith(_, "PN ") then "PN"
            else _,
            type text
        }}
    ),
    #"Changed Type" = Table.TransformColumnTypes(
        #"Transformed ESPECI",
        {
            {"DATPRE", type date},
            {"CODNEG", type text},
            {"TPMERC", type text},
            {"NOMRES", type text},
            {"ESPECI", type text},
            //{"PREABE", Currency.Type},
            //{"PREMAX", Currency.Type},
            //{"PREMIN", Currency.Type},
            //{"PREMED", Currency.Type},
            {"PREULT", type number},
            //{"VOLTOT", Currency.Type},
            {"FATCOT", Int64.Type}
        },
        "pt-BR"
    ),
    #"Trimmed Text Columns" = 
    let 
        TextColumnNames = Table.ColumnsOfType(#"Changed Type", {type text, type nullable text}),
        TransformOperations = List.Transform(TextColumnNames,
            (columnName as text) as list => {
                columnName,
                each Text.Trim(Text.Clean(_)),
                type text
            }
        ),
        TrimmedTextColumns = Table.TransformColumns(#"Changed Type", TransformOperations)
    in 
        TrimmedTextColumns
    ,
    #"Filtered CODNEG" = Table.SelectRows(#"Trimmed Text Columns", each Text.EndsWith([CODNEG], "3") or Text.EndsWith([CODNEG], "4")),
    #"Fixed PREULT" = Table.TransformColumns(
        #"Filtered CODNEG",
        {
            //{"PREABE", each _ / 100, Currency.Type},
            //{"PREMAX", each _ / 100, Currency.Type},
            //{"PREMIN", each _ / 100, Currency.Type}, 
            //{"PREMED", each _ / 100, Currency.Type},
            {"PREULT", each _ / 100, Currency.Type}
            //{"PREOFC", each _ / 100, Currency.Type},
            //{"PREOFV", each _ / 100, Currency.Type},
            //{"VOLTOT", each _ / 100, Currency.Type},
            //{"PREEXE", each _ / 100, Currency.Type},
            //{"PTOEXE", each _ / 1000000, type number}
        }
    ),
    #"Removed TPMERC" = Table.RemoveColumns(#"Fixed PREULT", {"TPMERC"}),
    #"Merged to PREULT" = Table.CombineColumns(#"Removed TPMERC",{"PREULT", "FATCOT"},(values) as number => values{0}/values{1},"PREULT")
in
    #"Merged to PREULT"