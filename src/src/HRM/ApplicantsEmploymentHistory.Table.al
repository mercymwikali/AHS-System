Table 52202800 "Applicants Employment History"
{
    LookupPageID = "Applicants Employment History";

    fields
    {
        field(2; From; Date)
        {
            NotBlank = true;
        }
        field(3; "To"; Date)
        {
            NotBlank = true;
        }
        field(4; "Company Name"; Text[150])
        {
            NotBlank = true;
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
            Editable = false;
            FieldClass = Normal;
        }
        field(17; "No. Series"; Code[50])
        {
        }
        field(18; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(19; Username; Code[30])
        {
        }
        field(20; "Email Address"; Code[30])
        {
        }
        field(21; "Supervisor Name Title"; Code[100])
        {
        }
        field(22; "Application No"; Code[20])
        {
        }
        field(23; "To Date"; date)
        {
        }
        field(24; "Phone Number"; code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
