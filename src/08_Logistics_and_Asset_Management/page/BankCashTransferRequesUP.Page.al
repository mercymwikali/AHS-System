page 85099 "Bank & Cash Transfer Reques UP"
{
    ApplicationArea = Basic, Suite;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval';
    SourceTable = "InterBank Transfers";
    SourceTableView = WHERE(Posted = CONST(false),
                            Status = FILTER(<> Cancelled));
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Date; Rec.Date)
                {
                    Editable = DateEditable;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Status; Rec.Status)
                {
                    // Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Control1102758030; '')
                {
                    CaptionClass = Text19025618;
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Receiving Transfer Type"; Rec."Receiving Transfer Type")
                {
                    Editable = ReceivingTransferTypeEditable;
                    ToolTip = 'Specifies the value of the Receiving Transfer Type field.';
                }
                field("Reciept Responsibility Center"; Rec."Reciept Responsibility Center")
                {
                    Editable = RecieptResponsibilityCenterEdi;
                    ToolTip = 'Specifies the value of the Reciept Responsibility Center field.';
                }
                field("Receipt Resp Centre"; Rec."Receipt Resp Centre")
                {
                    ToolTip = 'Specifies the value of the Receipt Resp Centre field.';
                }
                field("Receiving Depot Code"; Rec."Receiving Depot Code")
                {
                    ToolTip = 'Specifies the value of the Receiving Depot Code field.';
                }
                field("Receiving Department Code"; Rec."Receiving Department Code")
                {
                    ToolTip = 'Specifies the value of the Receiving Department Code field.';
                }
                field("Receiving Depot Name"; Rec."Receiving Depot Name")
                {
                    Caption = 'Receiving Department Name';
                    ToolTip = 'Specifies the value of the Receiving Department Name field.';
                }
                field("Receiving Account"; Rec."Receiving Account")
                {
                    Editable = "Receiving AccountEditable";
                    ToolTip = 'Specifies the value of the Receiving Account field.';

                    trigger OnValidate()
                    begin
                        ReceivingAccountOnAfterValidat();
                    end;
                }
                field("Receiving Bank Account Name"; Rec."Receiving Bank Account Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Receiving Bank Account Name field.';
                }
                field("Currency Code Destination"; Rec."Currency Code Destination")
                {
                    ToolTip = 'Specifies the value of the Currency Code Destination field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Request Amt LCY"; Rec."Request Amt LCY")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request Amt LCY field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("Transactions Type"; Rec."Transactions Type")
                {
                    ToolTip = 'Specifies the value of the Transactions Type field.';
                }
                field("External Doc No."; Rec."External Doc No.")
                {
                    Editable = "External Doc No.Editable";
                    ToolTip = 'Specifies the value of the External Doc No. field.';
                }
                field("Transfer Release Date"; Rec."Transfer Release Date")
                {
                    Editable = "Transfer Release DateEditable";
                    ToolTip = 'Specifies the value of the Transfer Release Date field.';
                }
                field("Exch. Rate Destination"; Rec."Exch. Rate Destination")
                {
                    Editable = "Exch. Rate DestinationEditable";
                    Visible = "Exch. Rate DestinationVisible";
                    ToolTip = 'Specifies the value of the Exch. Rate Destination field.';
                }
                field("Exch. Rate Source"; Rec."Exch. Rate Source")
                {
                    Editable = "Exch. Rate SourceEditable";
                    Visible = "Exch. Rate SourceVisible";
                    ToolTip = 'Specifies the value of the Exch. Rate Source field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = RemarksEditable;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
            group("Transfer Lines")
            {
                part(Control9; "Interbank Transfer Lines")
                {
                    SubPageLink = "No." = FIELD(No);
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Approvals action.';
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
            separator(Separator1102756004)
            {
            }
            action(sendApproval)
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send A&pproval Request action.';

                trigger OnAction()
                begin

                    Rec.TestField(Status, Rec.Status::Pending);
                    if Rec.Status = Rec.Status::"Pending Approval" then
                        Error(PendingErr);
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval Re&quest action.';

                trigger OnAction()
                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    Rec.Status := Rec.Status::Pending;
                    Rec.Modify();

                    // IF ApprovalMgt.CancelLeaveApprovalRequest(Rec,TRUE,TRUE) THEN;
                end;
            }

            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Executes the Print action.';
                trigger OnAction()
                begin

                    InterBank.Reset();
                    InterBank.SetRange(InterBank.No, Rec.No);
                    if InterBank.Find('-') then
                        REPORT.Run(Report::"Interbank Details", true, true, InterBank);
                end;
            }
            action("Cancel Document")
            {
                Caption = 'Cancel Document';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Cancel Document action.';
                trigger OnAction()
                var
                    Text000: Label 'Are you sure you want to Cancel this Document?';
                    Text001: Label 'You have selected not to Cancel this Document';
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Confirm(Text000, true) then begin
                        Rec.Status := Rec.Status::Cancelled;
                        Rec."Cancelled By" := UserId;
                        Rec."Date Cancelled" := Today;
                        Rec."Time Cancelled" := Time;
                        Rec.Modify();
                    end else
                        Error(Text001);
                end;
            }

            action("&Post")
            {
                Caption = '&Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the &Post action.';

                trigger OnAction()
                begin
                    CashOfficeUserTemplate.Reset();
                    CashOfficeUserTemplate.SetRange(CashOfficeUserTemplate.UserID, UserId);
                    if CashOfficeUserTemplate.Find('-') then begin
                        Rec."Inter Bank Template Name" := CashOfficeUserTemplate."Inter Bank Template Name";
                        Rec."Inter Bank Journal Batch" := CashOfficeUserTemplate."Inter Bank Batch Name";
                    end;

                    Rec.TESTFIELD(Status, Rec.Status::Approved);
                    Rec.TestField("Transfer Release Date");
                    Rec.CalcFields("Total Amount");
                    //Check whether the two LCY amounts are same
                    if Rec."Request Amt LCY" <> Rec."Total Amount" then
                        Error('The [Requested Amount in LCY: %1] should be same as the [Total Amount in LCY: %2]', Rec."Request Amt LCY", Rec."Pay Amt LCY");

                    //get the source account balance from the database table
                    BankAcc.Reset();
                    BankAcc.SetRange(BankAcc."No.", Rec."Paying Account");
                    BankAcc.SetRange(BankAcc."Bank Type", BankAcc."Bank Type"::Cash);

                    /* if BankAcc.FindFirst() then begin
                        BankAcc.CalcFields(BankAcc.Balance);
                        Rec."Current Source A/C Bal." := BankAcc.Balance;
                        if (Rec."Current Source A/C Bal." - Rec.Amount) < 0 then
                            Error('The transaction will result in a negative balance in a CASH ACCOUNT.');
                    end; */
                    if Rec.Amount = 0 then
                        Error('Please ensure Amount to Transfer is entered');
                    /*Check if the user's batch has any records within it*/
                    GenJnlLine.Reset();
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", Rec."Inter Bank Template Name");
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec."Inter Bank Journal Batch");
                    GenJnlLine.DeleteAll();

                    LineNo := LineNo + 1000;
                    /*Insert the new lines to be updated*/
                    GenJnlLine.Init();
                    /*Insert the lines*/
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Journal Template Name" := Rec."Inter Bank Template Name";
                    GenJnlLine."Journal Batch Name" := Rec."Inter Bank Journal Batch";
                    GenJnlLine."Posting Date" := Rec."Transfer Release Date";
                    GenJnlLine."Document No." := Rec.No;
                    if Rec."Receiving Transfer Type" = Rec."Receiving Transfer Type"::"Intra-Company" then
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account"
                    else
                        if Rec."Receiving Transfer Type" = Rec."Receiving Transfer Type"::"Inter-Company" then
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"IC Partner";
                    GenJnlLine."Account No." := Rec."Receiving Account";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format(Rec.No);
                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Receiving Depot Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Receiving Department Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code1");
                    GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code1");
                    GenJnlLine."External Document No." := Rec."External Doc No.";
                    GenJnlLine.Description := Rec.Remarks;
                    if Rec.Remarks = '' then
                        GenJnlLine.Description := 'Inter-Bank Transfer Ref No:' + Format(Rec.No);
                    GenJnlLine."Currency Code" := Rec."Currency Code Destination";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    if Rec."Currency Code Destination" <> '' then begin
                        GenJnlLine."Currency Factor" := Rec."Exch. Rate Destination";//"Reciprical 2";
                        GenJnlLine.Validate(GenJnlLine."Currency Factor");
                    end;
                    GenJnlLine.Amount := Rec."Total Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    //if "Transactions Type" = "Transactions Type"::Cash then
                    GenJnlLine.Insert();

                    InterBankLines.Reset();
                    InterBankLines.SetRange(InterBankLines."No.", Rec.No);
                    if InterBankLines.Find('-') then
                        repeat
                            InterBankLines.TestField("Paying Bank No");
                            InterBankLines.TestField("Source Campus Code");
                            InterBankLines.TestField("Source Department Code");
                            GenJnlLine.Init();
                            /*Insert the lines*/
                            GenJnlLine."Line No." := LineNo + 1;
                            GenJnlLine."Source Code" := 'PAYMENTJNL';
                            GenJnlLine."Journal Template Name" := Rec."Inter Bank Template Name";
                            GenJnlLine."Journal Batch Name" := Rec."Inter Bank Journal Batch";
                            GenJnlLine."Posting Date" := Rec."Transfer Release Date";

                            GenJnlLine."Document No." := Rec.No;

                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";

                            GenJnlLine."Account No." := InterBankLines."Paying Bank No";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine."Shortcut Dimension 1 Code" := InterBankLines."Source Campus Code";
                            GenJnlLine."Shortcut Dimension 2 Code" := InterBankLines."Source Department Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                            GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                            GenJnlLine."External Document No." := Rec."External Doc No.";
                            GenJnlLine.Description := InterBankLines.Description;
                            // GenJnlLine."Currency Code":="Currency Code Source";
                            //    GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                            //    IF "Currency Code Source"<>'' THEN
                            //      BEGIN
                            //        GenJnlLine."Currency Factor":="Exch. Rate Source";//"Reciprical 1";
                            //        GenJnlLine.VALIDATE(GenJnlLine."Currency Factor");
                            //      END;
                            GenJnlLine.Amount := -InterBankLines.Amount;
                            GenJnlLine.Validate(GenJnlLine.Amount);
                            if Rec."Transactions Type" = Rec."Transactions Type"::Cheque then begin
                                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                                GenJnlLine."Bal. Account No." := Rec."Receiving Account";
                            end;
                            GenJnlLine.Insert();
                            LineNo := LineNo + 1;
                            if ReceiptH.Get(InterBankLines."Receipt No") then begin
                                ReceiptH."InterBank No" := Rec.No;
                                ReceiptH.Modify();
                            end;
                        until InterBankLines.Next() = 0;
                    Post := true;
                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
                    //Post:=JournalPostedSuccessfully.PostedSuccessfully();

                    //IF Post THEN BEGIN

                    Rec.Posted := true;
                    Rec."Date Posted" := Today;
                    Rec."Time Posted" := Time;
                    Rec."Posted By" := UserId;
                    Rec.Modify();
                    Message('The Journal Has Been Posted Successfully');
                    //END;
                end;
            }

            action("Suggest Receipts")
            {
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Suggest Receipts action.';

                trigger OnAction()
                begin
                    // ReceiptH.Reset();
                    // ReceiptH.SetFilter("InterBank No Filter", Rec.No);
                    // if ReceiptH.Find('-') then
                    //     REPORT.Run(70135532, true, true, ReceiptH);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        "Transfer Release DateEditable" := true;
        "External Doc No.Editable" := true;
        "Exch. Rate SourceEditable" := true;
        AmountEditable := true;
        "Paying AccountEditable" := true;
        SendingResponsibilityCenterEdi := true;
        "Source Transfer TypeEditable" := true;
        "Exch. Rate DestinationEditable" := true;
        RemarksEditable := true;
        "Amount 2Editable" := true;
        "Receiving AccountEditable" := true;
        RecieptResponsibilityCenterEdi := true;
        ReceivingTransferTypeEditable := true;
        DateEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Date := Today;
        Rec."Inter Bank Template Name" := JTemplate;
        Rec."Inter Bank Journal Batch" := JBatch;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Reciept Responsibility Center" := UserMgt.GetPurchasesFilter();
        //VALIDATE( "Reciept Responsibility Center");
        Rec.Status := Rec.Status::Pending;
        Rec."Created By" := UserId;
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Reciept Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;

        CashOfficeUserTemplate.Reset();

        CashOfficeUserTemplate.SetRange(CashOfficeUserTemplate.UserID, UserId);
        if CashOfficeUserTemplate.Find('-') then begin
            JTemplate := CashOfficeUserTemplate."Inter Bank Template Name";
            JBatch := CashOfficeUserTemplate."Inter Bank Batch Name";
        end;

        /*Check if the user has the batches selected*/
        /*IF (JTemplate='') OR (JBatch='') THEN
          BEGIN
            ERROR('Please ensure you are setup as an interbank transfer user');
          END;*/

        /*
       IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
         FILTERGROUP(2);
         SETRANGE("Reciept Responsibility Center" ,UserMgt.GetPurchasesFilter());
         FILTERGROUP(0);
       END;
          //Reciept Responsibility Center
          */
    end;

    var
        BankAcc: Record "Bank Account";
        CashOfficeUserTemplate: Record "Cash Office User Template";
        GenJnlLine: Record "Gen. Journal Line";
        // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        InterBankLines: Record "Interbank Transfer Lines";
        InterBank: Record "InterBank Transfers";
        ReceiptH: Record "Receipts Header";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        UserMgt: Codeunit "User Setup Management BR";
        [InDataSet]
        "Amount 2Editable": Boolean;
        [InDataSet]
        AmountEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        "Exch. Rate DestinationEditable": Boolean;

        "Exch. Rate DestinationVisible": Boolean;
        [InDataSet]
        "Exch. Rate SourceEditable": Boolean;
        [InDataSet]
        "Exch. Rate SourceVisible": Boolean;
        [InDataSet]
        "External Doc No.Editable": Boolean;
        [InDataSet]
        "Paying AccountEditable": Boolean;
        Post: Boolean;
        [InDataSet]
        "Receiving AccountEditable": Boolean;
        [InDataSet]
        ReceivingTransferTypeEditable: Boolean;
        [InDataSet]
        RecieptResponsibilityCenterEdi: Boolean;
        [InDataSet]
        RemarksEditable: Boolean;
        [InDataSet]
        SendingResponsibilityCenterEdi: Boolean;
        [InDataSet]
        "Source Transfer TypeEditable": Boolean;
        [InDataSet]
        "Transfer Release DateEditable": Boolean;
        JBatch: Code[20];
        JTemplate: Code[20];
        LineNo: Integer;
        PendingErr: Label 'Document has already been sent for Approval';
        Text19025618: Label 'Requesting Details';
        VarVariant: Variant;

    procedure GetDimensionName(var "Code": Code[20]; DimNo: Integer) Name: Text[60]
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        /*Get the global dimension 1 and 2 from the database*/
        Name := '';

        GLSetup.Reset();
        GLSetup.Get();

        DimVal.Reset();
        DimVal.SetRange(DimVal.Code, Code);

        if DimNo = 1 then
            DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code")
        else
            if DimNo = 2 then
                DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
        if DimVal.Find('-') then
            Name := DimVal.Name;
    end;

    procedure UpdateControl()
    begin
        /*IF Status<>Status::Pending THEN BEGIN
           DateEditable :=FALSE;
           ReceivingTransferTypeEditable :=FALSE;
           RecieptResponsibilityCenterEdi :=FALSE;
           "Receiving AccountEditable" :=FALSE;
           "Amount 2Editable" :=FALSE;
           RemarksEditable :=FALSE;
           "Exch. Rate DestinationEditable" :=FALSE;
        END ELSE BEGIN
           DateEditable :=TRUE;
           ReceivingTransferTypeEditable :=TRUE;
           RecieptResponsibilityCenterEdi :=TRUE;
           "Receiving AccountEditable" :=TRUE;
           "Amount 2Editable" :=TRUE;
           RemarksEditable :=TRUE;
           "Exch. Rate DestinationEditable" :=TRUE;
        END;

        IF Status=Status::Approved THEN BEGIN
           "Source Transfer TypeEditable" :=TRUE;
           SendingResponsibilityCenterEdi :=TRUE;
           "Paying AccountEditable" :=TRUE;
           AmountEditable :=TRUE;
           "Paying AccountEditable" :=TRUE;
           "Exch. Rate SourceEditable" :=TRUE;
           "External Doc No.Editable" :=TRUE;
           "Transfer Release DateEditable" :=TRUE;
        END ELSE BEGIN
           "Source Transfer TypeEditable" :=FALSE;
           SendingResponsibilityCenterEdi :=FALSE;
           AmountEditable :=FALSE;
           "Paying AccountEditable" :=FALSE;
           "Exch. Rate SourceEditable" :=FALSE;
           "External Doc No.Editable" :=FALSE;
           "Transfer Release DateEditable" :=FALSE;
        END;
         */
    end;

    local procedure ReceivingAccountOnAfterValidat()
    begin
        //check if the currency code field has been filled in
        "Exch. Rate DestinationVisible" := false;
        if Rec."Currency Code Destination" <> '' then
            "Exch. Rate DestinationVisible" := true;
    end;

    local procedure PayingAccountOnAfterValidate()
    begin
        //check if the currency code field has been filled in
        "Exch. Rate SourceVisible" := false;
        if Rec."Currency Code Source" <> '' then
            "Exch. Rate SourceVisible" := true;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        if Rec."Currency Code Source" <> '' then
            "Exch. Rate SourceVisible" := true
        else
            "Exch. Rate SourceVisible" := false;

        if Rec."Currency Code Destination" <> '' then
            "Exch. Rate DestinationVisible" := true
        else
            "Exch. Rate DestinationVisible" := false;

        UpdateControl();
    end;
}
