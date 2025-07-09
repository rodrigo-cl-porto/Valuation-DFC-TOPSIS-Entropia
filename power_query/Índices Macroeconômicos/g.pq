let
    Source = List.Average(Excel.CurrentWorkbook(){[Name="tblPIB"]}[Content][REAL_VAR])
in
    Source