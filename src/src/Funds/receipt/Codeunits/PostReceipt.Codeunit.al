namespace PTL.HMIS;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Sales.Setup;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.History;
using Microsoft.Bank.BankAccount;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.GeneralLedger.Journal;

codeunit 52202456 "Post Receipt"
{
    var
        GenJnlLine: Record "Gen. Journal Line";
        ReceiptLine: Record "Receipt Line q";
        tAmount: Decimal;
        DefaultBatch: Record "Gen. Journal Batch";
        FunctionName: Text[100];
        BudgetCenterName: Text[100];
        BankName: Text[100];
        Rcpt: Record "Receipts Header";
        RecReport: Report "HMS Receipts Report";
        RcptNo: Code[20];
        DimVal: Record "Dimension Value";
        BankAcc: Record "Bank Account";
        UserSetup: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        GLine: Record "Gen. Journal Line";
        LineNo: Integer;
        BAmount: Decimal;
        SRSetup: Record "Sales & Receivables Setup";
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        USetup: Record "Cash Office User Template";
        RegMgt: Codeunit "Register Management";
        RegisterNumber: Integer;
        FromNumber: Integer;
        ToNumber: Integer;
        StrInvoices: Text[250];
        Appl: Record "CshMgt Application";
        UserMgt: Codeunit "User Setup Management BR";
        JournalPosted: Codeunit "Journal Post Successful";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        IsCashAccount: Boolean;
        DocLabRequestLines: Record "HMS Laboratory Test Line";
        LabTestLines: Record "HMS Laboratory Test Line";
        PatRec: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        PatientCharges: Record "HMS Patient Charges";
        PharmacyH: Page "HMS Pharmacy Header";
        GLEntry: Record "G/L Entry";
        PharmRec: Record "HMS Pharmacy Header";
        HMSCU: Codeunit "HMS Patient-integration";
        ReceiptSplit: Record "Receipt Split";

    procedure FnPostReceiptHeader(RecTb: record "Receipts Header") returnValue: Boolean
    var
        RcptLine: Record "Receipt Line q";
        PharmRec: Record "HMS Pharmacy Header";
        Rcpt: record "Receipts Header";
    begin
        returnValue := false;
        //Check Post Dated
        // RecTb.CalcFields("Total Amount");
        if RecTb."Total Amount" <> RecTb."Amount Recieved" then
            Error('Please note that the Total Amount and the Amount Received Must be the same');

        RcptLine.SetRange(No, RecTb."No.");
        RcptLine.SetFilter("Patient No", '<>%1', RecTb."Patient No.");
        if RcptLine.Find('-') then
            repeat
                if (RecTb."Patient No." <> RcptLine."Patient No") then
                    Error('The patient no in receipt header does not match the one in the lines');
            until RcptLine.Next() = 0;
        if CheckPostDated(RecTb."No.") then
            Error('One of the Receipt Lines is Post Dated');

        if (CheckTransactionTypeMissing(RecTb."No.")) and (RecTb."Patient No." <> '') then
            Error('One of the Receipt Lines has no transaction Type');

        if RecTb."Customer No" = '' then begin
            RecTb.TestField("Patient No.");
            RecTb.TestField("Patient Appointment No");
        end;
        //Post the transaction into the database
        if RecTb."Pharmacy No" <> '' then
            if PharmRec.Get(RecTb."Pharmacy No") then begin
                if PharmRec.Status <> PharmRec.Status::Completed then
                    // PharmacyH.PostItems("Pharmacy No");
                    PharmRec.Status := PharmRec.Status::Paid;
                PharmRec.Modify();
            end;

        if RecTb."Patient No." <> '' then ValidatePatientCharges(RecTb."Patient No.", RecTb."Patient Appointment No");
        HMSCU.PostCharges(RecTb."Patient No.", RecTb."Patient Appointment No", false);
        PerformPost(RecTb);
        if JournalPosted.IsPosted(RecTb."No.") then begin

            InsertPatientsReceipts(RecTb);  // Insert Receipts to Patient Charges
            UpdateInvoiceDetails(RecTb."No.");
            UpdatePatientCharges(RecTb, RecTb."Patient Appointment No");
            InsertIntoReceiptBuffer(RecTb);
            if RecTb.Cashier = '' then
                RecTb.Cashier := Format(UserId); // REFACTOR: Use correct User ID
            RecTb.Posted := true;
            RecTb."Date Posted" := Today;
            RecTb."Time Posted" := Time;
            if RecTb.Cashier = '' then
                RecTb."Posted By" := Format(UserId)
            else
                RecTb."Posted By" := RecTb.Cashier;

            RecTb.Modify();
        end;
        returnValue := true;
    end;

    local procedure PerformPost(ReceiptHeader: Record "Receipts Header")
    begin
        //get all the invoices that have been paid for using the receipt
        StrInvoices := '';
        Appl.Reset();
        Appl.SetRange(Appl."Document Type", Appl."Document Type"::Receipt);
        Appl.SetRange(Appl."Document No.", ReceiptHeader."No.");
        if Appl.FindFirst() then
            repeat
                StrInvoices := StrInvoices + ',' + Appl."Appl. Doc. No";
            until Appl.Next() = 0;

        //Cater for Cash Accounts
        IsCashAccount := false;
        BankAcc.Reset();
        if BankAcc.Get(ReceiptHeader."Bank Code") then
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

            JTemplate := USetup."Receipt Journal Template";
            JBatch := USetup."Receipt Journal Batch";
        end
        else
            Error('Please ensure that the Administrator sets you up as a cashier');


        //check if the receipt has any post dated cheques.
        //check if the amounts are similar

        // ReceiptHeader.CalcFields("Total Amount");
        if ReceiptHeader."Total Amount" <> ReceiptHeader."Amount Recieved" then
            Error('Please note that the Total Amount and the Amount Received Must be the same');

        //if any then the amount to be posted must be less the post dated amount
        if ReceiptHeader.Posted = true then
            Error('A Transaction Posted cannot be posted again');
        ReceiptHeader.CalcFields("Receipt Split Amount");
        // if paymode is MPESA
        if (ReceiptHeader."Pay Mode" = ReceiptHeader."Pay Mode"::MPESA) and (ReceiptHeader."Receipt Split Amount" = 0) then begin
            // if ReceiptHeader."Mobile Money Type" = 0 then
            // Error('Please specify the type of Mobile Money');
            // if ReceiptHeader."Transaction Code" = '' then
            // Error('Please specify the Mobile Money Transaction Code');
        end;
        //check if the person received from has been selected
        ReceiptHeader.TestField(Date);

        if ReceiptHeader."Receipt Split Amount" = 0 then begin
            ReceiptHeader.TestField("Bank Code");
            ReceiptHeader.TestField("Pay Mode");
        end;
        ReceiptHeader.TestField("Global Dimension 1 Code");
        //TestField("Shortcut Dimension 2 Code");
        ReceiptHeader.TestField("Received From");
        if ReceiptHeader."Patient No." <> '' then ReceiptHeader.TestField("Patient Appointment No");
        // Check if the amount received is equal to the total amount
        tAmount := 0;

        //Check Bank
        CheckBnkCurrency(ReceiptHeader."Bank Code", ReceiptHeader."Currency Code");

        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, ReceiptHeader."No.");
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
                    // if ReceiptLine."Transaction No." = '' then
                    //     Error('Please ensure that the Transaction Number is inserted');
                    if ReceiptLine.Type = '' then
                        Error('Please ensure that the Receipt Type is inserted');
                    if (ReceiptLine."HSM Transaction Type" = '') and (ReceiptHeader."Patient No." <> '') then
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
                ReceiptLine."Pay Mode" := ReceiptHeader."Pay Mode";
                if ReceiptLine."Patient No" = '' then
                    ReceiptLine."Patient No" := ReceiptHeader."Patient No.";
                ReceiptLine."Mobile Money Type" := ReceiptHeader."Mobile Money Type";
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
        ReceiptHeader.CalcFields("Receipt Split Amount");
        if (ReceiptHeader."Receipt Split Amount" > 0) and (ReceiptHeader."Split Amount" = true) then begin
            if ReceiptHeader."Receipt Split Amount" <> tAmount then error('The total split amount should be same as total receipt amount');
            ReceiptSplit.reset();
            ReceiptSplit.setrange("Receipt No", ReceiptHeader."No.");
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
                    GenJnlLine."Posting Date" := ReceiptHeader."Document Date";
                    GenJnlLine."Document No." := ReceiptHeader."No.";
                    GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                    if ReceiptHeader."Patient No." <> '' then begin
                        GenJnlLine."External Document No." := ReceiptHeader."Patient Appointment No";
                        GenJnlLine."Source No." := ReceiptHeader."Patient No.";
                    end;

                    GenJnlLine."Document Date" := ReceiptHeader."Document Date";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";

                    GenJnlLine."Account No." := ReceiptSplit."Bank Account No";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                    //GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                    GenJnlLine.Amount := ReceiptSplit.Amount;
                    //GenJnlLine.VALIDATE(GenJnlLine.Amount);

                    GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");

                    GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Shortcut Dimension 2 Code";
                    // GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                    //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");

                    GenJnlLine.Description := ReceiptHeader."Received From";
                    //GenJnlLine.VALIDATE(GenJnlLine.Description);
                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert();
                until ReceiptSplit.next() = 0;
        end else
            // Insert the bank transaction
            if BAmount < tAmount then begin
                GenJnlLine.Init();
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine."Source Code" := 'CASHRECJNL';
                GenJnlLine."Line No." := 1;
                GenJnlLine."Posting Date" := ReceiptHeader."Document Date";
                GenJnlLine."Document No." := ReceiptHeader."No.";
                GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                if ReceiptHeader."Patient No." <> '' then begin
                    GenJnlLine."External Document No." := ReceiptHeader."Patient Appointment No";
                    GenJnlLine."Source No." := ReceiptHeader."Patient No.";
                end;

                GenJnlLine."Document Date" := ReceiptHeader."Document Date";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";

                GenJnlLine."Account No." := ReceiptHeader."Bank Code";//USetup."Default Receipts Bank";
                GenJnlLine.Validate(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                //GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                GenJnlLine.Amount := (tAmount);
                //GenJnlLine.VALIDATE(GenJnlLine.Amount);

                GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Shortcut Dimension 2 Code";
                // GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");

                GenJnlLine.Description := ReceiptHeader."Received From";
                //GenJnlLine.VALIDATE(GenJnlLine.Description);
                if GenJnlLine.Amount <> 0 then
                    GenJnlLine.Insert();
            end;


        //insert the transaction lines into the database
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, ReceiptHeader."No.");
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
                    GenJnlLine."Posting Date" := ReceiptHeader.Date;
                    GenJnlLine."Document No." := ReceiptLine.No;
                    GenJnlLine."Document Date" := ReceiptHeader."Document Date";
                    if ReceiptLine."Customer Payment On Account" then begin
                        //SRSetup.GET();
                        //GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                        //GenJnlLine."Account No.":=SRSetup."Receivable Batch Account";

                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account No.";

                    end
                    else begin
                        GenJnlLine."Account Type" := ReceiptLine."Account Type";
                        GenJnlLine."Account No." := ReceiptLine."Account No.";
                    end;
                    // GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    GenJnlLine."External Document No." := ReceiptLine."Cheque/Deposit Slip No";
                    GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
                    // GenJnlLine.VALIDATE(GenJnlLine."Currency Code");

                    GenJnlLine.Amount := -ReceiptLine.Amount;
                    //  GenJnlLine.VALIDATE(GenJnlLine.Amount);

                    //IF ReceiptLine."Customer Payment On Account"=FALSE THEN
                    //BEGIN
                    //."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                    //GenJnlLine."Applies-to Doc. No.":=ReceiptLine."Applies-to Doc. No.";
                    //GenJnlLine.VALIDATE("Applies-to Doc. No.");
                    //GenJnlLine."Applies-to ID":=ReceiptLine."Applies-to ID";
                    // GenJnlLine.VALIDATE(GenJnlLine."Applies-to ID");
                    //END;

                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := CopyStr(ReceiptLine."Account Name" + ':' + Format(ReceiptLine."Pay Mode") +
                      ' Invoices:' + StrInvoices, 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := ReceiptHeader."Global Dimension 1 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine."Shortcut Dimension 2 Code" := ReceiptHeader."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                    // GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                    if ReceiptHeader."Patient No." <> '' then begin
                        GenJnlLine."External Document No." := ReceiptHeader."Patient Appointment No";
                        GenJnlLine."Source Code" := ReceiptHeader."Patient No.";
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
                            GenJnlLine."Posting Date" := ReceiptHeader.Date;
                            GenJnlLine."Document No." := ReceiptLine.No;
                            GenJnlLine."Document Date" := ReceiptHeader."Document Date";
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
                            GenJnlLine."Currency Code" := ReceiptHeader."Currency Code";
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
                            if ReceiptHeader."Patient No." <> '' then begin
                                GenJnlLine."External Document No." := ReceiptHeader."Patient Appointment No";
                                GenJnlLine."Source Code" := ReceiptHeader."Patient No.";
                            end;
                            if GenJnlLine.Amount <> 0 then GenJnlLine.Insert();
                        end;
            until ReceiptLine.Next() = 0;

        //Post the transactions
        Post := false;
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        //Adjust Gen Jnl Exchange Rate Rounding Balances
        AdjustGenJnl.Run(GenJnlLine);
        //End Adjust Gen Jnl Exchange Rate Rounding Balances

        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

        /*  if JournalPosted.IsPosted(ReceiptHeader."No.") = true then begin
             //Update Header
             ReceiptHeader.Cashier := UserId;
             //"Bank Code":=USetup."Default Receipts Bank";
             ReceiptHeader.Posted := true;
             ReceiptHeader."Date Posted" := Today;
             ReceiptHeader."Time Posted" := Time;
             ReceiptHeader."Posted By" := Format(UserId); // REFACTOR Get The Correct User
             ReceiptHeader.Modify();
             //Update Lines
             ReceiptLine.Reset();
             ReceiptLine.SetRange(ReceiptLine.No, ReceiptHeader."No.");
             ReceiptLine.SetRange(ReceiptLine.Posted, false);
             if ReceiptLine.Find('-') then
                 repeat
                     ReceiptLine.Posted := true;
                     ReceiptLine."Date Posted" := Today;
                     ReceiptLine."Time Posted" := Time;
                     ReceiptLine."Posted By" := Format(UserId);
                     ReceiptLine.Modify();
                 until ReceiptLine.Next() = 0;
         end; */
    end;


    procedure CheckPostDated(RHeaderNo: Code[20]) Exists: Boolean
    begin
        //get the sum total of the post dated cheques is any
        //reset the bank amount first
        Exists := false;
        BAmount := 0;
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, RHeaderNo);
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

    /* trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        FunctionName := '';
        DimVal.Reset();
        DimVal.SetRange(DimVal."Global Dimension No.", 1);
        DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
        if DimVal.Find('-') then
            FunctionName := DimVal.Name;
        BudgetCenterName := '';
        DimVal.Reset();
        DimVal.SetRange(DimVal."Global Dimension No.", 2);
        DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
        if DimVal.Find('-') then
            BudgetCenterName := DimVal.Name;
        BankName := '';
        BankAcc.Reset();
        BankAcc.SetRange(BankAcc."No.", "Bank Code");
        if BankAcc.Find('-') then
            BankName := BankAcc.Name;
    end; */

    procedure ValidatePatientCharges(PatientNo: code[20]; VisitNo: Code[20])
    begin
        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
        //PatientCharges.SETRANGE(PatientCharges."Insurance No",Patients."Insurance No.");
        PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
        PatientCharges.SetRange(PatientCharges.Closed, false);
        PatientCharges.SetRange(PatientCharges.Posted, false); //TODO: Commented to allow receipts for debtor patient
        PatientCharges.SetFilter(PatientCharges."Transaction Type", '<>%1', 'ZRECEIPT');
        PatientCharges.SetFilter(PatientCharges.Amount, '<>%1', 0);
        if PatientCharges.Find('-') then begin
            PatientCharges.TestField("G/L Account No");
            PatientCharges.TestField("Shortcut Dimension 1 Code");
        end;
    end;

    local procedure UpdatePatientCharges(RHeader: Record "Receipts Header"; VisitNo: Code[20])
    var
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
        HmsPatCharges: Record "HMS Patient Charges";
        HmsApp: Record "HMS Appointment Form Header";
        ObservHeader: Record "HMS Observation Form Header";
        LabHeader: Record "HMS Laboratory Form Header";
        HMSSetup: Record "HMS Setup";
        HMSClinicsSetup: Record "HMS Clinics Setup";
        NewNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin

        // TODO: What is this code doing
        if HmsApp.Get(VisitNo) then begin
            ObservHeader.SetRange(ObservHeader."Patient No.", RHeader."Patient No.");
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
                HMSTreatmentFormHeader."Patient No." := RHeader."Patient No.";
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
                ObservHeader."Patient No." := RHeader."Patient No.";
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
            if PatRec.Get(RHeader."Patient No.") then begin
                PatRec.CalcFields(PatRec."Bill Balance");
                if (PatRec."Bill Balance" = 0) and (RHeader."Pharmacy No" <> '') and (PatRec.Inpatient = false) then begin
                    PatRec.Activated := false;
                    PatRec.Modify();
                end;
            end;
        end;
    end;

    /* 
        local procedure UpdateDoctorInvoice()
        var
            HmsPatCharges: Record "HMS Patient Charges";
            HMSTransCode: Record "HMS Transactions code";
            HMSPatRec: Record "HMS Patient";
        begin
            ReceiptLine.Reset();
            ReceiptLine.SetRange(ReceiptLine.No, "No.");
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
                                    GenJnlLine."Posting Date" := Date;
                                    GenJnlLine."Document No." := ReceiptLine.No;
                                    GenJnlLine."Document Date" := "Document Date";
                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                                    GenJnlLine."Account No." := HmsPatCharges."Doctor ID";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine."External Document No." := HmsPatCharges."Invoice Number";
                                    GenJnlLine."Currency Code" := "Currency Code";
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
                                    GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                                    GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
                                    if GenJnlLine.Amount <> 0 then GenJnlLine.Insert();
                                    //Balance Account
                                    LineNo := LineNo + 100;
                                    HMSTransCode.TestField(HMSTransCode."Expense G/L Account");
                                    GenJnlLine.Init();
                                    GenJnlLine."Journal Template Name" := JTemplate;
                                    GenJnlLine."Journal Batch Name" := JBatch;
                                    GenJnlLine."Source Code" := 'CASHRECJNL';
                                    GenJnlLine."Line No." := LineNo;
                                    GenJnlLine."Posting Date" := Date;
                                    GenJnlLine."Document No." := ReceiptLine.No;
                                    GenJnlLine."Document Date" := "Document Date";
                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No." := HMSTransCode."Expense G/L Account";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine."External Document No." := HmsPatCharges."Invoice Number";
                                    GenJnlLine."Currency Code" := "Currency Code";
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
                                    GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                                    GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
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
     */
    local procedure InsertPatientsReceipts(RHeader: Record "Receipts Header")
    var
        HmsPatCharges: Record "HMS Patient Charges";
        HMSLabRequest: Record "HMS Laboratory Test Line";
        HMSLabHeader: Record "HMS Laboratory Form Header";
        HMSRadRequest: Record "HMS Radiology Form Line";
        HMSRadHeader: Record "HMS Radiology Form Header";
    begin
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, RHeader."No.");
        if ReceiptLine.Find('-') then
            repeat
                if ReceiptLine."Patient No" <> '' then begin
                    HMSLabHeader.reset();
                    HMSLabHeader.setrange(HMSLabHeader."Patient No.", ReceiptLine."Patient No");
                    HMSLabHeader.SetRange(HMSLabHeader."Link No.", RHeader."Patient Appointment No");
                    if HMSLabHeader.find('-') then begin
                        HMSLabRequest.reset();
                        HMSLabRequest.setrange(HMSLabRequest."Patient No", ReceiptLine."Patient No");
                        HMSLabRequest.setrange(HMSLabRequest."Laboratory No.", HMSLabHeader."Laboratory No.");
                        HMSLabRequest.setrange(HMSLabRequest."Laboratory Test Code", ReceiptLine."Transaction No.");
                        HMSLabRequest.setrange(Paid, false);
                        if HMSLabRequest.find('-') then
                            repeat
                                HMSLabRequest."Receipt No" := RHeader."No.";
                                HMSLabRequest."Receipt Line No" := ReceiptLine."Line No.";
                                HMSLabRequest.paid := true;
                                HMSLabRequest.modify();
                            until HMSLabRequest.next() = 0;
                    end;
                    HMSRadHeader.reset();
                    HMSRadHeader.setrange(HMSRadHeader."Patient No.", ReceiptLine."Patient No");
                    HMSRadHeader.SetRange(HMSRadHeader."Link No.", RHeader."Patient Appointment No");
                    if HMSRadHeader.FindFirst() then begin
                        HMSRadRequest.reset();
                        HMSRadRequest.setrange(HMSRadRequest."Radiology no.", HMSRadHeader."Radiology No.");
                        HMSRadRequest.setrange(HMSRadRequest."Radiology Type Code", ReceiptLine."Transaction No.");
                        HMSRadRequest.setrange(Paid, false);
                        if HMSRadRequest.find('-') then
                            repeat
                                HMSRadRequest."Receipt No" := RHeader."No.";
                                HMSRadRequest."Receipt Line No" := ReceiptLine."Line No.";
                                HMSRadRequest.paid := true;
                                HMSRadRequest.modify();
                            until HMSRadRequest.next() = 0;
                    end;

                    HmsPatCharges.Init();
                    HmsPatCharges."Appointment No." := RHeader."Patient Appointment No";
                    HmsPatCharges."Patient No." := ReceiptLine."Patient No";
                    HmsPatCharges.Validate("Patient No.");
                    HmsPatCharges."Transaction Type" := 'zReceipt';
                    //     IF ReceiptLine.Type='CO-PAY' THEN BEGIN
                    //       HmsPatCharges."Transaction Type":='CO-PAY';
                    //        HmsPatCharges."G/L Account No" :='15007';
                    //        END;
                    HmsPatCharges.Validate("Transaction Type");
                    HmsPatCharges.Date := Today;
                    HmsPatCharges."Line No" := ReceiptLine."Line No.";
                    HmsPatCharges."Shortcut Dimension 1 Code" := RHeader."Global Dimension 1 Code";
                    HmsPatCharges."Shortcut Dimension 2 Code" := RHeader."Shortcut Dimension 2 Code";
                    HmsPatCharges.Code := RHeader."No.";
                    HmsPatCharges.Description := ReceiptLine.Type + ' Rcpt ' + ReceiptLine."Transaction Name";
                    HmsPatCharges.Amount := ReceiptLine.Amount * -1;
                    HmsPatCharges."Total Amount" := ReceiptLine.Amount * -1;
                    HmsPatCharges."Insurance Amount" := ReceiptLine.Amount * -1;
                    HmsPatCharges."Claim Receipt No" := ReceiptLine.No;
                    HmsPatCharges."Link No" := ReceiptLine."Transaction No.";
                    if PatRec.Get(RHeader."Patient No.") then begin
                        HmsPatCharges."Visit No" := RHeader."Patient Appointment No";
                        if PatRec."Patient Type" = PatRec."Patient Type"::Corporate then
                            HmsPatCharges."Insurance No" := PatRec."Insurance No.";
                    end;
                    HmsPatCharges.Posted := true;
                    if PatRec.Get(ReceiptLine."Patient No") then
                        HmsPatCharges."Visit No" := RHeader."Patient Appointment No";
                    HmsPatCharges.Insert();
                end;
            until ReceiptLine.Next() = 0;
    end;

    local procedure UpdateInvoiceDetails(RHeaderNo: Code[20])
    var
        SalesH: Record "Sales Invoice Header";
        HmsPatCharges: Record "HMS Patient Charges";
    begin
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, RHeaderNo);
        if ReceiptLine.Find('-') then
            repeat
                SalesH.Reset;
                SalesH.SetRange(SalesH."No.", ReceiptLine."Applies-to Doc. No.");
                if SalesH.Find('-') then begin
                    SalesH.Paid := true;
                    SalesH."Payment Date" := Today;
                    SalesH."Receipt No" := ReceiptLine.No;
                    SalesH."Paid Amount" := ReceiptLine.Amount;
                    SalesH.Modify;
                end;

            until ReceiptLine.Next() = 0;
    end;

    procedure CheckTransactionTypeMissing(RHeaderNo: Code[20]) Exists: Boolean
    begin
        //get the sum total of the post dated cheques is any
        //reset the bank amount first
        Exists := false;
        BAmount := 0;
        ReceiptLine.Reset();
        ReceiptLine.SetRange(ReceiptLine.No, RHeaderNo);
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
    /* 
        local procedure PatientbillPending() ispending: Boolean
        var
            decReceipts: Decimal;
            decCharge: Decimal;
            decCurrentOpenBill: Decimal;
        begin
            ispending := true;
            decReceipts := 0;
            decCharge := 0;

            //Get open entries
            PatientCharges.Reset();
            PatientCharges.SetRange(PatientCharges."Patient No.", "Patient No.");
            PatientCharges.SetRange(PatientCharges.Closed, false);
            PatientCharges.SetRange(PatientCharges.Posted, false);
            PatientCharges.SetFilter(PatientCharges.Amount, '>0');
            if PatientCharges.Find('-') then
                repeat
                    decCharge := decCharge + PatientCharges.Amount;
                until PatientCharges.Next() = 0;

            //Get Receipts
            PatientCharges.Reset();
            PatientCharges.SetRange(PatientCharges."Patient No.", "Patient No.");
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
     */
    /* 
        local procedure UpdateDoctorInvoiceNew()
        var
            HmsPatCharges: Record "HMS Patient Charges";
            HMSTransCode: Record "HMS Transactions code";
            HMSPatRec: Record "HMS Patient";
        begin
            ReceiptLine.Reset();
            ReceiptLine.SetRange(ReceiptLine.No, "No.");
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
                                    GenJnlLine."Posting Date" := Date;
                                    GenJnlLine."Document No." := ReceiptLine.No;
                                    GenJnlLine."Document Date" := "Document Date";
                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                                    GenJnlLine."Account No." := HmsPatCharges."Doctor ID";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine."External Document No." := HmsPatCharges."Invoice Number";
                                    GenJnlLine."Currency Code" := "Currency Code";
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
                                    GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                                    GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
                                    if GenJnlLine.Amount <> 0 then GenJnlLine.Insert();
                                    //Balance Account
                                    LineNo := LineNo + 100;
                                    HMSTransCode.TestField(HMSTransCode."Expense G/L Account");
                                    GenJnlLine.Init();
                                    GenJnlLine."Journal Template Name" := JTemplate;
                                    GenJnlLine."Journal Batch Name" := JBatch;
                                    GenJnlLine."Source Code" := 'CASHRECJNL';
                                    GenJnlLine."Line No." := LineNo;
                                    GenJnlLine."Posting Date" := Date;
                                    GenJnlLine."Document No." := ReceiptLine.No;
                                    GenJnlLine."Document Date" := "Document Date";
                                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No." := HMSTransCode."Expense G/L Account";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine."External Document No." := HmsPatCharges."Invoice Number";
                                    GenJnlLine."Currency Code" := "Currency Code";
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
                                    GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                                    GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
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
     */
    local procedure CloseBill(VisitNo: Text; RHeader: Record "Receipts Header")
    var
        HmsPatCharges: Record "HMS Patient Charges";
    begin
        HmsPatCharges.Reset();
        HmsPatCharges.SetRange(HmsPatCharges."Patient No.", RHeader."Patient No.");
        HmsPatCharges.SetRange(HmsPatCharges.Posted, false);
        HmsPatCharges.SetRange(HmsPatCharges."Own Debtor", false);
        HmsPatCharges.SetRange(HmsPatCharges."Visit No", VisitNo);
        if HmsPatCharges.Find('-') then
            repeat
                HmsPatCharges.Posted := true;
                HmsPatCharges."Invoice ID" := RHeader."No.";
                HmsPatCharges.Closed := true;
                HmsPatCharges.Modify();

            until HmsPatCharges.Next() = 0;
    end;



    local procedure InsertIntoReceiptBuffer(RHeader: Record "Receipts Header")
    var
        RecBuffer: Record "Split Receipt Buffer";
        SplitRec: Record "Receipt Split";
        RecLine: Record "Receipt Line q";
        lnNo: Integer;
    begin
        RecBuffer.RESET();
        IF RecBuffer.FIND('-') THEN
            lnNo := RecBuffer.Count;

        SplitRec.Reset();
        SplitRec.SetRange("Receipt No", RHeader."No.");
        if SplitRec.find('-') then
            //insert split receipt into buffer
            repeat
                RecBuffer.Init();
                RecBuffer.Amount := SplitRec.Amount;
                RecBuffer."Bank Account No" := SplitRec."Bank Account No";
                RecBuffer."Pay Mode" := SplitRec."Pay Mode";
                RecBuffer."Patient No" := RHeader."Patient No.";
                RecBuffer."Receipt No" := SplitRec."Receipt No";
                RecBuffer."Transaction No" := SplitRec."Transaction No";
                RecBuffer."Visit No" := RHeader."Patient Appointment No";
                RecBuffer."Date Posted" := Today;
                RecBuffer."Posted By" := Format(UserId); // REFACTOR: Use Correct User ID
                RecBuffer."Time Posted" := Time;
                RecBuffer."Patient Name" := RHeader."Received From";
                RecBuffer."Receipt Line No" := lnNo;
                RecBuffer.Insert(true);
                lnNo := lnNo + 1;
            until SplitRec.Next() = 0
        else begin
            RecLine.Reset();
            RecLine.SetRange(RecLine.No, RHeader."No.");
            if RecLine.Find('-') then
                repeat
                    RecBuffer.Init();
                    RecBuffer."Receipt No" := RecLine.No;
                    RecBuffer."Bank Account No" := RecLine."Bank Code";
                    RecBuffer."Patient No" := RHeader."Patient No.";
                    RecBuffer."Pay Mode" := RecLine."Pay Mode";
                    RecBuffer.Amount := RecLine.Amount;
                    RecBuffer."Transaction No" := RHeader."Transaction Code";
                    RecBuffer."Visit No" := RHeader."Patient Appointment No";
                    RecBuffer."Transaction Type" := RecLine."HSM Transaction Type";
                    RecBuffer."Date Posted" := Today;
                    RecBuffer."Posted By" := Format(UserId);
                    RecBuffer."Time Posted" := Time;
                    RecBuffer."Patient Name" := RHeader."Received From";
                    RecBuffer."Receipt Line No" := lnNo;
                    RecBuffer.Insert();
                    lnNo := lnNo + 1;
                until RecLine.Next() = 0;
        end;
    end;

}
