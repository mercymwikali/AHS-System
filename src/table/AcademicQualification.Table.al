Table 85356 "Academic Qualification"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; No; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; Qualification; Code[30])
        {
        }
        field(50002; "Order"; Integer)
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
