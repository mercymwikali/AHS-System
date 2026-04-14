Table 85164 "Edmonton Scale"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Treatment No"; Code[20])
        {
        }
        field(50002; "Patient No"; Code[30])
        {
        }
        field(50003; Pain; Integer)
        {
        }
        field(50004; Tiredness; Integer)
        {
        }
        field(50005; Drowsiness; Integer)
        {
        }
        field(50006; Nausea; Integer)
        {
        }
        field(50007; Appetite; Integer)
        {
        }
        field(50008; "Shortness of Breath"; Integer)
        {
        }
        field(50009; Depression; Integer)
        {
        }
        field(50010; Anxienty; Integer)
        {
        }
        field(50011; Wellbeing; Integer)
        {
        }
        field(50012; Other; Integer)
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
