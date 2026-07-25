Table 85538 prPeriodLumpSummedItems
{
    fields
    {
        field(50000; "Employee Code"; Code[50])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "pay no"; Code[20])
        {
        }
        field(50002; "Transaction code"; Text[30])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(50003; "Transaction Number"; Code[20])
        {
        }
        field(50004; Amount; Decimal)
        {
        }
        field(50005; "cont to date"; Decimal)
        {
        }
        field(50006; Balance; Decimal)
        {
        }
        field(50007; "Period Month"; Integer)
        {
        }
        field(50008; "Period Year"; Integer)
        {
        }
        field(50009; "Payroll Period"; Date)
        {
        }
        field(50010; lumpsum; Boolean)
        {
            Description = 'Set to ''Yes'' to lumpsum the figures in the payslip - Denno';
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction code", "Transaction Number", "Period Month", "Period Year", "Payroll Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
