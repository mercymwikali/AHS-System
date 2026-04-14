page 85247 "Receipt Header UP"
{
    Caption = 'Receipt';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Receipts Header";
    SourceTableView = WHERE(Posted = CONST(false),
                            "Manual Ref.Number" = FILTER(<> 'BLOCKED'));
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Receipt Date';
                    Editable = true;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Receipt Date field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Caption = 'Deposit Date';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Deposit Date field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    trigger OnValidate()
                    begin
                        FunctionName := '';
                        DimVal.Reset();
                        DimVal.SetRange(DimVal."Global Dimension No.", 1);
                        DimVal.SetRange(DimVal.Code, Rec."Global Dimension 1 Code");
                        if DimVal.Find('-') then
                            FunctionName := DimVal.Name;
                    end;
                }
                field(FunctionName; FunctionName)
                {
                    Editable = false;
                    ShowCaption = false;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    trigger OnValidate()
                    begin
                        BudgetCenterName := '';
                        DimVal.Reset();
                        DimVal.SetRange(DimVal."Global Dimension No.", 2);
                        DimVal.SetRange(DimVal.Code, Rec."Shortcut Dimension 2 Code");
                        if DimVal.Find('-') then
                            BudgetCenterName := DimVal.Name;
                    end;
                }
                field(BudgetCenterName; BudgetCenterName)
                {
                    visible = false;
                    Editable = false;
                    ShowCaption = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                    // Editable = false;
                }
                field("Patient Appointment No"; Rec."Patient Appointment No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient Appointment No field.';
                    //Editable = false;
                }
                field("Pharmacy No"; Rec."Pharmacy No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Pharmacy No field.';
                }
                field("Laboratory No"; Rec."Laboratory No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Laboratory No field.';
                }
                field("Imprest No"; Rec."Imprest No")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Imprest No field.';
                }
                field("Customer No"; Rec."Customer No")
                {
                    Editable = true;
                    Enabled = true;
                    HideValue = false;
                    Visible = true;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Customer No field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Pay Mode field.';

                }
                field("Mobile Money Type"; Rec."Mobile Money Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Mobile Money Type field.';
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                    trigger OnValidate()
                    begin
                        if Rec."Pay Mode" = Rec."Pay Mode"::Cash then Error('The payment mode is cash not M-Pesa');

                    end;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }

                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                    // Visible = false;
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    // Visible = false;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Amount Recieved"; Rec."Amount Recieved")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Amount Recieved field.';
                }
                field("Receipt Split Amount"; Rec."Receipt Split Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Receipt Split Amount field.';
                }
                field("Split Amount"; Rec."Split Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Split Amount field.';
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Received From field.';
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
                field("Co-Pay"; Rec."Co-Pay")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Co-Pay field.';
                }
                field(isPartialPayment; Rec.isPartialPayment)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the isPartialPayment field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Remarks field.';

                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
            part(Control1000000000; "Receipts Line UP")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = No = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {

            action(Refresh)
            {
                Caption = 'Refresh';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Refresh action.';
                trigger OnAction()
                begin
                    CurrPage.Update();
                    message(Rec.GetView());
                end;
            }
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Post action.';
                trigger OnAction()
                var
                    CodeunitPostReceipt: Codeunit "Post Receipt";
                    CurrReceiptNo: code[20];
                begin
                    //Check Post Dated
                    // Rec.CalcFields("Total Amount");
                    // if Rec."Total Amount" <> Rec."Amount Recieved" then
                    //     Error('Please note that the Total Amount and the Amount Received Must be the same');

                    CodeunitPostReceipt.FnPostReceiptHeader(Rec);

                end;
            }

        }
        area(processing)
        {
            action(Print)
            {
                Caption = 'Print Patient Receipt';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Print action.';
                trigger OnAction()
                begin
                    //IF Posted=FALSE THEN ERROR('Post the receipt before printing.');
                    Rec.Reset();
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::"Receipts Report A4", true, true, Rec);
                    Rec.Reset();
                end;
            }
            action(Print2)
            {
                Caption = 'Print Customer Receipt';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Print action.';
                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::"Customer Receipt", true, true, Rec);
                    Rec.Reset();
                end;
            }
            separator(Separator7)
            {
            }
            action("Import Insurance Payments")
            {
                Image = Import;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Import Insurance Payments action.';
                trigger OnAction()
                begin
                    Rec.TestField("Customer No");

                    ReceiptLine.Reset();
                    ReceiptLine.SetFilter(ReceiptLine.No, Rec."No.");
                    if ReceiptLine.Find('-') then ReceiptLine.DeleteAll();

                    ReceiptLine.Init();
                    ReceiptLine.No := Rec."No.";
                    ReceiptLine.Type := 'CORPORATE';
                    ReceiptLine.Grouping := 'CORPORATE';
                    ReceiptLine."Account Type" := ReceiptLine."Account Type"::Customer;
                    ReceiptLine."Account No." := Rec."Customer No";
                    ReceiptLine.Insert();

                    ReceiptLine.Reset();
                    ReceiptLine.SetFilter(ReceiptLine.No, Rec."No.");
                    ReceiptLine.SetFilter(ReceiptLine.Type, 'CORPORATE');
                    ReceiptLine.SetFilter(ReceiptLine.Grouping, 'CORPORATE');
                    ReceiptLine.SetFilter(ReceiptLine."Account Type", '%1', ReceiptLine."Account Type"::Customer);
                    ReceiptLine.SetFilter(ReceiptLine."Account No.", Rec."Customer No");
                    if ReceiptLine.Find('-') then
                        XMLPORT.Run(Xmlport::"Import Insurance Receipts.", false, true, ReceiptLine);
                end;
            }
            action("Insurance XML File")
            {
                ApplicationArea = Basic, Suite;
                Image = XMLFile;
                Promoted = true;
                ToolTip = 'Executes the Insurance XML File action.';
                //RunObject = Xmlport."Import Insurance Receipts.";
                trigger OnAction()
                begin
                    XMLPORT.Run(Xmlport::"Import Insurance Receipts.", false, false);
                end;
            }

            action("Charges Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient Charges";
                RunPageLink = "Patient No." = field("Patient No."), "Visit No" = field("Patient Appointment No");
                ToolTip = 'Executes the Charges Lines action.';
            }
            action("Split Receipts")
            {
                ApplicationArea = Basic, Suite;
                Image = Invoice;
                Promoted = true;
                RunObject = Page "Receipt Split";
                RunPageLink = "Receipt No" = FIELD("No.");
                ToolTip = 'Executes the Split Receipts action.';
            }
            action("Posted Charges")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Charges';
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient ClosedCharges List";
                RunPageLink = "Patient No." = field("Patient No."), "Visit No" = field("Patient Appointment No");
                ToolTip = 'Executes the Posted Charges action.';
            }
            action("&Print Interim Invoice")
            {
                Caption = '&Print Interim Invoice';
                Image = PrintDocument;
                Promoted = true;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the &Print Interim Invoice action.';
                trigger OnAction()
                begin
                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                    if HMSPatientCharges.Find('-') then
                        REPORT.Run(Report::"HMS Patient Invoice", true, true, HMSPatientCharges);
                end;
            }
            action("Import Insurance Receipts")
            {
                Caption = '&Import Insurance Receipts';
                Image = Import;
                Promoted = true;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the &Import Insurance Receipts action.';
                trigger OnAction()
                begin
                    Rec.TESTFIELD("Customer No");

                    ReceiptLine.RESET();
                    ReceiptLine.SETFILTER(ReceiptLine.No, Rec."No.");
                    IF ReceiptLine.FIND('-') THEN ReceiptLine.DELETEALL();

                    ReceiptLine.INIT();
                    ReceiptLine.No := Rec."No.";
                    ReceiptLine.Type := 'CORPORATE';
                    ReceiptLine.Grouping := 'CORPORATE';
                    ReceiptLine."Account Type" := ReceiptLine."Account Type"::Customer;
                    ReceiptLine."Account No." := Rec."Customer No";
                    ReceiptLine.INSERT();

                    ReceiptLine.RESET();
                    ReceiptLine.SETFILTER(ReceiptLine.No, Rec."No.");
                    ReceiptLine.SETFILTER(ReceiptLine.Type, 'CORPORATE');
                    ReceiptLine.SETFILTER(ReceiptLine.Grouping, 'CORPORATE');
                    ReceiptLine.SETFILTER(ReceiptLine."Account Type", '%1', ReceiptLine."Account Type"::Customer);
                    ReceiptLine.SETFILTER(ReceiptLine."Account No.", Rec."Customer No");
                    IF ReceiptLine.FIND('-') THEN
                        XMLPORT.RUN(Xmlport::"Import Insurance Receipts.", FALSE, TRUE, ReceiptLine);
                end;
            }
        }
    }



    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //********************************JACK**********************************//
        Rcpt.Reset();
        Rcpt.SetRange(Rcpt.Posted, false);
        Rcpt.SetRange(Rcpt."Created By", UserId);
        Rcpt.SetFilter(Rcpt."Manual Ref.Number", '<>%1', 'BLOCKED');
        Rcpt.SetFilter(Rcpt."Posted Count", '%1', 0);
        if Rcpt.Count > 0 then;
        //IF CONFIRM('There are still some unposted receipts. Continue?',FALSE)=FALSE THEN
        //  BEGIN
        // Error('There are still some unposted receipts. Please utilise them first');
        //  END;
        //********************************END **********************************//
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetSalesFilter();
        //Add dimensions if set by default here
        Rec."Global Dimension 1 Code" := UserSetup."Default Branch Code";
        Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        Rec.Validate("Shortcut Dimension 3 Code");
        Rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        Rec.Validate("Shortcut Dimension 4 Code");
        Rec.Date := Today;
        Rec."Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        Rec."Responsibility Center" := 'ACCOUNTS';
        Rec."Bank Code" := UserSetup."Default Receipts Bank";

    end;

    trigger OnOpenPage()
    begin

        UserSetup.Reset();

        if UserSetup.Get(UserId) then begin
            JTemplate := UserSetup."Receipt Journal Template";
            JBatch := UserSetup."Receipt Journal Batch";
        end;
        // if (JTemplate = '') or (JBatch = '') then
        //     Error('Please contact the system administrator to be setup as a receipting user');
        if UserSetup."Default Receipts Bank" = '' then;
        Rec.SetFilter(Status, ' ');

        //***************************JACK***************************//
        // SETRANGE("Created By",USERID);
        /*
       IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
         FILTERGROUP(2);
         SETRANGE("Responsibility Center",UserMgt.GetSalesFilter());
         FILTERGROUP(0);
       END;
        */
        //***************************END ***************************//

    end;

    var
        Appl: Record "CshMgt Application";
        BankAcc: Record "Bank Account";
        DefaultBatch: Record "Gen. Journal Batch";
        DimVal: Record "Dimension Value";
        DocLabRequestLines: Record "HMS Laboratory Test Line";
        GenJnlLine: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
        GLine: Record "Gen. Journal Line";
        HMSPatientCharges: Record "HMS Patient Charges";
        LabTestLines: Record "HMS Laboratory Test Line";
        PatientCharges: Record "HMS Patient Charges";
        PatRec: Record "HMS Patient";
        PharmRec: Record "HMS Pharmacy Header";
        Rcpt: Record "Receipts Header";
        ReceiptLine: Record "Receipt Line q";
        ReceiptSplit: Record "Receipt Split";
        SRSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "Cash Office User Template";
        USetup: Record "Cash Office User Template";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        HMSCU: Codeunit "HMS Patient-integration";
        JournalPosted: Codeunit "Journal Post Successful";
        PCheck: Codeunit "Posting Check FP";
        RegMgt: Codeunit "Register Management";
        UserMgt: Codeunit "User Setup Management BR";
        PharmacyH: Page "HMS Pharmacy Header";
        RecReport: Report "HMS Receipts Report";
        IsCashAccount: Boolean;
        Post: Boolean;
        JBatch: Code[10];
        JTemplate: Code[10];
        RcptNo: Code[20];
        BAmount: Decimal;
        tAmount: Decimal;
        FromNumber: Integer;
        LineNo: Integer;
        RegisterNumber: Integer;
        ToNumber: Integer;
        BankName: Text[100];
        BudgetCenterName: Text[100];
        FunctionName: Text[100];
        StrInvoices: Text[250];

    procedure PerformPost()
    begin
        //get all the invoices that have been paid for using the receipt
        StrInvoices := '';
        Appl.Reset();
        Appl.SetRange(Appl."Document Type", Appl."Document Type"::Receipt);
        Appl.SetRange(Appl."Document No.", Rec."No.");
        if Appl.FindFirst() then
            repeat
                StrInvoices := StrInvoices + ',' + Appl."Appl. Doc. No";
            until Appl.Next() = 0;

        //Cater for Cash Accounts
        IsCashAccount := false;
        BankAcc.Reset();
        if BankAcc.Get(Rec."Bank Code") then
            if BankAcc."Bank Type" = BankAcc."Bank Type"::Cash then
                IsCashAccount := true;

        //if IsCashAccount then
        //   TestField(Date, WorkDate);
        //End Cater for Cash Account


        USetup.Reset();
        USetup.SetRange(USetup.UserID, UserId);
        if USetup.FindFirst() then begin
            if USetup."Receipt Journal Template" = '' then
                Error('Please ensure that the Administrator sets you up as a cashier');
            if USetup."Receipt Journal Batch" = '' then
                Error('Please ensure that the Administrator sets you up as a cashier');
            if USetup."Default Receipts Bank" = '' then;
        end
        else
            Error('Please ensure that the Administrator sets you up as a cashier');


        //check if the receipt has any post dated cheques.
        //check if the amounts are similar

        // Rec.CalcFields("Total Amount");
        if Rec."Total Amount" <> Rec."Amount Recieved" then
            Error('Please note that the Total Amount and the Amount Received Must be the same');

        //if any then the amount to be posted must be less the post dated amount
        if Rec.Posted = true then
            Error('A Transaction Posted cannot be posted again');
        Rec.CalcFields("Receipt Split Amount");
        // if paymode is MPESA
        if (Rec."Pay Mode" = Rec."Pay Mode"::MPESA) and (Rec."Receipt Split Amount" = 0) then begin
            if Rec."Mobile Money Type" = 0 then
                Error('Please specify the type of Mobile Money');
            if Rec."Transaction Code" = '' then
                Error('Please specify the Mobile Money Transaction Code');
        end;
        //check if the person received from has been selected
        Rec.TestField(Date);

        if Rec."Receipt Split Amount" = 0 then begin
            ;
            Rec.TestField("Bank Code");
            Rec.TestField("Pay Mode");
        end;
        Rec.TestField("Global Dimension 1 Code");
        //TestField("Shortcut Dimension 2 Code");
        Rec.TestField("Received From");
        if Rec."Patient No." <> '' then Rec.TestField("Patient Appointment No");
        /*Check if the amount received is equal to the total amount*/
        tAmount := 0;

        //Check Bank
        CheckBnkCurrency(Rec."Bank Code", Rec."Currency Code");

        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then
            repeat
                // IF ReceiptLine."Pay Mode"=ReceiptLine."Pay Mode"::" " THEN
                //   ERROR('Paymode is Mandatory on the Receipt Line');

                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::"Deposit Slip" then begin
                    if ReceiptLine."Cheque/Deposit Slip No" = '' then
                        Error('The Cheque/Deposit Slip No must be inserted');
                    if ReceiptLine.Amount = 0 then
                        Error('Amount in Lines must be inserted');
                    if ReceiptLine."Cheque/Deposit Slip Date" = 0D then
                        Error('The Cheque/Deposit Date must be inserted');
                    if ReceiptLine."Transaction No." = '' then
                        Error('Please ensure that the Transaction Number is inserted');
                    if ReceiptLine.Type = '' then
                        Error('Please ensure that the Receipt Type is inserted');
                    if (ReceiptLine."HSM Transaction Type" = '') and (Rec."Patient No." <> '') then
                        Error('Please ensure that the Transaction Type is inserted');

                end;

                if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then begin
                    if ReceiptLine."Cheque/Deposit Slip No" = '' then
                        Error('The Cheque/Deposit Slip No must be inserted');
                    if ReceiptLine."Cheque/Deposit Slip Date" = 0D then
                        Error('The Cheque/Deposit Date must be inserted');
                    if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then
                        if StrLen(ReceiptLine."Cheque/Deposit Slip No") <> 6 then
                            Error('Invalid Cheque Number inserted');
                end;
                tAmount := tAmount + ReceiptLine.Amount;
                //BKK
                ReceiptLine."Pay Mode" := Rec."Pay Mode";
                if ReceiptLine."Patient No" = '' then
                    ReceiptLine."Patient No" := Rec."Patient No.";
                ReceiptLine."Mobile Money Type" := Rec."Mobile Money Type";
                ReceiptLine.Modify();
            until ReceiptLine.Next() = 0;



        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        GenJnlLine.DeleteAll();

        if DefaultBatch.Get(JTemplate, JBatch) then
            DefaultBatch.Delete();

        DefaultBatch.Init();
        DefaultBatch."Journal Template Name" := JTemplate;
        DefaultBatch.Name := JBatch;
        DefaultBatch.Insert();
        // Check Receipt Split
        Rec.CalcFields("Receipt Split Amount");
        if (Rec."Receipt Split Amount" > 0) and (Rec."Split Amount" = true) then begin
            if Rec."Receipt Split Amount" <> tAmount then error('The total split amount should be same as total receipt amount');
            ReceiptSplit.reset();
            ReceiptSplit.setrange("Receipt No", Rec."No.");
            if ReceiptSplit.find('-') then
                repeat
                    LineNo := LineNo + 10;
                    ReceiptSplit.TestField("Bank Account No");
                    //ReceiptSplit.TestField("Transaction No");
                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine."Source Code" := 'CASHRECJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Rec."Document Date";
                    GenJnlLine."Document No." := Rec."No.";
                    GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                    if Rec."Patient No." <> '' then begin
                        GenJnlLine."External Document No." := Rec."Patient Appointment No";
                        GenJnlLine."Source No." := Rec."Patient No.";
                    end;

                    GenJnlLine."Document Date" := Rec."Document Date";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";

                    GenJnlLine."Account No." := ReceiptSplit."Bank Account No";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Rec."Currency Code";
                    //GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                    GenJnlLine.Amount := ReceiptSplit.Amount;
                    //GenJnlLine.VALIDATE(GenJnlLine.Amount);

                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");

                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    // GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                    //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");

                    GenJnlLine.Description := Rec."Received From";
                    //GenJnlLine.VALIDATE(GenJnlLine.Description);
                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert();
                until ReceiptSplit.next() = 0;
        end else
            /*Insert the bank transaction*/
            if BAmount < tAmount then begin
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Source Code" := 'CASHRECJNL';
                GenJnlLine."Line No." := 1;
                GenJnlLine."Posting Date" := Rec."Document Date";
                GenJnlLine."Document No." := Rec."No.";
                GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                if Rec."Patient No." <> '' then begin
                    GenJnlLine."External Document No." := Rec."Patient Appointment No";
                    GenJnlLine."Source No." := Rec."Patient No.";
                end;

                GenJnlLine."Document Date" := Rec."Document Date";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";

                GenJnlLine."Account No." := Rec."Bank Code";//USetup."Default Receipts Bank";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Rec."Currency Code";
                //GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                GenJnlLine.Amount := (tAmount);
                //GenJnlLine.VALIDATE(GenJnlLine.Amount);

                GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                // GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");

                GenJnlLine.Description := Rec."Received From";
                //GenJnlLine.VALIDATE(GenJnlLine.Description);
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();
            end;


        //insert the transaction lines into the database
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        ReceiptLine.SetRange(ReceiptLine.Posted, false);

        if ReceiptLine.Find('-') then
            repeat
                if ReceiptLine.Amount = 0 then Error('Please enter amount.');

                if ReceiptLine.Amount < 0 then Error('Amount cannot be less than zero.');

                ReceiptLine.TestField(ReceiptLine."Global Dimension 1 Code");

                // ReceiptLine.TestField(ReceiptLine."Shortcut Dimension 2 Code");

                //get the last line number from the general journal line
                GLine.Reset();


                GLine.SetRange(GLine."Journal Template Name", JTemplate);
                GLine.SetRange(GLine."Journal Batch Name", JBatch);
                LineNo := 0;
                if GLine.Find('+') then LineNo := GLine."Line No.";
                LineNo := LineNo + 1;
                if ReceiptLine."Pay Mode" <> ReceiptLine."Pay Mode"::Cheque then begin
                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine."Source Code" := 'CASHRECJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Rec.Date;
                    GenJnlLine."Document No." := ReceiptLine.No;
                    GenJnlLine."Document Date" := Rec."Document Date";
                    if ReceiptLine."Customer Payment On Account" then begin
                        /*SRSetup.GET();
                        GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No.":=SRSetup."Receivable Batch Account";*/

                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account No.";

                    end
                    else begin
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account No.";
                    end;
                    // GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                    GenJnlLine."Currency Code" := Rec."Currency Code";
                    // GenJnlLine.VALIDATE(GenJnlLine."Currency Code");

                    GenJnlLine.Amount := -ReceiptLine.Amount;
                    //  GenJnlLine.VALIDATE(GenJnlLine.Amount);
                    /*
                    IF ReceiptLine."Customer Payment On Account"=FALSE THEN
                      BEGIN
                        GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                        GenJnlLine."Applies-to Doc. No.":=ReceiptLine."Applies-to Doc. No.";
                        GenJnlLine.VALIDATE("Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID":=ReceiptLine."Applies-to ID";
                        GenJnlLine.VALIDATE(GenJnlLine."Applies-to ID");
                      END;
                      */
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := CopyStr(ReceiptLine."Account Name" + ':' + Format(ReceiptLine."Pay Mode") +
                      ' Invoices:' + StrInvoices, 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                    // GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                    if Rec."Patient No." <> '' then begin
                        GenJnlLine."External Document No." := Rec."Patient Appointment No";
                        GenJnlLine."Source Code" := Rec."Patient No.";
                    end;
                    if GenJnlLine.Amount <> 0 then GenJnlLine.Insert();
                end
                else
                    if ReceiptLine."Pay Mode" = ReceiptLine."Pay Mode"::Cheque then
                        if ReceiptLine."Cheque/Deposit Slip Date" <= Today then begin
                            GenJnlLine.Init();
                            GenJnlLine."Journal Template Name" := JTemplate;
                            GenJnlLine."Journal Batch Name" := JBatch;
                            GenJnlLine."Source Code" := 'CASHRECJNL';
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Posting Date" := Rec.Date;
                            GenJnlLine."Document No." := ReceiptLine.No;
                            GenJnlLine."Document Date" := Rec."Document Date";
                            if ReceiptLine."Customer Payment On Account" then begin
                                SRSetup.Get();
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                // GenJnlLine."Account No." := SRSetup."Receivable Batch Account";
                            end
                            else begin
                                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                                GenJnlLine."Account No." := ReceiptLine."Account No.";
                            end;
                            //  GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                            GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                            GenJnlLine."Currency Code" := Rec."Currency Code";
                            //  GenJnlLine.VALIDATE(GenJnlLine."Currency Code");

                            GenJnlLine.Amount := -ReceiptLine.Amount;
                            //  GenJnlLine.VALIDATE(GenJnlLine.Amount);

                            if ReceiptLine."Customer Payment On Account" = false then begin
                                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                                GenJnlLine.Validate("Applies-to Doc. No.");
                                GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                                GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                            end;

                            //  GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                            GenJnlLine.Description := CopyStr(ReceiptLine."Account Name" + ':' + Format(ReceiptLine."Pay Mode")
                            + ' Invoices:' + StrInvoices, 1, 50);
                            GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                            //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                            if Rec."Patient No." <> '' then begin
                                GenJnlLine."External Document No." := Rec."Patient Appointment No";
                                GenJnlLine."Source Code" := Rec."Patient No.";
                            end;
                            if GenJnlLine.Amount <> 0 then GenJnlLine.Insert();
                        end;
            until ReceiptLine.Next() = 0;

        /*Post the transactions*/
        Post := false;
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        //Adjust Gen Jnl Exchange Rate Rounding Balances
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust Gen Jnl Exchange Rate Rounding Balances

        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

        if JournalPosted.IsPosted(Rec."No.") = true then begin
            //Update Header
            Rec.Cashier := UserId;
            //"Bank Code":=USetup."Default Receipts Bank";
            Rec.Posted := true;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;
            Rec.Modify();
            //Update Lines
            ReceiptLine.Reset();
            ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
            ReceiptLine.SetRange(ReceiptLine.Posted, false);
            if ReceiptLine.Find('-') then
                repeat
                    ReceiptLine.Posted := true;
                    ReceiptLine."Date Posted" := Today;
                    ReceiptLine."Time Posted" := Time;
                    ReceiptLine."Posted By" := UserId;
                    ReceiptLine.Modify();
                until ReceiptLine.Next() = 0;

            //MESSAGE('Receipt Posted Successfully');

        end;
    end;



    procedure PerformPostLine()
    begin
    end;

    procedure CheckPostDated() Exists: Boolean
    begin
        //get the sum total of the post dated cheques is any
        //reset the bank amount first
        Exists := false;
        BAmount := 0;
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        ReceiptLine.SetRange(ReceiptLine."Pay Mode", ReceiptLine."Pay Mode"::Cheque);
        if ReceiptLine.Find('-') then
            repeat
                if ReceiptLine."Cheque/Deposit Slip Date" > Today then begin
                    Exists := true;
                    exit;
                    //cheque is post dated
                    // BAmount:=BAmount + ReceiptLine.Amount;
                end;
            until ReceiptLine.Next() = 0;
    end;

    procedure CheckBnkCurrency(BankAcc: Code[20]; CurrCode: Code[20])
    var
        BankAcct: Record "Bank Account";
    begin
        BankAcct.Reset();
        BankAcct.SetRange(BankAcct."No.", BankAcc);
        if BankAcct.Find('-') then
            if BankAcct."Currency Code" <> CurrCode then
                if BankAcct."Currency Code" = '' then
                    Error('This bank [%1:- %2] can only transact in LOCAL Currency', BankAcct."No.", BankAcct.Name)
                else
                    Error('This bank [%1:- %2] can only transact in %3', BankAcct."No.", BankAcct.Name, BankAcct."Currency Code");
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        FunctionName := '';
        DimVal.Reset();
        DimVal.SetRange(DimVal."Global Dimension No.", 1);
        DimVal.SetRange(DimVal.Code, Rec."Global Dimension 1 Code");
        if DimVal.Find('-') then
            FunctionName := DimVal.Name;
        BudgetCenterName := '';
        DimVal.Reset();
        DimVal.SetRange(DimVal."Global Dimension No.", 2);
        DimVal.SetRange(DimVal.Code, Rec."Shortcut Dimension 2 Code");
        if DimVal.Find('-') then
            BudgetCenterName := DimVal.Name;
        BankName := '';
        BankAcc.Reset();
        BankAcc.SetRange(BankAcc."No.", Rec."Bank Code");
        if BankAcc.Find('-') then
            BankName := BankAcc.Name;
    end;

    procedure ValidatePatientCharges(var PatientNo: code[20]; VisitNo: Code[20])
    var
        PatientCharges: Record "HMS Patient Charges";
    begin
        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
        //PatientCharges.SETRANGE(PatientCharges."Insurance No",Patients."Insurance No.");
        PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
        PatientCharges.SetRange(PatientCharges.Closed, false);
        PatientCharges.SetRange(PatientCharges.Posted, false); //Commented to allow receipts for debtor patient
        PatientCharges.SetFilter(PatientCharges."Transaction Type", '<>%1', 'ZRECEIPT');
        PatientCharges.SetFilter(PatientCharges.Amount, '<>%1', 0);
        if PatientCharges.Find('-') then begin
            PatientCharges.TestField("G/L Account No");
            PatientCharges.TestField("Shortcut Dimension 1 Code");
        end;
    end;

    local procedure UpdatePatientCharges(PatNo: code[20]; VisitNo: Code[20])
    var
        HmsApp: Record "HMS Appointment Form Header";
        HMSClinicsSetup: Record "HMS Clinics Setup";
        HmsPatCharges: Record "HMS Patient Charges";
        HMSSetup: Record "HMS Setup";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
        LabHeader: Record "HMS Laboratory Form Header";
        ObservHeader: Record "HMS Observation Form Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
    begin
        if HmsApp.Get(VisitNo) then begin
            ObservHeader.SetRange(ObservHeader."Patient No.", PatNo);
            ObservHeader.SetRange(ObservHeader."Observation Date", Today);
            if ObservHeader.Find('-') then
                HmsApp.Get(VisitNo)
            else begin
                HMSSetup.Reset();
                HMSSetup.Get();
                NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);

                HMSTreatmentFormHeader.Init();
                HMSTreatmentFormHeader."Treatment No." := NewNo;
                HMSTreatmentFormHeader."Link No." := HmsApp."Link No";
                HMSTreatmentFormHeader."Treatment Date" := Today;
                HMSTreatmentFormHeader."Treatment Time" := Time;
                HMSTreatmentFormHeader."Doctor ID" := HmsApp.Doctor;
                HMSTreatmentFormHeader.validate("Doctor ID");
                HMSTreatmentFormHeader."Patient No." := Rec."Patient No.";
                HMSTreatmentFormHeader.Clinic := HmsApp."Special Clinics";
                HMSTreatmentFormHeader.Direct := true;
                HMSTreatmentFormHeader."Link No." := HmsApp."Appointment No.";
                //:=LabHeader."Request Area"::Doctor;
                HMSTreatmentFormHeader."Link Type" := 'Outpatient';
                //      HMSTreatmentFormHeader."Link No.":=TreatmentHeader."Appointment No.";
                HMSTreatmentFormHeader.Insert();

                ObservHeader.Init();
                ObservHeader."Observation No." := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);
                ObservHeader."Link No." := HmsApp."Link No";
                ObservHeader."Observation Date" := Today;
                ObservHeader."Observation Time" := Time;
                ObservHeader.Doctor := HmsApp.Doctor;
                ObservHeader."Patient No." := Rec."Patient No.";
                ObservHeader."Link Type" := 'Observation';
                ObservHeader."Link No." := HmsApp."Appointment No.";
                ObservHeader."Treatment No" := NewNo;
                ObservHeader.Insert();
            end;

            /*    if HmsApp."Dispatch To" = HmsApp."Dispatch To"::Laboratory then begin
                HMSSetup.Reset;
                HMSSetup.Get();
                NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Lab Test Request Nos", 0D, true);
                LabHeader.Init;
                LabHeader."Laboratory No." := NewNo;
                LabHeader."Link No." := HmsApp."Link No";
                LabHeader."Laboratory Date" := Today;
                LabHeader."Laboratory Time" := Time;
                LabHeader."Cash Sale" := true;

                LabHeader."Doctor ID" := HmsApp.Doctor;
                LabHeader."Patient No." := "Patient No.";
                LabHeader."Link Type" := 'Appointment';
                LabHeader."Link No." := HmsApp."Appointment No.";
                LabHeader.Insert;
                //------------------------------------------------------------------------------------
                DocLabRequestLines.Reset;
                DocLabRequestLines.SetRange(DocLabRequestLines."Laboratory No.", HmsApp."Appointment No.");
                //DocLabRequestLines.SETRANGE(DocLabRequestLines.Status,DocLabRequestLines.Status::New);
                if DocLabRequestLines.Find('-') then begin
                    repeat

                        LabTestLines.Init;
                        LabTestLines."Laboratory No." := HmsApp."Link No";
                        LabTestLines."Laboratory Test Code" := DocLabRequestLines."Laboratory Test Code";
                        LabTestLines."Specimen Code" := DocLabRequestLines."Specimen Code";
                        LabTestLines."Measuring Unit Code" := DocLabRequestLines."Measuring Unit Code";
                        LabTestLines."Laboratory Test Name" := DocLabRequestLines."Laboratory Test Name";
                        LabTestLines."Specimen Name" := DocLabRequestLines."Specimen Name";
                        LabTestLines.Insert;

                    until DocLabRequestLines.Next = 0;
                end;
                //------------------------------------------------------------------------------------
                // end;

                HmsPatCharges.Posted := true;

                if PatRec.Get("Patient No.") then
                    HmsPatCharges."Visit No" := PatRec."Active Visit No";
                HmsPatCharges."Invoice ID" := "No.";
                // HmsPatCharges.Modify;
            end; */

            // Close the Visit if cleared at Pharmacy
            if PatRec.Get(Rec."Patient No.") then begin
                PatRec.CalcFields(PatRec."Bill Balance");
                if (PatRec."Bill Balance" = 0) and (Rec."Pharmacy No" <> '') and (PatRec.Inpatient = false) then begin
                    PatRec.Activated := false;
                    PatRec.Modify();
                end;
            end;
        end;
    end;


    local procedure UpdateDoctorInvoice()
    var
        HmsPatCharges: Record "HMS Patient Charges";
        HMSPatRec: Record "HMS Patient";
        HMSTransCode: Record "HMS Transactions code";
    begin
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then
            repeat
                HmsPatCharges.Reset();
                HmsPatCharges.SetRange(HmsPatCharges."Patient No.", ReceiptLine."Patient No");
                // HmsPatCharges.SETRANGE(HmsPatCharges."Posted Invoice No.",ReceiptLine."Applies-to Doc. No.");
                HmsPatCharges.SetRange(HmsPatCharges.Claimed, false);
                HmsPatCharges.SetFilter(HmsPatCharges."Doctor ID", '<>%1', '');
                if HmsPatCharges.Find('-') then
                    repeat
                        HmsPatCharges.CalcFields("Posted Invoice No.");
                        HmsPatCharges.CalcFields(HmsPatCharges."Calc Doctor Fee");
                        if (HmsPatCharges."Posted Invoice No." = ReceiptLine."Applies-to Doc. No.") and (HmsPatCharges."Calc Doctor Fee" = true) then
                            if HMSTransCode.Get(HmsPatCharges."Transaction Type") then begin
                                if HMSPatRec.Get(HmsPatCharges."Patient No.") then;
                                LineNo := LineNo + 100;
                                HMSTransCode.TestField(HMSTransCode."Expense G/L Account");
                                GenJnlLine.Init();
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := Rec.Date;
                                GenJnlLine."Document No." := ReceiptLine.No;
                                GenJnlLine."Document Date" := Rec."Document Date";
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                                GenJnlLine."Account No." := HmsPatCharges."Doctor ID";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."External Document No." := HmsPatCharges."Invoice Number";
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");
                                GenJnlLine.Amount := HmsPatCharges."Doctors Amount" * -1;
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                // GenJnlLine."Bal. Account No.":=HMSTransCode."Expense G/L Account";
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := HmsPatCharges."Patient No." + ' -  ' + HMSPatRec.Surname + ' ' + HMSPatRec."Last Name";
                                GenJnlLine."Shortcut Dimension 1 Code" := HmsPatCharges."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := HmsPatCharges."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert();
                                //Balance Account
                                LineNo := LineNo + 100;
                                HMSTransCode.TestField(HMSTransCode."Expense G/L Account");
                                GenJnlLine.Init();
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := Rec.Date;
                                GenJnlLine."Document No." := ReceiptLine.No;
                                GenJnlLine."Document Date" := Rec."Document Date";
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account No." := HMSTransCode."Expense G/L Account";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."External Document No." := HmsPatCharges."Invoice Number";
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");
                                GenJnlLine.Amount := HmsPatCharges."Doctors Amount";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                // GenJnlLine."Bal. Account No.":=HMSTransCode."Expense G/L Account";
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := HmsPatCharges."Patient No." + ' -  ' + HMSPatRec.Surname + ' ' + HMSPatRec."Last Name";
                                ;
                                GenJnlLine."Shortcut Dimension 1 Code" := HmsPatCharges."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := HmsPatCharges."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert();
                            end;
                        HmsPatCharges.Claimed := true;
                        HmsPatCharges."Claim Receipt No" := ReceiptLine.No;
                    until HmsPatCharges.Next() = 0;
            until ReceiptLine.Next() = 0;

        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.Find('-') then
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnlLine);
    end;

    local procedure InsertPatientsReceipts()
    var
        HMSLabHeader: Record "HMS Laboratory Form Header";
        HMSLabRequest: Record "HMS Laboratory Test Line";
        HmsPatCharges: Record "HMS Patient Charges";
        HMSRadHeader: Record "HMS Radiology Form Header";
        HMSRadRequest: Record "HMS Radiology Form Line";
    begin
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then
            repeat
                if ReceiptLine."Patient No" <> '' then begin
                    HMSLabHeader.reset();
                    HMSLabHeader.setrange(HMSLabHeader."Patient No.", ReceiptLine."Patient No");
                    HMSLabHeader.SetRange(HMSLabHeader."Link No.", Rec."Patient Appointment No");
                    if HMSLabHeader.find('-') then begin
                        HMSLabRequest.reset();
                        HMSLabRequest.setrange(HMSLabRequest."Patient No", ReceiptLine."Patient No");
                        HMSLabRequest.setrange(HMSLabRequest."Laboratory No.", HMSLabHeader."Laboratory No.");
                        HMSLabRequest.setrange(HMSLabRequest."Laboratory Test Code", ReceiptLine."Transaction No.");
                        HMSLabRequest.setrange(Paid, false);
                        if HMSLabRequest.find('-') then
                            repeat
                                HMSLabRequest."Receipt No" := Rec."No.";
                                HMSLabRequest."Receipt Line No" := ReceiptLine."Line No.";
                                HMSLabRequest.paid := true;
                                HMSLabRequest.modify();
                            until HMSLabRequest.next() = 0;
                    end;
                    HMSRadHeader.reset();
                    HMSRadHeader.setrange(HMSRadHeader."Patient No.", ReceiptLine."Patient No");
                    HMSRadHeader.SetRange(HMSRadHeader."Link No.", Rec."Patient Appointment No");
                    if HMSRadHeader.find('-') then begin
                        HMSRadRequest.reset();
                        HMSRadRequest.setrange(HMSRadRequest."Radiology no.", HMSRadHeader."Radiology No.");
                        HMSRadRequest.setrange(HMSRadRequest."Radiology Type Code", ReceiptLine."Transaction No.");
                        HMSRadRequest.setrange(Paid, false);
                        if HMSRadRequest.find('-') then
                            repeat
                                HMSRadRequest."Receipt No" := Rec."No.";
                                HMSRadRequest."Receipt Line No" := ReceiptLine."Line No.";
                                HMSRadRequest.paid := true;
                                HMSRadRequest.modify();
                            until HMSRadRequest.next() = 0;
                    end;

                    HmsPatCharges.Init();
                    HmsPatCharges."Appointment No." := Rec."Patient Appointment No";
                    HmsPatCharges."Transaction Type" := 'zReceipt';
                    //     IF ReceiptLine.Type='CO-PAY' THEN BEGIN
                    //       HmsPatCharges."Transaction Type":='CO-PAY';
                    //        HmsPatCharges."G/L Account No" :='15007';
                    //        END;
                    // HmsPatCharges.Validate("Transaction Type");
                    HmsPatCharges.Date := Today;
                    HmsPatCharges."Line No" := ReceiptLine."Line No.";
                    HmsPatCharges."Patient No." := ReceiptLine."Patient No";
                    HmsPatCharges."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    HmsPatCharges."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    HmsPatCharges.Code := Rec."No.";
                    HmsPatCharges.Description := ReceiptLine.Type + ' Rcpt ' + ReceiptLine."Transaction Name";
                    HmsPatCharges.Amount := ReceiptLine.Amount * -1;
                    HmsPatCharges."Total Amount" := ReceiptLine.Amount * -1;
                    HmsPatCharges."Insurance Amount" := ReceiptLine.Amount * -1;
                    HmsPatCharges."Claim Receipt No" := ReceiptLine.No;
                    HmsPatCharges."Link No" := ReceiptLine."Transaction No.";
                    if PatRec.Get(Rec."Patient No.") then begin
                        HmsPatCharges."Visit No" := Rec."Patient Appointment No";
                        if PatRec."Patient Type" = PatRec."Patient Type"::Corporate then
                            HmsPatCharges."Insurance No" := PatRec."Insurance No.";
                    end;
                    HmsPatCharges.Posted := true;
                    if PatRec.Get(ReceiptLine."Patient No") then
                        HmsPatCharges."Visit No" := Rec."Patient Appointment No";
                    HmsPatCharges.Insert();
                end;
            until ReceiptLine.Next() = 0;
    end;

    local procedure UpdateInvoiceDetails()
    var
        HmsPatCharges: Record "HMS Patient Charges";
        SalesH: Record "Sales Invoice Header";
    begin
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then
            repeat
                SalesH.Reset();
                SalesH.SetRange(SalesH."No.", ReceiptLine."Applies-to Doc. No.");
                if SalesH.Find('-') then begin
                    SalesH.Paid := true;
                    SalesH."Payment Date" := Today;
                    SalesH."Receipt No" := ReceiptLine.No;
                    SalesH."Paid Amount" := ReceiptLine.Amount;
                    SalesH.Modify();
                end;

            until ReceiptLine.Next() = 0;
    end;

    procedure CheckTransactionTypeMissing() Exists: Boolean
    begin
        //get the sum total of the post dated cheques is any
        //reset the bank amount first
        Exists := false;
        BAmount := 0;
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then
            repeat
                if ReceiptLine."HSM Transaction Type" = '' then begin
                    Exists := true;
                    exit;
                    //cheque is post dated
                    // BAmount:=BAmount + ReceiptLine.Amount;
                end;
            until ReceiptLine.Next() = 0;
    end;

    local procedure PatientbillPending() ispending: Boolean
    var
        decCharge: Decimal;
        decCurrentOpenBill: Decimal;
        decReceipts: Decimal;
    begin
        ispending := true;
        decReceipts := 0;
        decCharge := 0;

        //Get open entries
        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", Rec."Patient No.");
        PatientCharges.SetRange(PatientCharges.Closed, false);
        PatientCharges.SetRange(PatientCharges.Posted, false);
        PatientCharges.SetFilter(PatientCharges.Amount, '>0');
        if PatientCharges.Find('-') then
            repeat
                decCharge := decCharge + PatientCharges.Amount;
            until PatientCharges.Next() = 0;

        //Get Receipts
        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", Rec."Patient No.");
        PatientCharges.SetFilter(PatientCharges.Amount, '<0');
        if PatientCharges.Find('-') then
            repeat
                decReceipts := decReceipts + PatientCharges.Amount;
            until PatientCharges.Next() = 0;


        if decReceipts < 0 then decReceipts := decReceipts * -1;

        decCurrentOpenBill := decCharge - decReceipts;

        //Ca
        if decCurrentOpenBill <= 0 then ispending := false;
    end;

    local procedure UpdateDoctorInvoiceNew()
    var
        HmsPatCharges: Record "HMS Patient Charges";
        HMSPatRec: Record "HMS Patient";
        HMSTransCode: Record "HMS Transactions code";
    begin
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then
            repeat
                HmsPatCharges.Reset();
                HmsPatCharges.SetRange(HmsPatCharges."Patient No.", ReceiptLine."Patient No");
                // HmsPatCharges.SETRANGE(HmsPatCharges."Posted Invoice No.",ReceiptLine."Applies-to Doc. No.");
                HmsPatCharges.SetRange(HmsPatCharges.Claimed, false);
                if HmsPatCharges.Find('-') then
                    repeat
                        HmsPatCharges.CalcFields("Posted Invoice No.");
                        HmsPatCharges.CalcFields(HmsPatCharges."Calc Doctor Fee");
                        if (HmsPatCharges."Posted Invoice No." = ReceiptLine."Applies-to Doc. No.") and (HmsPatCharges."Calc Doctor Fee" = true) then
                            if HMSTransCode.Get(HmsPatCharges."Transaction Type") then begin
                                if HMSPatRec.Get(HmsPatCharges."Patient No.") then;
                                LineNo := LineNo + 100;
                                HMSTransCode.TestField(HMSTransCode."Expense G/L Account");
                                GenJnlLine.Init();
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := Rec.Date;
                                GenJnlLine."Document No." := ReceiptLine.No;
                                GenJnlLine."Document Date" := Rec."Document Date";
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                                GenJnlLine."Account No." := HmsPatCharges."Doctor ID";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."External Document No." := HmsPatCharges."Invoice Number";
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");
                                GenJnlLine.Amount := HmsPatCharges."Doctors Amount" * -1;
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                // GenJnlLine."Bal. Account No.":=HMSTransCode."Expense G/L Account";
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := HmsPatCharges."Patient No." + ' -  ' + HMSPatRec.Surname + ' ' + HMSPatRec."Last Name";
                                GenJnlLine."Shortcut Dimension 1 Code" := HmsPatCharges."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := HmsPatCharges."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert();
                                //Balance Account
                                LineNo := LineNo + 100;
                                HMSTransCode.TestField(HMSTransCode."Expense G/L Account");
                                GenJnlLine.Init();
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := Rec.Date;
                                GenJnlLine."Document No." := ReceiptLine.No;
                                GenJnlLine."Document Date" := Rec."Document Date";
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account No." := HMSTransCode."Expense G/L Account";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."External Document No." := HmsPatCharges."Invoice Number";
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");
                                GenJnlLine.Amount := HmsPatCharges."Doctors Amount";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                // GenJnlLine."Bal. Account No.":=HMSTransCode."Expense G/L Account";
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := HmsPatCharges."Patient No." + ' -  ' + HMSPatRec.Surname + ' ' + HMSPatRec."Last Name";
                                ;
                                GenJnlLine."Shortcut Dimension 1 Code" := HmsPatCharges."Shortcut Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := HmsPatCharges."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                                if GenJnlLine.Amount <> 0 then GenJnlLine.Insert();
                            end;
                        HmsPatCharges.Claimed := true;
                        HmsPatCharges."Claim Receipt No" := ReceiptLine.No;
                    until HmsPatCharges.Next() = 0;
            until ReceiptLine.Next() = 0;

        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.Find('-') then
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnlLine);
    end;

    local procedure CloseBill(VisitNo: Text)
    var
        HmsPatCharges: Record "HMS Patient Charges";
    begin
        HmsPatCharges.Reset();
        HmsPatCharges.SetRange(HmsPatCharges."Patient No.", Rec."Patient No.");
        HmsPatCharges.SetRange(HmsPatCharges.Posted, false);
        HmsPatCharges.SetRange(HmsPatCharges."Own Debtor", false);
        HmsPatCharges.SetRange(HmsPatCharges."Visit No", VisitNo);
        if HmsPatCharges.Find('-') then
            repeat
                HmsPatCharges.Posted := true;
                HmsPatCharges."Invoice ID" := Rec."No.";
                HmsPatCharges.Closed := true;
                HmsPatCharges.Modify();

            until HmsPatCharges.Next() = 0;
    end;

    local procedure InsertIntoReceiptBuffer()
    var
        RecBuffer: Record "Split Receipt Buffer";
        RecLine: Record "Receipt Line q";
        SplitRec: Record "Receipt Split";
        lnNo: Integer;
    begin
        RecBuffer.RESET();
        IF RecBuffer.FIND('-') THEN
            lnNo := RecBuffer.Count;

        SplitRec.Reset();
        SplitRec.SetRange("Receipt No", Rec."No.");
        if SplitRec.find('-') then
            //insert split receipt into buffer
            repeat
                RecBuffer.Init();
                RecBuffer.Amount := SplitRec.Amount;
                RecBuffer."Bank Account No" := SplitRec."Bank Account No";
                RecBuffer."Pay Mode" := SplitRec."Pay Mode";
                RecBuffer."Patient No" := Rec."Patient No.";
                RecBuffer."Receipt No" := SplitRec."Receipt No";
                RecBuffer."Transaction No" := SplitRec."Transaction No";
                RecBuffer."Visit No" := Rec."Patient Appointment No";
                RecBuffer."Date Posted" := Today;
                RecBuffer."Posted By" := UserId;
                RecBuffer."Time Posted" := Time;
                RecBuffer."Patient Name" := Rec."Received From";
                RecBuffer."Receipt Line No" := lnNo;
                RecBuffer.Insert(true);
                lnNo := lnNo + 1;
            until SplitRec.Next() = 0
        else begin
            RecLine.Reset();
            RecLine.SetRange(RecLine.No, Rec."No.");
            if RecLine.Find('-') then
                repeat
                    RecBuffer.Init();
                    RecBuffer."Receipt No" := RecLine.No;
                    RecBuffer."Bank Account No" := RecLine."Bank Code";
                    RecBuffer."Patient No" := Rec."Patient No.";
                    RecBuffer."Pay Mode" := RecLine."Pay Mode";
                    RecBuffer.Amount := RecLine.Amount;
                    RecBuffer."Transaction No" := Rec."Transaction Code";
                    RecBuffer."Patient No" := Rec."Patient No.";
                    RecBuffer."Visit No" := Rec."Patient Appointment No";
                    RecBuffer."Transaction Type" := RecLine."HSM Transaction Type";
                    RecBuffer."Date Posted" := Today;
                    RecBuffer."Posted By" := UserId;
                    RecBuffer."Time Posted" := Time;
                    RecBuffer."Patient Name" := Rec."Received From";
                    RecBuffer."Receipt Line No" := lnNo;
                    RecBuffer.Insert();
                    lnNo := lnNo + 1;
                until RecLine.Next() = 0;

        end;
    end;

}

