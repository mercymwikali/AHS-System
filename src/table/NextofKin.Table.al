Table 85116 "Next of Kin"
{
    fields
    {
        field(50000; "Patient No"; Code[20])
        {
        }
        field(50001; Names; Text[200])
        {
            NotBlank = true;
        }
        field(50002; Relationship; Code[20])
        {
        }
        field(50003; Occupation; Text[200])
        {
        }
        field(50004; "Date of Birth"; Date)
        {
        }
        field(50005; "Tel No"; Text[100])
        {
        }
        field(50006; "E-Mail"; Text[100])
        {
        }
        field(50007; Address; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; Names, "Patient No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
