Page 52203013 "Posted Imprest Requisitions UP"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Imprest Header";
    SourceTableView = where(Posted = const(true));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field(No; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec.Date)
                {
                    Editable = DateEditable;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Editable = GlobalDimension1CodeEditable;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(FunctionName; Rec."Function Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Function Name field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = ShortcutDimension2CodeEditable;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(BudgetCenterName; Rec."Budget Center Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Budget Center Name field.';
                }
                field(ShortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = ShortcutDimension3CodeEditable;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field(Dim3; Rec.Dim3)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Dim3 field.';
                }
                field(ShortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Editable = ShortcutDimension4CodeEditable;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field(Dim4; Rec.Dim4)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Dim4 field.';
                }
                field(AccountType; Rec."Account Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(AccountNo; Rec."Account No.")
                {
                    Editable = "Account No.Editable";
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field(Payee; Rec.Payee)
                {
                    Editable = PayeeEditable;
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    Editable = "Currency CodeEditable";
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(PayingBankAccount; Rec."Paying Bank Account")
                {
                    ToolTip = 'Specifies the value of the Paying Bank Account field.';
                }
                field(BankName; Rec."Bank Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ToolTip = 'Specifies the value of the Purpose field.';
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
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field(TotalNetAmount; Rec."Total Net Amount")
                {
                    ToolTip = 'Specifies the value of the Total Net Amount field.';
                }
                field(PostingDate; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    Editable = "Payment Release DateEditable";
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(PayMode; Rec."Pay Mode")
                {
                    Editable = "Pay ModeEditable";
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field(PaymentVoucherNo; Rec."Payment Voucher No")
                {
                    ToolTip = 'Specifies the value of the Payment Voucher No field.';
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
                field(PostedBy; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
            }
            part(PVLines; "Imprest Details UP")
            {
                Editable = false;
                SubPageLink = No = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = '&Functions';
                action(PrintPreview)
                {
                    Caption = 'Print/Preview';
                    Visible = false;
                    ToolTip = 'Executes the Print/Preview action.';

                    trigger OnAction()
                    begin
                        Rec.Reset();
                        Rec.SetFilter("No.", Rec."No.");
                        Report.Run(70134880, true, true, Rec);
                        Rec.Reset();
                    end;
                }
                action("Print Accounting Request")
                {
                    Image = PrintAttachment;
                    ToolTip = 'Executes the Print Accounting Request action.';

                    trigger OnAction()
                    begin

                        Rec.Reset();
                        Rec.SetFilter("No.", Rec."No.");
                        Report.Run(70135446, true, true, Rec);
                        Rec.Reset();
                    end;
                }
                separator(Action7)
                {
                }
                action("Re-Open")
                {
                    Image = ReopenCancelled;
                    ToolTip = 'Executes the Re-Open action.';

                    trigger OnAction()
                    begin
                        Rec.CalcFields("Posted Count");
                        if Rec."Posted Count" > 0 then
                            Error('Please note that you must reverse the transactions before re-opening the document');
                        Rec.Posted := false;
                        Rec."Posted By" := UserId;
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Account No.Editable" := true;
        DateEditable := true;
        ShortcutDimension4CodeEditable := true;
        ShortcutDimension3CodeEditable := true;
        PayeeEditable := true;
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
        "Currency CodeEditable" := true;
        "Pay ModeEditable" := true;
        "Payment Release DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        Rec."Payment Type" := Rec."payment type"::Imprest;
        Rec."Account Type" := Rec."account type"::Customer;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    var
        Temp: Record "Cash Office User Template";
        GenJnlLine: Record "Gen. Journal Line";
        PayLine: Record "Payment Line";
        JournlPosted: Codeunit "Journal Post Successful";
        UserMgt: Codeunit "User Setup Management BR";
        [InDataSet]
        "Account No.Editable": Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        PayeeEditable: Boolean;
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

    procedure LinesCommitmentStatus() Exists: Boolean
    begin
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
        GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
        GenJnlLine."Account No." := Rec."Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine."Posting Date" := Rec."Payment Release Date";
        GenJnlLine."Document Type" := GenJnlLine."document type"::Invoice;
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        Rec.CalcFields("Total Net Amount");
        GenJnlLine.Amount := Rec."Total Net Amount";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"Bank Account";
        GenJnlLine."Bal. Account No." := Rec."Paying Bank Account";
        GenJnlLine.Description := 'Imprest: ' + Rec."Account No." + ':' + Rec.Payee;
        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

        if GenJnlLine.Amount <> 0 then
            GenJnlLine.Insert();

        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);

        Post := false;
        Post := JournlPosted.PostedSuccessfully(Rec."No.");
        if Post then begin
            Rec.Posted := true;
            Rec."Date Posted" := Today;
            Rec."Time Posted" := Time;
            Rec."Posted By" := UserId;
            Rec.Status := Rec.Status::Posted;
            Rec.Modify();
        end;
    end;

    procedure CheckImprestRequiredItems()
    begin

        Rec.TestField("Payment Release Date");
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Account No.");
        Rec.TestField("Account Type", Rec."account type"::Customer);

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
    end;

    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Approved then begin
            "Payment Release DateEditable" := false;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            "Pay ModeEditable" := false;
            "Currency CodeEditable" := false;
            //CurrPage.UpdateControls();
        end else begin
            "Payment Release DateEditable" := true;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            "Pay ModeEditable" := true;
            "Currency CodeEditable" := true;
            // CurrPage.UpdateControls();
        end;

        if Rec.Status = Rec.Status::Pending then begin
            GlobalDimension1CodeEditable := true;
            ShortcutDimension2CodeEditable := true;
            PayeeEditable := true;
            ShortcutDimension3CodeEditable := true;
            ShortcutDimension4CodeEditable := true;
            DateEditable := true;
            "Account No.Editable" := true;
            //CurrPage.UpdateControls();
        end else begin
            GlobalDimension1CodeEditable := false;
            ShortcutDimension2CodeEditable := false;
            PayeeEditable := false;
            ShortcutDimension3CodeEditable := false;
            ShortcutDimension4CodeEditable := false;
            DateEditable := false;
            "Account No.Editable" := false;
            //CurrPage.UpdateControls();
        end
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;
}
