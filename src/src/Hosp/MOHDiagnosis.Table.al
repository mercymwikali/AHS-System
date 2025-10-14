Table 52202515 "MOH Diagnosis"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Diagnosis; Text[200])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Children,Adults';
            OptionMembers = Children,Adults;
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
