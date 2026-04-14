Table 85547 "PR Transaction Codes"
{
    DataCaptionFields = "Transaction Name";
    DrillDownPageID = "prList TransCode";
    LookupPageID = "prList TransCode";

    fields
    {
        field(50000; "Transaction Code"; Code[50])
        {
            Description = 'Unique Trans line code';
        }
        field(50001; "Transaction Name"; Text[100])
        {
            Description = 'Description';
        }
        field(50002; "Balance Type"; Option)
        {
            Description = 'None,Increasing,Reducing';
            OptionMembers = "None",Increasing,Reducing;
        }
        field(50003; "Transaction Type"; Option)
        {
            Description = 'Income,Deduction';
            OptionMembers = Income,Deduction;
        }
        field(50004; Frequency; Option)
        {
            Description = 'Fixed,Varied';
            OptionMembers = "Fixed",Varied;
        }
        field(50005; "Is Cash"; Boolean)
        {
            Description = 'Does staff receive cash for this transaction';
        }
        field(50006; Taxable; Boolean)
        {
            Description = 'Is it taxable or not';
        }
        field(50007; "Is Formula"; Boolean)
        {
            Description = 'Is the transaction based on a formula';
        }
        field(50008; Formula; Text[200])
        {
            Description = '[Formula] If the above field is "Yes", give the formula';
        }
        field(50009; "Amount Preference"; Option)
        {
            Description = 'Either (Posted Amount), (Take Higher) or (Take Lower)';
            OptionMembers = "Posted Amount","Take Higher","Take Lower ";
        }
        field(50010; "Special Transactions"; Option)
        {
            Description = 'Represents all Special Transactions';
            OptionCaption = 'Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters,Morgage,Gratuity,Insurance Relief,Allowance Recovery';
            OptionMembers = Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage,Gratuity,"Insurance Relief","Allowance Recovery";
        }
        field(50011; "Deduct Premium"; Boolean)
        {
            Description = '[Insurance] Should the Premium be treated as a payroll deduction?';
        }
        field(50012; "Interest Rate"; Decimal)
        {
            Description = '[Loan] If above is "Yes", give the interest rate';
        }
        field(50013; "Repayment Method"; Option)
        {
            Description = '[Loan] Reducing,Straight line';
            OptionMembers = Reducing,"Straight line",Amortized;
        }
        field(50014; "Fringe Benefit"; Boolean)
        {
            Description = '[Loan] should the loan be treated as a Fringe Benefit?';
        }
        field(50015; "Employer Deduction"; Boolean)
        {
            Description = 'Caters for Employer Deductions';
        }
        field(50016; isHouseAllowance; Boolean)
        {
            Description = 'Flags if its house allowance - Dennis';
        }
        field(50017; "Include Employer Deduction"; Boolean)
        {
            Description = 'Is the transaction to include the employer deduction? - Dennis';
        }
        field(50018; "Is Formula for employer"; Text[200])
        {
            Description = '[Is Formula for employer] If the above field is "Yes", give the Formula for employer Dennis';
        }
        field(50019; "Transaction Code old"; Code[50])
        {
            Description = 'Old Unique Trans line code - Dennis';
        }
        field(50020; "GL Account"; Code[50])
        {
            Description = 'to post to GL account - Dennis';
            TableRelation = "G/L Account"."No.";
        }
        field(50021; "GL Employee Account"; Code[50])
        {
            Description = 'to post to GLemployee  account - Dennis';
        }
        field(50022; "coop parameters"; Option)
        {
            Caption = 'Other Categorization';
            Description = 'to be able to report the different coop contributions -Dennis';
            OptionMembers = "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime;
        }
        field(50023; "IsCoop/LnRep"; Boolean)
        {
            Description = 'to be able to report the different coop contributions -Dennis';
        }
        field(50024; "Deduct Mortgage"; Boolean)
        {
        }
        field(50025; Subledger; Option)
        {
            OptionMembers = " ",Customer,Vendor;
        }
        field(50026; Welfare; Boolean)
        {
        }
        field(50027; CustomerPostingGroup; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(50028; Pension; Boolean)
        {
        }
        field(50029; "itax Grouping"; Option)
        {
            Description = 'for iTax';
            OptionCaption = ' ,Housing Allowance,Transport Allowance,Leave Allowance,OT,Directors Fees';
            OptionMembers = " ","Housing Allowance","Transport Allowance","Leave Allowance",OT,"Directors Fees";
        }
        field(50030; "Non Cash Benefit"; Boolean)
        {
        }
        field(50031; Address; Text[100])
        {
        }
        field(50032; "Payroll Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50033; Amount; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = field("Transaction Code"),
                                                                    "Payroll Period" = field("Payroll Filter")));
            FieldClass = FlowField;
        }
        field(50034; "Maximum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Employer Maximum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Employee Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HR-Employee"."No.";
        }
        field(50037; "Employee Amount"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = field("Transaction Code"),
                                                                    "Payroll Period" = field("Payroll Filter"),
                                                                    "Employee Code" = field("Employee Filter")));
            FieldClass = FlowField;
        }
        field(50038; "Employee Balance"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Balance where("Transaction Code" = field("Transaction Code"),
                                                                     "Payroll Period" = field("Payroll Filter"),
                                                                     "Employee Code" = field("Employee Filter")));
            FieldClass = FlowField;
        }
        field(50039; "Imprest Surrender"; Boolean)
        {
        }
        field(50040; "Used Count"; Integer)
        {
            CalcFormula = count("prPeriod Transactions" where("Transaction Code" = field("Transaction Code"), "Payroll Period" = field("Payroll Filter")));
            FieldClass = FlowField;
        }
        field(50041; "Transaction grouping"; Integer)
        {
        }
        field(50042; "Grouping Name"; text[100])
        {
        }
        field(50043; "Exception"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Transaction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Transaction Code", "Transaction Name")
        {

        }
    }
}
