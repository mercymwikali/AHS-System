Table 52202584 prTemporaryBalance
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
        }
        field(2; "Transaction Code"; Code[20])
        {
        }
        field(3; Balance; Decimal)
        {
        }
        field(4; updated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Found; Boolean)
        {
            CalcFormula = exist("prPeriod Transactions" where("Employee Code" = field("Employee No"),
                                                               "Transaction Code" = field("Transaction Code"),
                                                               "Payroll Period" = field("PAyroll Period")));
            FieldClass = FlowField;
        }
        field(6; "PAyroll Period"; Date)
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
