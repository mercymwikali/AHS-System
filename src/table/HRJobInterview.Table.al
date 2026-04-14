Table 85420 "HR Job Interview"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Interview Code"; Code[20])
        {
        }
        field(50001; "Interview Description"; Text[100])
        {
        }
        field(50002; Score; Decimal)
        {
        }
        field(50003; "Total Score"; Decimal)
        {
        }
        field(50004; Comments; Text[100])
        {
        }
        field(50005; Interviewer; Code[20])
        {
        }
        field(50006; "Interviewer Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Interview Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
