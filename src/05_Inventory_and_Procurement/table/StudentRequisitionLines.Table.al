Table 85344 "Student Requisition Lines"
{
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Application No"; Code[20])
        {
        }
        field(50002; "Unit Code"; Code[20])
        {
        }
        field(50003; "Unit Title"; Text[50])
        {
        }
        field(50004; Reason; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
