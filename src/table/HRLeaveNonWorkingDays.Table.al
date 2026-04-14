table 85028 "HR Leave Non Working Days"
{
    Caption = 'HR Leave Non Working Days';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; Date; Date)
        {
        }
        field(50001; Reason; Text[40])
        {
        }
        field(50002; Recurring; Boolean)
        {
        }
        field(50003; "Calender Code"; Code[30])
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
