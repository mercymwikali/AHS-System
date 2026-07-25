Table 85128 "Receipt Items"
{
    fields
    {
        field(50000; "Receipt No"; Code[20])
        {
            TableRelation = Receipt."Student No.";
        }
        field(50001; "Code"; Code[20])
        {
        }
        field(50002; Description; Text[120])
        {
        }
        field(50003; Amount; Decimal)
        {
        }
        field(50004; Balance; Decimal)
        {
        }
        field(50005; Date; Date)
        {
        }
        field(50006; Programme; Code[20])
        {
        }
        field(50007; Stage; Code[20])
        {
        }
        field(50008; Unit; Code[20])
        {
        }
        field(50009; Semester; Code[20])
        {
        }
        field(50010; "Settlement Type"; Code[30])
        {
        }
        field(50011; "Transaction ID"; Code[20])
        {
        }
        field(50012; "Student No."; Code[20])
        {
        }
        field(50013; "Amount P"; Decimal)
        {
        }
        field(50014; "Uniq No."; Integer)
        {
        }
        field(50015; "Uniq No 2"; Integer)
        {
        }
        field(50016; Campus; Code[20])
        {
        }
        field(50017; Course; Code[20])
        {
        }
        field(50018; Posted; Boolean)
        {
        }
        field(50019; Upposted; Boolean)
        {
        }
        field(50020; "Reg. No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Receipt No", "Uniq No 2", "Transaction ID", Description)
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; Description)
        {
        }
        key(Key3; Programme, Date)
        {
            SumIndexFields = Amount;
        }
        key(Key4; "Transaction ID", "Student No.", Date, Upposted)
        {
            SumIndexFields = Amount;
        }
        key(Key5; "Reg. No", "Student No.")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}
