table 85574 "Smart Benefits"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; EntryNo; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Patient No"; Code[20])
        {
        }
        field(50002; "Policy ID"; Code[50])
        {
        }
        field(50003; "Global ID"; Code[250])
        {
        }
        field(50004; Benefit; Text[250])
        {
        }
        field(50005; Amount; Decimal)
        {
        }
        field(50006; PreAuthNeeded; Boolean)
        {
        }
        field(50007; Claimable; Boolean)
        {
        }
        field(50008; "DateTime Retrieved"; DateTime)
        {
        }
        field(50009; "Membership No"; Code[50])
        {
        }
        field(50010; "Membership Code"; Code[50])
        {
        }
        field(50011; "Membership Plan"; Code[100])
        {
        }
        field(50012; "Pool No"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
