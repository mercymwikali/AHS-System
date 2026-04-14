Table 85509 "prEmployee Banks"
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Bank Code"; Code[20])
        {
            TableRelation = "Pr Bank Branches"."Bank Code";
        }
        field(50002; "Branch Code"; Code[20])
        {
            TableRelation = "Pr Bank Branches"."Branch Code";
        }
        field(50003; Default; Boolean)
        {
            InitValue = true;
        }
        field(50004; "Account No"; Text[50])
        {
        }
        field(50005; Percentage; Decimal)
        {
            Description = 'Refers to %of Net to be transfered to this A/C';
            InitValue = 100;
        }
        field(50006; Amount; Decimal)
        {
            Description = 'Refers to Amount to be transfered to this A/C';
            InitValue = 0;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Bank Code", "Branch Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
