Table 85086 "CshMgt Approvals"
{
    fields
    {
        field(50000; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Document Type"; Option)
        {
            OptionMembers = PV,PC;
        }
        field(50002; "Document No."; Code[20])
        {
        }
        field(50003; "Document Date"; Date)
        {
        }
        field(50004; "Process Date"; Date)
        {
        }
        field(50005; "Process Time"; Time)
        {
        }
        field(50006; "Process User ID"; Code[20])
        {
        }
        field(50007; "Process Name"; Code[20])
        {
        }
        field(50008; "Process Machine"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
