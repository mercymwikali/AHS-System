Table 52202846 "Edmonton Scale"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Treatment No"; Code[20])
        {
        }
        field(3; "Patient No"; Code[30])
        {
        }
        field(4; Pain; Integer)
        {
        }
        field(5; Tiredness; Integer)
        {
        }
        field(6; Drowsiness; Integer)
        {
        }
        field(7; Nausea; Integer)
        {
        }
        field(8; Appetite; Integer)
        {
        }
        field(9; "Shortness of Breath"; Integer)
        {
        }
        field(10; Depression; Integer)
        {
        }
        field(11; Anxienty; Integer)
        {
        }
        field(12; Wellbeing; Integer)
        {
        }
        field(13; Other; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
