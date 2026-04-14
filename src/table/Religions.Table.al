Table 85463 Religions
{
    fields
    {
        field(50000; Religion; Code[50])
        {
            NotBlank = true;
        }
        field(50001; Remarks; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; Religion)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
