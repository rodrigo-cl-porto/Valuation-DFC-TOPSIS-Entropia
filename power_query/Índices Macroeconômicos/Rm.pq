let
    #"Average Monthly Return" = List.Average(Excel.CurrentWorkbook(){[Name="tblIBOV"]}[Content][REAL_VAR]),
    #"Average Annual Return" = Number.Power(1 + #"Average Monthly Return", 12) - 1,
    #"Added Metadata" = #"Average Annual Return" meta [IsParameterQuery=true, Type="Number", IsParameterQueryRequired=true]
in
    #"Added Metadata"