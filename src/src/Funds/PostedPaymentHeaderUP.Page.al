page 52203023 "Posted Payment Header UP"
{
    Caption = 'Posted Payment Voucher';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Payments Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec.Date)
                {
                    Editable = DateEditable;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Apply to Document Type"; Rec."Apply to Document Type")
                {
                    ToolTip = 'Specifies the value of the Apply to Document Type field.';
                }
                field("Apply to Document No"; Rec."Apply to Document No")
                {
                    ToolTip = 'Specifies the value of the Apply to Document No field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = GlobalDimension1CodeEditable;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = ShortcutDimension2CodeEditable;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Editable = "Pay ModeEditable";
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = "Currency CodeEditable";
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Editable = "Paying Bank AccountEditable";
                    ToolTip = 'Specifies the value of the Paying Bank Account field.';
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payment to';
                    Editable = PayeeEditable;
                    ToolTip = 'Specifies the value of the Payment to field.';
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Editable = "Payment NarrationEditable";
                    ToolTip = 'Specifies the value of the Payment Narration field.';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Reference No. field.';
                }
                field("Imprest No."; Rec."Imprest No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Imprest No. field.';
                }
                field("Function Name"; Rec."Function Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Function Name field.';
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Budget Center Name field.';
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    Editable = "Cheque TypeEditable";
                    ToolTip = 'Specifies the value of the Cheque Type field.';

                    trigger OnValidate()
                    begin
                        if Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check" then
                            "Cheque No.Editable" := false
                        else
                            "Cheque No.Editable" := true;
                    end;
                }
                field("Invoice Currency Code"; Rec."Invoice Currency Code")
                {
                    Editable = "Invoice Currency CodeEditable";
                    ToolTip = 'Specifies the value of the Invoice Currency Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                    ToolTip = 'Specifies the value of the Total Payment Amount field.';
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ToolTip = 'Specifies the value of the Total VAT Amount field.';
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Total Witholding Tax Amount field.';
                }
                field("Total Retention Amount"; Rec."Total Retention Amount")
                {
                    ToolTip = 'Specifies the value of the Total Retention Amount field.';
                }
                field("Total PAYE Amount"; Rec."Total PAYE Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total PAYE Amount field.';
                }
                field("""Total Payment Amount"" -( ""Total Witholding Tax Amount""+""Total Retention Amount"" + ""Total PAYE Amount"")"; Rec."Total Payment Amount" - (Rec."Total Witholding Tax Amount" + Rec."Total Retention Amount" + Rec."Total PAYE Amount"))
                {
                    Caption = 'Total Net Amount';
                    ToolTip = 'Specifies the value of the Total Net Amount field.';
                }
                field("""Total Payment Amount""-( ""Total Witholding Tax Amount""+""Total Retention Amount"" + ""Total PAYE Amount"")"; Rec."Total Payment Amount" - (Rec."Total Witholding Tax Amount" + Rec."Total Retention Amount" + Rec."Total PAYE Amount"))
                {
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Net Amount LCY field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Caption = 'Cheque/EFT No.';
                    Editable = true;
                    ToolTip = 'Specifies the value of the Cheque/EFT No. field.';

                    trigger OnValidate()
                    begin
                        //check if the cheque has been inserted
                        Rec.TestField("Paying Bank Account");
                        /*
                        PVHead.RESET;
                        PVHead.SETRANGE(PVHead."Paying Bank Account","Paying Bank Account");
                        PVHead.SETRANGE(PVHead."Pay Mode",PVHead."Pay Mode"::Cheque);
                        IF PVHead.FINDFIRST THEN
                          BEGIN
                            REPEAT
                              IF PVHead."Cheque No."="Cheque No." THEN
                                BEGIN
                                  IF PVHead."No."<>"No." THEN
                                    BEGIN
                                      ERROR('The Cheque Number has already been utilised');
                                    END;
                                END;
                            UNTIL PVHead.NEXT=0;
                          END;
                         */
                    end;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Editable = "Payment Release DateEditable";
                    ToolTip = 'Specifies the value of the Payment Release Date field.';
                }
                field("Cheque Printed"; Rec."Cheque Printed")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cheque Printed field.';
                }
                field("Financial Period"; Rec."Financial Period")
                {
                    ToolTip = 'Specifies the value of the Financial Period field.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
                field("Actual Expenditure"; Rec."Actual Expenditure")
                {
                    ToolTip = 'Specifies the value of the Actual Expenditure field.';
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    ToolTip = 'Specifies the value of the Committed Amount field.';
                }
                field("Budget Balance"; Rec."Budget Balance")
                {
                    ToolTip = 'Specifies the value of the Budget Balance field.';
                }
            }
            part(PVLines; "Payment Lines")
            {
                SubPageLink = No = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print/Preview")
            {
                Caption = 'Print/Preview';
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the Print/Preview action.';

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Pending then
                        //ERROR('You cannot Print until the document is released for approval');
                        Rec.Reset();
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::"Payment Voucher Vend", true, true, Rec);
                    Rec.Reset();
                end;
            }
            separator(Separator9)
            {
            }
            action("Print Applied Invoice")
            {
                Image = PaymentHistory;
                ToolTip = 'Executes the Print Applied Invoice action.';
                trigger OnAction()
                var
                    PatVisit: Record "HMS Patient Visit Nos";
                begin
                    IF Rec."Doctors Batch No" = '' THEN BEGIN
                        rcpt.RESET();
                        rcpt.SETRANGE(rcpt."No.", Rec."No.");
                        IF rcpt.FIND('-') THEN
                            REPORT.RUN(Report::"Payment Voucher App Inv2", TRUE, TRUE, rcpt);

                    END ELSE BEGIN
                        PatVisit.RESET();
                        PatVisit.SETRANGE("Batch No", Rec."Doctors Batch No");
                        PatVisit.SETRANGE("Doctor ID", Rec."Vendor No.");
                        IF PatVisit.FIND('-') THEN
                            REPORT.RUN(51929, TRUE, TRUE, PatVisit);
                    END;
                end;
            }
            action("Re-Open")
            {
                Image = ReleaseDoc;
                ToolTip = 'Executes the Re-Open action.';

                trigger OnAction()
                begin
                    if Confirm('Do you really want to re-open the document') then begin
                        Rec.CalcFields("Reversed PV");
                        Rec.CalcFields("Posted Count");
                        if Rec."Posted Count" > 0 then
                            Rec.TestField("Reversed PV", true);
                        Rec.Posted := false;
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnInit()
    begin
        DateEditable := true;
        PayeeEditable := true;
        ShortcutDimension2CodeEditable := true;
        "Payment NarrationEditable" := true;
        GlobalDimension1CodeEditable := true;
        "Cheque TypeEditable" := true;
        "Pay ModeEditable" := true;
        "Paying Bank AccountEditable" := true;
        "Payment Release DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        Rec."Payment Type" := Rec."Payment Type"::Normal;

        Rcpt.Reset();
        Rcpt.SetRange(Rcpt.Posted, false);
        Rcpt.SetRange(Rcpt.Cashier, UserId);
        if Rcpt.Count > 0 then
            if Confirm('There are still some unposted payments. Continue?', false) = false then
                Error('There are still some unposted payments. Please utilise them first');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        Rec."Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        Rec.Validate("Global Dimension 1 Code");
        Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Rec.Validate("Shortcut Dimension 2 Code");
        Rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        Rec.Validate("Shortcut Dimension 3 Code");
        Rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Rec.Validate("Shortcut Dimension 4 Code");
        Rec."Responsibility Center" := 'MAIN';
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;

        UpdateControls();
    end;

    var
        BankPayment: Record "Bank Payments";
        CashierLinks: Record "Cash Office User Template";
        Temp: Record "Cash Office User Template";
        CheckLedger: Record "Check Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
        ImprestHeader: Record "Imprest Header";
        PayLine: Record "Payment Line";
        Payments: Record "Payments Header";
        PVHead: Record "Payments Header";
        Rcpt: Record "Payments Header";
        TarriffCodes: Record "Tariff Codes";
        VBank: Record "Vendor Bank Account";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        CheckManagement: Codeunit CheckManagement;
        DocPrint: Codeunit "Document-Print";
        JournlPosted: Codeunit "Journal Post Successful";
        UserMgt: Codeunit "User Setup Management BR";
        AllKeyFieldsEntered: Boolean;
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        "Cheque TypeEditable": Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        HasLines: Boolean;
        [InDataSet]
        "Invoice Currency CodeEditable": Boolean;
        [InDataSet]
        PayeeEditable: Boolean;
        [InDataSet]
        "Paying Bank AccountEditable": Boolean;
        [InDataSet]
        "Payment NarrationEditable": Boolean;
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Pay ModeEditable": Boolean;
        Post: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        JBatch: Code[10];
        JTemplate: Code[10];
        LineNo: Integer;
        Text000: Label 'Do you want to Void Check No %1';
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        strText: Text[100];

    procedure PostPaymentVoucher()
    begin

        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.Find('+') then
            LineNo := GenJnlLine."Line No." + 1000
        else
            LineNo := 1000;
        GenJnlLine.DeleteAll();
        GenJnlLine.Reset();

        Payments.Reset();
        Payments.SetRange(Payments."No.", Rec."No.");
        if Payments.Find('-') then begin
            PayLine.Reset();
            PayLine.SetRange(PayLine.No, Payments."No.");
            if PayLine.Find('-') then
                repeat
                    PostHeader(Payments);
                until PayLine.Next() = 0;

            //Post:=FALSE;
            //Post:=JournlPosted.PostedSuccessfully();
            //IF Post THEN  BEGIN
            Rec.Posted := true;
            Rec.Status := Payments.Status::Posted;
            Rec."Posted By" := UserId;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec.Modify();

            //Post Reversal Entries for Commitments
            Doc_Type := Doc_Type::"Payment Voucher";
            CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");

            if ImprestHeader.Get(Rec."Apply to Document No") then begin
                ImprestHeader.Posted := true;
                ImprestHeader."Date Posted" := Today;
                ImprestHeader."Time Posted" := Time;
                ImprestHeader."Posted By" := UserId;
                ImprestHeader."Cheque No." := Rec."Cheque No.";
                ImprestHeader.Modify();
            end;
            if PVHead.Get(Rec."Apply to Document No") then begin
                PVHead.Posted := true;
                PVHead."Date Posted" := Today;
                PVHead."Time Posted" := Time;
                PVHead."Posted By" := UserId;
                PVHead.Modify();
            end;
        end;
        //END;
    end;

    procedure PostHeader(var Payment: Record "Payments Header")
    begin

        //IF (Payments."Pay Mode"=Payments."Pay Mode"::Cheque) AND ("Cheque Type"="Cheque Type"::"Computer Check") THEN
        //  ERROR('Cheque type has to be specified');

        if Payments."Pay Mode" = Payments."Pay Mode"::Cheque then
            if (Payments."Cheque No." = '') and (Rec."Cheque Type" = Rec."Cheque Type"::"Manual Check") then
                Error('Please ensure that the cheque number is inserted');

        if Payments."Pay Mode" = Payments."Pay Mode"::EFT then
            if Payments."Cheque No." = '' then;

        if Payments."Pay Mode" = Payments."Pay Mode"::"Letter of Credit" then
            if Payments."Cheque No." = '' then
                Error('Please ensure that the Letter of Credit ref no. is entered.');
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);

        if GenJnlLine.Find('+') then
            LineNo := GenJnlLine."Line No." + 1000
        else
            LineNo := 1000;

        LineNo := LineNo + 1000;
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Payment."Payment Release Date";
        if CustomerPayLinesExist() then
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
        else
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No." := Payments."No.";
        GenJnlLine."External Document No." := Payments."Cheque No.";

        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := Payments."Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");

        GenJnlLine."Currency Code" := Payments."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
        Payments.CalcFields(Payments."Total Net Amount");
        GenJnlLine.Amount := -(Payments."Total Net Amount");
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';

        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

        GenJnlLine.Description := CopyStr('Pay To:' + Payments.Payee, 1, 50);
        GenJnlLine.Validate(GenJnlLine.Description);

        if Rec."Pay Mode" <> Rec."Pay Mode"::Cheque then
            GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "
        else
            if Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check" then
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check"
            else
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" ";
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert();

        //Post Other Payment Journal Entries
        PostPV(Payments);
    end;

    procedure GetAppliedEntries(var LineNo: Integer) InvText: Text[100]
    var
        Appl: Record "CshMgt Application";
    begin

        InvText := '';
        Appl.Reset();
        Appl.SetRange(Appl."Document Type", Appl."Document Type"::PV);
        Appl.SetRange(Appl."Document No.", Rec."No.");
        Appl.SetRange(Appl."Line No.", LineNo);
        if Appl.FindFirst() then
            repeat
                InvText := CopyStr(InvText + ',' + Appl."Appl. Doc. No", 1, 50);
            until Appl.Next() = 0;
    end;

    procedure InsertApproval()
    var
        Appl: Record "CshMgt Approvals";
        LineNo: Integer;
    begin
        LineNo := 0;
        Appl.Reset();
        if Appl.FindLast() then
            LineNo := Appl."Line No.";

        LineNo := LineNo + 1;

        Appl.Reset();
        Appl.Init();
        Appl."Line No." := LineNo;
        Appl."Document Type" := Appl."Document Type"::PV;
        Appl."Document No." := Rec."No.";
        Appl."Document Date" := Rec.Date;
        Appl."Process Date" := Today;
        Appl."Process Time" := Time;
        Appl."Process User ID" := UserId;
        Appl."Process Name" := Rec."Current Status";
        //Appl."Process Machine":=ENVIRON('COMPUTERNAME');
        Appl.Insert();
    end;

    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCSetup: Record "Budgetary Control Setup";
    begin
        if BCSetup.Get() then begin
            if not BCSetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        PayLine.Reset();
        PayLine.SetRange(PayLine.No, Rec."No.");
        PayLine.SetRange(PayLine.Committed, false);
        PayLine.SetRange(PayLine."Budgetary Control A/C", true);
        if PayLine.Find('-') then
            Exists := true;
    end;

    procedure CheckPVRequiredItems()
    begin
        PayLine.Reset();
        PayLine.SetRange(PayLine.No, Rec."No.");
        PayLine.SetRange(PayLine."Budgetary Control A/C", true);
        if PayLine.Find('-') then
            PayLine.TestField(PayLine.Committed, true);

        if Rec.Posted then
            Error('The Document has already been posted');

        Rec.TestField(Status, Rec.Status::Approved);
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Pay Mode");
        Rec.TestField("Payment Release Date");
        //Confirm whether Bank Has the Cash
        if Rec."Pay Mode" = Rec."Pay Mode"::Cash then
            // CheckBudgetAvail.CheckFundsAvailability(Rec);

            /*Check if the user has selected all the relevant fields*/
        Temp.Reset();
        if Temp.Get(UserId) then begin
            Temp.TestField(Temp."Payment Journal Template");
            Temp.TestField(Temp."Payment Journal Batch");
            JTemplate := Temp."Payment Journal Template";
            JBatch := Temp."Payment Journal Batch";
        end;
        if JTemplate = '' then begin
            Error('Ensure the PV Template is set up in cash office setup1 ');
            if JBatch = '' then
                Error('Ensure the Batch Template is set up in cash office setup1 ');
        end;

        if (Rec."Pay Mode" = Rec."Pay Mode"::Cheque) and (Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check") then
            if not Confirm(Text002, false) then
                Error('You have selected to Abort PV Posting');
        //Check whether there is any printed cheques and lines not posted
        CheckLedger.Reset();
        CheckLedger.SetRange(CheckLedger."Document No.", Rec."No.");
        CheckLedger.SetRange(CheckLedger."Entry Status", CheckLedger."Entry Status"::Printed);
        if CheckLedger.Find('-') then begin
            //Ask whether to void the printed cheque
            GenJnlLine.Reset();
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.FindFirst();
            if Confirm(Text000, false, CheckLedger."Check No.") then
                CheckManagement.VoidCheck(GenJnlLine)
            else
                Error(Text001, Rec."No.", CheckLedger."Check No.");
        end;
    end;

    procedure PostPV(var Payment: Record "Payments Header")
    begin

        PayLine.Reset();
        PayLine.SetRange(PayLine.No, Payments."No.");
        if PayLine.Find('-') then begin

            repeat
                strText := GetAppliedEntries(PayLine."Line No.");
                Payment.TestField(Payment.Payee);
                PayLine.TestField(PayLine.Amount);
                PayLine.TestField(PayLine."Global Dimension 1 Code");

                //BANK
                if PayLine."Pay Mode" = PayLine."Pay Mode"::Cash then begin
                    CashierLinks.Reset();
                    CashierLinks.SetRange(CashierLinks.UserID, UserId);
                end;

                //CHEQUE
                LineNo := LineNo + 1000;
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document No." := PayLine.No;
                if PayLine."Account Type" = PayLine."Account Type"::Customer then
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                else
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine.Description := CopyStr(PayLine."Transaction Name" + ':' + Payment.Payee, 1, 50);
                // GenJnlLine.Payee:=Payment.Payee;
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                if PayLine."VAT Code" = '' then
                    GenJnlLine.Amount := PayLine."Net Amount"
                else
                    GenJnlLine.Amount := PayLine."Net Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."VAT Prod. Posting Group" := PayLine."VAT Prod. Posting Group";
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Applies-to Doc. No.";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Applies-to ID";

                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();

                //Post VAT to GL[VAT GL]
                TarriffCodes.Reset();
                TarriffCodes.SetRange(TarriffCodes.Code, PayLine."VAT Code");
                if TarriffCodes.Find('-') then begin
                    TarriffCodes.TestField(TarriffCodes."G/L Account");
                    LineNo := LineNo + 1000;
                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Account No." := TarriffCodes."G/L Account";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                    GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := -PayLine."VAT Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.Description := CopyStr('VAT:' + Format(PayLine."Account Type") + '::' + Format(PayLine."Account Name"), 1, 50);
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                    GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert();
                end;

                //POST W/TAX to Respective W/TAX GL Account
                TarriffCodes.Reset();
                TarriffCodes.SetRange(TarriffCodes.Code, PayLine."Withholding Tax Code");
                if TarriffCodes.Find('-') then begin
                    TarriffCodes.TestField(TarriffCodes."G/L Account");
                    LineNo := LineNo + 1000;
                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Account No." := TarriffCodes."G/L Account";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                    GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := -PayLine."Withholding Tax Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := CopyStr('W/Tax:' + Format(PayLine."Account Name") + '::' + strText, 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                    GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert();
                end;

                //Post PAYE to GL[PAYE GL] -----JOSEH
                TarriffCodes.Reset();
                TarriffCodes.SetRange(TarriffCodes.Code, PayLine."PAYE Code");
                if TarriffCodes.Find('-') then begin
                    TarriffCodes.TestField(TarriffCodes."G/L Account");
                    LineNo := LineNo + 1000;
                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Account No." := TarriffCodes."G/L Account";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                    GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := -PayLine."PAYE Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.Description := CopyStr('PAYE:' + Format(PayLine."Account Type") + '::' + Format(PayLine."Account Name"), 1, 50);
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                    GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert();
                end;

                //Post VAT Balancing Entry Goes to Vendor
                LineNo := LineNo + 1000;
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                if PayLine."VAT Code" = '' then
                    GenJnlLine.Amount := 0
                else
                    GenJnlLine.Amount := PayLine."VAT Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := CopyStr('VAT:' + Format(PayLine."Account Type") + '::' + Format(PayLine."Account Name"), 1, 50);
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();

                //Post W/TAX Balancing Entry Goes to Vendor
                LineNo := LineNo + 1000;
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine.Amount := PayLine."Withholding Tax Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := CopyStr('W/Tax:' + strText, 1, 50);
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();

                //EFT
                if Payments."Pay Mode" = Payments."Pay Mode"::EFT then
                    if PayLine."Account No." <> '' then begin
                        BankPayment.Reset();
                        BankPayment.SetRange(BankPayment."Doc No", Rec."No.");
                        if BankPayment.Find('-') then
                            BankPayment.Delete();
                        PayLine.TestField(PayLine."Vendor Bank Account");
                        BankPayment.Init();
                        BankPayment."Doc No" := Rec."No.";
                        BankPayment.Payee := PayLine."Account No.";
                        BankPayment.Amount := Rec."Total Payment Amount" - (Rec."Total Witholding Tax Amount" + Rec."Total Retention Amount" + Rec."Total VAT Amount");
                        BankPayment."Bank A/C No" := PayLine."Vendor Bank Account";
                        VBank.Reset();
                        VBank.SetRange(VBank."Vendor No.", PayLine."Account No.");
                        VBank.SetRange(VBank.Code, PayLine."Vendor Bank Account");
                        if VBank.Find('-') then begin
                            VBank.TestField(VBank."Bank Branch No.");
                            VBank.TestField(VBank."Bank Account No.");
                            BankPayment."Bank A/C No" := Format(VBank."Bank Account No.");
                            BankPayment."Bank Branch No" := Format(VBank."Bank Branch No.");
                            BankPayment."Bank Code" := Format(VBank.Code);
                            BankPayment."Bank A/C Name" := VBank.Name
                        end;
                        BankPayment.Date := Today;
                        BankPayment.Insert();
                    end;

                //Post PAYE Balancing Entry Goes to Vendor(Lecturer)----JLL
                LineNo := LineNo + 1000;
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine.Amount := PayLine."PAYE Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := CopyStr('PAYE:' + strText, 1, 50);
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();
            until PayLine.Next() = 0;

            Commit();
            //Post the Journal Lines
            GenJnlLine.Reset();
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            //Adjust Gen Jnl Exchange Rate Rounding Balances
            AdjustGenJnl.Run(GenJnlLine);
            //End Adjust Gen Jnl Exchange Rate Rounding Balances

            //Before posting if paymode is cheque print the cheque
            if (Rec."Pay Mode" = Rec."Pay Mode"::Cheque) and (Rec."Cheque Type" = Rec."Cheque Type"::"Computer Check") then begin
                DocPrint.PrintCheck(GenJnlLine);
                CODEUNIT.Run(CODEUNIT::"Adjust Gen. Journal Balance", GenJnlLine);
                //Confirm Cheque printed //Not necessary.
            end;

            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            Post := false;
            Post := JournlPosted.PostedSuccessfully(Rec."No.");
            if Post then
                if PayLine.FindFirst() then
                    repeat
                        PayLine."Date Posted" := Today;
                        PayLine."Time Posted" := Time;
                        PayLine."Posted By" := UserId;
                        PayLine.Status := PayLine.Status::Posted;
                        PayLine.Modify();
                    until PayLine.Next() = 0;
        end;
        /*
        IF PayLine."Document Type"=PayLine."Document Type"::Imprest
        THEN BEGIN
        ImprestHeader.RESET;
        ImprestHeader.SETRANGE(ImprestHeader."No.",PayLine."Document No");
        IF ImprestHeader.FIND('-') THEN BEGIN
        ImprestHeader."Payment Voucher No":=PayLine.No;
        ImprestHeader.Posted:=TRUE;
        ImprestHeader."Date Posted":=TODAY;
        ImprestHeader."Time Posted":=TIME;
        ImprestHeader."Posted By":=USERID;
        ImprestHeader.MODIFY;
        END;
        END;

        IF PayLine."Document Type"=PayLine."Document Type"::Claim
        THEN BEGIN
        Payments.RESET;
        Payments.SETRANGE(Payments."No.",PayLine."Document No");
        IF Payments.FIND('-') THEN BEGIN
        Payments.Posted:=TRUE;
        Payments."Date Posted":=TODAY;
        Payments."Time Posted":=TIME;
        Payments."Posted By":=USERID;
        Payments.MODIFY;
        END;
        END;
         */
    end;

    procedure UpdateControls()
    begin
        /*IF Status<>Status::Approved THEN BEGIN
          "Payment Release DateEditable" :=FALSE;
          "Paying Bank AccountEditable" :=FALSE;
          "Pay ModeEditable" :=FALSE;
          "Currency CodeEditable" :=TRUE;
          "Cheque No.Editable" :=FALSE;
          "Cheque TypeEditable" :=FALSE;
          "Invoice Currency CodeEditable" :=TRUE;
        //  CurrForm.UPDATECONTROLS();
          END ELSE BEGIN
          "Payment Release DateEditable" :=TRUE;
          "Paying Bank AccountEditable" :=TRUE;
          "Pay ModeEditable" :=TRUE;
          IF "Pay Mode"="Pay Mode"::Cheque THEN
            "Cheque TypeEditable" :=TRUE;
          //CurrForm."Currency Code".EDITABLE:=FALSE;
          IF "Cheque Type"<>"Cheque Type"::"Computer Check" THEN
              "Cheque No.Editable" :=TRUE;
          "Invoice Currency CodeEditable" :=FALSE;
         // CurrForm.UPDATECONTROLS();
          END;

          IF Status=Status::Pending THEN BEGIN
          "Currency CodeEditable" :=TRUE;
          GlobalDimension1CodeEditable :=TRUE;
          "Payment NarrationEditable" :=TRUE;
          ShortcutDimension2CodeEditable :=TRUE;
          PayeeEditable :=TRUE;
         // CurrForm."Shortcut Dimension 3 Code".EDITABLE:=TRUE;
         // CurrForm."Shortcut Dimension 4 Code".EDITABLE:=TRUE;
          DateEditable :=TRUE;
         // CurrForm."Serial No".EDITABLE:=TRUE;
         // CurrForm.UPDATECONTROLS();
          END ELSE BEGIN
          "Currency CodeEditable" :=FALSE;
          GlobalDimension1CodeEditable :=FALSE;
          "Payment NarrationEditable" :=FALSE;
          ShortcutDimension2CodeEditable :=TRUE;
          PayeeEditable :=TRUE;
         // CurrForm."Shortcut Dimension 3 Code".EDITABLE:=FALSE;
         // CurrForm."Shortcut Dimension 4 Code".EDITABLE:=FALSE;
          DateEditable :=FALSE;
        //  CurrForm."Serial No".EDITABLE:=FALSE;
          //CurrForm.UPDATECONTROLS();
             END
            */
    end;

    procedure LinesExists(): Boolean
    var
        PayLines: Record "Payment Line";
    begin
        HasLines := false;
        PayLines.Reset();
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Payment Line";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset();
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."Account No." = '') or (PayLines.Amount <= 0) then
                    AllKeyFieldsEntered := false;
            until PayLines.Next() = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    procedure CustomerPayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line";
    begin
        PayLine.Reset();
        PayLine.SetRange(PayLine.No, Rec."No.");
        PayLine.SetRange(PayLine."Account Type", PayLine."Account Type"::Customer);
        exit(PayLine.FindFirst());
    end;

    procedure PopulateCheckJournal(var Payment: Record "Payments Header")
    begin
        PayLine.Reset();
        PayLine.SetRange(PayLine.No, Rec."No.");
        if PayLine.Find('-') then
            repeat
                //  strText:=GetAppliedEntries(PayLine."Line No.");
                Payment.TestField(Payment.Payee);
                PayLine.TestField(PayLine.Amount);
                // PayLine.TESTFIELD(PayLine."Global Dimension 1 Code");

                //BANK
                if PayLine."Pay Mode" <> PayLine."Pay Mode"::Cheque then;

                //CHEQUE
                LineNo := LineNo + 1000;
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Rec."Payment Release Date";
                GenJnlLine."Document No." := PayLine.No;
                if PayLine."Account Type" = PayLine."Account Type"::Customer then
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                else
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Rec."Cheque No.";

                GenJnlLine."Currency Code" := Rec."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                GenJnlLine.Validate("Currency Factor");
                if PayLine."VAT Code" = '' then
                    GenJnlLine.Amount := PayLine."Net Amount"
                else
                    GenJnlLine.Amount := PayLine."Net Amount";
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."VAT Prod. Posting Group" := PayLine."VAT Prod. Posting Group";
                GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine."Bal. Account No." := Rec."Paying Bank Account";
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check";
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Applies-to Doc. No.";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Applies-to ID";
                GenJnlLine.Description := Rec.Payee;
                ///GenJnlLine."Received By":=Payee;
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();
            until PayLine.Next() = 0;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;
}
