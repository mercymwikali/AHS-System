Table 85496 "Hr Proffessional Membership"
{
    fields
    {
        field(50000; "Employee Code"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Membership No"; Code[30])
        {
        }
        field(50002; "Name of Body"; Text[200])
        {
        }
        field(50003; "Date of Membership"; Date)
        {
        }
        field(50004; "Membership Status"; Option)
        {
            OptionMembers = ,Active,Inactive;
        }
        field(50005; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50006; Remarks; Text[250])
        {
        }
        field(50007; "Subscription Commence Date"; Date)
        {
        }
        field(50008; "Subscription Renewal Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
