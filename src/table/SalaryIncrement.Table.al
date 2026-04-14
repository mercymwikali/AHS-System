Table 85554 "Salary Increment"
{
    fields
    {
        field(50000; "Emp Code"; Code[20])
        {
        }
        field(50001; Salary; Decimal)
        {
        }
        field(50002; "Employee Name"; Text[200])
        {
        }
        field(50003; "% Increment"; Decimal)
        {
        }
        field(50004; Increment; Decimal)
        {
        }
        field(50005; "Old Salary"; Decimal)
        {
        }
        field(50006; "Total Arrears"; Decimal)
        {
        }
        field(50007; "Backdated Months"; Decimal)
        {
        }
        field(50008; "Current Payroll Period"; Date)
        {
        }
        field(50009; "Arrears Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Emp Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
