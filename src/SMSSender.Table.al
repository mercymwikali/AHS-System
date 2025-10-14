Table 52202921 "SMS Sender"
{
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Phone No"; Code[12])
        {
        }
        field(3; Message; Text[160])
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = ' ,Pending,Sent';
            OptionMembers = " ",Pending,Sent;
        }
        field(5; Date; Date)
        {
        }
        field(6; "Code"; Code[20])
        {
        }
        field(7; "Status Response"; Code[20])
        {
        }
        field(8; "Status Response Message"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
