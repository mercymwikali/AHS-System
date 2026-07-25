Table 85513 "prEmployee Posting Group"
{
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "prEmployee Posting Group";
    LookupPageID = "prEmployee Posting Group";

    fields
    {
        field(50000; "Code"; Code[50])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[50])
        {
        }
        field(50002; "Salary Account"; Code[100])
        {
            TableRelation = "G/L Account";
        }
        field(50003; "Income Tax Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50004; "NSSF Employer Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50005; "NSSF Employee Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50006; "Net Salary Payable"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50007; "Operating Overtime"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50008; "Tax Relief"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50009; "Employee Provident Fund Acc."; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50010; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "G/L Account";
        }
        field(50011; "Pension Employer Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50012; "Pension Employee Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50013; "Earnings and deductions"; Code[50])
        {
        }
        field(50014; "Staff Benevolent"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50015; SalaryExpenseAC; Code[100])
        {
            TableRelation = "G/L Account";
        }
        field(50016; DirectorsFeeGL; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50017; StaffGratuityDebit; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50018; "SHIF Employee Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50019; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(50020; "Pension Payable Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50021; "NSSF Payable Acc"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50022; StaffGratuityCredit; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50023; "Housing Levy Employer Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50024; "Housing Levy Employee Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(50025; "NHIF Employee Account"; Code[50])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Earnings and deductions")
        {
        }
    }

    fieldgroups
    {
    }
}
