let
    Source = List.Average(Excel.CurrentWorkbook(){[Name="tblSelic"]}[Content][REAL_RATE]),
    #"Expected Selic Rate" = Number.Power(1 + Source, 12) - 1,
    #"Added Metadata" = #"Expected Selic Rate" meta [IsParameterQuery=true, Type="Number", IsParameterQueryRequired=true]
in
    #"Added Metadata"