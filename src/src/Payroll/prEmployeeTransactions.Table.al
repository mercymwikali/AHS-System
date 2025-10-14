Table 52202590 "prEmployee Transactions"
{
    fields
    {
        field(1; "Employee Code"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(2; "Transaction Code"; Code[30])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";

            trigger OnValidate()
            begin

                blnIsLoan := false;
                if objTransCodes.Get("Transaction Code") then
                    "Transaction Name" := objTransCodes."Transaction Name";
                //"Payroll Period":=SelectedPeriod;
                //"Period Month":=PeriodMonth;
                //"Period Year":=PeriodYear;
                if objTransCodes."Special Transactions" = 8 then
                    blnIsLoan := true;
            end;
        }
        field(3; "Transaction Name"; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Balance; Decimal)
        {
        }
        field(6; "Original Amount"; Decimal)
        {
        }
        field(7; "Period Month"; Integer)
        {
        }
        field(8; "Period Year"; Integer)
        {
        }
        field(9; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(10; "#of Repayments"; Integer)
        {
        }
        field(11; Membership; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(12; "Reference No"; Text[100])
        {
        }
        field(13; integera; Integer)
        {
        }
        field(14; "Employer Amount"; Decimal)
        {
        }
        field(15; "Employer Balance"; Decimal)
        {
        }
        field(16; "Stop for Next Period"; Boolean)
        {
        }
        field(17; "Amortized Loan Total Repay Amt"; Decimal)
        {
        }
        field(18; "Start Date"; Date)
        {
        }
        field(19; "End Date"; Date)
        {
        }
        field(20; "Loan Number"; Code[30])
        {
        }
        field(21; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(22; "No of Units"; Decimal)
        {
        }
        field(23; Suspended; Boolean)
        {
        }
        field(24; "Transaction Type"; Option)
        {
            CalcFormula = lookup("PR Transaction Codes"."Transaction Type" where("Transaction Code" = field("Transaction Code")));
            FieldClass = FlowField;
            OptionMembers = Income,Deduction;
        }
        field(25; "Loan Account No"; Code[30])
        {
        }
        field(26; "Emp Count"; Integer)
        {
            CalcFormula = count("HR-Employee" where("No." = field("Employee Code"),
                                                     Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(27; "PV Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(28; "Emp Status"; Option)
        {
            CalcFormula = lookup("HR-Employee".Status where("No." = field("Employee Code")));
            FieldClass = FlowField;
            OptionCaption = 'Normal,Resigned,Discharged,Retrenched,Pension,Disabled';
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(29; "Recurance Index"; Integer)
        {
        }
        field(30; "Loan Termination Date"; Date)
        {
        }
        field(31; "Loan Termination Reason"; Text[250])
        {
            trigger OnValidate()
            begin
                if "Loan Terminated by" = '' then begin
                    "Loan Termination Date" := Today;
                    "Loan Terminated by" := UserId;
                    Modify();
                end else
                    if "Loan Terminated by" <> UserId then
                        Error('The reason can only be modified by ' + "Loan Terminated by");
            end;
        }
        field(32; "Loan Terminated by"; Code[20])
        {
        }
        field(33; "Non Cash Benefit"; Boolean)
        {
            CalcFormula = lookup("PR Transaction Codes"."Non Cash Benefit" where("Transaction Code" = field("Transaction Code")));
            FieldClass = FlowField;
        }
        field(34; "No relief"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Unit Code"; code[20])
        {
            // TableRelation = "Courses Master".code;
            DataClassification = ToBeClassified;
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

    trigger OnInsert()
    begin
        "Recurance Index" := 999;
    end;

    var
        objTransCodes: Record "PR Transaction Codes";
        blnIsLoan: Boolean;
}
