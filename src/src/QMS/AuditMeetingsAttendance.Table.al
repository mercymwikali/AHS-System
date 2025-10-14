Table 52202925 "Audit Meetings Attendance"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Meeting Code"; Code[20])
        {
        }
        field(3; Attendee; Code[30])
        {
        }
        field(4; "Date Created"; Date)
        {
        }
        field(5; "Created By"; Code[30])
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
