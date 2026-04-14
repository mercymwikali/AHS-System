Table 85397 "HR Appraisal indicators"
{
    fields
    {
        field(50000; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; Criteria; Code[20])
        {
            trigger OnValidate()
            begin
                /* Performsummary.SETRANGE(Performsummary.Criteria,Criteria);
                  IF Performsummary.FIND('-') THEN BEGIN
                     "Performance Indicator":=Performsummary.Description;
                      END;
                   */
            end;
        }
        field(50002; "Performance Indicator"; Text[250])
        {
        }
        field(50003; "Appraisal Year"; Code[50])
        {
        }
        field(50004; "Code"; Code[10])
        {
        }
        field(50005; Remarks; Text[100])
        {
        }
        field(50006; Test1; Text[30])
        {
        }
        field(50007; Test; Text[30])
        {
        }
        field(50008; Test2; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No", Criteria, "Code", "Appraisal Year")
        {
            Clustered = true;
        }
        key(Key2; "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(PerformanceIndicator; "Performance Indicator")
        {
        }
    }
}
