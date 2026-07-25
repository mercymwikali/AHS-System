Table 85540 "prPeriod Transactions"
{
    DrillDownPageID = "prPeriodTransaction List";
    LookupPageID = "prPeriodTransaction List";

    fields
    {
        field(50000; "Employee Code"; Code[50])
        {
        }
        field(50001; "Transaction Code"; Text[30])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";
            TestTableRelation = false;
        }
        field(50002; "Group Text"; Text[30])
        {
            Description = 'e.g Statutory, Deductions, Tax Calculation etc';
        }
        field(50003; "Transaction Name"; Text[200])
        {
        }
        field(50004; Amount; Decimal)
        {
        }
        field(50005; Balance; Decimal)
        {
        }
        field(50006; "Original Amount"; Decimal)
        {
        }
        field(50007; "Group Order"; Integer)
        {
        }
        field(50008; "Sub Group Order"; Integer)
        {
        }
        field(50009; "Period Month"; Integer)
        {
        }
        field(50010; "Period Year"; Integer)
        {
        }
        field(50011; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50012; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50013; Membership; Code[50])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(50014; "Reference No"; Text[20])
        {
        }
        field(50015; "Department Code"; Code[50])
        {
        }
        field(50016; Lumpsumitems; Boolean)
        {
        }
        field(50017; TravelAllowance; Code[20])
        {
        }
        field(50018; "GL Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50019; "Company Deduction"; Boolean)
        {
            Description = 'Dennis- Added to filter out the company deductions esp: the Pensions';
        }
        field(50020; "Emp Amount"; Decimal)
        {
            Description = 'Dennis- Added to take care of the balances that need a combiantion btwn employee and employer';
        }
        field(50021; "Emp Balance"; Decimal)
        {
            Description = 'Dennis- Added to take care of the balances that need a combiantion btwn employee and employer';
        }
        field(50022; "Journal Account Code"; Code[20])
        {
        }
        field(50023; "Journal Account Type"; Option)
        {
            OptionMembers = " ","G/L Account",Customer,Vendor;
        }
        field(50024; "Post As"; Option)
        {
            OptionMembers = " ",Debit,Credit;
        }
        field(50025; "Loan Number"; Code[30])
        {
        }
        field(50026; "coop parameters"; Option)
        {
            Description = 'to be able to report the different coop contributions -Dennis';
            OptionMembers = "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime;
        }
        field(50027; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(50028; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,SACCO;
        }
        field(50029; "Total Statutories"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("Employee Code"),
                                                                    "Group Text" = const('STATUTORIES'),
                                                                    "Period Month" = field("Period Month"),
                                                                    "Period Year" = field("Period Year")));
            FieldClass = FlowField;
        }
        field(50030; "Trans Desc"; Text[200])
        {
            CalcFormula = lookup("prPeriod Transactions"."Transaction Name" where("Transaction Code" = field("Transaction Code"),
                                                                                   "Period Year" = const(2019),
                                                                                   "Period Month" = const(1)));
            FieldClass = FlowField;
        }
        field(50031; "Trans Desc2"; Text[200])
        {
            CalcFormula = lookup("PR Transaction Codes"."Transaction Name" where("Transaction Code" = field("Transaction Code")));
            FieldClass = FlowField;
        }
        field(50032; "Posting Group"; code[20])
        {
            CalcFormula = lookup("HR-Employee"."Payroll Posting Group" where("No." = field("Employee Code")));
            FieldClass = FlowField;
            TableRelation = "Employee Posting Group".Code;
        }
        field(50033; "Other parameters"; Option)
        {
            CalcFormula = lookup("PR Transaction Codes"."coop parameters" where("Transaction Code" = field("Transaction Code")));
            Caption = 'Other Categorization';
            Description = 'to be able to report the different coop contributions -Dennis';
            FieldClass = FlowField;
            OptionMembers = "none",shares,loan,"loan Interest","Emergency loan","Emergency loan Interest","School Fees loan","School Fees loan Interest",Welfare,Pension,NSSF,Overtime;
        }
        field(50034; "Global Dimension 1 code"; code[20])
        {
        }
        field(50035; "Prev. Payroll Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50036; "Employee Status"; Option)
        {
            CalcFormula = lookup("HR-Employee".Status where("No." = field("Employee Code")));
            FieldClass = FlowField;
            OptionCaption = 'Active,Resigned,Terminated,Retrenched,Pension,Inactive,Suspended,Deceased';
            OptionMembers = Active,Resigned,Terminated,Retrenched,Pension,Inactive,Suspended,Deceased;
        }
        field(50037; "Pension LK"; Boolean)
        {
            CalcFormula = lookup("PR Transaction Codes".Pension where("Transaction Code" = field("Transaction Code")));
            FieldClass = FlowField;
        }
        field(50038; "Transaction Group"; code[50])
        {
            //FieldClass = FlowField;
            // CalcFormula = lookup("prTransaction Codes"."Group Code" where("Transaction Code" = field("Transaction Code")));
        }
        field(50039; "Contract Type"; code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Contract Type"));
        }
        field(50040; "Employee Department"; code[20])
        {
            TableRelation = "HR-Employee"."Shortcut Dimension 2 Code" where("No." = field("Employee Code"));
        }
        field(50041; "PWD"; Boolean)
        {
            CalcFormula = lookup("HR-Employee"."Physical Disability" where("No." = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(50042; "PWD Exemption No"; Code[50])
        {
            //  CalcFormula = lookup("HR-Employee"."PWD Exemption No." where("No." = field("Employee Code")));
            //FieldClass = FlowField;
        }
        field(50043; "Bank Account No"; code[50])
        {
        }
        field(50044; "Bank Code"; code[50])
        {
        }
        field(50045; "Bank Branch"; code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; "Employee Code", "Period Month", "Period Year", "Group Order", "Sub Group Order", Membership, "Reference No")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Group Order", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No", "Department Code")
        {
            SumIndexFields = Amount;
        }
        key(Key4; Membership)
        {
        }
        key(Key5; "Transaction Code", "Payroll Period", Membership, "Reference No")
        {
            SumIndexFields = Amount;
        }
        key(Key6; "Payroll Period", "Group Order", "Sub Group Order")
        {
            SumIndexFields = Amount;
        }
        key(Key7; "Employee Code", "Department Code")
        {
            SumIndexFields = Amount;
        }
        key(Key8; "Transaction Name")
        {
        }
    }

    fieldgroups
    {
    }
}
