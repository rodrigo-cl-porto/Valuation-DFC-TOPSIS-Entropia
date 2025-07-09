let
    Source = Table.SelectRows(Excel.CurrentWorkbook(), each Text.StartsWith([Name], "tblBPUA")),
    #"Selected Content" = Table.SelectColumns(Source,{"Content"}),
    #"Expanded Content" = 
    let 
        ColumnNames = Table.ColumnNames(#"Selected Content"[Content]{0}),
        ExpandedTableColumn = Table.ExpandTableColumn(#"Selected Content", "Content", ColumnNames)
    in  
        ExpandedTableColumn
    ,
    #"Added ACO" = Table.AddColumn(#"Expanded Content", "ACO", each [1.01.03 CONTAS_RECEBER] + [1.01.04 ESTOQUE] + [1.01.07 DESPESAS_ANTECIPADAS] + [1.01.08 OUTROS_AC], Currency.Type),
    #"Added PCO" = Table.AddColumn(#"Added ACO", "PCO", each [2.01.02 FORNECEDORES_PC] + [2.01.06 PROVISOES] + [2.01.03 OBRIGACOES_FISCAIS] + [2.01.01 OBRIGACOES_SOCIAIS_TRABALHISTAS], Currency.Type),
    #"Added NCG" = Table.AddColumn(#"Added PCO", "NCG", each [ACO] - [PCO], Currency.Type),
    #"Added ΔNCG" =
    let
        SortedRows = Table.Sort(#"Added NCG",{{"ANO", Order.Ascending}}),
        GroupedRows = Table.Group(
            SortedRows,
            {"CNPJ_CIA", "DENOM_CIA", "CD_CVM"},
            {{
                "DADOS",
                each let
                    AddedIndex = Table.AddIndexColumn(_, "INDEX", 0, 1),
                    BufferedList = List.Buffer(AddedIndex[NCG]),
                    AddedDeltaNCG = Table.AddColumn(AddedIndex, "ΔNCG", each if [INDEX] = 0 then null else [NCG] - BufferedList{[INDEX]-1}, Currency.Type)
                in
                    AddedDeltaNCG
                ,
                type table [ACO=Currency.Type, PCO=Currency.Type, NCG=Currency.Type, ΔNCG=Currency.Type]
            }}
        ),
        ColumnNames = List.RemoveItems(Table.ColumnNames(GroupedRows[DADOS]{0}), {"CNPJ_CIA", "DENOM_CIA", "CD_CVM", "INDEX"}),
        ExpandedDados = Table.ExpandTableColumn(GroupedRows, "DADOS", ColumnNames)
    in 
        ExpandedDados
    ,
    #"Changed Type" = 
    let
        ColumnNames = Table.ColumnNames(#"Added ΔNCG"),
        CurrencyColumnNames = List.RemoveItems(ColumnNames, {"CNPJ_CIA", "DENOM_CIA", "CD_CVM", "ANO"}),
        ZippedCurrencyTypes = List.Transform(CurrencyColumnNames, each {_, Currency.Type}),
        ListTypeTransformations = List.Combine({{{"CNPJ_CIA", type text}, {"DENOM_CIA", type text}, {"CD_CVM", type text}, {"ANO", Int64.Type}}, ZippedCurrencyTypes}),
        ChangedType = Table.TransformColumnTypes(#"Added ΔNCG", ListTypeTransformations)
    in 
        ChangedType,
    #"Removed Null ΔNCG" = Table.SelectRows(#"Changed Type", each ([ΔNCG] <> null)),
    #"Added Gross Debt" = Table.AddColumn(#"Removed Null ΔNCG", "DIVIDA_BRUTA", each [2.01.04 DIVIDA_PC]+[2.02.01 DIVIDA_PNC], Currency.Type),
    #"Added Net Debt" = Table.AddColumn(#"Added Gross Debt", "DIVIDA_LIQUIDA", each [DIVIDA_BRUTA] - [1.01.01 CAIXA], Currency.Type),
    #"Added ILC" = Table.AddColumn(#"Added Net Debt", "ILC", each if [2.01 PC] = 0 then null else [1.01 AC] / [2.01 PC], type number),
    #"Added ILG" = Table.AddColumn(#"Added ILC", "ILG", each [1 ATIVO_TOTAL]/([2 PASSIVO_TOTAL]-[2.03 PATRIMONIO_LIQUIDO]), type number)
in
    #"Added ILG"