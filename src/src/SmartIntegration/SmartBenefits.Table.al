table 52202693 "Smart Benefits"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; EntryNo; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Patient No"; Code[20])
        {
        }
        field(3; "Policy ID"; Code[50])
        {
        }
        field(4; "Global ID"; Code[250])
        {
        }
        field(5; Benefit; Text[250])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; PreAuthNeeded; Boolean)
        {
        }
        field(8; Claimable; Boolean)
        {
        }
        field(9; "DateTime Retrieved"; DateTime)
        {
        }
        field(10; "Membership No"; Code[50])
        {
        }
        field(11; "Membership Code"; Code[50])
        {
        }
        field(12; "Membership Plan"; Code[100])
        {
        }
        field(13; "Pool No"; Code[10])
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
