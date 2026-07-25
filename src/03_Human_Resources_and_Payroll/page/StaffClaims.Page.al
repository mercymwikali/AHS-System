page 85031 "Staff Claims"
{
    ApplicationArea = all;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Processing,Reports,Approval,Check Budget';
    SourceTable = "Staff Claims Header";
    SourceTableView = WHERE(Posted = CONST(false), Status = FILTER(<> Cancelled));
    UsageCategory = Documents;
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = GlobalDimension1CodeEditable;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Function Name"; Rec."Function Name")
                {
                    Caption = 'Branch Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Branch Name field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = ShortcutDimension2CodeEditable;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    Caption = 'Department Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = ShortcutDimension3CodeEditable;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Business Code';
                    Editable = ShortcutDimension4CodeEditable;
                    ToolTip = 'Specifies the value of the Business Code field.';
                }
                field(Dim3; Rec.Dim3)
                {
                    Caption = 'Business Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Business Name field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Staff No/Name';
                    Editable = true;
                    ToolTip = 'Specifies the value of the Staff No/Name field.';
                }
                field(Payee; Rec.Payee)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    Caption = 'Claim Description';
                    ToolTip = 'Specifies the value of the Claim Description field.';
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Editable = "Paying Bank AccountEditable";
                    Visible = "Paying Bank AccountVisible";
                    ToolTip = 'Specifies the value of the Paying Bank Account field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                    Visible = "Bank NameVisible";
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    Caption = 'Requestor ID';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Requestor ID field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ToolTip = 'Specifies the value of the Total Net Amount field.';
                }
                field("Total Net Amount LCY"; Rec."Total Net Amount LCY")
                {
                    ToolTip = 'Specifies the value of the Total Net Amount LCY field.';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    Editable = "Payment Release DateEditable";
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Editable = "Pay ModeEditable";
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
                    ToolTip = 'Specifies the value of the Cheque/EFT No. field.';
                }
            }
            group(Lines)
            {
                part(PVLines; "Staff Claim Lines")
                {
                    Caption = 'Claim Lines';
                    SubPageLink = No = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Payment and Print")
            {
                Caption = 'Post Payment and Print';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the Post Payment and Print action.';

                trigger OnAction()
                begin
                    CheckImprestRequiredItems();
                    PostImprest();

                    Rec.RESET();
                    Rec.SETFILTER("No.", Rec."No.");
                    REPORT.RUN(39006260, TRUE, TRUE, Rec);
                    Rec.RESET();

                    CurrPage.UPDATE();
                end;
            }
            separator(Separator1102755021)
            {
            }
            action("Post Payment")
            {
                Caption = 'Post Payment';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Post Payment action.';

                trigger OnAction()
                begin
                    CheckImprestRequiredItems();
                    PostImprest();

                    CurrPage.UPDATE();
                end;
            }
            separator(Separator1102755026)
            {
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
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
                action(sendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Send A&pproval Request action.';

                    trigger OnAction()
                    var
                        //  ApprovalMgt: Codeunit "Approvals Management";

                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin

                        IF NOT LinesExists() THEN
                            ERROR('There are no Lines created for this Document');

                        IF NOT AllFieldsEntered() THEN
                            ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //Ensure No Items That should be committed that are not
                        IF LinesCommitmentStatus() THEN
                            ERROR('There are some lines that have not been committed');

                        //Release the Imprest for Approval
                        Rec.TESTFIELD(Status, Rec.Status::Pending);

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
                    var
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    begin

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                separator(Separator1102755009)
                {
                }
                action("Check Budgetary Availability")
                {
                    Caption = 'Check Budgetary Availability';
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Executes the Check Budgetary Availability action.';

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";
                    begin

                        BCSetup.GET();
                        IF NOT BCSetup.Mandatory THEN
                            EXIT;

                        IF NOT LinesExists() THEN
                            ERROR('There are no Lines created for this Document');

                        IF NOT AllFieldsEntered() THEN
                            ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //First Check whether other lines are already committed.
                        Commitments.RESET();
                        Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::StaffClaim);
                        Commitments.SETRANGE(Commitments."Document No.", Rec."No.");
                        IF Commitments.FIND('-') THEN BEGIN
                            IF CONFIRM('Lines in this Document appear to be committed do you want to re-commit?', FALSE) = FALSE THEN
                                EXIT;
                            Commitments.RESET();
                            Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::StaffClaim);
                            Commitments.SETRANGE(Commitments."Document No.", Rec."No.");
                            Commitments.DELETEALL();
                        END;

                        CheckBudgetAvail.CheckStaffClaim(Rec);
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    Caption = 'Cancel Budget Commitment';
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Executes the Cancel Budget Commitment action.';

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you Wish to Cancel the Commitment entries for this document', FALSE) = FALSE THEN
                            EXIT;

                        Commitments.RESET();
                        Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::StaffClaim);
                        Commitments.SETRANGE(Commitments."Document No.", Rec."No.");
                        Commitments.DELETEALL();

                        PayLine.RESET();
                        PayLine.SETRANGE(PayLine.No, Rec."No.");
                        IF PayLine.FIND('-') THEN
                            REPEAT
                                PayLine.Committed := FALSE;
                                PayLine.MODIFY();
                            UNTIL PayLine.NEXT() = 0;
                    end;
                }
                separator(Separator1102755033)
                {
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Promoted = true;
                    PromotedCategory = Report;
                    ToolTip = 'Executes the Print/Preview action.';

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Approved THEN
                            ERROR('You can only print after the document is Approved');
                        Rec.RESET();
                        Rec.SETFILTER("No.", Rec."No.");
                        REPORT.RUN(70135210, TRUE, TRUE, Rec);
                        Rec.RESET();
                    end;
                }
                separator(Separator1102756006)
                {
                }
                action("Cancel Document")
                {
                    Caption = 'Cancel Document';
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Cancel Document action.';

                    trigger OnAction()
                    var
                        Text000Msg: Label 'Are you sure you want to Cancel this Document?';
                        Text001Msg: Label 'You have selected not to Cancel this Document';
                    begin

                        //TESTFIELD(Status,Status::Approved);
                        IF (Rec.Status = Rec.Status::Approved) OR (Rec.Status = Rec.Status::Pending) THEN
                            IF CONFIRM(Text000Msg, TRUE) THEN BEGIN
                                //Post Committment Reversals
                                Doc_Type := Doc_Type::Imprest;
                                BudgetControl.ReverseEntries(Doc_Type, Rec."No.");
                                Rec.Status := Rec.Status::Cancelled;
                                Rec.MODIFY();
                            END ELSE
                                ERROR(Text001Msg);
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Currency CodeEditable" := TRUE;
        DateEditable := TRUE;
        ShortcutDimension2CodeEditable := TRUE;
        GlobalDimension1CodeEditable := TRUE;
        "Cheque No.Editable" := TRUE;
        "Pay ModeEditable" := TRUE;
        "Paying Bank AccountEditable" := TRUE;
        "Payment Release DateEditable" := TRUE;
        "Bank NameVisible" := TRUE;
        "Paying Bank AccountVisible" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //check if the documenent has been added while another one is still pending
        TravReqHeader.RESET();
        //TravAccHeader.SETRANGE(SaleHeader."Document Type",SaleHeader."Document Type"::"Cash Sale");
        TravReqHeader.SETRANGE(TravReqHeader.Cashier, USERID);
        TravReqHeader.SETRANGE(TravReqHeader.Status, Rec.Status::Pending);

        IF TravReqHeader.COUNT > 0 THEN;
            //ERROR('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
            //*********************************END ****************************************//

        Rec."Payment Type" := Rec."Payment Type"::Imprest;
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    //     //Add dimensions if set by default here
    //     Rec."Global Dimension 1 Code" := UserMgt.GetSetDimensions(USERID, 1);
    //     Rec.VALIDATE("Global Dimension 1 Code");
    //     Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(USERID, 2);
    //     Rec.VALIDATE("Shortcut Dimension 2 Code");
    //     Rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(USERID, 3);
    //     Rec.VALIDATE("Shortcut Dimension 3 Code");
    //     Rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(USERID, 4);
    //     Rec.VALIDATE("Shortcut Dimension 4 Code");
    // end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;
        UpdateControls();
    end;

    var
        Temp: Record "Cash Office User Template";
        Commitments: Record Committment;
        GenJnlLine: Record "Gen. Journal Line";
        PayLine: Record "Staff Claim Lines";
        TravReqHeader: Record "Staff Claims Header";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        BudgetControl: Codeunit "Budgetary Control";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        JournlPosted: Codeunit "Journal Post Successful";
        UserMgt: Codeunit "User Setup Management BR";
        AllKeyFieldsEntered: Boolean;
        [InDataSet]
        "Bank NameVisible": Boolean;
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        HasLines: Boolean;
        [InDataSet]
        "Paying Bank AccountEditable": Boolean;
        [InDataSet]
        "Paying Bank AccountVisible": Boolean;
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Pay ModeEditable": Boolean;
        Post: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        JBatch: Code[10];
        JTemplate: Code[10];
        LineNo: Integer;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        VarVariant: Variant;
    //  CustomApprovals: Codeunit "Custom Approvals Codeunit";

    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "Budgetary Control Setup";
    begin
        IF BCsetup.GET() THEN BEGIN
            IF NOT BCsetup.Mandatory THEN BEGIN
                Exists := FALSE;
                EXIT;
            END;
        END ELSE BEGIN
            Exists := FALSE;
            EXIT;
        END;
        Exists := FALSE;
        PayLine.RESET();
        PayLine.SETRANGE(PayLine.No, Rec."No.");
        PayLine.SETRANGE(PayLine.Committed, FALSE);
        // PayLine.SETRANGE(PayLine."Budgetary Control A/C", TRUE);
        IF PayLine.FIND('-') THEN
            Exists := TRUE;
    end;

    procedure PostImprest()
    begin

        IF Temp.GET(USERID) THEN BEGIN
            GenJnlLine.RESET();
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DELETEALL();
        END;

        //CREDIT BANK
        LineNo := LineNo + 1000;
        GenJnlLine.INIT();
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Payment Release Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No." := Rec."Paying Bank Account";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        GenJnlLine.Description := Rec.Purpose;
        Rec.CALCFIELDS("Total Net Amount");
        GenJnlLine."Credit Amount" := Rec."Total Net Amount";
        GenJnlLine.VALIDATE(GenJnlLine."Credit Amount");
        //Added for Currency Codes
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine.VALIDATE("Currency Code");
        GenJnlLine."Currency Factor" := Rec."Currency Factor";
        GenJnlLine.VALIDATE("Currency Factor");
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT();

        //DEBIT RESPECTIVE G/L ACCOUNT(S)
        PayLine.RESET();
        PayLine.SETRANGE(PayLine.No, Rec."No.");
        IF PayLine.FIND('-') THEN
            REPEAT
                LineNo := LineNo + 1000;
                GenJnlLine.INIT();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Posting Date" := Rec."Payment Release Date";
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
                GenJnlLine."Document No." := Rec."No.";
                GenJnlLine."External Document No." := Rec."Cheque No.";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No." := PayLine."Account No:";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine.Description := Rec.Purpose;
                GenJnlLine."Debit Amount" := PayLine.Amount;
                GenJnlLine.VALIDATE(GenJnlLine."Debit Amount");
                //Added for Currency Codes
                GenJnlLine."Currency Code" := Rec."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine."Currency Factor" := Rec."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");
                GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT();
            UNTIL PayLine.NEXT() = 0;

        GenJnlLine.RESET();
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        //Adjust Gen Jnl Exchange Rate Rounding Balances
        AdjustGenJnl.RUN(GenJnlLine);
        //End Adjust Gen Jnl Exchange Rate Rounding Balances

        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

        Post := FALSE;
        Post := JournlPosted.PostedSuccessfully(Rec."No.");
        //IF Post THEN BEGIN
        Rec.Posted := TRUE;
        Rec."Date Posted" := TODAY;
        Rec."Time Posted" := TIME;
        Rec."Posted By" := USERID;
        Rec.Status := Rec.Status::Posted;
        Rec.MODIFY();
        //END;
    end;

    procedure CheckImprestRequiredItems()
    begin

        Rec.TESTFIELD("Payment Release Date");
        Rec.TESTFIELD("Paying Bank Account");
        Rec.TESTFIELD("Account No.");
        Rec.TESTFIELD("Account Type", Rec."Account Type"::Customer);

        IF Rec.Posted THEN
            ERROR('The Document has already been posted');

        Rec.TESTFIELD(Status, Rec.Status::Approved);

        /*Check if the user has selected all the relevant fields*/

        Temp.GET(USERID);
        JTemplate := Temp."Claim Template";
        JBatch := Temp."Claim  Batch";

        IF JTemplate = '' THEN
            ERROR('Ensure the Imprest Template is set up in Cash Office Setup');

        IF JBatch = '' THEN
            ERROR('Ensure the Imprest Batch is set up in the Cash Office Setup');

        IF NOT LinesExists() THEN
            ERROR('There are no Lines created for this Document');
    end;

    procedure UpdateControls()
    begin
        IF Rec.Status <> Rec.Status::Approved THEN BEGIN
            "Payment Release DateEditable" := FALSE;
            "Paying Bank AccountEditable" := FALSE;
            "Paying Bank AccountVisible" := FALSE;
            "Bank NameVisible" := FALSE;
            "Pay ModeEditable" := FALSE;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            "Cheque No.Editable" := FALSE;
            //CurrPage.UpdateControls();
        END ELSE BEGIN
            "Paying Bank AccountVisible" := TRUE;
            "Bank NameVisible" := TRUE;
            "Payment Release DateEditable" := TRUE;
            "Paying Bank AccountEditable" := TRUE;
            "Pay ModeEditable" := TRUE;
            "Cheque No.Editable" := TRUE;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            //CurrPage.UpdateControls();
        END;

        IF Rec.Status = Rec.Status::Pending THEN BEGIN
            GlobalDimension1CodeEditable := TRUE;
            ShortcutDimension2CodeEditable := TRUE;
            //CurrForm.Payee.EDITABLE:=TRUE;
            ShortcutDimension3CodeEditable := TRUE;
            ShortcutDimension4CodeEditable := TRUE;
            DateEditable := TRUE;
            //CurrForm."Account No.".EDITABLE:=TRUE;
            "Currency CodeEditable" := TRUE;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrPage.UpdateControls();
        END ELSE BEGIN
            GlobalDimension1CodeEditable := FALSE;
            ShortcutDimension2CodeEditable := FALSE;
            //CurrForm.Payee.EDITABLE:=FALSE;
            ShortcutDimension3CodeEditable := FALSE;
            ShortcutDimension4CodeEditable := FALSE;
            DateEditable := FALSE;
            //CurrForm."Account No.".EDITABLE:=FALSE;
            "Currency CodeEditable" := FALSE;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            // CurrPage.UpdateControls();
        END
    end;

    procedure LinesExists(): Boolean
    var
        PayLines: Record "Staff Claim Lines";
    begin
        HasLines := FALSE;
        PayLines.RESET();
        PayLines.SETRANGE(PayLines.No, Rec."No.");
        IF PayLines.FIND('-') THEN BEGIN
            HasLines := TRUE;
            EXIT(HasLines);
        END;
    end;

    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Staff Claim Lines";
    begin
        AllKeyFieldsEntered := TRUE;
        PayLines.RESET();
        PayLines.SETRANGE(PayLines.No, Rec."No.");
        IF PayLines.FIND('-') THEN BEGIN
            REPEAT
                IF (PayLines."Account No:" = '') OR (PayLines.Amount <= 0) THEN
                    AllKeyFieldsEntered := FALSE;
            UNTIL PayLines.NEXT() = 0;
            EXIT(AllKeyFieldsEntered);
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;
}
