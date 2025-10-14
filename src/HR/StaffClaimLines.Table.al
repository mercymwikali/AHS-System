Table 52202872 "Staff Claim Lines"
{
    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                // IF Pay.GET(No) THEN
                // "Imprest Holder":=Pay."Account No.";
            end;
        }
        field(2; "Account No:"; Code[10])
        {
            Editable = true;
            NotBlank = false;
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin

                if GLAcc.Get("Account No:") then
                    "Account Name" := GLAcc.Name;
                GLAcc.Validate(GLAcc."No.");
                GLAcc.TestField("Direct Posting", true);
                "Budgetary Control A/C" := GLAcc."Budget Controlled";
                /* Pay.SETRANGE(Pay."No.",No);
                IF Pay.FINDFIRST THEN BEGIN
                 IF Pay."Account No."<>'' THEN
                "Imprest Holder":=Pay."Account No."
                 ELSE
                 // ERROR('Please Enter the Customer/Account Number');
                //END;
                  */
            end;
        }
        field(3; "Account Name"; Text[80])
        {
        }
        field(4; Amount; Decimal)
        {
            trigger OnValidate()
            begin

                ImprestHeader.Reset();
                ImprestHeader.SetRange(ImprestHeader."No.", No);
                if ImprestHeader.FindFirst() then begin
                    "Date Taken" := ImprestHeader.Date;
                    ImprestHeader.TestField("Responsibility Center");
                    ImprestHeader.TestField("Global Dimension 1 Code");
                    ImprestHeader.TestField("Shortcut Dimension 2 Code");
                    "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
                    "Currency Factor" := ImprestHeader."Currency Factor";
                    "Currency Code" := ImprestHeader."Currency Code";
                    if Purpose = '' then
                        Purpose := ImprestHeader.Purpose;
                end;

                if "Currency Factor" <> 0 then
                    "Amount LCY" := Amount / "Currency Factor"
                else
                    "Amount LCY" := Amount;
            end;
        }
        field(5; "Due Date"; Date)
        {
        }
        field(6; "Imprest Holder"; Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(7; "Actual Spent"; Decimal)
        {
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(41; "Apply to"; Code[20])
        {
        }
        field(42; "Apply to ID"; Code[20])
        {
        }
        field(44; "Surrender Date"; Date)
        {
        }
        field(45; Surrendered; Boolean)
        {
        }
        field(46; "M.R. No"; Code[20])
        {
        }
        field(47; "Date Issued"; Date)
        {
        }
        field(48; "Type of Surrender"; Option)
        {
            OptionMembers = " ",Cash,Receipt;
        }
        field(49; "Dept. Vch. No."; Code[20])
        {
        }
        field(50; "Cash Surrender Amt"; Decimal)
        {
        }
        field(51; "Bank/Petty Cash"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(52; "Surrender Doc No."; Code[20])
        {
        }
        field(53; "Date Taken"; Date)
        {
        }
        field(54; Purpose; Text[250])
        {
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(79; "Budgetary Control A/C"; Boolean)
        {
            Editable = false;
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the fourth global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(83; Committed; Boolean)
        {
        }
        field(84; "Advance Type"; Code[20])
        {
            Caption = 'Claim Type';
            TableRelation = "Receipts and Payment Types".Code where(Type = const(Claim),
                                                                     Blocked = const(false));

            trigger OnValidate()
            begin

                ImprestHeader.Reset();
                ImprestHeader.SetRange(ImprestHeader."No.", No);
                if ImprestHeader.FindFirst() then
                    if (ImprestHeader.Status = ImprestHeader.Status::Approved) or
                    (ImprestHeader.Status = ImprestHeader.Status::Posted) or
                    (ImprestHeader.Status = ImprestHeader.Status::"Pending Approval") then
                        Error('You Cannot Insert a new record when the status of the document is not Pending');

                RecPay.Reset();
                RecPay.SetRange(RecPay.Code, "Advance Type");
                RecPay.SetRange(RecPay.Type, RecPay.Type::Claim);
                if RecPay.Find('-') then begin
                    "Account No:" := RecPay."G/L Account";
                    Validate("Account No:");
                end;
            end;
        }
        field(85; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Currency Factor" <> 0 then
                    "Amount LCY" := Amount / "Currency Factor"
                else
                    "Amount LCY" := Amount;
            end;
        }
        field(86; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(87; "Amount LCY"; Decimal)
        {
        }
        field(88; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(89; "Claim Receipt No"; Code[20])
        {
        }
        field(90; "Expenditure Date"; Date)
        {
        }
        field(91; "Attendee/Organization Names"; Text[250])
        {
        }
        field(50000; "Lecturer No"; Code[20])
        {
            TableRelation = "HR-Employee"."No." where(Lecturer = const(true));
        }
        field(50002; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50008; "Budgeted Amount"; Decimal)
        {
            CalcFormula = sum("G/L Budget Entry".Amount where("Global Dimension 1 Code" = field("Global Dimension 1 Code"),
                                                               "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                               "G/L Account No." = field("Account No:"), Date = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50007; "Actual Expenditure"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Account No:"),
                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Code"),
                                                        "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                        "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50006; "Committed Amount"; Decimal)
        {
            CalcFormula = sum(Committment.Amount where("Shortcut Dimension 1 Code" = field("Global Dimension 1 Code"),
                                                        "Shortcut Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                        "G/L Account No." = field("Account No:"), "Posting Date" = field("Date Filter"), Cancelled = const(False)));
            FieldClass = FlowField;
        }
        field(500010; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50005; "Medical Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                ClaimLines.Reset();
                ClaimLines.SetRange(ClaimLines."Account No:", '6001006');
                ClaimLines.SetRange(ClaimLines."Imprest Holder", "Imprest Holder");
                if ClaimLines.Find('-') then
                    PrevAmt := PrevAmt + ClaimLines.Amount;

                ImprestHeader.Get(No);
                if Cust.Get(ImprestHeader."Account No.") then begin
                    EmpSal.Reset();
                    EmpSal.SetRange(EmpSal."Employee Code", Cust."Employee Job Group");
                    if EmpSal.Find('-') then
                        if "Medical Amount" < (EmpSal."Basic Pay" * 0.8) then
                            Amount := "Medical Amount" * 0.8
                        else
                            Error('Please note that the Medical Amount can be more than 80% of Basic Pay');
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Line No.", No)
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount LCY";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
       ImprestHeader.RESET;
       ImprestHeader.SETRANGE(ImprestHeader."No.",No);
       IF ImprestHeader.FINDFIRST THEN
         BEGIN
               IF (ImprestHeader.Status=ImprestHeader.Status::Approved) OR
               (ImprestHeader.Status=ImprestHeader.Status::Posted)OR
               (ImprestHeader.Status=ImprestHeader.Status::"Pending Approval") THEN
              ERROR('You Cannot Delete this record its status is not Pending');
         END;
         TESTFIELD(Committed,FALSE);
             */
    end;

    trigger OnInsert()
    begin

        ImprestHeader.Reset();
        ImprestHeader.SetRange(ImprestHeader."No.", No);
        if ImprestHeader.FindFirst() then begin
            "Date Taken" := ImprestHeader.Date;
            ImprestHeader.TestField("Responsibility Center");
            ImprestHeader.TestField("Global Dimension 1 Code");
            ImprestHeader.TestField("Shortcut Dimension 2 Code");
            "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
            "Currency Factor" := ImprestHeader."Currency Factor";
            "Currency Code" := ImprestHeader."Currency Code";
            if Purpose = '' then
                Purpose := ImprestHeader.Purpose;
        end;
    end;

    trigger OnModify()
    begin
        /*
       ImprestHeader.RESET;
       ImprestHeader.SETRANGE(ImprestHeader."No.",No);
       IF ImprestHeader.FINDFIRST THEN
         BEGIN
           IF (ImprestHeader.Status=ImprestHeader.Status::Approved) OR
               (ImprestHeader.Status=ImprestHeader.Status::Posted)OR
               (ImprestHeader.Status=ImprestHeader.Status::"Pending Approval") THEN
              ERROR('You Cannot Modify this record its status is not Pending');

           "Date Taken":=ImprestHeader.Date;
           "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
           "Shortcut Dimension 2 Code":=ImprestHeader."Shortcut Dimension 2 Code";
           "Shortcut Dimension 3 Code":=ImprestHeader."Shortcut Dimension 3 Code";
           "Shortcut Dimension 4 Code":=ImprestHeader."Shortcut Dimension 4 Code";
           "Currency Factor":=ImprestHeader."Currency Factor";
           "Currency Code":=ImprestHeader."Currency Code";
           IF Purpose='' THEN
           Purpose:=ImprestHeader.Purpose;
         END;

         TESTFIELD(Committed,FALSE);
             */
    end;

    var
        Cust: Record Customer;
        GLAcc: Record "G/L Account";
        EmpSal: Record "prSalary Card";
        RecPay: Record "Receipts and Payment Types";
        ClaimLines: Record "Staff Claim Lines";
        ImprestHeader: Record "Staff Claims Header";
        PrevAmt: Decimal;
}
