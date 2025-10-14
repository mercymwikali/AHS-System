page 52203063 "Item/Cash Card"
{
    Caption = 'Item Cash Requisition';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Check Budget Availlability';
    SourceTable = "Imprest Header";
    SourceTableView = WHERE(Posted = FILTER(false),
                            Status = FILTER(<> Cancelled),
                            "imprest TYpe" = FILTER("Item Cash"));

    layout
    {
        area(content)
        {
            group(Control54)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = basic;
                    Editable = true;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = basic;
                    Editable = DateEditable;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Requested By field.';
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = basic;
                    Caption = 'Staff Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = basic;
                    Editable = GlobalDimension1CodeEditable;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = basic;
                    Caption = 'Branch Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Branch Name field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = basic;
                    Editable = ShortcutDimension2CodeEditable;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Department Name"; Rec."Budget Center Name")
                {
                    ApplicationArea = basic;
                    Caption = 'Department Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = basic;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Total Net Amount field.';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    ApplicationArea = basic;
                    Caption = 'Payment Release Date';
                    ToolTip = 'Specifies the value of the Payment Release Date field.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = basic;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
                field("Actual Expenditure"; Rec."Actual Expenditure")
                {
                    ApplicationArea = basic;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Actual Expenditure field.';
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    ApplicationArea = basic;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Committed Amount field.';
                }
                field("Budget Balance"; Rec."Budget Balance")
                {
                    ApplicationArea = basic;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Budget Balance field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = basic;
                    Caption = 'Paying Cash Account';
                    Editable = true;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Paying Cash Account field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = basic;
                    Caption = 'Cash Account Name';
                    Editable = false;
                    Visible = true;
                    ToolTip = 'Specifies the value of the Cash Account Name field.';
                }
            }
            part(PVLines; "ItemCash Details UP")
            {
                ApplicationArea = basic;
                SubPageLink = No = FIELD("No."),
                              "Imprest Type" = FILTER(ItemCash);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Imprest")
            {
                ApplicationArea = basic;
                Caption = 'Post';
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;
                ToolTip = 'Executes the Post action.';

                trigger OnAction()
                begin
                    if Confirm('Post Document?', true) = false then
                        exit;

                    PostImprest();
                end;
            }
            separator(Separator24)
            {
            }
            separator(Separator13)
            {
            }
            action("Check Budgetary Availability")
            {
                ApplicationArea = basic;
                Caption = 'Check Budgetary Availability';
                Image = CheckLedger;
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

                    if not LinesExists() then
                        Error('There are no Lines created for this Document');

                    if not AllFieldsEntered() then
                        Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                    //First Check whether other lines are already committed.
                    Commitments.Reset();
                    Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::Imprest);
                    Commitments.SetRange(Commitments."Document No.", Rec."No.");
                    if Commitments.Find('-') then begin
                        if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then
                            exit;
                        Commitments.Reset();
                        Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::Imprest);
                        Commitments.SetRange(Commitments."Document No.", Rec."No.");
                        Commitments.DeleteAll();
                    end;

                    CheckBudgetAvail.CheckImprest(Rec);
                end;
            }
            action("Cancel Budget Commitment")
            {
                ApplicationArea = basic;
                Caption = 'Cancel Budget Commitment';
                Image = CancelledEntries;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Executes the Cancel Budget Commitment action.';
                trigger OnAction()
                begin
                    if Confirm('Do you Wish to Cancel the Commitment entries for this document', false) = false then
                        exit;

                    Commitments.Reset();
                    Commitments.SetRange(Commitments."Document Type", Commitments."Document Type"::Imprest);
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
            separator(Separator9)
            {
            }
            action("Print/Preview")
            {
                ApplicationArea = basic;
                Caption = 'Print/Preview';
                Image = PrintAttachment;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Executes the Print/Preview action.';
                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then
                        Error('You can only print after the document is released for approval');
                    Rec.Reset();
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(70134926, true, true, Rec);
                    Rec.Reset();
                end;
            }
            separator(Separator5)
            {
            }
            action("Cancel Document")
            {
                ApplicationArea = basic;
                Caption = 'Cancel Document';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Cancel Document action.';
                trigger OnAction()
                var
                    Text000: Label 'Are you sure you want to Cancel this Document?';
                    Text001: Label 'You have selected not to Cancel this Document';
                begin
                    //TESTFIELD(Status,Status::Approved);
                    if Confirm(Text000, true) then begin
                        //Post Committment Reversals
                        Doc_Type := Doc_Type::Imprest;
                        BudgetControl.ReverseEntries(Doc_Type, Rec."No.");
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify();
                    end else
                        Error(Text001);
                end;
            }
            action(Action21)
            {
                Caption = 'Post Imprest';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Post Imprest action.';

                trigger OnAction()
                begin
                    if Confirm('Post Document?', true) = false then
                        exit;

                    PostImprest();
                end;
            }
            action("Print Accounting Request")
            {
                Image = PrintAttachment;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Executes the Print Accounting Request action.';
                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::Approved);
                    if Confirm('Print', true) then begin
                        //Post Committment Reversals
                        Doc_Type := Doc_Type::Imprest;
                        BudgetControl.ReverseEntries(Doc_Type, Rec."No.");
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify();
                    end else
                        Error('Document Cancelled Successfully');
                end;
            }
            action(sendApproval)
            {
                ApplicationArea = basic;
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
                    Rec.TestField(Status, Rec.Status::Pending);

                    if not AllFieldsEntered() then
                        Error('Please enter all the required information in the lines. (Account No,Amount,Qunatity');

                    if LinesCommitmentStatus() then
                        Error('Please Check the Budget before you Proceed');

                    //Release the PV for Approval
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(cancellsApproval)
            {
                ApplicationArea = basic;
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
                end;
            }

            group(Approval)
            {
                Caption = 'Approval';
                action(Approvals)
                {
                    ApplicationArea = all;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Comments action.';
                }
            }
        }
    }

    trigger OnInit()
    begin
        DateEditable := true;
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."imprest TYpe" := Rec."imprest TYpe"::"Item Cash";
        Rec."Payment Type" := Rec."Payment Type"::Imprest;
        Rec."Account Type" := Rec."Account Type"::Customer;

        Rcpt.Reset();
        Rcpt.SetRange(Rcpt.Posted, false);
        Rcpt.SetRange(Rcpt.Cashier, UserId);
        if Rcpt.Count > 0 then
            if Confirm('There are still some unposted imprests. Continue?', false) = false then
                Error('There are still some unposted imprests. Please utilise them first');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        /* "Global Dimension 1 Code":=UserMgt.GetSetDimensions(USERID,1);
         VALIDATE("Global Dimension 1 Code");
         "Shortcut Dimension 2 Code":=UserMgt.GetSetDimensions(USERID,2);
         VALIDATE("Shortcut Dimension 2 Code");
         "Shortcut Dimension 3 Code":=UserMgt.GetSetDimensions(USERID,3);
         VALIDATE("Shortcut Dimension 3 Code");
         "Shortcut Dimension 4 Code":=UserMgt.GetSetDimensions(USERID,4);
         VALIDATE("Shortcut Dimension 4 Code");*/

        //"Budget Name":=Setup."Current Budget";
        Rec."imprest TYpe" := Rec."imprest TYpe"::"Item Cash";
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
        Temp: Record "Cash Office User Template";
        Commitments: Record Committment;
        GLEntry: Record "G/L Entry";
        GenJnlLine: Record "Gen. Journal Line";
        Rcpt: Record "Imprest Header";
        PayLine: Record "Payment Line";
        BudgetControl: Codeunit "Budgetary Control";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        UserMgt: Codeunit "User Setup Management BR";
        AllKeyFieldsEntered: Boolean;
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        HasLines: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        [InDataSet]
        "Paying Bank AccountEditable": Boolean;
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Pay ModeEditable": Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        JBatch: Code[10];
        JTemplate: Code[10];
        LastEntry: Integer;
        LineNo: Integer;
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition"," Staff Update ",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary;
        VarVariant: Variant;

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

    procedure PostImprest()
    begin
        Rec.TestField("Payment Release Date");
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Account No.");
        Rec.TestField("Account Type", Rec."Account Type"::Customer);

        if Rec.Posted = true then
            Error('The Document is already Posted!');
        /*Check if the user has selcted all the relevant fields*/
        Temp.Get(UserId);
        JTemplate := Temp."Imprest Template";
        JBatch := Temp."Imprest  Batch";

        if JTemplate = '' then
            Error('Please ensure that the Imprest Template is setup in the cash management setup!!');
        if JBatch = '' then
            Error('Please ensure that the Imprest Batch is setup in the cash management setup!!');

        PayLine.Reset();
        PayLine.SetRange(PayLine.No, Rec."No.");
        if PayLine.Find('-') then begin
        end else
            ;
            //ERROR('There are no lines created for this document!');

        if Temp.Get(UserId) then begin
            GenJnlLine.Reset();
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DeleteAll();
        end;

        LineNo := LineNo + 1000;
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec.Date;
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := Rec."Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := 'Imprest: ' + Rec."Account No." + ':' + Rec.Payee;
        Rec.CalcFields("Total Net Amount");
        GenJnlLine.Amount := Rec."Total Net Amount";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := Rec."Paying Bank Account";
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        //Added for Currency Codes
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine.Validate("Currency Code");
        GenJnlLine."Currency Factor" := Rec."Currency Factor";
        GenJnlLine.Validate("Currency Factor");
        /*
        GenJnlLine."Currency Factor":=Payments."Currency Factor";
        GenJnlLine.VALIDATE("Currency Factor");
        */
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert();

        if GLEntry.FindLast() then
            LastEntry := GLEntry."Entry No.";

        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
        Rec.Posted := true;
        Rec."Date Posted" := Today;
        Rec."Time Posted" := Time;
        Rec."Posted By" := UserId;
        Rec.Status := Rec.Status::Posted;
        Rec.Modify();

        //EFT
        PayLine.Reset();
        PayLine.SetRange(PayLine.No, Rec."No.");
        if PayLine.Find('-') then
            repeat
            /* IF "Pay Mode"="Pay Mode"::EFT THEN BEGIN
             IF PayLine."Account No."<>'' THEN BEGIN
             BankPayment.SETRANGE(BankPayment."Doc No","No.");
             IF BankPayment.FIND('-') THEN BankPayment.DELETE;

             PayLine.TESTFIELD(PayLine."EFT Bank Account No");
            // PayLine.TESTFIELD(PayLine."EFT Branch No.");
             PayLine.TESTFIELD(PayLine."EFT Bank Code");
             PayLine.TESTFIELD(PayLine."EFT Account Name");

             BankPayment.INIT;
             BankPayment."Doc No":=Rec."No.";
             BankPayment.Payee:=PayLine."Account No.";
             BankPayment.Amount:="Total Payment Amount"-("Total Witholding Tax Amount"+"Total VAT Amount");
             BankPayment."Bank A/C No":=PayLine."EFT Bank Account No";
           //  BankPayment."Bank Branch No":=PayLine."EFT Branch No.";
           //  BankPayment."Bank Code":=PayLine."EFT Bank Code";
             BankPayment."Bank A/C Name":=PayLine."EFT Account Name";
            // END;
             BankPayment.Date:=TODAY;
             BankPayment.INSERT;
             END;
             END; */
            until PayLine.Next() = 0;
        //Post:= FALSE;
        //Post:=JournlPosted.PostedSuccessfully();
    end;

    procedure CheckImprestRequiredItems()
    begin

        Rec.TestField("Payment Release Date");
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Account No.");
        Rec.TestField("Account Type", Rec."Account Type"::Customer);

        if Rec.Posted then
            Error('The Document has already been posted');

        Rec.TestField(Status, Rec.Status::Approved);

        /*Check if the user has selected all the relevant fields*/

        Temp.Get(UserId);
        JTemplate := Temp."Imprest Template";
        JBatch := Temp."Imprest  Batch";

        if JTemplate = '' then
            Error('Ensure the Imprest Template is set up in Cash Office Setup');

        if JBatch = '' then
            Error('Ensure the Imprest Batch is set up in the Cash Office Setup');

        if not LinesExists() then
            Error('There are no Lines created for this Document');
    end;

    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Approved then begin
            "Payment Release DateEditable" := false;
            "Paying Bank AccountEditable" := false;
            "Pay ModeEditable" := false;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            "Cheque No.Editable" := false;
            // CurrForm."Serial No".EDITABLE:=FALSE;
            // CurrPage.UpdateControls();
        end else begin
            "Payment Release DateEditable" := true;
            "Paying Bank AccountEditable" := true;
            "Pay ModeEditable" := true;
            "Cheque No.Editable" := true;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            //CurrPage.UpdateControls();
        end;

        if Rec.Status = Rec.Status::Pending then begin
            GlobalDimension1CodeEditable := true;
            ShortcutDimension2CodeEditable := true;
            //CurrForm.Payee.EDITABLE:=TRUE;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            DateEditable := true;
            //CurrForm."Account No.".EDITABLE:=TRUE;
            "Currency CodeEditable" := true;
            //  CurrForm."Serial No".EDITABLE:=TRUE;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrPage.UpdateControls();
        end else begin
            GlobalDimension1CodeEditable := false;
            ShortcutDimension2CodeEditable := true;
            //CurrForm.Payee.EDITABLE:=FALSE;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            //  CurrForm."Serial No".EDITABLE:=FALSE;
            //CurrForm."Account No.".EDITABLE:=FALSE;
            "Currency CodeEditable" := false;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrPage.UpdateControls();
        end
    end;

    procedure LinesExists(): Boolean
    var
        PayLines: Record "Imprest Lines";
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
        PayLines: Record "Imprest Lines";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset();
        PayLines.SetRange(PayLines.No, Rec."No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."Account No:" = '') or (PayLines.Amount <= 0) or (PayLines.Quantity <= 0) then
                    AllKeyFieldsEntered := false;
            until PayLines.Next() = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;
}
