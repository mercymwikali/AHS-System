Table 85334 "Patients Doctor's Advice"
{
    fields
    {
        field(50000; "Patient Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50001; Date; Date)
        {
            NotBlank = true;
        }
        field(50002; Time; Time)
        {
        }
        field(50003; "Doctor Code"; Text[20])
        {
            TableRelation = Resource."No." where(Type = const(2));
        }
        field(50004; "Consultancy Charges"; Code[20])
        {
            TableRelation = Resource."No." where(Type = const(Machine));
        }
        field(50005; "Doctors Advice"; Text[200])
        {
            TableRelation = "Doctors Advice".Advice;
        }
        field(50006; Posted; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Date, "Patient Code", "Doctor Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
