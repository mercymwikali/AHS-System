Table 52202581 "PR Transaction Codes"
{
    DataCaptionFields = "Transaction Name";
    DrillDownPageID = "prList TransCode";
    LookupPageID = "prList TransCode";

    fields
    {
        field(1; "Transaction Code"; Code[50])
        {
            Description = 'Unique Trans line code';
        }
        field(3; "Transaction Name"; Text[100])
        {
            Description = 'Description';
        }
        field(4; "Balance Type"; Option)
        {
            Description = 'None,Increasing,Reducing';
            OptionMembers = "None",Increasing,Reducing;
        }
        field(5; "Transaction Type"; Option)
        {
            Description = 'Income,Deduction';
            OptionMembers = Income,Deduction;
        }
        field(6; Frequency; Option)
        {
            Description = 'Fixed,Varied';
            OptionMembers = "Fixed",Varied;
        }
        field(7; "Is Cash"; Boolean)
        {
            Description = 'Does staff receive cash for this transaction';
        }
        field(8; Taxable; Boolean)
        {
            Description = 'Is it taxable or not';
        }
        field(9; "Is Formula"; Boolean)
        {
            Description = 'Is the transaction based on a formula';
        }
        field(10; Formula; Text[200])
        {
            Description = '[Formula] If the above field is "Yes", give the formula';
        }
        field(16; "Amount Preference"; Option)
        {
            Description = 'Either (Posted Amount), (Take Higher) or (Take Lower)';
            OptionMembers = "Posted Amount","Take Higher","Take Lower ";
        }
        field(18; "Special Transactions"; Option)
        {
            Description = 'Represents all Special Transactions';
            OptionCaption = 'Ignore,Defined Contribution,Home Ownership Savings Plan,Life Insurance,Owner Occupier Interest,Prescribed Benefit,Salary Arrears,Staff Loan,Value of Quarters,Morgage,Gratuity,Insurance Relief,Allowance Recovery';
            OptionMembers = Ignore,"Defined Contribution","Home Ownership Savings Plan","Life Insurance","Owner Occupier Interest","Prescribed Benefit","Salary Arrears","Staff Loan","Value of Quarters",Morgage,Gratuity,"Insurance Relief","Allowance Recovery";
        }
        field(21; "Deduct Premium"; Boolean)
        {
            Description = '[Insurance] Should the Premium be treated as a payroll deduction?';
        }
        field(26; "Interest Rate"; Decimal)
        {
            Description = '[Loan] If above is "Yes", give the interest rate';
        }
        field(28; "Repayment Method"; Option)
        {
            Description = '[Loan] Reducing,Straight line';
            OptionMembers = Reducing,"Straight line",Amortized;
        }
        field(29; "Fringe Benefit"; Boolean)
        {
            Description = '[Loan] should the loan be treated as a Fringe Benefit?';
        }
        field(30; "Employer Deduction"; Boolean)
        {
            Description = 'Caters for Employer Deductions';
        }
        field(31; isHouseAllowance; Boolean)
        {
            Description = 'Flags if its house allowance - Dennis';
        }
        field(32; "Include Employer Deduction"; Boolean)
        {
            Description = 'Is the transaction to include the employer deduction? - Dennis';
        }
        field(33; "Is Formula for employer"; Text[200])
        {
            Description = '[Is Formula for employer] If the above field is "Yes", give the Formula for employer Dennis';
        }
        field(34; "Transaction Code old"; Code[50])
        {
            Description = 'Old Unique Trans line code - Dennis';
        }
        field(35; "GL Account"; Code[50])
        {
            Description = 'to post to GL account - Dennis';
            TableRelation = "G/L Account"."No.";
        }
        field(36; "GL Employee Account"; Code[50])
        {
            Description = 'to post to GLemployee  account - Dennis';
        }
        field(37; "coop parameters"; Option)
        {
            Caption = 'Other Categorization';
            Description = 'to be able to report the different coop contributions -Dennis';
            OptionMembers = "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime;
        }
        field(38; "IsCoop/LnRep"; Boolean)
        {
            Description = 'to be able to report the different coop contributions -Dennis';
        }
        field(39; "Deduct Mortgage"; Boolean)
        {
        }
        field(40; Subledger; Option)
        {
            OptionMembers = " ",Customer,Vendor;
        }
        field(41; Welfare; Boolean)
        {
        }
        field(42; CustomerPostingGroup; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(43; Pension; Boolean)
        {
        }
        field(44; "itax Grouping"; Option)
        {
            Description = 'for iTax';
            OptionCaption = ' ,Housing Allowance,Transport Allowance,Leave Allowance,OT,Directors Fees';
            OptionMembers = " ","Housing Allowance","Transport Allowance","Leave Allowance",OT,"Directors Fees";
        }
        field(45; "Non Cash Benefit"; Boolean)
        {
        }
        field(46; Address; Text[100])
        {
        }
        field(47; "Payroll Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(48; Amount; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = field("Transaction Code"),
                                                                    "Payroll Period" = field("Payroll Filter")));
            FieldClass = FlowField;
        }
        field(49; "Maximum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Employer Maximum Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Employee Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HR-Employee"."No.";
        }
        field(52; "Employee Amount"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = field("Transaction Code"),
                                                                    "Payroll Period" = field("Payroll Filter"),
                                                                    "Employee Code" = field("Employee Filter")));
            FieldClass = FlowField;
        }
        field(53; "Employee Balance"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Balance where("Transaction Code" = field("Transaction Code"),
                                                                     "Payroll Period" = field("Payroll Filter"),
                                                                     "Employee Code" = field("Employee Filter")));
            FieldClass = FlowField;
        }
        field(54; "Imprest Surrender"; Boolean)
        {
        }
        field(55; "Used Count"; Integer)
        {
            CalcFormula = count("prPeriod Transactions" where("Transaction Code" = field("Transaction Code"), "Payroll Period" = field("Payroll Filter")));
            FieldClass = FlowField;
        }
        field(50093; "Transaction grouping"; Integer)
        {
        }
        field(50094; "Grouping Name"; text[100])
        {
        }
        field(50095; "Exception"; Boolean)
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
