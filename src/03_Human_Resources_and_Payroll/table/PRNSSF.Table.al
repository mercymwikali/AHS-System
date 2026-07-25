Table 85555 "PR NSSF"
{
    fields
    {
        field(50000; Tier; Integer)
        {
        }
        field(50001; Earnings; Decimal)
        {
        }
        field(50002; "Pensionable Earnings"; Decimal)
        {
        }
        field(50003; "Tier 1 earnings"; Decimal)
        {
        }
        field(50004; "Tier 1 Employee Deduction"; Decimal)
        {
        }
        field(50005; "Tier 1 Employer Contribution"; Decimal)
        {
        }
        field(50006; "Tier 2 earnings"; Decimal)
        {
        }
        field(50007; "Tier 2 Employee Deduction"; Decimal)
        {
        }
        field(50008; "Tier 2 Employer Contribution"; Decimal)
        {
        }
        field(50009; "Lower Limit"; Decimal)
        {
        }
        field(50010; "Upper Limit"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Tier)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
