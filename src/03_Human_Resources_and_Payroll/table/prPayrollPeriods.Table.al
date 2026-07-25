Table 85534 "prPayroll Periods"
{
    LookupPageID = "prPayroll Periods";

    fields
    {
        field(50000; "Period Month"; Integer)
        {
            NotBlank = true;
        }
        field(50001; "Period Year"; Integer)
        {
            NotBlank = true;
        }
        field(50002; "Period Name"; Text[30])
        {
            Description = 'e.g November 2009';
            NotBlank = true;
        }
        field(50003; "Date Opened"; Date)
        {
            NotBlank = true;
        }
        field(50004; "Date Closed"; Date)
        {
        }
        field(50005; Closed; Boolean)
        {
            Description = 'A period is either closed or open';
        }
        field(50006; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(50007; "Tax Paid"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Payroll Period" = field("Date Opened"),
                                                                    "Group Order" = const(7),
                                                                    "Sub Group Order" = const(3)));
            FieldClass = FlowField;
        }
        field(50008; "Payslip Message"; Text[250])
        {
        }
        field(50009; "Allow View of Online Payslips"; Boolean)
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
