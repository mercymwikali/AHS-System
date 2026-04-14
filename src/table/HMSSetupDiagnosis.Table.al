Table 85245 "HMS Setup Diagnosis"
{
    DataCaptionFields = Description, "Code";
    // DrillDownPageID = UnknownPage70135107;
    // LookupPageID = UnknownPage70135107;

    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[250])
        {
            NotBlank = true;
        }
        field(50002; "Male Counter"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Diagnosis" where("Diagnosis No." = field(Code),
                                                                      Gender = filter(Male),
                                                                      "Treatment Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50003; "Female Counter"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Diagnosis" where("Diagnosis No." = field(Code),
                                                                      Gender = filter(Female),
                                                                      "Treatment Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50004; "Total Treatments"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Diagnosis" where("Diagnosis No." = field(Code),
                                                                      "Treatment Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50005; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50006; Edit; Boolean)
        {
        }
        field(50007; "New Appointments"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Diagnosis" where("Diagnosis No." = field(Code),
                                                                      "Treatment Date" = field("Date Filter"),
                                                                      "Patient Appointments" = const(1)));
            FieldClass = FlowField;
        }
        field(50008; Diagnosis; Code[200])
        {
        }
        field(50009; "Total Treatments Under 5"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Diagnosis" where("Diagnosis No." = field(Code),
                                                                      "Treatment Date" = field("Date Filter"),
                                                                      "Age in Years" = filter(<= 5)));
            FieldClass = FlowField;
        }
        field(50010; "Total Treatments Over 5"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Diagnosis" where("Diagnosis No." = field(Code),
                                                                      "Treatment Date" = field("Date Filter"),
                                                                      "Age in Years" = filter(> 5)));
            FieldClass = FlowField;
        }
        field(50011; "Expected Date of Discharge"; Text[100])
        {
            TableRelation = "EDD Protocol Setup"."Psychiatry Condition";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
        key(Key3; Diagnosis)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Code")
        {
        }
        fieldgroup(Brick; Description, "Code")
        {
        }
    }
}
