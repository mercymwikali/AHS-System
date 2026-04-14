Table 85016 "Staff Advanc Surrender Details"
{
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
            NotBlank = true;
            TableRelation = "G/L Account"."No." where("Direct Posting" = const(true));

            trigger OnValidate()
            begin

                if GLAcc.Get("Account No:") then
                    "Account Name" := GLAcc.Name;
                GLAcc.TestField("Direct Posting", true);
                "Budgetary Control A/C" := GLAcc."Budget Controlled";
                Pay.SetRange(Pay.No, "Surrender Doc No.");
                if Pay.FindFirst() then
                    if Pay."Account No." <> '' then begin
                        "Advance Holder" := Pay."Account No.";
                        "Shortcut Dimension 1 Code" := Pay."Global Dimension 1 Code";
                        "Shortcut Dimension 2 Code" := Pay."Shortcut Dimension 2 Code";
                        "Currency Factor" := Pay."Currency Factor";
                        "Currency Code" := Pay."Currency Code";

                    end else
                        Error('Please Enter the Customer/Account Number');
            end;
        }
        field(50002; "Account Name"; Text[30])
        {
        }
        field(50003; Amount; Decimal)
        {
        }
        field(50004; "Due Date"; Date)
        {
            Editable = false;
        }
        field(50005; "Advance Holder"; Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(50006; "Actual Spent"; Decimal)
        {
            trigger OnValidate()
            begin
                //Allow actual spent to be more than amount if open for overexpenditure and from original document
                if not ("Allow Overexpenditure") and ("Line on Original Document") then;

                    /*
                    IF "Actual Spent">Amount THEN
                         ERROR('The Actual Spent Cannot be more than the Issued Amount');
                         */

                if "Actual Spent" > Amount then begin
                    "Difference Owed" := "Actual Spent" - Amount;
                    "Cash Surrender Amt" := 0;
                end
                else
                    if "Actual Spent" < Amount then begin
                        "Cash Surrender Amt" := Amount - "Actual Spent";
                        "Difference Owed" := 0;
                    end;
                // ERROR('The Actual Spent Cannot be more than the Issued Amount');
                if "Currency Factor" <> 0 then
                    "Amount LCY" := "Actual Spent" / "Currency Factor"
                else
                    "Amount LCY" := "Actual Spent";

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
            TableRelation = "Receipts Header"."No." where("Receipt Reference" = const("Other Advance Refunds"),
                                                           "Staff Number" = field("Advance Holder"),
                                                           "Currency Code" = field("Currency Code"));

            trigger OnValidate()
            begin

                if CashRcptHdr.Get("Cash Receipt No") then
                    "Actual Receipt Amount" := CashRcptHdr."Amount Recieved";
                "Cash Receipt Amount" := 0;
                "Cash Receipt Amount" := "Actual Receipt Amount";

                if "Cash Receipt No" <> '' then begin
                    OtherAdvSurrLines.Reset();
                    OtherAdvSurrLines.SetRange(OtherAdvSurrLines."Cash Receipt No", "Cash Receipt No");
                    if OtherAdvSurrLines.Find('-') then
                        repeat
                            if OtherAdvSurrLines."Surrender Doc No." <> "Surrender Doc No." then
                                if not Confirm('This Receipt is already in use do you want to continue using it', true, false) then
                                    Error('Assigning of receipt aborted');
                        until OtherAdvSurrLines.Next() = 0;
                end;
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
            Editable = false;
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
            Caption = 'Advance Type';
            TableRelation = "Receipts and Payment Types".Code where(Type = const(Advance));

            trigger OnValidate()
            begin
                ImprestHeader.Reset();
                ImprestHeader.SetRange(ImprestHeader.No, "Surrender Doc No.");
                if ImprestHeader.FindFirst() then
                    if (ImprestHeader.Status = ImprestHeader.Status::Approved) or
                    (ImprestHeader.Status = ImprestHeader.Status::Posted) or
                    (ImprestHeader.Status = ImprestHeader.Status::"Pending Approval") then
                        Error('You Cannot Insert a new record when the status of the document is not Pending');

                RecPay.Reset();
                RecPay.SetRange(RecPay.Code, "Imprest Type");
                RecPay.SetRange(RecPay.Type, RecPay.Type::Advance);
                if RecPay.Find('-') then begin
                    "Account No:" := RecPay."G/L Account";
                    "Account Name" := RecPay."Transation Remarks";
                    Validate("Account No:");
                end;
            end;
        }
        field(50028; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50029; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(50030; "Amount LCY"; Decimal)
        {
        }
        field(50031; "Cash Surrender Amt LCY"; Decimal)
        {
        }
        field(50032; "Imprest Req Amt LCY"; Decimal)
        {
        }
        field(50033; "Cash Receipt Amount"; Decimal)
        {
            trigger OnValidate()
            begin

                if "Cash Receipt Amount" <> 0 then
                    if "Cash Receipt No" = '' then
                        Error('You must select a receipt to before you can enter the amount receipted');

                //Get Total of Receipt used
                TotalForReceipt.SetCurrentkey("Cash Receipt No");
                TotalForReceipt.SetRange(TotalForReceipt."Cash Receipt No", "Cash Receipt No");
                TotalForReceipt.CalcSums(TotalForReceipt."Cash Receipt Amount");

                if "Actual Receipt Amount" < (TotalForReceipt."Cash Receipt Amount" + "Cash Receipt Amount") then
                    Error('The Cash Receipt Amounts linked to Advance accounting %1 cannot be more than the actual receipt amount of %2',
                    ("Cash Receipt Amount" + TotalForReceipt."Cash Receipt Amount"), "Actual Receipt Amount");
            end;
        }
        field(50034; "Line No."; Integer)
        {
        }
        field(50035; Committed; Boolean)
        {
        }
        field(50036; "Budgetary Control A/C"; Boolean)
        {
        }
        field(50037; "Line on Original Document"; Boolean)
        {
        }
        field(50038; "Allow Overexpenditure"; Boolean)
        {
        }
        field(50039; "Open for Overexpenditure by"; Code[20])
        {
        }
        field(50040; "Date opened for OvExpenditure"; Date)
        {
        }
        field(50041; "Actual Receipt Amount"; Decimal)
        {
        }
        field(50042; "Difference Owed"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Surrender Doc No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Amount LCY", "Imprest Req Amt LCY", "Actual Spent", "Cash Receipt Amount";
        }
        key(Key2; "Cash Receipt No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Don't Allow deleting of lines on original document
        if "Line on Original Document" then
            Error('You are not allowed to delete lines that were on the original issuing document');

        Pay.Reset();
        Pay.SetRange(Pay.No, "Surrender Doc No.");
        if Pay.Find('-') then
            if (Pay.Status = Pay.Status::Posted) or (Pay.Status = Pay.Status::"Pending Approval")
            or (Pay.Status = Pay.Status::Approved) then
                Error('This Document is already Send for Approval/Approved or Posted');

        TestField(Committed, false);
    end;

    trigger OnInsert()
    begin
        //Do not allow insertion of lines until the document is open for over expenditure
        Pay.Reset();
        Pay.SetRange(Pay.No, "Surrender Doc No.");
        if Pay.Find('-') then
            if not Pay."Allow Overexpenditure" then
                Error('You must first open the document to allow over expenditure and addition of lines');
    end;

    trigger OnModify()
    begin
        Pay.Reset();
        Pay.SetRange(Pay.No, "Surrender Doc No.");
        if Pay.Find('-') then
            if (Pay.Status = Pay.Status::Posted) or (Pay.Status = Pay.Status::"Pending Approval")
            or (Pay.Status = Pay.Status::Approved) then
                Error('This Document is already Send for Approval/Approved or Posted');
        Pay.TestField("Commitment Status", false);
    end;

    var
        GLAcc: Record "G/L Account";
        RecPay: Record "Receipts and Payment Types";
        CashRcptHdr: Record "Receipts Header";
        ImprestHeader: Record "Staff Advance Surrender Header";
        Pay: Record "Staff Advance Surrender Header";
        OtherAdvSurrLines: Record "Staff Advanc Surrender Details";
        TotalForReceipt: Record "Staff Advanc Surrender Details";
}
