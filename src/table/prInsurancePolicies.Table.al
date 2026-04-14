Table 85523 prInsurancePolicies
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Policy Number"; Code[50])
        {
            NotBlank = true;
        }
        field(50002; "Insurance Code"; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(50003; Amount; Decimal)
        {
        }
        field(50004; "Deduct premium"; Boolean)
        {
        }
        field(50005; balance; Decimal)
        {
        }
        field(50006; lumpsumitems; Boolean)
        {
            Description = 'lump sum the values';
        }
        field(50007; "Is Insurance policy"; Boolean)
        {
            Description = 'True if its an insurance policy';
        }
        field(50008; "Transaction Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Policy Number", "Insurance Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
