Table 85518 "prEmployer Deductions"
{
    fields
    {
        field(50000; "Employee Code"; Code[20])
        {
        }
        field(50001; "Transaction Code"; Code[20])
        {
        }
        field(50002; Amount; Decimal)
        {
        }
        field(50003; "Period Month"; Integer)
        {
        }
        field(50004; "Period Year"; Integer)
        {
        }
        field(50005; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50006; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}
