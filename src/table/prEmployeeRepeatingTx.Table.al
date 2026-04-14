Table 85514 prEmployeeRepeatingTx
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Transaction Code"; Code[20])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(50002; "Transaction Name"; Text[30])
        {
        }
        field(50003; Amount; Decimal)
        {
        }
        field(50004; Balance; Decimal)
        {
        }
        field(50005; "Period Month"; Integer)
        {
        }
        field(50006; "Period Year"; Integer)
        {
        }
        field(50007; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50008; "#of Repayments"; Integer)
        {
        }
        field(50009; "Reference No"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Reference No", "Period Month", "Period Year", "Payroll Period")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}
