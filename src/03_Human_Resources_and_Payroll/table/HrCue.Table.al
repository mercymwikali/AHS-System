Table 85491 "Hr Cue"
{
    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
        }
        field(50001; "Employee-Normal"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(50002; "Employee-Male"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Gender = filter(Male),
                                                     Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(50003; "Employee-Female"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Gender = filter(Female),
                                                     Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(50004; "Employee-InNormal"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(<> Normal)));
            FieldClass = FlowField;
        }
        field(50005; "Employee-Normal (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(50006; "Employee-Male (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(50007; "Employee-Female (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Gender = filter(Female)));
            FieldClass = FlowField;
        }
        field(50008; "Employee-InNormal (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(<> Normal)));
            FieldClass = FlowField;
        }
        field(50009; "Normal Casulals (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Employee Type" = filter(Casual)));
            FieldClass = FlowField;
        }
        field(50010; "Normal Permanent (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Type of Contract" = filter('PERMANENT')));
            FieldClass = FlowField;
        }
        field(50011; "Normal Casula (Female) (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Employee Type" = filter(Casual),
                                                     Gender = filter(" ")));
            FieldClass = FlowField;
        }
        field(50012; "Normal Casula (Male) (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Employee Type" = filter(Casual),
                                                     Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(50013; "Normal Permanent (Female) (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Employee Type" = filter(Permanent),
                                                     Gender = filter(" ")));
            FieldClass = FlowField;
        }
        field(50014; "Normal Permanent (Male) (PR)"; Integer)
        {
            CalcFormula = count("HR-Employee" where(Status = filter(Normal),
                                                     "Employee Type" = filter(Permanent),
                                                     Gender = filter(Male)));
            FieldClass = FlowField;
        }
        field(50015; "New Visitors"; Integer)
        {
            CalcFormula = count("Sec-Visitor Management" where(Status = filter(Arrived),
                                                                "Initiated Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50016; "Normal visitors"; Integer)
        {
            CalcFormula = count("Sec-Visitor Management" where(Status = filter(Entered),
                                                                "Initiated Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50017; "Cleared Visitors"; Integer)
        {
            CalcFormula = count("Sec-Visitor Management" where(Status = filter(Cleared),
                                                                "Initiated Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50018; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50019; "Part Time Employees"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Part Time" = filter(true)));
            FieldClass = FlowField;
        }
        field(50020; CEO; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('CEO'),
                                                     Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(50021; CHAIRMAN; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('CHAIRMAN'),
                                                     Status = filter(Normal)));

            FieldClass = FlowField;
            Caption = 'CHAIRMAN';
        }
        field(50022; "CLINICAL SERVICES"; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('CLINICAL SERVICES'),
                                                     Status = filter(Normal)));

            FieldClass = FlowField;
            Caption = 'CLINICAL SERVICES';
        }
        field(50023; CMH_W; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('CMH_W;'),
                                                     Status = filter(Normal)));

            FieldClass = FlowField;
            Caption = 'Corporate Mental Health and Wellness';
        }
        field(50024; CORPORATE_PSY; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('CORPORATE PSYCHIATRY'),
                                                     Status = filter(Normal)));

            FieldClass = FlowField;
            Caption = 'CORPORATE PSYCHIATRY';
        }
        field(50025; DOCTOR; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('DOCTOR'),
                                                     Status = filter(Normal)));

            FieldClass = FlowField;
            Caption = 'Doctor';
        }
        field(50026; EXTERNAL_PSY; Integer)
        {
            CalcFormula = count("HR-Employee" where("Shortcut Dimension 2 Code" = filter('EXTERNAL_PSY'),
                                                     Status = filter('Normal')));
            FieldClass = FlowField;
            Caption = 'PSYCHIATRY EXTERNAL';
        }
        field(50027; FINANCE; Integer)
        {
            CalcFormula = count("hr-employee" where("Shortcut Dimension 2 Code" = filter('FINANCE'),
                                                           Status = filter(NORMAL)));
            FieldClass = FlowField;
            Caption = 'Finance';
        }
        field(50028; "New Legal"; Integer)
        {
            CalcFormula = count("Legal Management" where(Status = filter(Open),
                                                           "Initiated Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50029; "Posted Legal"; Integer)
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
