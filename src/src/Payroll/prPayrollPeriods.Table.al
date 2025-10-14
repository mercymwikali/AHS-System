Table 52202580 "prPayroll Periods"
{
    LookupPageID = "prPayroll Periods";

    fields
    {
        field(1; "Period Month"; Integer)
        {
            NotBlank = true;
        }
        field(2; "Period Year"; Integer)
        {
            NotBlank = true;
        }
        field(3; "Period Name"; Text[30])
        {
            Description = 'e.g November 2009';
            NotBlank = true;
        }
        field(4; "Date Opened"; Date)
        {
            NotBlank = true;
        }
        field(5; "Date Closed"; Date)
        {
        }
        field(6; Closed; Boolean)
        {
            Description = 'A period is either closed or open';
        }
        field(7; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(8; "Tax Paid"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Payroll Period" = field("Date Opened"),
                                                                    "Group Order" = const(7),
                                                                    "Sub Group Order" = const(3)));
            FieldClass = FlowField;
        }
        field(9; "Payslip Message"; Text[250])
        {
        }
        field(10; "Allow View of Online Payslips"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Date Opened")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
