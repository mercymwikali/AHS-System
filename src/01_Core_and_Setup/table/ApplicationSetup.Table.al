Table 85576 "Application Setup"
{
    fields
    {
        field(50000; "Primary Key"; Code[20])
        {
            Description = 'Stores the constant key of the table';
        }
        field(50001; "Application Form Nos."; Code[20])
        {
            Description = 'Stores the reference to the numbering system of the application form numbers in the database';
            TableRelation = "No. Series".Code;
        }
        field(50002; "Summary Application Nos."; Code[20])
        {
            Description = 'Stores the reference to the numbering system of the batch numbers in the database';
            TableRelation = "No. Series".Code;
        }
        field(50003; "Minimum Age"; Integer)
        {
        }
        field(50004; "Maximum Age"; Integer)
        {
        }
        field(50005; "Admission Letter Signatory Nam"; Text[200])
        {
        }
        field(50006; "Admission Letter Sign. Title"; Code[120])
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
