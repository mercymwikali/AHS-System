Table 85262 "HMS Treatment Admission Notes"
{
    fields
    {
        field(50000; Line; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Patient No"; Code[20])
        {
        }
        field(50002; "Treatment No"; Code[20])
        {
        }
        field(50003; "Notes Type"; Option)
        {
            OptionCaption = ',Past Medical History,Past Surgical History,Social History,Investigations,Assessment and plan';
            OptionMembers = ,"Past Medical History","Past Surgical History","Social History",Investigations,"Assessment and plan";
        }
        field(50004; Notes; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Line)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
