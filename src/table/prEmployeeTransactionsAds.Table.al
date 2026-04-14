Table 85516 "prEmployee Transactions Ads"
{
    fields
    {
        field(50000; "Employee Code"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Transaction Code"; Code[30])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(50002; "Transaction Name"; Text[100])
        {
        }
        field(50003; Amount; Decimal)
        {
        }
        field(50004; Balance; Decimal)
        {
        }
        field(50005; "Original Amount"; Decimal)
        {
        }
        field(50006; "Period Month"; Integer)
        {
        }
        field(50007; "Period Year"; Integer)
        {
        }
        field(50008; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50009; "#of Repayments"; Integer)
        {
        }
        field(50010; Membership; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(50011; "Reference No"; Text[30])
        {
        }
        field(50012; integera; Integer)
        {
        }
        field(50013; imported; Boolean)
        {
            Description = 'flag if its imported';
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}
