Table 85382 "Disciplinary Remarks"
{
    fields
    {
        field(50000; Remark; Code[50])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[200])
        {
        }
        field(50002; Comments; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; Remark)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
