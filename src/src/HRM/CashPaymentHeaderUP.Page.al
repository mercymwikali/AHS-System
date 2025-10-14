page 52203019 "Cash Payment Header UP"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approval,Check Budget';
    SourceTable = "Payments Header";
    SourceTableView = WHERE(Posted = CONST(false),
                            "Payment Type" = CONST("Petty Cash"),
                            Status = FILTER(<> Cancelled));

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("PF No"; Rec."PF No")
                {
                    ToolTip = 'Specifies the value of the PF No field.';
                    trigger OnValidate()
                    begin
                        HREmployee.Reset();
                        HREmployee.SetRange(HREmployee."No.", Rec."PF No");
                        if HREmployee.Find('-') then
                            LecturerName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Campus Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Campus Name field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Department Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = '%';
                }

                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field(Dim3; Rec.Dim3)
                {
                    ApplicationArea = Basic;
                    Caption = ' Patient Type';
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Paying Bank Account field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment to';
                    ToolTip = 'Specifies the value of the Payment to field.';
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Payment Narration field.';
                }
                field("Apply to Document Type"; Rec."Apply to Document Type")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Apply to Document Type field.';
                }
                field("Apply to Document No"; Rec."Apply to Document No")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Apply to Document No field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Cheque Type field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Total Payment Amount field.';
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Total VAT Amount field.';
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Total Witholding Tax Amount field.';
                }
                field("Total Retention Amount"; Rec."Total Retention Amount")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Total Retention Amount field.';
                }
                field("""Total Payment Amount"" - (""Total Witholding Tax Amount""+""Total VAT Amount""+""Total Retention Amount"")"; Rec."Total Payment Amount" - (Rec."Total Witholding Tax Amount" + Rec."Total VAT Amount" + Rec."Total Retention Amount"))
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Net Amount';
                    ToolTip = 'Specifies the value of the Total Net Amount field.';
                }
                field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                {
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Net Amount LCY field.';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Payment Release Date field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
            }
            group(Lines)
            {
                part(PVLines; "Cash Payment Lines UP")
                {
                    ApplicationArea = All;
                    SubPageLink = No = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Payment")
            {
                ApplicationArea = Basic;
                Caption = 'Post Payment';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Post Payment action.';

                trigger OnAction()
                begin
                    //Post PV Entries
                    CheckPVRequiredItems();
                    PostPaymentVoucher(Rec);
                end;
            }
            separator(Separator1102755026)
            {
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Executes the Approvals action.';

                trigger OnAction()
                begin
                    //DocumentType:=DocumentType::"Petty Cash";
                    //ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header",DocumentType,"No.");
                    //ApprovalEntries.RUN;

                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)
                end;
            }
            action(sendApproval)
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send A&pproval Request action.';

                trigger OnAction()
                begin
                    if not LinesExists() then
                        Error('There are no Lines created for this Document');

                    if not AllFieldsEntered() then
                        Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                    //Ensure No Items That should be committed that are not
                    if LinesCommitmentStatus() then
                        Error('There are some lines that have not been committed');

                    //Release the Imprest for Approval

                    /*State:=State::Open;
                   IF Status<>Status::Pending THEN State:=State::"Pending Approval";
                   DocType:=DocType::"Petty Cash";
                   CLEAR(tableNo);
                   tableNo:=DATABASE::"Payments Header";
                   IF ApprovalMgt.SendApproval(tableNo,Rec."No.",DocType,State,'',"Responsibility Center") THEN;
                   //  IF ApprovalMgt.SendLeaveApprovalRequest(Rec) THEN;*/

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(cancellsApproval)
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval Re&quest action.';

                trigger OnAction()
                begin
                    /*DocType:=DocType::"Payment Voucher";
                    showmessage:=TRUE;
                    ManualCancel:=TRUE;
                    CLEAR(tableNo);
                    tableNo:=DATABASE::"Payments Header";
                     IF ApprovalMgt.CancelApproval(tableNo,DocType,Rec."No.",showmessage,ManualCancel) THEN;*/

                    // IF ApprovalMgt.CancelLeaveApprovalRequest(Rec,TRUE,TRUE) THEN;

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            separator(Separator1102755009)
            {
            }
            action("Check Budgetary Availability")
            {
                ApplicationArea = Basic;
                Caption = 'Check Budgetary Availability';
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Executes the Check Budgetary Availability action.';

                trigger OnAction()
                var
                    BCSetup: Record "Budgetary Control Setup";
                begin
                    BCSetup.Get();
                    if not BCSetup.Mandatory then
                        exit;

                    if not AllFieldsEntered() then
                        Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                    //First Check whether other lines are already committed.
                    Commitments.Reset();
                    Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                    Commitments.SetRange(Commitments."Document No.", Rec."No.");
                    if Commitments.Find('-') then begin
                        if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then
                            exit;
                        Commitments.Reset();
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                        Commitments.SetRange(Commitments."Document No.", Rec."No.");
                        Commitments.DeleteAll();
                    end;

                    CheckBudgetAvail.CheckPayments(Rec);
                end;
            }
            action("Cancel Budget Commitment")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Budget Commitment';
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Executes the Cancel Budget Commitment action.';

                trigger OnAction()
                begin
                    if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then
                        exit;

                    Commitments.Reset();
                    Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                    Commitments.SetRange(Commitments."Document No.", Rec."No.");
                    Commitments.DeleteAll();

                    PayLine.Reset();
                    PayLine.SetRange(PayLine.No, Rec."No.");
                    if PayLine.Find('-') then
                        repeat
                            PayLine.Committed := false;
                            PayLine.Modify();
                        until PayLine.Next() = 0;
                end;
            }
            separator(Separator1102755033)
            {
            }
            action("Print/Preview")
            {
                ApplicationArea = Basic;
                Caption = 'Print/Preview';
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Executes the Print/Preview action.';

                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::Approved);
                    Rec.Reset();
                    Rec.SetFilter("No.", Rec."No.");
                    // REPORT.Run(Report::, true, true, Rec);
                    Rec.Reset();
                end;
            }
            action("Print Lecturer Claim Form")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Lecturer Claim Form';
                Promoted = true;
                PromotedCategory = Category5;
                Visible = false;
                ToolTip = 'Executes the Print Lecturer Claim Form action.';
                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(70134808, true, true, Rec);
                    Rec.Reset();
                end;
            }
            separator(Separator1102756004)
            {
            }
            action("Cancel Document")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Document';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Cancel Document action.';
                trigger OnAction()
                var
                    Text000: Label 'Are you sure you want to cancel this document?';
                    Text001: Label 'You have Selected not to cancle this document';
                begin
                    //TESTFIELD(Status,Status::Approved);
                    if Confirm(Text000, true) then begin
                        //Post Reversal Entries for Commitments
                        Doc_Type := Doc_Type::PettyCash;
                        CheckBudgetAvail.ReverseEntries(Doc_Type, Rec."No.");
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify();
                    end else
                        Error(Text001);
                end;
            }
            separator(Separator1102755040)
            {
            }
            action("Re-Open Document")
            {
                ApplicationArea = Basic;
                Caption = 'Re-Open Document';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Re-Open Document action.';
                trigger OnAction()
                begin
                    if Confirm('Do you really want to re-open the document?') then begin
                        Rec.Status := Rec.Status::Pending;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        Rec."Payment Type" := Rec."Payment Type"::"Petty Cash";
        Rec."Pay Mode" := Rec."Pay Mode"::Cash;
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
        CashierLinks: Record "Cash Office User Template";
        Temp: Record "Cash Office User Template";
        Commitments: Record Committment;
        GenJnlLine: Record "Gen. Journal Line";
        HREmployee: Record "HR-Employee";
        ImprestHeader: Record "Imprest Header";
        PayLine: Record "Payment Line";
        Payments: Record "Payments Header";
        PVHead: Record "Payments Header";
        TarriffCodes: Record "Tariff Codes";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocPrint: Codeunit "Document-Print";
        JournlPosted: Codeunit "Journal Post Successful";
        UserMgt: Codeunit "User Setup Management BR";
        AllKeyFieldsEntered: Boolean;
        HasLines: Boolean;
        Post: Boolean;
        JBatch: Code[10];
        JTemplate: Code[10];
        LineNo: Integer;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        LecturerName: Text[80];
        strText: Text[100];
        VarVariant: Variant;

    procedure UpdateControls()
    begin
        /* IF Status<>Status::Approved THEN BEGIN
         CurrForm."Payment Release Date".EDITABLE:=FALSE;
         //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
         CurrForm."Currency Code".EDITABLE:=TRUE;
         CurrForm.UPDATECONTROLS();
         END ELSE BEGIN
         CurrForm."Payment Release Date".EDITABLE:=TRUE;
         //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
         CurrForm."Currency Code".EDITABLE:=FALSE;
         CurrForm.UPDATECONTROLS();
         END;

         IF Status=Status::Pending THEN BEGIN
         CurrForm."Global Dimension 1 Code".EDITABLE:=TRUE;
         CurrForm."Shortcut Dimension 2 Code".EDITABLE:=TRUE;
         CurrForm.Payee.EDITABLE:=TRUE;
         CurrForm."Shortcut Dimension 3 Code".EDITABLE:=TRUE;
         CurrForm."Shortcut Dimension 4 Code".EDITABLE:=TRUE;
         CurrForm.Date.EDITABLE:=TRUE;
         CurrForm.UPDATECONTROLS();
         END ELSE BEGIN
         CurrForm."Global Dimension 1 Code".EDITABLE:=FALSE;
         CurrForm."Shortcut Dimension 2 Code".EDITABLE:=FALSE;
         CurrForm.Payee.EDITABLE:=FALSE;
         CurrForm."Shortcut Dimension 3 Code".EDITABLE:=FALSE;
         CurrForm."Shortcut Dimension 4 Code".EDITABLE:=FALSE;
         CurrForm.Date.EDITABLE:=FALSE;
         CurrForm.UPDATECONTROLS();
         END
    */
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
        BCsetup: Record "Budgetary Control Setup";
    begin
        if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
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
        if Rec.Posted then
            Error('The Document has already been posted');

        // Rec.TestField(Status, Rec.Status::Approved);
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Pay Mode");
        Rec.TestField("Payment Release Date");
        //TESTFIELD(Status::);

        //Confirm whether Bank Has the Cash
        if Rec."Pay Mode" = Rec."Pay Mode"::Cash then
            // CheckBudgetAvail.CheckFundsAvailability(Rec);

            /*Check if the user has selected all the relevant fields*/
        Temp.Get(UserId);

        JTemplate := Temp."Payment Journal Template";
        JBatch := Temp."Payment Journal Batch";

        if JTemplate = '' then
            Error('Ensure the PV Template is set up in Cash Office Setup');
        if JBatch = '' then
            Error('Ensure the PV Batch is set up in the Cash Office Setup');
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

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;

    procedure PostPaymentVoucher(rec: Record "Payments Header")
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
            if PayLine.FindFirst() then
                PostHeader(Payments);

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
                ImprestHeader.Status := ImprestHeader.Status::Posted;
                ImprestHeader."Payment Voucher No" := Rec."No.";
                ImprestHeader.Modify();
            end;
            if PVHead.Get(Rec."Apply to Document No") then begin
                PVHead.Posted := true;
                PVHead."Date Posted" := Today;
                PVHead."Time Posted" := Time;
                PVHead."Posted By" := UserId;
                PVHead.Status := PVHead.Status::Posted;

                PVHead.Modify();
            end;
        end;
        //END;
    end;

    procedure PostHeader(var Payment: Record "Payments Header")
    begin

        //IF (Payments."Pay Mode"=Payments."Pay Mode"::Cheque) AND ("Cheque Type"="Cheque Type"::"Computer Check") THEN
        //  ERROR('Cheque type has to be specified');
        /*
        IF Payments."Pay Mode"=Payments."Pay Mode"::Cheque THEN BEGIN
            IF (Payments."Cheque No."='') AND ("Cheque Type"="Cheque Type"::"2") THEN
              BEGIN
                ERROR('Please ensure that the cheque number is inserted');
              END;
        END;

        IF Payments."Pay Mode"=Payments."Pay Mode"::EFT THEN
          BEGIN
            IF Payments."Cheque No."='' THEN;
          END;

        IF Payments."Pay Mode"=Payments."Pay Mode"::"Letter of Credit" THEN
          BEGIN
            IF Payments."Cheque No."='' THEN
              BEGIN
                ERROR('Please ensure that the Letter of Credit ref no. is entered.');
              END;
          END;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name",JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name",JBatch);

          IF GenJnlLine.FIND('+') THEN
            BEGIN
              LineNo:=GenJnlLine."Line No."+1000;
            END
          ELSE
            BEGIN
              LineNo:=1000;
            END;

        LineNo:=LineNo+1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name":=JTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name":=JBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No.":=LineNo;
        GenJnlLine."Source Code":='PAYMENTJNL';
        GenJnlLine."Posting Date":=Payment."Payment Release Date";
        IF CustomerPayLinesExist THEN
         GenJnlLine."Document Type":=GenJnlLine."Document Type"::" "
        ELSE
          GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
        GenJnlLine."Document No.":=Payments."No.";
        GenJnlLine."External Document No.":=Payments."Cheque No.";

        GenJnlLine."Account Type":=GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No.":=Payments."Paying Bank Account";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");

        GenJnlLine."Currency Code":=Payments."Currency Code";
        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        Payments.CALCFIELDS(Payments."Total Net Amount");
        //GenJnlLine.Amount:=-(Payments."Total Net Amount" );
        GenJnlLine.Amount:=-Payments."Total Payment Amount" - (Payments."Total Witholding Tax Amount"+Payments."Total VAT Amount"+Payments."Total Retention Amount");

        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No.":='';

        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");

        GenJnlLine.Description:=COPYSTR('Pay To:' + Payments.Payee,1,50);
        GenJnlLine.VALIDATE(GenJnlLine.Description);

        IF "Pay Mode"<>"Pay Mode"::Cheque THEN  BEGIN
        GenJnlLine."Bank Payment Type":=GenJnlLine."Bank Payment Type"::" "
        END ELSE BEGIN
        IF "Cheque Type"="Cheque Type"::"Manual Check" THEN
         GenJnlLine."Bank Payment Type":=GenJnlLine."Bank Payment Type"::"Computer Check"
        ELSE
           GenJnlLine."Bank Payment Type":=GenJnlLine."Bank Payment Type"::" "
        END;
        IF GenJnlLine.Amount<>0 THEN
        GenJnlLine.INSERT;

        //Post Other Payment Journal Entries
        PostPV(Payments);
        */ /////////////////////////////////////////////////// From John

        if (Payments."Pay Mode" = Payments."Pay Mode"::Cheque) and (Rec."Cheque Type" = Rec."Cheque Type"::" ") then
            Error('Cheque type has to be specified');

        if Payments."Pay Mode" = Payments."Pay Mode"::Cheque then
            if (Payments."Cheque No." = '') and (Rec."Cheque Type" = Rec."Cheque Type"::"Manual Check") then
                Error('Please ensure that the cheque number is inserted');

        if Payments."Pay Mode" = Payments."Pay Mode"::EFT then
            if Payments."Cheque No." = '' then
                Error('Please ensure that the EFT number is inserted');

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
        Payments.CalcFields("Total Payment Amount");
        Payments.CalcFields("Total Witholding Tax Amount");
        Payments.CalcFields("Total VAT Amount");
        Payments.CalcFields("Total Retention Amount");

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
        //CurrFactor
        GenJnlLine."Currency Factor" := Payments."Currency Factor";
        GenJnlLine.Validate("Currency Factor");

        Payments.CalcFields(Payments."Total Net Amount", Payments."Total VAT Amount");
        //(Payments."Total Net Amount" );
        GenJnlLine.Amount := -(Payments."Total Payment Amount" - (Payments."Total Witholding Tax Amount" + Payments."Total VAT Amount" + Payments."Total Retention Amount"));

        //error(format(Payments."Total Payment Amount" - (Payments."Total Witholding Tax Amount"+Payments."Total VAT Amount"+Payments."Total Retention Amount")));
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';

        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

        GenJnlLine.Description := CopyStr(Rec."Payment Narration", 1, 50) + 'R2';//COPYSTR('Pay To:' + Payments.Payee,1,50);
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

    procedure PostPV(var Payment: Record "Payments Header")
    begin

        PayLine.Reset();
        PayLine.SetRange(PayLine.No, Payments."No.");
        if PayLine.Find('-') then begin

            repeat
                strText := GetAppliedEntries(PayLine."Line No.");
                Payment.TestField(Payment.Payee);
                PayLine.TestField(PayLine.Amount);
                //IF PayLine."PAYE Amount">0 THEN PayLine.TESTFIELD(PayLine."KRA Pin No.");
                // PayLine.TESTFIELD(PayLine."Global Dimension 1 Code");

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
                if CustomerPayLinesExist() then
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                else
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine.Description := CopyStr(Rec."Payment Narration", 1, 50);
                //    GenJnlLine.Description:=COPYSTR(PayLine."Transaction Name" + ':' + Payment.Payee,1,50);
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate("Currency Code");
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");

                if PayLine."VAT Code" = '' then
                    GenJnlLine.Amount := PayLine."Net Amount"//..
                else
                    if PayLine."VAT Withheld Code" = '' then
                        GenJnlLine.Amount := PayLine."Net Amount"
                    else
                        GenJnlLine.Amount := PayLine."Net Amount";
                if PayLine."Retention Code" <> '' then
                    GenJnlLine.Amount := PayLine.Amount;

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
                // error(format(GenJnlLine.Amount));
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();

                //Post RETENTION to GL[RETENTION GL]
                if PayLine."Retention Code" <> '' then begin

                    TarriffCodes.Reset();
                    TarriffCodes.SetRange(TarriffCodes.Code, PayLine."Retention Code");
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
                        if CustomerPayLinesExist() then
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                        else
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                        GenJnlLine."Document No." := PayLine.No;
                        GenJnlLine."External Document No." := Payments."Cheque No.";
                        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No." := TarriffCodes."G/L Account";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Currency Code" := Payments."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        //CurrFactor
                        GenJnlLine."Currency Factor" := Payments."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");

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
                        GenJnlLine.Amount := -PayLine."Retention  Amount";
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.Description := CopyStr('RETENTION1:' + Format(PayLine."Account Type") + '::' + Format(PayLine."Account Name"), 1, 50);
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                        GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert();
                    end;

                    // Retention to balancing
                    LineNo := LineNo + 1000;
                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    if CustomerPayLinesExist() then
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                    else
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := PayLine."Account Type";
                    GenJnlLine."Account No." := PayLine."Account No.";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    //CurrFactor
                    GenJnlLine."Currency Factor" := Payments."Currency Factor";
                    GenJnlLine.Validate("Currency Factor");

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
                    GenJnlLine.Amount := PayLine."Retention  Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.Description := CopyStr('RETENTION2:' + Format(PayLine."Account Type") + '::' + Format(PayLine."Account Name"), 1, 50);
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                    GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                    // IF GenJnlLine.Amount<>0 THEN GenJnlLine.INSERT;
                end;

                ///////////////Post VAT WITHHELD////////////////////////////////////////////////////

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
                    GenJnlLine.Amount := -PayLine."VAT Withheld Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.Description := CopyStr('VAT WITHHELD:' + Format(PayLine."Account Type") + '::' + Format(PayLine."Account Name"), 1, 50);
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

                ////////////////////////////END VAT WITHHELD to GL//////////////////////////////////////////////
                TarriffCodes.Reset();
                TarriffCodes.SetRange(TarriffCodes.Code, PayLine."VAT Code");
                if TarriffCodes.Find('-') then begin
                    // TarriffCodes.TESTFIELD(TarriffCodes."G/L Account");
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
                    //GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                    //GenJnlLine."Bal. Account Type":=GenJnlLine."Account Type"::Vendor;
                    GenJnlLine."Account Type" := PayLine."Account Type";
                    GenJnlLine."Account No." := PayLine."Account No.";
                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    //GenJnlLine."Account No.":=TarriffCodes."G/L Account";
                    //GenJnlLine.VALIDATE(GenJnlLine."Account No.");
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
                    GenJnlLine.Amount := PayLine."VAT Withheld Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.Description := CopyStr('VAT WITHHELD:' + Format(PayLine."Account Type") + '::' + Format(PayLine."Account Name"), 1, 50);
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

                ////////////////////END BALANCING VAT WITHHELD/////////////////////////////////////////////////////////////

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
                    if CustomerPayLinesExist() then
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                    else
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Account No." := TarriffCodes."G/L Account";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    //CurrFactor
                    GenJnlLine."Currency Factor" := Payments."Currency Factor";
                    GenJnlLine.Validate("Currency Factor");

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
                    GenJnlLine."Bal. Account Type" := PayLine."Account Type";
                    // GenJnlLine."Bal. Account No.":=PayLine."Account No.";
                    // GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := CopyStr('W/Tax:' + Format(PayLine."Account Name") + '::' + strText, 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                    GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");

                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert();
                end;

                ///////////////Post P.A.Y.E////////////////////////////////////////////////////

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
                    GenJnlLine.Description := CopyStr('p.a.y.e:' + Format(PayLine."Account Type") + '::' + Format(PayLine."Account Name"), 1, 50);
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
                if CustomerPayLinesExist() then
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                else
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                //CurrFactor
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");

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
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                if GenJnlLine.Amount <> 0 then
                    //  GenJnlLine.INSERT;

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
                if CustomerPayLinesExist() then
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                else
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                //CurrFactor
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");

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
                GenJnlLine.Amount := PayLine."Withholding Tax Amount";//1
                GenJnlLine.Validate(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := CopyStr('W/Tax:' + strText, 1, 50);
                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, PayLine."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();
                //Post P.A.YE Balancing Entry Goes to Vendor
                LineNo := LineNo + 1000;
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                if CustomerPayLinesExist() then
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                else
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.Validate(GenJnlLine."Currency Code");
                //CurrFactor
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.Validate("Currency Factor");

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
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
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
            //   AdjustGenJnl.RUN(GenJnlLine);
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
                        PayLine.Posted := true;
                        PayLine.Status := PayLine.Status::Posted;
                        PayLine.Modify();
                    until PayLine.Next() = 0;
            //update creation doc as posted
            /* IF StaffClaim.GET("Creation Doc No.") THEN
                BEGIN
                  StaffClaim."Date Posted":=TODAY;
                  StaffClaim."Time Posted":=TIME;
                  StaffClaim."Posted By":=USERID;
                  StaffClaim.Status:=Status::Posted;
                  StaffClaim.Posted:=TRUE;
                  StaffClaim.MODIFY;
                END;
              IF AdvanceHeader.GET("Creation Doc No.") THEN
                BEGIN
                  AdvanceHeader."Date Posted":=TODAY;
                  AdvanceHeader."Time Posted":=TIME;
                  AdvanceHeader."Posted By":=USERID;
                  AdvanceHeader.Status:=Status::Posted;
                  AdvanceHeader.Posted:=TRUE;
                  AdvanceHeader.MODIFY;
                END;
              IF PayReqHeader.GET("Creation Doc No.") THEN
                BEGIN
                  PayReqHeader."Date Posted":=TODAY;
                  PayReqHeader."Time Posted":=TIME;
                  PayReqHeader."Posted By":=USERID;
                  PayReqHeader.Status:=Status::Posted;
                  PayReqHeader.Posted:=TRUE;
                  PayReqHeader.MODIFY;
                END; */
        end;
    end;
}
