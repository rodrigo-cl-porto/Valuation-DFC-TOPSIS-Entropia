(tbl as table, CorrCut as number) as table =>
let 
    MatrixCorr = fxCorrelationMatrix(tbl),
    AddedMeanCorr = Table.AddColumn(
        MatrixCorr,
        "Mean Correlation Above Cut",
        each let
            IndicatorName = [VARIABLE],
            IndicatorValues = Table.Column(MatrixCorr, IndicatorName),
            FilteredValues = List.Select(
                IndicatorValues,
                each _ > CorrCut or _ < -CorrCut
            ),
            AbsoluteValues = List.Transform(FilteredValues, Number.Abs),
            SumCorr = List.Sum(AbsoluteValues) - 1,
            CountCorr = List.Count(AbsoluteValues) - 1,
            MeanCorr = SumCorr/CountCorr
        in  
            MeanCorr,
        Percentage.Type
    ),
    MeanCorrList = AddedMeanCorr[Mean Correlation Above Cut],
    MeanCorrCut = List.Average(MeanCorrList) - List.StandardDeviation(MeanCorrList),
    FilteredRows = Table.SelectRows(AddedMeanCorr, each [Mean Correlation Above Cut] < MeanCorrCut),
    FilteredColumns = Table.SelectColumns(FilteredRows, List.Combine({{"VARIABLE"}, FilteredRows[VARIABLE]}))
in 
    FilteredColumns