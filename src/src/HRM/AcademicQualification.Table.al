Table 52202514 "Academic Qualification"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Qualification; Code[30])
        {
        }
        field(3; "Order"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Qualification)
        {
        }
    }
}
