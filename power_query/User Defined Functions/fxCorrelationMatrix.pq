(tb as table, optional columns as nullable list) =>
let
    tbBuffer = Table.Buffer(tb),
    columns = if columns = null or columns = {} then Table.ColumnNames(tbBuffer) else columns,
    // Number of Columns
    N = List.Count(columns),
    // List of column names, repeated N times each in a row
    RepeatedColumnNames = List.Transform(columns, each List.Repeat({_}, N)),
    AllColumnCombinations = List.Transform(RepeatedColumnNames, each List.Zip({_, columns})),
    MatrixCorrelation = List.Transform(
        AllColumnCombinations,
        each List.Transform(
            _, 
            each let
                column1 = Table.Column(tbBuffer, _{0}),
                column2 = Table.Column(tbBuffer, _{1})
            in 
                fxCorrelation(column1, column2)
        )
    ),
    TableMatrixCorrelation = Table.Buffer(#table(columns, MatrixCorrelation)),
    AddedIndex = Table.AddIndexColumn(TableMatrixCorrelation, "Index", 0, 1),
    AddedVariableColumn = Table.AddColumn(AddedIndex, "VARIABLE", each columns{[Index]}, type text),
    RemovedIndex = Table.RemoveColumns(AddedVariableColumn, {"Index"}),
    ColumnTypesList = List.Transform(columns, each {_, type number}),
    TypeChanged = Table.TransformColumnTypes(RemovedIndex, ColumnTypesList),
    ReorderedColumns = Table.ReorderColumns(TypeChanged, List.Combine({{"VARIABLE"}, columns}))
in
    ReorderedColumns