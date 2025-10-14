Table 52202836 "HMS Treatment Admission Notes"
{
    fields
    {
        field(1; Line; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Patient No"; Code[20])
        {
        }
        field(3; "Treatment No"; Code[20])
        {
        }
        field(4; "Notes Type"; Option)
        {
            OptionCaption = ',Past Medical History,Past Surgical History,Social History,Investigations,Assessment and plan';
            OptionMembers = ,"Past Medical History","Past Surgical History","Social History",Investigations,"Assessment and plan";
        }
        field(5; Notes; Text[250])
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
