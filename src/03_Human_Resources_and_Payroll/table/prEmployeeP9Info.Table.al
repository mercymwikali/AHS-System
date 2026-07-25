Table 85512 "prEmployee P9 Info"
{
    DrillDownPageID = "prEmployee History";
    LookupPageID = "prEmployee History";

    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Basic Pay"; Decimal)
        {
        }
        field(50002; Allowances; Decimal)
        {
        }
        field(50003; Benefits; Decimal)
        {
        }
        field(50004; "Value Of Quarters"; Decimal)
        {
        }
        field(50005; "Defined Contribution"; Decimal)
        {
        }
        field(50006; "Owner Occupier Interest"; Decimal)
        {
        }
        field(50007; "Gross Pay"; Decimal)
        {
        }
        field(50008; "Taxable Pay"; Decimal)
        {
        }
        field(50009; "Tax Charged"; Decimal)
        {
        }
        field(50010; "Insurance Relief"; Decimal)
        {
        }
        field(50011; "Tax Relief"; Decimal)
        {
        }
        field(50012; PAYE; Decimal)
        {
        }
        field(50013; NSSF; Decimal)
        {
        }
        field(50014; NHIF; Decimal)
        {
        }
        field(50015; Deductions; Decimal)
        {
        }
        field(50016; "Net Pay"; Decimal)
        {
        }
        field(50017; "Period Month"; Integer)
        {
        }
        field(50018; "Period Year"; Integer)
        {
        }
        field(50019; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50020; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50021; Pension; Decimal)
        {
        }
        field(50022; HELB; Decimal)
        {
        }
        field(50023; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(50025; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50024; "Housing Levy"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Payroll Period")
        {
            Clustered = true;
            SumIndexFields = "Basic Pay", "Gross Pay", "Net Pay", Allowances, Deductions, PAYE, NSSF, NHIF;
        }
    }

    fieldgroups
    {
    }
}
