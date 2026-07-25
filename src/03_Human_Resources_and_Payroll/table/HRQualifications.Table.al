Table 85431 "HR Qualifications"
{
    Caption = 'HR Qualifications';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "HR Qualifications";
    LookupPageID = "HR Qualifications";

    fields
    {
        field(50000; "Qualification Type"; Code[50])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Qualification Type"));
        }
        field(50001; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(50002; Description; Text[200])
        {
            Caption = 'Description';
            NotBlank = true;
        }
        field(50003; "Academic Level"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Qualification Type", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
