Table 85363 "Applicants Employment History"
{
    LookupPageID = "Applicants Employment History";

    fields
    {
        field(50000; From; Date)
        {
            NotBlank = true;
        }
        field(50001; "To"; Date)
        {
            NotBlank = true;
        }
        field(50002; "Company Name"; Text[150])
        {
            NotBlank = true;
        }
        field(50003; "Postal Address"; Text[40])
        {
        }
        field(50004; "Address 2"; Text[40])
        {
        }
        field(50005; "Job Title"; Text[150])
        {
        }
        field(50006; "Key Experience"; Text[150])
        {
        }
        field(50007; "Salary On Leaving"; Decimal)
        {
        }
        field(50008; "Reason For Leaving"; Text[150])
        {
        }
        field(50009; Comment; Text[200])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50010; "No. Series"; Code[50])
        {
        }
        field(50011; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50012; Username; Code[30])
        {
        }
        field(50013; "Email Address"; Code[30])
        {
        }
        field(50014; "Supervisor Name Title"; Code[100])
        {
        }
        field(50015; "Application No"; Code[20])
        {
        }
        field(50016; "To Date"; date)
        {
        }
        field(50017; "Phone Number"; code[50])
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
