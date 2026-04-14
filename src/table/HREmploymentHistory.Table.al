Table 85415 "HR Employment History"
{
    LookupPageID = "Interbank Transfer";

    fields
    {
        field(50000; "Employee No."; Code[20])
        {
            NotBlank = false;
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; From; Date)
        {
            NotBlank = false;
        }
        field(50002; "To Date"; Date)
        {
            NotBlank = false;
        }
        field(50003; "Company Name"; Text[150])
        {
            NotBlank = false;
        }
        field(50004; "Postal Address"; Text[40])
        {
        }
        field(50005; "Address 2"; Text[40])
        {
        }
        field(50006; "Job Title"; Text[150])
        {
        }
        field(50007; "Key Experience"; Text[150])
        {
        }
        field(50008; "Salary On Leaving"; Decimal)
        {
        }
        field(50009; "Reason For Leaving"; Text[150])
        {
        }
        field(50010; Comment; Text[200])
        {
            Editable = true;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
