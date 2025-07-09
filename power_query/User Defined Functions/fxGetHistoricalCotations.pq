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
    //#table({"TIPREG","DATPRE","CODBDI","CODNEG","TPMERC","NOMRES","ESPECI","PRAZOT","MODREF","PREABE","PREMAX","PREMIN","PREMED","PREULT","PREOFC","PREOFV","TOTNEG","QUATOT","VOLTOT","PREEXE","INDOPC","DATVEN","FATCOT","PTOEXE","CODISI","DISMES"}, {})
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
                TIPREG = Text.Start(_, 2),       // Tipo de Registro
                DATPRE = Text.Middle(_,   2,  8), // Data do Pregão
                CODBDI = Text.Middle(_,  10,  2), // Utilizado para classificar os papéis na emissão do boletim diário de informações
                CODNEG = Text.Middle(_,  12, 12), // Código de negociação do papel
                TPMERC = Text.Middle(_,  24,  3), // Tipo de mercado
                NOMRES = Text.Middle(_,  27, 12), // Nome Resumido da empresa emissora do papel
                ESPECI = Text.Middle(_,  39, 10), // Especificação do papel
                PRAZOT = Text.Middle(_,  49,  3), // Prazo em dias do mercado a termo
                MODREF = Text.Middle(_,  52,  4), // Moeda de referência
                PREABE = Text.Middle(_,  56, 13), // Preço de abertura do papel - Mercado no pregão
                PREMAX = Text.Middle(_,  69, 13), // Preço máximo do papel - Mercado no pregão
                PREMIN = Text.Middle(_,  82, 13), // Preço mínimo do papel - Mercado no pregão
                PREMED = Text.Middle(_,  95, 13), // Preço médio do papel - Mercado no pregão
                PREULT = Text.Middle(_, 108, 13), // Preço do último negócio do papel - Mercado no pregão
                PREOFC = Text.Middle(_, 121, 13), // Preço da melhor oferta de compra do papel - Mercado
                PREOFV = Text.Middle(_, 134, 13), // Preço da melhor oferta de venda do papel - Mercado
                TOTNEG = Text.Middle(_, 147,  5), // Número de negócios efetuados com o papel - Mercado no Pregão
                QUATOT = Text.Middle(_, 152, 18), // Quantidade de títulos negociados neste papel - Mercado
                VOLTOT = Text.Middle(_, 170, 18), // Volume total de títulos negociados neste papel - Mercado
                PREEXE = Text.Middle(_, 188, 13), // Preço de exercício para o mercado de opções ou valor do contrato para o mercado a termo secundário
                INDOPC = Text.Middle(_, 201,  1), // Indicador de correção de preços de exercícios ou valores de contrato para os mercados de opções ou termo secundário
                DATVEN = Text.Middle(_, 202,  8), // Data do vencimento para os mercados de opções ou termo secundário
                FATCOT = Text.Middle(_, 210,  7), // Fator de cotação do papel
                PTOEXE = Text.Middle(_, 219,  9), // Preço de exercício em pontos para opções referenciadas em dólar ou valor de contrato em pontos para termo secundário
                CODISI = Text.Middle(_, 230, 12), // Código do papel no sistema ISIN ou código interno do papel
                DISMES = Text.End(_, 3)           // Número de distribuição do papel
            ],
            type record
        }}
    ),
    #"Expanded Records" = 
    let 
        ColumnNames = Record.FieldNames(#"Extracted Records"[Column1]{0}),
        ExpandedRecords = Table.ExpandRecordColumn(#"Extracted Records", "Column1", ColumnNames, ColumnNames)
    in 
        ExpandedRecords,
    #"Removed Header and Tail" = Table.SelectRows(#"Expanded Records", each ([TIPREG] = "01")),
    #"Colunas Removidas" = Table.RemoveColumns(#"Removed Header and Tail",{"TIPREG"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Colunas Removidas",{{"DATPRE", type date}, {"CODBDI", type text}, {"CODNEG", type text}, {"TPMERC", type text}, {"NOMRES", type text}, {"ESPECI", type text}, {"PRAZOT", Int64.Type}, {"MODREF", type text}, {"PREABE", Int64.Type}, {"PREMAX", Int64.Type}, {"PREMIN", Int64.Type}, {"PREMED", Int64.Type}, {"PREULT", Int64.Type}, {"PREOFC", Int64.Type}, {"PREOFV", Int64.Type}, {"TOTNEG", Int64.Type}, {"QUATOT", Int64.Type}, {"VOLTOT", Currency.Type}, {"PREEXE", Int64.Type}, {"INDOPC", Int64.Type}, {"DATVEN", type date}, {"FATCOT", Int64.Type}, {"PTOEXE", type number}, {"CODISI", type text}, {"DISMES", Int64.Type}}),
    #"Preprocessed Text Columns" = 
    let 
        TextColumnNames = Table.ColumnsOfType(#"Changed Type", {type text, type nullable text}),
        TransformOperations = List.Transform(
            TextColumnNames,
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
    #"Fixed Values" = Table.TransformColumns(
        #"Preprocessed Text Columns",
        {
            {"PREABE", each _ / 100, Currency.Type},
            {"PREMAX", each _ / 100, Currency.Type},
            {"PREMIN", each _ / 100, Currency.Type}, 
            {"PREMED", each _ / 100, Currency.Type},
            {"PREULT", each _ / 100, Currency.Type},
            {"PREOFC", each _ / 100, Currency.Type},
            {"PREOFV", each _ / 100, Currency.Type},
            {"VOLTOT", each _ / 100, Currency.Type},
            {"PREEXE", each _ / 100, Currency.Type},
            {"PTOEXE", each _ / 1000000, type number}
        }
    ), 
    #"Fix CODBDI" = Table.TransformColumns(
        #"Fixed Values",
        {{"CODBDI", 
        each if _ = "02" then "LOTE PADRAO"
        else if _ = "05" then "SANCIONADAS PELOS REGULAMENTOS BMFBOVESPA"
        else if _ = "06" then "CONCORDATARIAS"
        else if _ = "07" then "RECUPERACAO EXTRAJUDICIAL"
        else if _ = "08" then "RECUPERAÇÃO JUDICIAL"
        else if _ = "09" then "RAET - REGIME DE ADMINISTRACAO ESPECIAL TEMPORARIA"
        else if _ = "10" then "DIREITOS E RECIBOS"
        else if _ = "11" then "INTERVENCAO"
        else if _ = "12" then "FUNDOS IMOBILIARIOS"
        else if _ = "14" then "CERT.INVEST/TIT.DIV.PUBLICA"
        else if _ = "18" then "OBRIGACÕES"
        else if _ = "22" then "BÔNUS (PRIVADOS)"
        else if _ = "26" then "APOLICES/BÔNUS/TITULOS PUBLICOS"
        else if _ = "32" then "EXERCICIO DE OPCOES DE COMPRA DE INDICES"
        else if _ = "33" then "EXERCICIO DE OPCOES DE VENDA DE INDICES"
        else if _ = "38" then "EXERCICIO DE OPCOES DE COMPRA"
        else if _ = "42" then "EXERCICIO DE OPCOES DE VENDA"
        else if _ = "46" then "LEILAO DE NAO COTADOS"
        else if _ = "48" then "LEILAO DE PRIVATIZACAO"
        else if _ = "49" then "LEILAO DO FUNDO RECUPERACAO ECONOMICA ESPIRITO SANTO"
        else if _ = "50" then "LEILAO"
        else if _ = "51" then "LEILAO FINOR"
        else if _ = "52" then "LEILAO FINAM"
        else if _ = "53" then "LEILAO FISET"
        else if _ = "54" then "LEILAO DE ACÕES EM MORA"
        else if _ = "56" then "VENDAS POR ALVARA JUDICIAL"
        else if _ = "58" then "OUTROS"
        else if _ = "60" then "PERMUTA POR ACÕES"
        else if _ = "61" then "META"
        else if _ = "62" then "MERCADO A TERMO"
        else if _ = "66" then "DEBENTURES COM DATA DE VENCIMENTO ATE 3 ANOS"
        else if _ = "68" then "DEBENTURES COM DATA DE VENCIMENTO MAIOR QUE 3 ANOS"
        else if _ = "70" then "FUTURO COM RETENCAO DE GANHOS"
        else if _ = "71" then "MERCADO DE FUTURO"
        else if _ = "74" then "OPCOES DE COMPRA DE INDICES"
        else if _ = "75" then "OPCOES DE VENDA DE INDICES"
        else if _ = "78" then "OPCOES DE COMPRA"
        else if _ = "82" then "OPCOES DE VENDA"
        else if _ = "83" then "BOVESPAFIX"
        else if _ = "84" then "SOMA FIX"
        else if _ = "90" then "TERMO VISTA REGISTRADO"
        else if _ = "96" then "MERCADO FRACIONARIO"
        else if _ = "99" then "TOTAL GERAL"
        else "",
        type text
    }}),
    #"Fix TPMERC" = Table.TransformColumns(
        #"Fix CODBDI",
        {{"TPMERC", 
        each if _= "010" then "VISTA"
        else if _= "012" then "EXERCÍCIO DE OPÇÕES DE COMPRA"
        else if _= "013" then "EXERCÍCIO DE OPÇÕES DE VENDA"
        else if _= "017" then "LEILÃO"
        else if _= "020" then "FRACIONÁRIO"
        else if _= "030" then "TERMO"
        else if _= "050" then "FUTURO COM RETENÇÃO DE GANHO"
        else if _= "060" then "FUTURO COM MOVIMENTAÇÃO CONTÍNUA"
        else if _= "070" then "OPÇÕES DE COMPRA"
        else if _= "080" then "OPÇÕES DE VENDA"
        else "",
        type text
    }})
in
    #"Fix TPMERC"