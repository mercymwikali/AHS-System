Table 85525 "prJournal Details"
{
    fields
    {
        field(50000; "Journal Line"; Code[10])
        {
        }
        field(50001; "Account Code"; Code[20])
        {
        }
        field(50002; Narrative; Text[100])
        {
        }
        field(50003; "Transaction Amount"; Decimal)
        {
        }
        field(50004; Analysis0; Text[50])
        {
        }
        field(50005; Analysis1; Text[50])
        {
        }
        field(50006; Analysis2; Text[50])
        {
        }
        field(50007; Analysis3; Text[50])
        {
        }
        field(50008; Analysis4; Text[50])
        {
        }
        field(50009; Analysis5; Text[50])
        {
        }
        field(50010; "Period Month"; Integer)
        {
        }
        field(50011; "Period Year"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Journal Line")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
