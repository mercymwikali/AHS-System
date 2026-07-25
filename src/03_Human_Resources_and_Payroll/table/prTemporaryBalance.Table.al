Table 85545 prTemporaryBalance
{
    fields
    {
        field(50000; "Employee No"; Code[20])
        {
        }
        field(50001; "Transaction Code"; Code[20])
        {
        }
        field(50002; Balance; Decimal)
        {
        }
        field(50003; updated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Found; Boolean)
        {
            CalcFormula = exist("prPeriod Transactions" where("Employee Code" = field("Employee No"),
                                                               "Transaction Code" = field("Transaction Code"),
                                                               "Payroll Period" = field("PAyroll Period")));
            FieldClass = FlowField;
        }
        field(50005; "PAyroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
    }

    keys
    {
        key(Key1; "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
