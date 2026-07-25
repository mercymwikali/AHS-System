page 85243 "Receipts Line Posted UP"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Receipt Line q";

    layout
    {
        area(content)
        {
            repeater(Control1102760083)
            {
                ShowCaption = false;
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    trigger OnValidate()
                    begin
                        RecPayTypes.Reset();
                        RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Receipt);
                        RecPayTypes.SetRange(RecPayTypes.Code, Rec.Type);
                        if RecPayTypes.Find('-') then
                            if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" then
                                "Account No.Editable" := false
                            else
                                "Account No.Editable" := true;
                    end;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = basic;
                    Editable = "Account No.Editable";
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = basic;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field("Cheque/Deposit Slip Type"; Rec."Cheque/Deposit Slip Type")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Cheque/Deposit Slip Type field.';
                }
                field("Cheque/Deposit Slip Date"; Rec."Cheque/Deposit Slip Date")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Cheque/Deposit Slip Date field.';
                }
                field("Cheque/Deposit Slip No"; Rec."Cheque/Deposit Slip No")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Cheque/Deposit Slip No field.';
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Bank Account field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = basic;
                    Caption = 'Amount Exclusive VAT';
                    ToolTip = 'Specifies the value of the Amount Exclusive VAT field.';
                }
                field("Apply to ID"; Rec."Apply to ID")
                {
                    ApplicationArea = basic;
                    DrillDown = true;
                    Lookup = true;
                    ToolTip = 'Specifies the value of the Apply to ID field.';

                    trigger OnDrillDown()
                    begin
                        /*Check if the amount is greater than zero*/
                        if Rec.Amount <= 0 then
                            Error('Please ensure amount receipted is greater than zero');
                        /*Apply the entries for the receipt*/
                        //JACK:ApplyEntry."Apply to Receipts"(Rec);
                        /*Check if the type of  the account is customer*/
                        if (Rec."Account Type" = Rec."Account Type"::Customer) or (Rec."Account Type" = Rec."Account Type"::Vendor) then
                            Rec."Apply to ID" := Rec.No;
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = basic;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
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

                    if Rec."Global Dimension 1 Code" = '' then
                        Error('Please enter the Function code');

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

                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
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
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
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
                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

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
                    REPORT.Run(52015, true, true, Rec);
                    Rec.Reset();
                end;
            }
            action("Direct Printing")
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
                    REPORT.Run(52015, false, true, Rec);
                    Rec.Reset();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*
        {Display the captions for the dimensions that the user selected}
        DimName1:=DimName.getDimensionName("Global Dimension 1 Code",1);
        DImName2:=DimName.getDimensionName("Shortcut Dimension 2 Code",2);
        rdimname1:=DimName.getDimensionName("Dest Global Dimension 1 Code",1);
        rdimname2:=DimName.getDimensionName("Dest Shortcut Dimension 2 Code",2);
            */
    end;

    trigger OnInit()
    begin
        "Account No.Editable" := true;
    end;

    var
        DefaultBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        RecPayTypes: Record "Receipts and Payment Types";
        [InDataSet]
        "Account No.Editable": Boolean;
}
