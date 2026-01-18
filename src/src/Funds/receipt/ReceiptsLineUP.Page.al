Page 52203022 "Receipts Line UP"
{
    PageType = ListPart;
    SourceTable = "Receipt Line q";
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1102760083)
            {
                Visible = true;
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';

                    trigger OnValidate()
                    begin
                        RecPayTypes.Reset();
                        RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Receipt);
                        RecPayTypes.SetRange(RecPayTypes.Code, Rec.Type);
                        if RecPayTypes.Find('-') then
                            if RecPayTypes."Account Type" = RecPayTypes."account type"::"G/L Account" then
                                "Account No.Editable" := false
                            else
                                "Account No.Editable" := true;
                    end;
                }
                field(Grouping; Rec.Grouping)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Grouping field.';
                }
                field(AccountNo; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field(AccountName; Rec."Account Name")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field(PatientNo; Rec."Patient No")
                {
                    HideValue = true;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field(PayMode; Rec."Pay Mode")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Pay Mode field.';

                    trigger OnValidate()
                    begin
                        PayModeOnAfterValidate();
                    end;
                }
                field(MobileMoneyType; Rec."Mobile Money Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Mobile Money Type field.';
                }
                field(BankAccount; Rec."Bank Account")
                {
                    Visible = "Bank AccountVisible";
                    ToolTip = 'Specifies the value of the Bank Account field.';
                }
                field(ChequeDepositSlipBank; Rec."Cheque/Deposit Slip Bank")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cheque/Deposit Slip Bank field.';
                }
                field(ChequeDepositSlipType; Rec."Cheque/Deposit Slip Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cheque/Deposit Slip Type field.';
                }
                field(ChequeDepositSlipDate; Rec."Cheque/Deposit Slip Date")
                {
                    ToolTip = 'Specifies the value of the Cheque/Deposit Slip Date field.';
                }
                field(DepositSlipTime; Rec."Deposit Slip Time")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Deposit Slip Time field.';
                }
                field(ChequeDepositSlipNo; Rec."Cheque/Deposit Slip No")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Cheque/Deposit Slip No field.';
                }
                field(TransactionType; Rec."HSM Transaction Type")
                {
                    Caption = ' Transaction Type';
                    Editable = true;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the  Transaction Type field.';
                }
                field(TransactionNo; Rec."Transaction No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Transaction No. field.';
                }
                field(TellerID; Rec."Teller ID")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Teller ID field.';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount Exclusive VAT';
                    ToolTip = 'Specifies the value of the Amount Exclusive VAT field.';
                }
                field(AppliestoDocType; Rec."Applies-to Doc. Type")
                {
                    // Visible = false;
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.';
                }
                field(AppliestoDocNo; Rec."Applies-to Doc. No.")
                {
                    // Visible = false;
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.';
                }
                field(AppliestoID; Rec."Applies-to ID")
                {
                    // Visible = false;
                    ToolTip = 'Specifies the value of the Applies-to ID field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(ShortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field(ShortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Post action.';

                trigger OnAction()
                begin
                    if Rec.Posted then
                        Error('The transaction has already been posted.');

                    if Rec."Transaction Name" = '' then
                        Error('Please enter the transaction description under transaction name.');

                    if Rec.Amount = 0 then
                        Error('Please enter amount.');

                    if Rec.Amount < 0 then
                        Error('Amount cannot be less than zero.');

                    // if Rec."Global Dimension 1 Code" = '' then
                    //     Error('Please enter the Function code');

                    if Rec."Shortcut Dimension 2 Code" = '' then
                        Error('Please enter the source of funds.');

                    /*
                    CashierLinks.RESET;
                    CashierLinks.SETRANGE(CashierLinks.UserID,USERID);
                    IF CashierLinks.FIND('-') THEN BEGIN
                    END
                    ELSE BEGIN
                    ERROR('Please link the user/cashier to a collection account before proceeding.');
                    END;
                    */

                    // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                    GenJnlLine.Reset();
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'CASH RECEI');
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec.No);
                    GenJnlLine.DeleteAll();

                    if DefaultBatch.Get('CASH RECEI', Rec.No) then
                        DefaultBatch.Delete();

                    DefaultBatch.Reset();
                    DefaultBatch."Journal Template Name" := 'CASH RECEI';
                    DefaultBatch.Name := Rec.No;
                    DefaultBatch.Insert();

                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := 'CASH RECEI';
                    GenJnlLine."Journal Batch Name" := Rec.No;
                    GenJnlLine."Line No." := 10000;
                    GenJnlLine."Account Type" := Rec."Account Type";
                    GenJnlLine."Account No." := Rec."Account No.";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Posting Date" := Rec.Date;
                    GenJnlLine."Document No." := Rec.No;
                    GenJnlLine."External Document No." := Rec."Cheque/Deposit Slip No";
                    GenJnlLine.Amount := -Rec."Total Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);

                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."applies-to doc. type"::Invoice;
                    GenJnlLine."Applies-to Doc. No." := Rec."Apply to";
                    //GenJnlLine."Bal. Account No.":=CashierLinks."Bank Account No";
                    if Rec."Bank Code" = '' then
                        Error('Select the Bank Code');

                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := Rec."Transaction Name";
                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert();

                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := 'CASH RECEI';
                    GenJnlLine."Journal Batch Name" := Rec.No;
                    GenJnlLine."Line No." := 10001;
                    GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
                    GenJnlLine."Account No." := Rec."Bank Code";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Posting Date" := Rec.Date;
                    GenJnlLine."Document No." := Rec.No;
                    GenJnlLine."External Document No." := Rec."Cheque/Deposit Slip No";
                    GenJnlLine.Amount := Rec."Total Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);

                    GenJnlLine.Description := Rec."Transaction Name";
                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Dest Global Dimension 1 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Dest Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert();

                    GenJnlLine.Reset();
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'CASH RECEI');
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec.No);
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);

                    GenJnlLine.Reset();
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'CASH RECEI');
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec.No);
                    if GenJnlLine.Find('-') then
                        exit;

                    Rec.Posted := true;
                    Rec."Date Posted" := Today;
                    Rec."Time Posted" := Time;
                    Rec."Posted By" := UserId;
                    Rec.Modify();
                end;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Print action.';

                trigger OnAction()
                begin
                    if Rec.Posted = false then
                        Error('Post the receipt before printing.');
                    Rec.Reset();
                    Rec.SetFilter(No, Rec.No);
                    Report.Run(52015, true, true, Rec);
                    Rec.Reset();
                end;
            }
            action(DirectPrinting)
            {
                Caption = 'Direct Printing';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Direct Printing action.';

                trigger OnAction()
                begin
                    if Rec.Posted = false then
                        Error('Post the receipt before printing.');
                    Rec.Reset();
                    Rec.SetFilter(No, Rec.No);
                    Report.Run(52015, false, true, Rec);
                    Rec.Reset();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        "Account No.Editable" := true;
        "Bank AccountVisible" := true;
    end;

    var
        DefaultBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        RecPayTypes: Record "Receipts and Payment Types";
        [InDataSet]
        "Account No.Editable": Boolean;
        [InDataSet]
        "Bank AccountVisible": Boolean;

    local procedure PayModeOnAfterValidate()
    begin
        if Rec."Pay Mode" = Rec."pay mode"::"Deposit Slip" then
            "Bank AccountVisible" := true
        else
            "Bank AccountVisible" := false;
    end;
}
