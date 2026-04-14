Table 85019 "Imprest Header"

{
    DrillDownPageId = "Imprest Lists";
    LookupPageId = "Imprest Lists";

    fields
    {
        field(50000; "No."; code[20])
        {
            Description = 'Stores the reference of the payment voucher in the database';
            NotBlank = false;
        }
        field(50001; Date; Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';

            trigger OnValidate()
            begin
                if ImpLinesExist() then
                    Error('You first need to delete the existing imprest lines before changing the Currency Code'
                    );

                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor();

                if "Currency Code" <> xRec."Currency Code" then
                    UpdateCurrencyFactor()
                //RecreatePurchLines(FIELDCAPTION("Currency Code"));
                else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor();

                UpdateHeaderToLine();
            end;
        }
        field(50002; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50003; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            Enabled = true;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if ImpLinesExist() then
                    Error('You first need to delete the existing imprest lines before changing the Currency Code'
                    );

                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor();

                if "Currency Code" <> xRec."Currency Code" then
                    UpdateCurrencyFactor()
                //RecreatePurchLines(FIELDCAPTION("Currency Code"));
                else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor();

                UpdateHeaderToLine();
            end;
        }
        field(50004; Payee; Text[100])
        {
            Description = 'Stores the name of the person who received the money';
        }
        field(50005; "On Behalf Of"; Text[100])
        {
            Description = 'Stores the name of the person on whose behalf the payment voucher was taken';
        }
        field(50006; Cashier; Text[100])
        {
            Description = 'Stores the identifier of the cashier in the database';
        }
        field(50007; Posted; Boolean)
        {
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(50008; "Date Posted"; Date)
        {
            Description = 'Stores the date when the payment voucher was posted';
        }
        field(50009; "Time Posted"; Time)
        {
            Description = 'Stores the time when the payment voucher was posted';
        }
        field(50010; "Posted By"; Code[20])
        {
            Description = 'Stores the name of the person who posted the payment voucher';
        }
        field(50011; "Total Payment Amount"; Decimal)
        {
            CalcFormula = sum("Imprest Lines".Amount where(No = field("No.")));
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Paying Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            begin
                "Bank Name" := '';
                if BankAcc.Get("Paying Bank Account") then
                    "Bank Name" := BankAcc.Name;
            end;
        }
        field(50013; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name;

                UpdateHeaderToLine();
            end;
        }
        field(50014; Status; Option)
        {
            Description = 'Stores the status of the record in the database';
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook,"Pending Approval",Approved;
            trigger OnValidate()
            var
                ComRec: Record Committment;
            begin
                if Status = Status::Pending then begin
                    ComRec.reset();
                    ComRec.setrange("Document No.", "No.");
                    if ComRec.find('-') then
                        ComRec.DeleteAll();
                end;
            end;
        }
        field(50015; "Payment Type"; Option)
        {
            OptionMembers = Imprest;
        }
        field(50016; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;

                UpdateHeaderToLine();
            end;
        }
        field(50017; "Function Name"; Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(50018; "Budget Center Name"; Text[100])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(50019; "Bank Name"; Text[100])
        {
            Description = 'Stores the description of the paying bank account in the database';
        }
        field(50020; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(50021; Select; Boolean)
        {
            Description = 'Enables the user to select a particular record';
        }
        field(50022; "Total VAT Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line"."VAT Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "Total Witholding Tax Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line"."Withholding Tax Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Total Net Amount"; Decimal)
        {
            CalcFormula = sum("Imprest Lines".Amount where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Current Status"; Code[20])
        {
            Description = 'Stores the current status of the payment voucher in the database';
        }
        field(50026; "Cheque No."; Code[20])
        {
        }
        field(50027; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit","Custom 3","Custom 4","Custom 5";
        }
        field(50028; "Payment Release Date"; Date)
        {
            trigger OnValidate()
            begin

                //Changed to ensure Release date is not less than the Date entered
                if "Payment Release Date" < Date then
                    Error('The Payment Release Date cannot be lesser than the Document Date');
            end;
        }
        field(50029; "No. Printed"; Integer)
        {
        }
        field(50030; "VAT Base Amount"; Decimal)
        {
        }
        field(50031; "Exchange Rate"; Decimal)
        {
        }
        field(50032; "Currency Reciprical"; Decimal)
        {
        }
        field(50033; "Current Source A/C Bal."; Decimal)
        {
        }
        field(50034; "Cancellation Remarks"; Text[250])
        {
        }
        field(50035; "Register Number"; Integer)
        {
        }
        field(50036; "From Entry No."; Integer)
        {
        }
        field(50037; "To Entry No."; Integer)
        {
        }
        field(50038; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(50039; "Total Net Amount LCY"; Decimal)
        {
            CalcFormula = sum("Payment Line".Amount where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50040; "Document Type"; Option)
        {
            OptionMembers = "Payment Voucher","Petty Cash";
        }
        field(50041; "Shortcut Dimension 3 Code"; Code[10])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 3);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name;

                UpdateHeaderToLine();
            end;
        }
        field(50042; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                DimVal.SetRange(DimVal."Global Dimension No.", 4);
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name;

                UpdateHeaderToLine();
            end;
        }
        field(50043; Dim3; Text[250])
        {
        }
        field(50044; Dim4; Text[250])
        {
        }
        field(50045; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin

                TestField(Status, Status::Pending);
                if not UserMgt.CheckRespCenter(1, "Shortcut Dimension 3 Code") then
                    Error(
                      Text001,
                      RespCenter.TableCaption, UserMgt.GetPurchasesFilter());
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */
            end;
        }
        field(50046; "Account Type"; Option)
        {
            Caption = 'Account Type';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(50047; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            Editable = true;
            TableRelation = if ("Account Type" = const(Customer)) Customer;

            trigger OnValidate()
            begin
                Cust.Reset();
                if Cust.Get("Account No.") then begin
                    Cust.TestField("Gen. Bus. Posting Group");
                    Cust.TestField(Blocked, Cust.Blocked::" ");
                    Payee := Cust.Name;
                    "On Behalf Of" := Cust.Name;
                end;
                //Check CreditLimit Here In cases where you have a credit limit set for employees
                Cust.CalcFields(Cust."Balance (LCY)");
                if (Cust."Balance (LCY)" > Cust."Credit Limit (LCY)") and (UserId <> 'MU0\4804') then
                    Error('You Have an unaccounted balance of %1. Please consult Finance Department', Cust."Balance (LCY)");

                // END;
            end;
        }
        field(50048; "Surrender Status"; Option)
        {
            OptionMembers = " ",Full,Partial;
        }
        field(50049; Purpose; Text[250])
        {
        }
        field(50050; "Payment Voucher No"; Code[20])
        {
        }
        field(50051; "Serial No."; Code[20])
        {
        }
        field(50052; "Budgeted Amount"; Decimal)
        {
            Editable = false;
        }
        field(50053; "Actual Expenditure"; Decimal)
        {
            Editable = false;
        }
        field(50054; "Committed Amount"; Decimal)
        {
            Editable = false;
        }
        field(50055; "Budget Balance"; Decimal)
        {
            Editable = false;
        }
        field(50056; "Requested By"; Code[30])
        {
        }
        field(50057; "Employee No."; Code[30])
        {
            FieldClass = Normal;
            TableRelation = "HR-Employee"."No.";
        }
        field(50058; "PV No"; Code[20])
        {
            CalcFormula = lookup("Payments Header"."No." where("Apply to Document No" = field("No.")));
            FieldClass = FlowField;
        }
        field(50059; "Payment Schedule No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; Reversed; Boolean)
        {
            CalcFormula = lookup("Cust. Ledger Entry".Reversed where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50061; "imprest TYpe"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Imprest,Item Cash';
            OptionMembers = Imprest,"Item Cash";
        }
        field(50062; "Posted Count"; Integer)
        {
            CalcFormula = count("G/L Entry" where("Document No." = field("No."),
                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(50063; Committed; Boolean)
        {
            Caption = 'Documment Committed';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if (Status = Status::Approved) or (Status = Status::Posted) or (Status = Status::"Pending Approval") then
            Error('You Cannot Delete this record its status is not Pending');
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            GenLedgerSetup.Get();
            if "Payment Type" = "payment type"::Imprest then begin
                GenLedgerSetup.TestField(GenLedgerSetup."Imprest Req No");
                NoSeriesMgt.InitSeries(GenLedgerSetup."Imprest Req No", xRec."No. Series", 0D, "No.", "No. Series");
            end
        end;

        /*
        UserTemplate.RESET;
        UserTemplate.SETRANGE(UserTemplate.UserID,USERID);
        IF UserTemplate.FINDFIRST THEN
          BEGIN
            "Paying Bank Account":=UserTemplate."Default Payment Bank";
            VALIDATE("Paying Bank Account");
          END;
           */

        Date := Today;
        // Cashier := Format(UserId);
        // "Requested By" := Format(UserId);--->
        Validate(Cashier);
        Validate("Requested By");
        //{
        if UserSetup.Get(UserId) then begin
            "Account Type" := "account type"::Customer;
            "Account No." := UserSetup."Staff Travel Account";
            if UserSetup."Employee No." = '' then
                Error('You have not been created as an imprest user...\Consult the Finance department for guidance.');
            "Shortcut Dimension 2 Code" := UserSetup.Department;
            "Global Dimension 1 Code" := UserSetup."Branch Code";
            //"Responsibility Center"

            Validate("Account No.");
        end else
            Error('You have not been created as an imprest user...\Consult the Finance department for guidance.');
        //"Responsibility Center":='KARU';

        //"Budget Name":=GenLedgerSetup."Current Budget";
        //MODIFY;
        "HR-EMP".Reset();
        "HR-EMP".SetRange("HR-EMP"."User ID", UserId);
        if "HR-EMP".Find('-') then
            "Employee No." := "HR-EMP"."No.";
    end;

    trigger OnModify()
    begin
        if Status = Status::Pending then
            UpdateHeaderToLine();

        //IF (Status<>Status::Pending) OR (Status=Status::Posted)OR (Status=Status::"Pending Approval") THEN
        //      ERROR('You Cannot Modify this record its status is not Pending');
    end;

    var
        BankAcc: Record "Bank Account";
        GenLedgerSetup: Record "Cash Office Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        DimVal: Record "Dimension Value";
        "HR-EMP": Record "HR-Employee";
        ImpLines: Record "Payment Line";
        RespCenter: Record "Responsibility Center BR";
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserMgt: Codeunit "User Setup Management BR";
        Text001: label 'Your identification is set up to process from %1 %2 only.';

    procedure UpdateHeaderToLine()
    var
        PayLine: Record "Imprest Lines";
    begin
        PayLine.Reset();
        PayLine.SetRange(PayLine.No, "No.");
        if PayLine.Find('-') then
            repeat
                PayLine."Imprest Holder" := "Account No.";
                PayLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                PayLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                PayLine."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                PayLine."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                PayLine."Currency Code" := "Currency Code";
                PayLine."Currency Factor" := "Currency Factor";
                PayLine.Validate("Currency Factor");
                PayLine.Modify();
            until PayLine.Next() = 0;
    end;

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate := Date;
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;

    procedure ImpLinesExist(): Boolean
    begin
        ImpLines.Reset();
        ImpLines.SetRange(ImpLines.No, "No.");
        exit(ImpLines.FindFirst());
    end;
}
