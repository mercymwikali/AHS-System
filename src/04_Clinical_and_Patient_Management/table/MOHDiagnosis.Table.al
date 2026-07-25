Table 85326 "MOH Diagnosis"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; Diagnosis; Text[200])
        {
        }
        field(50002; Type; Option)
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
