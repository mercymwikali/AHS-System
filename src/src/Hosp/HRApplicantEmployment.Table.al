Table 52202908 "HR Applicant Employment"
{
    fields
    {
        field(1; "Applicant No"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HR-Employee"."No.";
        }
        field(2; From; Date)
        {
            NotBlank = false;
        }
        field(3; "To Date"; Date)
        {
            NotBlank = false;
        }
        field(4; "Company Name"; Text[150])
        {
            NotBlank = false;
        }
        field(5; "Postal Address"; Text[40])
        {
        }
        field(6; "Address 2"; Text[40])
        {
        }
        field(7; "Job Title"; Text[150])
        {
        }
        field(8; "Key Experience"; Text[150])
        {
        }
        field(9; "Salary On Leaving"; Decimal)
        {
        }
        field(10; "Reason For Leaving"; Text[150])
        {
        }
        field(16; Comment; Text[200])
        {
            Editable = true;
        }
        field(17; "Job ID"; Code[20])
        {
        }
        field(18; "Current Salary"; Decimal)
        {
        }
        field(19; "Expected Salary"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Applicant No", "Company Name", "Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
