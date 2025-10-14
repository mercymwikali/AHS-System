Table 52202623 "Salary Increment"
{
    fields
    {
        field(1; "Emp Code"; Code[20])
        {
        }
        field(2; Salary; Decimal)
        {
        }
        field(3; "Employee Name"; Text[200])
        {
        }
        field(4; "% Increment"; Decimal)
        {
        }
        field(5; Increment; Decimal)
        {
        }
        field(6; "Old Salary"; Decimal)
        {
        }
        field(7; "Total Arrears"; Decimal)
        {
        }
        field(8; "Backdated Months"; Decimal)
        {
        }
        field(9; "Current Payroll Period"; Date)
        {
        }
        field(10; "Arrears Code"; Code[20])
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
