Page 52203048 "Posted Receipts"
{
    ApplicationArea = Basic, Suite;
    CardPageID = "Posted Receipt UP";
    Editable = false;
    PageType = List;
    SourceTable = "Receipts Header";
    SourceTableView = where(Posted = filter(true));
    UsageCategory = History;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(ReceivedFrom; Rec."Received From")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Received From field.';
                }
                field(BankCode; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field(BankName; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field(TotalAmount; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = basic, suite;
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755010; Notes)
            {
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action("<Action1102760016>")
            {
                ApplicationArea = all;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Print action.';

                trigger OnAction()
                begin
                    //  if Posted = false then Error('Post the receipt before printing.');
                    Rec.Reset();
                    Rec.SetFilter("No.", Rec."No.");
                    Report.Run(70135180, true, true, Rec);
                    Rec.Reset();
                end;
            }
        }
    }

    var
        BankAcc: Record "Bank Account";
        USetup: Record "Cash Office User Template";
        Appl: Record "CshMgt Application";
        DimVal: Record "Dimension Value";
        DefaultBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        GLine: Record "Gen. Journal Line";
        ReceiptLine: Record "Receipt Line q";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        JournalPosted: Codeunit "Journal Post Successful";
        IsCashAccount: Boolean;
        Post: Boolean;
        JBatch: Code[10];
        JTemplate: Code[10];
        BAmount: Decimal;
        tAmount: Decimal;
        LineNo: Integer;
        BankName: Text[100];
        BudgetCenterName: Text[100];
        FunctionName: Text[100];
        StrInvoices: Text[250];

    procedure PerformPost()
    begin
        //get all the invoices that have been paid for using the receipt
        StrInvoices := '';
        Appl.Reset();
        Appl.SetRange(Appl."Document Type", Appl."document type"::Receipt);
        Appl.SetRange(Appl."Document No.", Rec."No.");
        if Appl.FindFirst() then
            repeat
                StrInvoices := StrInvoices + ',' + Appl."Appl. Doc. No";
            until Appl.Next() = 0;

        //Cater for Cash Accounts
        IsCashAccount := false;
        BankAcc.Reset();
        if BankAcc.Get(Rec."Bank Code") then
            if BankAcc."Bank Type" = BankAcc."bank type"::Cash then
                IsCashAccount := true;

        if IsCashAccount then
            Rec.TestField(Date, WorkDate());
        //End Cater for Cash Account

        USetup.Reset();
        USetup.SetRange(USetup.UserID, UserId);
        if USetup.FindFirst() then begin
            if USetup."Receipt Journal Template" = '' then
                Error('Please ensure that the Administrator sets you up as a cashier');
            if USetup."Receipt Journal Batch" = '' then
                Error('Please ensure that the Administrator sets you up as a cashier');
            if USetup."Default Receipts Bank" = '' then
                Error('Please ensure that the Administrator sets you up as a cashier');
        end
        else
            Error('Please ensure that the Administrator sets you up as a cashier');

        //check if the receipt has any post dated cheques.
        //check if the amounts are similar

        Rec.CalcFields("Total Amount");
        if Rec."Total Amount" <> Rec."Amount Recieved" then
            Error('Please note that the Total Amount and the Amount Received Must be the same');

        //if any then the amount to be posted must be less the post dated amount
        if Rec.Posted = true then
            Error('A Transaction Posted cannot be posted again');

        //check if the person received from has been selected
        Rec.TestField(Date);
        Rec.TestField("Bank Code");
        Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Shortcut Dimension 2 Code");
        Rec.TestField("Received From");
        /*Check if the amount received is equal to the total amount*/
        tAmount := 0;

        //Check Bank
        CheckBnkCurrency(Rec."Bank Code", Rec."Currency Code");

        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
        if ReceiptLine.Find('-') then
            repeat
                if ReceiptLine."Pay Mode" = ReceiptLine."pay mode"::" " then
                    Error('Paymode is Mandatory on the Receipt Line');

                if ReceiptLine."Pay Mode" = ReceiptLine."pay mode"::"Deposit Slip" then begin
                    if ReceiptLine."Cheque/Deposit Slip No" = '' then
                        Error('The Cheque/Deposit Slip No must be inserted');
                    if ReceiptLine."Cheque/Deposit Slip Date" = 0D then
                        Error('The Cheque/Deposit Date must be inserted');
                    if ReceiptLine."Transaction No." = '' then
                        Error('Please ensure that the Transaction Number is inserted');
                    if ReceiptLine.Type = '' then
                        Error('Please ensure that the Receipt Type is inserted');
                end;

                if ReceiptLine."Pay Mode" = ReceiptLine."pay mode"::Cheque then begin
                    if ReceiptLine."Cheque/Deposit Slip No" = '' then
                        Error('The Cheque/Deposit Slip No must be inserted');
                    if ReceiptLine."Cheque/Deposit Slip Date" = 0D then
                        Error('The Cheque/Deposit Date must be inserted');
                    if ReceiptLine."Pay Mode" = ReceiptLine."pay mode"::Cheque then
                        if StrLen(ReceiptLine."Cheque/Deposit Slip No") <> 6 then
                            Error('Invalid Cheque Number inserted');
                end;
                tAmount := tAmount + ReceiptLine.Amount;
            until ReceiptLine.Next() = 0;

        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        GenJnlLine.DeleteAll();

        if DefaultBatch.Get(JTemplate, JBatch) then
            DefaultBatch.Delete();

        DefaultBatch.Reset();
        DefaultBatch."Journal Template Name" := JTemplate;
        DefaultBatch.Name := JBatch;
        DefaultBatch.Insert();

        /*Insert the bank transaction*/
        if BAmount < tAmount then begin
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := JTemplate;
            GenJnlLine."Journal Batch Name" := JBatch;
            GenJnlLine."Source Code" := 'CASHRECJNL';
            GenJnlLine."Line No." := 1;
            GenJnlLine."Posting Date" := Rec.Date;
            GenJnlLine."Document No." := Rec."No.";
            GenJnlLine."Document Date" := Rec."Document Date";
            GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";

            GenJnlLine."Account No." := Rec."Bank Code";//USetup."Default Receipts Bank";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code" := Rec."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine.Amount := (tAmount);
            GenJnlLine.Validate(GenJnlLine.Amount);

            GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

            GenJnlLine.Description := CopyStr('On Behalf Of:' + Rec."Received From" + 'Invoices:' + StrInvoices, 1, 50);
            GenJnlLine.Validate(GenJnlLine.Description);
            if GenJnlLine.Amount <> 0 then
                GenJnlLine.Insert();

            //insert the transaction lines into the database
            ReceiptLine.Reset();
            ReceiptLine.SetRange(ReceiptLine.No, Rec."No.");
            ReceiptLine.SetRange(ReceiptLine.Posted, false);

            if ReceiptLine.Find('-') then
                repeat
                    if ReceiptLine.Amount = 0 then
                        Error('Please enter amount.');

                    if ReceiptLine.Amount < 0 then
                        Error('Amount cannot be less than zero.');

                    ReceiptLine.TestField(ReceiptLine."Global Dimension 1 Code");

                    ReceiptLine.TestField(ReceiptLine."Shortcut Dimension 2 Code");

                    //get the last line number from the general journal line
                    GLine.Reset();
                    GLine.SetRange(GLine."Journal Template Name", JTemplate);
                    GLine.SetRange(GLine."Journal Batch Name", JBatch);
                    LineNo := 0;
                    if GLine.Find('+') then
                        LineNo := GLine."Line No.";
                    LineNo := LineNo + 1;
                    if ReceiptLine."Pay Mode" <> ReceiptLine."pay mode"::Cheque then begin
                        GenJnlLine.Init();
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine."Source Code" := 'CASHRECJNL';
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := Rec.Date;
                        GenJnlLine."Document No." := ReceiptLine.No;
                        GenJnlLine."Document Date" := Rec."Document Date";
                        /*IF ReceiptLine."Customer Payment On Account" THEN
                          BEGIN
                            {SRSetup.GET();
                            GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine."Account No.":=SRSetup."Receivable Batch Account";}

                            GenJnlLine."Account Type":=ReceiptLine."Account Type";
                            GenJnlLine."Account No.":=ReceiptLine."Account No.";
                          END
                        ELSE
                          BEGIN
                            GenJnlLine."Account Type":=ReceiptLine."Account Type";
                            GenJnlLine."Account No.":=ReceiptLine."Account No.";
                          END;*/
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account No.";

                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                        GenJnlLine."Currency Code" := Rec."Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");

                        GenJnlLine.Amount := -ReceiptLine.Amount;
                        GenJnlLine.Validate(GenJnlLine.Amount);

                        if ReceiptLine."Customer Payment On Account" = false then begin
                            //GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                            GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                            GenJnlLine.Validate("Applies-to Doc. No.");
                            GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                            GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                        end;

                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine.Description := CopyStr(ReceiptLine."Account Name" + ':' + Format(ReceiptLine."Pay Mode") +
                          ' Invoices:' + StrInvoices, 1, 50);
                        GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert();
                    end
                    else
                        if ReceiptLine."Pay Mode" = ReceiptLine."pay mode"::Cheque then
                            if ReceiptLine."Cheque/Deposit Slip Date" <= Today then begin
                                GenJnlLine.Init();
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'CASHRECJNL';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := Rec.Date;
                                GenJnlLine."Document No." := ReceiptLine.No;
                                GenJnlLine."Document Date" := Rec."Document Date";
                                /*IF ReceiptLine."Customer Payment On Account" THEN
                                  BEGIN
                                    SRSetup.GET();
                                    GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No.":=SRSetup."Receivable Batch Account";
                                  END
                                ELSE
                                  BEGIN
                                    GenJnlLine."Account Type":=ReceiptLine."Account Type";
                                    GenJnlLine."Account No.":=ReceiptLine."Account No.";
                                  END;*/

                                GenJnlLine."Account Type" := ReceiptLine."Account Type";
                                GenJnlLine."Account No." := ReceiptLine."Account No.";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");

                                GenJnlLine.Amount := -ReceiptLine.Amount;
                                GenJnlLine.Validate(GenJnlLine.Amount);

                                if ReceiptLine."Customer Payment On Account" = false then begin
                                    //GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                                    GenJnlLine."Applies-to Doc. No." := ReceiptLine."Applies-to Doc. No.";
                                    GenJnlLine.Validate("Applies-to Doc. No.");
                                    GenJnlLine."Applies-to ID" := ReceiptLine."Applies-to ID";
                                    GenJnlLine.Validate(GenJnlLine."Applies-to ID");
                                end;
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := CopyStr(ReceiptLine."Account Name" + ':' + Format(ReceiptLine."Pay Mode")
                                + ' Invoices:' + StrInvoices, 1, 50);
                                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptLine."Global Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptLine."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert();
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

            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnlLine);
            if JournalPosted.PostedSuccessfully(Rec."No.") then begin
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

                Message('Receipt Posted Successfully');
            end;
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
        ReceiptLine.SetRange(ReceiptLine."Pay Mode", ReceiptLine."pay mode"::Cheque);
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

    local procedure OnAfterGetCurrRecord()
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
}
