Table 85021 "Imprest Surrender Details"
{
    DrillDownPageId = "Imprest Surrender Details UP";
    LookupPageId = "Imprest Surrender Details UP";
    fields
    {
        field(50000; "Surrender Doc No."; Code[20])
        {
            Editable = false;
            NotBlank = true;

            trigger OnValidate()
            begin
                // IF Pay.GET(No) THEN
                // "Imprest Holder":=Pay."Account No.";
            end;
        }
        field(50001; "Account No:"; Code[10])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = if ("Imprest Surrender Type" = filter(Imprest)) "G/L Account"."No." where("Direct Posting" = const(true))
            else
            if ("Imprest Surrender Type" = filter(ItemCash)) Item."No.";

            trigger OnValidate()
            begin

                if GLAcc.Get("Account No:") then
                    "Account Name" := GLAcc.Name;
                GLAcc.TestField("Direct Posting", true);
                if Pay.Get("Surrender Doc No.") then
                    if Pay."Account No." <> '' then
                        "Imprest Holder" := Pay."Account No."
                    else
                        Error('Please Enter the Customer/Account Number');

                if "Imprest Surrender Type" = "imprest surrender type"::ItemCash then
                    if Items.Get("Account No:") then begin
                        "Account Name" := Items.Description;
                        "Unit of Measure" := Items."Base Unit of Measure";
                    end;
            end;
        }
        field(50002; "Account Name"; Text[50])
        {
            Editable = true;
        }
        field(50003; Amount; Decimal)
        {
            Editable = true;
        }
        field(50004; "Due Date"; Date)
        {
            Editable = false;
        }
        field(50005; "Imprest Holder"; Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(50006; "Actual Spent"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Actual Spent" > Amount then
                    Error('The Actual Spent Cannot be more than the Issued Amount');
                if "Currency Factor" <> 0 then
                    "Amount LCY" := "Actual Spent" / "Currency Factor"
                else
                    "Amount LCY" := "Actual Spent";
            end;
        }
        field(50007; "Apply to"; Code[20])
        {
            Editable = false;
        }
        field(50008; "Apply to ID"; Code[50])
        {
            Editable = false;
        }
        field(50009; "Surrender Date"; Date)
        {
            Editable = false;
        }
        field(50010; Surrendered; Boolean)
        {
            Editable = false;
        }
        field(50011; "Cash Receipt No"; Code[20])
        {
            TableRelation = "Receipts Header"."No." where(Posted = filter(true), "Customer No" = field("Imprest Holder"));

            trigger OnValidate()
            begin
                /*CustLedger.RESET;
                CustLedger.SETRANGE(CustLedger."Document No.","Cash Receipt No");
                CustLedger.SETRANGE(CustLedger."Source Code",'CASHRECJNL');
                CustLedger.SETRANGE(CustLedger.Open,TRUE);
                IF CustLedger.FIND('-') THEN
                 "Cash Receipt Amount":=ABS(CustLedger.Amount)
                ELSE BEGIN
                   "Cash Receipt Amount":=0;
                   MESSAGE();
                END;*/
                //"Cust. Ledger Entry"."Document No." WHERE (Source Code=CONST(CASHRECJNL),Open=CONST(Yes),Customer No.=FIELD(Account No:))

                if ReceiptH.Get("Cash Receipt No") then
                    "Cash Receipt Amount" := ReceiptH."Amount Recieved";
            end;
        }
        field(50012; "Date Issued"; Date)
        {
            Editable = false;
        }
        field(50013; "Type of Surrender"; Option)
        {
            OptionMembers = " ",Cash,Receipt;
        }
        field(50014; "Dept. Vch. No."; Code[20])
        {
        }
        field(50015; "Cash Surrender Amt"; Decimal)
        {
        }
        field(50016; "Bank/Petty Cash"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50017; "Doc No."; Code[20])
        {
            CalcFormula = lookup("Imprest Surrender Header"."Imprest Issue Doc. No" where(No = field("Surrender Doc No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50018; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = Dimension;
        }
        field(50019; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = Dimension;
        }
        field(50020; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = Dimension;
        }
        field(50021; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = Dimension;
        }
        field(50022; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = Dimension;
        }
        field(50023; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = Dimension;
        }
        field(50024; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = Dimension;
        }
        field(50025; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = Dimension;
        }
        field(50026; "VAT Prod. Posting Group"; Code[20])
        {
            Editable = false;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(50027; "Imprest Type"; Code[20])
        {
            TableRelation = "Receipts and Payment Types".Code where(Type = const(Imprest));
        }
        field(50028; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }
        field(50029; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Imprest Surrender Type" = "imprest surrender type"::ItemCash then begin
                    Amount := "Unit Cost (LCY)" * Quantity;
                    "Amount LCY" := "Unit Cost (LCY)" * Quantity;
                    Validate(Amount);
                end;
            end;
        }
        field(50030; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Account No:");
                TestField(Quantity);

                if "Imprest Surrender Type" = "imprest surrender type"::ItemCash then begin
                    Amount := "Unit Cost (LCY)" * Quantity;
                    "Amount LCY" := "Unit Cost (LCY)" * Quantity;
                    Validate(Amount);
                end;
            end;
        }
        field(50031; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50032; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(50033; "Amount LCY"; Decimal)
        {
        }
        field(50034; "Cash Surrender Amt LCY"; Decimal)
        {
        }
        field(50035; "Imprest Req Amt LCY"; Decimal)
        {
        }
        field(50036; "Cash Receipt Amount"; Decimal)
        {
        }
        field(50037; "Cheque/Deposit Slip No"; Code[20])
        {
            trigger OnValidate()
            begin
                //heckSlipDetails();
            end;
        }
        field(50038; "Cheque/Deposit Slip Date"; Date)
        {
            trigger OnValidate()
            begin
                /*
                GenLedgerSetup.GET;
                IF CALCDATE(GenLedgerSetup."Cheque Reject Period","Cheque/Deposit Slip Date")<=TODAY THEN
                  BEGIN
                    ERROR('The cheque date is not within the allowed range.');
                  END;

                CheckSlipDetails();
                */
            end;
        }
        field(50039; "Cheque/Deposit Slip Type"; Option)
        {
            OptionMembers = " "," Local","Up Country";
        }
        field(50040; "Cheque/Deposit Slip Bank"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50041; "Cash Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,EFT,Deposit Slip,Banker''s Cheque,RTGS,Custom3';
            OptionMembers = " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,Custom3;
        }
        field(50042; "Over Expenditure"; Decimal)
        {
        }
        field(50043; "Imprest Surrender Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Imprest,ItemCash';
            OptionMembers = Imprest,ItemCash;
        }
        field(50044; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
    }

    keys
    {
        key(Key1; "Surrender Doc No.", "Account No:", "Imprest Surrender Type")
        {
            Clustered = true;
            SumIndexFields = "Amount LCY", "Imprest Req Amt LCY", "Actual Spent";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Pay.Reset();
        Pay.SetRange(Pay.No, "Surrender Doc No.");
        if Pay.Find('-') then
            if (Pay.Status = Pay.Status::Posted) or (Pay.Status = Pay.Status::"Pending Approval")
            or (Pay.Status = Pay.Status::Approved) then
                Error('This Document is already Send for Approval/Approved or Posted');
    end;

    trigger OnModify()
    begin
        Pay.Reset();
        Pay.SetRange(Pay.No, "Surrender Doc No.");
        if Pay.Find('-') then
            if (Pay.Status = Pay.Status::Posted) or (Pay.Status = Pay.Status::"Pending Approval")
            or (Pay.Status = Pay.Status::Approved) then
                Error('This Document is already Send for Approval/Approved or Posted');
    end;

    var
        GLAcc: Record "G/L Account";
        Pay: Record "Imprest Surrender Header";
        Items: Record Item;
        ReceiptH: Record "Receipts Header";
}
