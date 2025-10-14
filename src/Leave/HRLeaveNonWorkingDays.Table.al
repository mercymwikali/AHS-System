table 52203004 "HR Leave Non Working Days"
{
    Caption = 'HR Leave Non Working Days';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; Date; Date)
        {
        }
        field(2; Reason; Text[40])
        {
        }
        field(3; Recurring; Boolean)
        {
        }
        field(4; "Calender Code"; Code[30])
        {
            TableRelation = "HR Leave Calendar".Code;
        }
    }

    keys
    {
        key(Key1; Date, "Calender Code")
        {
            Clustered = true;
        }
    }
}
