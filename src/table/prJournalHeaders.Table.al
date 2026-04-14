Table 85526 "prJournal Headers"
{
    fields
    {
        field(50000; "Trans Period"; Integer)
        {
        }
        field(50001; "Trans Year"; Integer)
        {
        }
        field(50002; "Country Code"; Code[20])
        {
        }
        field(50003; "Journal Type"; Code[20])
        {
        }
        field(50004; "Trans Date"; Date)
        {
        }
        field(50005; "Currency Code"; Code[20])
        {
        }
        field(50006; "JV Ref"; Code[20])
        {
        }
        field(50007; Narrative; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Trans Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
