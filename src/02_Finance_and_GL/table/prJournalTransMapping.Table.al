Table 85527 "prJournal Trans Mapping"
{
    fields
    {
        field(50000; "Transaction Code"; Code[10])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(50001; "GL Navision"; Text[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50002; "Append StaffCode"; Boolean)
        {
        }
        field(50003; "Is Formula"; Boolean)
        {
        }
        field(50004; Formula; Text[100])
        {
        }
        field(50005; Analysis0; Boolean)
        {
        }
        field(50006; Analysis1; Boolean)
        {
        }
        field(50007; Analysis2; Boolean)
        {
        }
        field(50008; Analysis3; Boolean)
        {
        }
        field(50009; Analysis4; Boolean)
        {
        }
        field(50010; Analysis5; Boolean)
        {
        }
        field(50011; "Amount (Dr/Cr)"; Option)
        {
            OptionMembers = Debit,Credit;
        }
        field(50012; "GL Others"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Transaction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
