Table 52202815 "Hr Cue"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Employee-Normal"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(3; "Employee-Male"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Gender = filter(Male),
                                                     Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(4; "Employee-Female"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Gender = filter(Female),
                                                     Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(5; "Employee-InNormal"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(<> Normal)));
            FieldClass = FlowField;
        }
        field(6; "Employee-Normal (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(7; "Employee-Male (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(8; "Employee-Female (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Gender = filter(Female)));
            FieldClass = FlowField;
        }
        field(9; "Employee-InNormal (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(<> Normal)));
            FieldClass = FlowField;
        }
        field(10; "Normal Casulals (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Employee Type" = filter(Casual)));
            FieldClass = FlowField;
        }
        field(11; "Normal Permanent (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Type of Contract" = filter('PERMANENT')));
            FieldClass = FlowField;
        }
        field(12; "Normal Casula (Female) (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Employee Type" = filter(Casual),
                                                     Gender = filter(" ")));
            FieldClass = FlowField;
        }
        field(13; "Normal Casula (Male) (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Employee Type" = filter(Casual),
                                                     Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(14; "Normal Permanent (Female) (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Employee Type" = filter(Permanent),
                                                     Gender = filter(" ")));
            FieldClass = FlowField;
        }
        field(15; "Normal Permanent (Male) (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Employee Type" = filter(Permanent),
                                                     Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(16; "New Visitors"; Integer)
        {
            CalcFormula = count("Sec-Visitor Management" where(Status = filter(Arrived),
                                                                "Initiated Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(17; "Normal visitors"; Integer)
        {
            CalcFormula = count("Sec-Visitor Management" where(Status = filter(Entered),
                                                                "Initiated Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(18; "Cleared Visitors"; Integer)
        {
            CalcFormula = count("Sec-Visitor Management" where(Status = filter(Cleared),
                                                                "Initiated Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Part Time Employees"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Part Time" = filter(true)));
            FieldClass = FlowField;
        }
        field(21; CEO; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('CEO'),
                                                     Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(22; CHAIRMAN; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('CHAIRMAN'),
                                                     Status = filter(Normal)));

            FieldClass = FlowField;
            Caption = 'CHAIRMAN';
        }
        field(23; "CLINICAL SERVICES"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('CLINICAL SERVICES'),
                                                     Status = filter(Normal)));

            FieldClass = FlowField;
            Caption = 'CLINICAL SERVICES';
        }
        field(24; CMH_W; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('CMH_W;'),
                                                     Status = filter(Normal)));

            FieldClass = FlowField;
            Caption = 'Corporate Mental Health and Wellness';
        }
        field(25; CORPORATE_PSY; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('CORPORATE PSYCHIATRY'),
                                                     Status = filter(Normal)));

            FieldClass = FlowField;
            Caption = 'CORPORATE PSYCHIATRY';
        }
        field(26; DOCTOR; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('DOCTOR'),
                                                     Status = filter(Normal)));

            FieldClass = FlowField;
            Caption = 'Doctor';
        }
        field(28; EXTERNAL_PSY; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('EXTERNAL_PSY'),
                                                     Status = filter('Normal')));
            FieldClass = FlowField;
            Caption = 'PSYCHIATRY EXTERNAL';
        }
        field(50001; FINANCE; Integer)
        {
            CalcFormula = count("hr-employee" where("Shortcut Dimension 2 Code" = filter('FINANCE'),
                                                           Status = filter(NORMAL)));
            FieldClass = FlowField;
            Caption = 'Finance';
        }
        field(50002; "New Legal"; Integer)
        {
            CalcFormula = count("Legal Management" where(Status = filter(Open),
                                                           "Initiated Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50003; "Posted Legal"; Integer)
        {
            CalcFormula = count("Legal Management" where(Status = filter(Posted),
                                                           "Initiated Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
