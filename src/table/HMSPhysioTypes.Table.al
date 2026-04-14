Table 85227 "HMS PhysioTypes"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; pfno; Code[10])
        {
        }
        field(50001; "code"; Code[10])
        {
        }
        field(50002; Amounttt; Decimal)
        {
        }
        field(50003; "No."; Integer)
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
