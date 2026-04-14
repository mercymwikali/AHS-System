Table 85537 "prPension Details"
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Pension Number"; Code[50])
        {
            NotBlank = true;
        }
        field(50002; Company; Text[100])
        {
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
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(50009; "Inception Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Pension Number", Company)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
