Table 52202612 prEmployeeRepeatingTx
{
    fields
    {
        field(1; "Employee Code"; Code[10])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(2; "Transaction Code"; Code[20])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(3; "Transaction Name"; Text[30])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Balance; Decimal)
        {
        }
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(10; "#of Repayments"; Integer)
        {
        }
        field(12; "Reference No"; Text[50])
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
