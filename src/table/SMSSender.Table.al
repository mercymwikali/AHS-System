Table 85044 "SMS Sender"
{
    fields
    {
        field(50000; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Phone No"; Code[12])
        {
        }
        field(50002; Message; Text[160])
        {
        }
        field(50003; Status; Option)
        {
            OptionCaption = ' ,Pending,Sent';
            OptionMembers = " ",Pending,Sent;
        }
        field(50004; Date; Date)
        {
        }
        field(50005; "Code"; Code[20])
        {
        }
        field(50006; "Status Response"; Code[20])
        {
        }
        field(50007; "Status Response Message"; Text[100])
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
