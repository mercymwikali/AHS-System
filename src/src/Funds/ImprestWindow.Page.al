Page 52203030 "Imprest Window"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Imprest Request';
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Imprest Header";
    // SourceTableView = where(Posted = filter(false),Status = filter(<> Cancelled));

    UsageCategory = Documents;
    layout
    {
        area(content)
        {
            group(Control1)
            {
                field(No; Rec."No.")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec.Date)
                {
                    Editable = DateEditable;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(RequestedBy; Rec."Requested By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Requested By field.';
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
                field("Department Name"; Rec."Budget Center Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Budget Center Name field.';
                }
                field(AccountType; Rec."Account Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(AccountNo; Rec."Account No.")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field(Payee; Rec.Payee)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    Editable = "Currency CodeEditable";
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(PayingBankAccount; Rec."Paying Bank Account")
                {
                    Editable = "Paying Bank AccountEditable";
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
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(TotalNetAmount; Rec."Total Net Amount")
                {
                    ToolTip = 'Specifies the value of the Total Net Amount field.';
                }
                field(TotalNetAmountLCY; Rec."Total Net Amount LCY")
                {
                    ToolTip = 'Specifies the value of the Total Net Amount LCY field.';
                }
                field(PaymentReleaseDate; Rec."Payment Release Date")
                {
                    Caption = 'Payment Release Date';
                    Editable = "Payment Release DateEditable";
                    ToolTip = 'Specifies the value of the Payment Release Date field.';
                }
                field(PayMode; Rec."Pay Mode")
                {
                    Editable = "Pay ModeEditable";
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(ChequeEFTNo; Rec."Cheque No.")
                {
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
                    ToolTip = 'Specifies the value of the Cheque/EFT No. field.';
                }
                field(PaymentVoucherNo; Rec."Payment Voucher No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payment Voucher No field.';
                }
                field(SerialNo; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.';
                }
            }
            part(PVLines; "Imprest Details UP")
            {
                SubPageLink = No = field("No.");
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action(PrintPreview)
            {
                Caption = 'Print/Preview';
                Image = PrintAttachment;
                Promoted = true;
                ToolTip = 'Executes the Print/Preview action.';

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then
                        Error('You can only print after the document is released for approval');
                    Rec.Reset();
                    Rec.SetFilter("No.", Rec."No.");
                    Report.Run(70135439, true, true, Rec);
                    Rec.Reset();
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
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        Rec."Payment Type" := Rec."payment type"::Imprest;
        Rec."Account Type" := Rec."account type"::Customer;

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
        OnAfterGetCurrRecord();

        //"Budget Name":=Setup."Current Budget";
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
        GLEntry: Record "G/L Entry";
        GenJnlLine: Record "Gen. Journal Line";
        Rcpt: Record "Imprest Header";
        PayLine: Record "Payment Line";
        JournlPosted: Codeunit "Journal Post Successful";
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
        [InDataSet]
        "Paying Bank AccountEditable": Boolean;
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
        LastEntry: Integer;
        LineNo: Integer;

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
        //TESTFIELD("Payment Release Date");
        //TESTFIELD("Paying Bank Account");
        Rec.TestField("Account No.");
        Rec.TestField("Account Type", Rec."account type"::Customer);

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
        GenJnlLine."Document Type" := GenJnlLine."document type"::Invoice;
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
        GenJnlLine."Account No." := Rec."Account No.";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Description := 'Imprest: ' + Rec."Account No." + ':' + Rec.Payee;
        Rec.CalcFields("Total Net Amount");
        GenJnlLine.Amount := Rec."Total Net Amount";
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"Bank Account";
        GenJnlLine."Bal. Account No." := 'B-001';
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
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);
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
        Post := false;
        Post := JournlPosted.PostedSuccessfully(Rec."No.");
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
                if (PayLines."Account No:" = '') or (PayLines.Amount <= 0) then
                    AllKeyFieldsEntered := false;
            until PayLines.Next() = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;
}
