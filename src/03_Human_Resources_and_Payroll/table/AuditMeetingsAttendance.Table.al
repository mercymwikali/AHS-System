Table 85560 "Audit Meetings Attendance"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; "Meeting Code"; Code[20])
        {
        }
        field(50002; Attendee; Code[30])
        {
        }
        field(50003; "Date Created"; Date)
        {
        }
        field(50004; "Created By"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Meeting Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
