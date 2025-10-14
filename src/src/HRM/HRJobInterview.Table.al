Table 52202756 "HR Job Interview"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Interview Code"; Code[20])
        {
        }
        field(2; "Interview Description"; Text[100])
        {
        }
        field(3; Score; Decimal)
        {
        }
        field(4; "Total Score"; Decimal)
        {
        }
        field(5; Comments; Text[100])
        {
        }
        field(6; Interviewer; Code[20])
        {
        }
        field(7; "Interviewer Name"; Text[100])
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
