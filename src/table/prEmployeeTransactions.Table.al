Table 85515 "prEmployee Transactions"
{
    fields
    {
        field(50000; "Employee Code"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50001; "Transaction Code"; Code[30])
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
        field(50002; "Transaction Name"; Text[100])
        {
        }
        field(50003; Amount; Decimal)
        {
        }
        field(50004; Balance; Decimal)
        {
        }
        field(50005; "Original Amount"; Decimal)
        {
        }
        field(50006; "Period Month"; Integer)
        {
        }
        field(50007; "Period Year"; Integer)
        {
        }
        field(50008; "Payroll Period"; Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50009; "#of Repayments"; Integer)
        {
        }
        field(50010; Membership; Code[20])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(50011; "Reference No"; Text[100])
        {
        }
        field(50012; integera; Integer)
        {
        }
        field(50013; "Employer Amount"; Decimal)
        {
        }
        field(50014; "Employer Balance"; Decimal)
        {
        }
        field(50015; "Stop for Next Period"; Boolean)
        {
        }
        field(50016; "Amortized Loan Total Repay Amt"; Decimal)
        {
        }
        field(50017; "Start Date"; Date)
        {
        }
        field(50018; "End Date"; Date)
        {
        }
        field(50019; "Loan Number"; Code[30])
        {
        }
        field(50020; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(50021; "No of Units"; Decimal)
        {
        }
        field(50022; Suspended; Boolean)
        {
        }
        field(50023; "Transaction Type"; Option)
        {
            CalcFormula = lookup("PR Transaction Codes"."Transaction Type" where("Transaction Code" = field("Transaction Code")));
            FieldClass = FlowField;
            OptionMembers = Income,Deduction;
        }
        field(50024; "Loan Account No"; Code[30])
        {
        }
        field(50025; "Emp Count"; Integer)
        {
            CalcFormula = count("HR-Employee" where("No." = field("Employee Code"),
                                                     Status = filter(Normal)));
            FieldClass = FlowField;
        }
        field(50026; "PV Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50027; "Emp Status"; Option)
        {
            CalcFormula = lookup("HR-Employee".Status where("No." = field("Employee Code")));
            FieldClass = FlowField;
            OptionCaption = 'Normal,Resigned,Discharged,Retrenched,Pension,Disabled';
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(50028; "Recurance Index"; Integer)
        {
        }
        field(50029; "Loan Termination Date"; Date)
        {
        }
        field(50030; "Loan Termination Reason"; Text[250])
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
        field(50031; "Loan Terminated by"; Code[20])
        {
        }
        field(50032; "Non Cash Benefit"; Boolean)
        {
            CalcFormula = lookup("PR Transaction Codes"."Non Cash Benefit" where("Transaction Code" = field("Transaction Code")));
            FieldClass = FlowField;
        }
        field(50033; "No relief"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Unit Code"; code[20])
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
