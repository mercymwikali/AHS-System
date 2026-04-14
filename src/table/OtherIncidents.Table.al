Table 85449 "Other Incidents"
{
    fields
    {
        field(50000; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Incident Date"; Date)
        {
            NotBlank = true;
        }
        field(50002; Incident; Text[200])
        {
            NotBlank = true;
        }
        field(50003; Comments; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Incident Date", Incident)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
