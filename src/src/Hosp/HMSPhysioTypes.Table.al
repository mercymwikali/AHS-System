Table 52202624 "HMS PhysioTypes"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; pfno; Code[10])
        {
        }
        field(2; "code"; Code[10])
        {
        }
        field(3; Amounttt; Decimal)
        {
        }
        field(4; "No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; pfno)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
