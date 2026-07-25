namespace PTL.HMIS;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Purchases.Payables;
using Microsoft.Sales.History;

codeunit 85001 "Patient Billing"
{
    procedure PostWieverRequest(WeiverRequest: record "HMS Patient Charges Weiver"; PostingUser: Code[20])
    var
        USetup: Record "Cash Office User Template";
        GenJnlLine: Record "Gen. Journal Line";
        PatRec: Record "HMS Patient";
        HMSPatCharges: Record "HMS Patient Charges";
        HMSPatientsCharges: Record "HMS Patient Charges";
        HMSSetup: Record "HMS Setup";
        VendL: Record "Vendor Ledger Entry";
        JBatch: code[20];
        JTemplate: code[20];
        LineNo: Integer;
    begin
        HMSSetup.get();
        if GuiAllowed then
            if CONFIRM('Do you reall want to post the Weiver?', false) then
                exit;

        USetup.Reset();
        USetup.SetRange(USetup.UserID, PostingUser);
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

        WeiverRequest.TESTFIELD(Posted, false);
        WeiverRequest.TESTFIELD(Status, WeiverRequest.Status::Approved);
        HMSSetup.TestField("Weiver Transaction Code");

        HMSPatCharges.reset();
        HMSPatCharges.setrange("Patient No.", WeiverRequest."Patient No");
        HMSPatCharges.setrange("Visit No", WeiverRequest."Visit No");
        HMSPatCharges.setrange("Line No", WeiverRequest."Line No");
        if HMSPatCharges.find('-') then begin
            // HMSPatCharges.calcfields(Reversed);
            if (HMSPatCharges.Posted = true) and (HMSPatCharges.Reversed = false) then
                error('Please note that posted charges must be reversed before posting weiver');
            if HMSPatCharges.Amount - WeiverRequest.Amount < 0 then
                error('Please note that weiver amount can not be more than original amount');
            PatRec.get(HMSPatCharges."Patient No.");

            HMSPatientsCharges.Init();
            HMSPatientsCharges."Line No" := HMSPatCharges."Line No" + 100;
            HMSPatientsCharges."Patient No." := WeiverRequest."Patient No";
            HMSPatientsCharges."Link No" := WeiverRequest."Link No";
            HMSPatientsCharges."Treatment No." := HMSPatCharges."Treatment No.";
            HMSPatientsCharges."Appointment No." := HMSPatCharges."Appointment No.";
            HMSPatientsCharges."Transaction Type" := HMSSetup."Weiver Transaction Code";
            HMSPatientsCharges.Code := HMSPatCharges.Code;
            HMSPatientsCharges.Description := HMSPatCharges.Description;
            HMSPatientsCharges.Date := HMSPatCharges.Date;
            HMSPatientsCharges."Shortcut Dimension 1 Code" := HMSPatCharges."Shortcut Dimension 1 Code";
            HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSPatCharges."Shortcut Dimension 2 Code";
            HMSPatientsCharges."Bill Section" := HMSPatCharges."Bill Section";
            HMSPatientsCharges."Doctor ID" := HMSPatCharges."Doctor ID";
            HMSPatientsCharges."User ID" := PostingUser;
            HMSPatientsCharges."Creation Date" := Today;
            HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
            HMSPatientsCharges."Admission No" := HMSPatCharges."Admission No";
            HMSPatientsCharges."Visit No" := HMSPatCharges."Visit No";
            HMSPatientsCharges.Amount := WeiverRequest.Amount * -1;
            HMSPatientsCharges.Quantity := 1;
            HMSPatientsCharges."Total Amount" := WeiverRequest.Amount * -1;
            HMSPatientsCharges.Insert();
        end;
        // Reverse Posted Doctors Fee
        VendL.reset();
        VendL.setrange("Vendor No.", HMSPatCharges."Doctor ID");
        VendL.setfilter("Document No.", '%1|%2', HMSPatCharges."Doctors Posting No", HMSPatCharges."Visit No");
        if VendL.find('-') then begin
            VendL.CalcFields(Amount);
            LineNo := LineNo + 100;
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := JTemplate;
            GenJnlLine."Journal Batch Name" := JBatch;
            GenJnlLine."Source Code" := 'DOCTORREV';
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := today;
            if VendL."Document No." = HMSPatCharges."Doctors Posting No" then
                GenJnlLine."Document No." := HMSPatCharges."Doctors Posting No"
            else
                GenJnlLine."Document No." := HMSPatCharges."Visit No";
            // GenJnlLine."Document Date":="Document Date";
            GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
            GenJnlLine."Account No." := VendL."Vendor No.";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."External Document No." := HMSPatCharges."Patient No.";
            // GenJnlLine."Currency Code":="Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine.Amount := ABS(VendL.Amount);
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Source Code" := CopyStr(HMSPatCharges."Visit No", 1, MaxStrLen(GenJnlLine."Source Code"));
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := HMSSetup."Doctors Expense Account";
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine.Description := CopyStr('Weiver - ' + WeiverRequest.No + '/' + PatRec.Names, 1, MaxStrLen(GenJnlLine.Description));
            GenJnlLine."Shortcut Dimension 1 Code" := HMSPatCharges."Shortcut Dimension 1 Code";
            GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := HMSPatCharges."Shortcut Dimension 2 Code";
            GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3, HMSPatCharges."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4, HMSPatCharges."Shortcut Dimension 4 Code");
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
            if VendL."Document No." = HMSPatCharges."Doctors Posting No" then
                GenJnlLine."Applies-to Doc. No." := HMSPatCharges."Doctors Posting No"
            else
                GenJnlLine."Applies-to Doc. No." := HMSPatCharges."Visit No";
            //GenJnlLine.validate("Applies-to Doc. No.");

            if GenJnlLine.Amount <> 0 then
                GenJnlLine.Insert();


            GenJnlLine.Reset();
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            if GenJnlLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Bill", GenJnlLine);
        end;

        HMSPatCharges."Weiver Amount" := WeiverRequest.Amount;
        HMSPatCharges."Weiver Code" := WeiverRequest.No;
        HMSPatCharges.Weived := true;
        HMSPatCharges.modify();
        WeiverRequest.Posted := true;
        WeiverRequest.modify();
    end;

    procedure RefreshPatientChargesAll(VisitNo: Code[30]; PatientNo: Code[30]) returnValue: Boolean
    var
        HMSPatCharges: Record "HMS Patient Charges";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        HMSPatient: Record "HMS Patient";
    begin
        returnValue := false;
        /* Since we are only changing Cash - Corporate, or Vice Versa 
            - The Fields to be touched are,
                * Insurance number, 
                * Insurance name,
                * Invoice Number
                * Shortcut Dimension 4 - Settlement Type (Cash/Corporate)
            - Exclude Shif Rebates from update (SHA is posted to its own insurance number)
        ****** Implementation**********
            - First Check if there are closed charges
            - If there were receipts posted some reversal may be needed, Nofify the User to Either reverse the receipts and refund the money or continue with the receipts
            - Reopen all charges (posted = false, closed = false) - If the change is purely from cash to corporate or vice versa
            - if in a case where you they have two insurances splitting the bill, Assume the posted charges belong to the previous insurance so do not re open the charges.
            - if all charges are moving from one insurance to the other, re open the charges then continue.
            - if an invoice number already exists check that it is not posted before continuing.

        *************** Implementation of Double Insurance*************************
            - Update the Interim and Final Invoice filters to get the Specific Insurance Number
        */
        HMSPatient.Get(PatientNo);
        HMSPatient.TestField(Activated, true);
        HMSPatient.TestField("Active Visit No", VisitNo);
        // 1. Re-Open Posted Charges.
        HMSPatCharges.Reset();
        HMSPatCharges.SetRange(HMSPatCharges."Patient No.", HMSPatient."Patient No.");
        HMSPatCharges.SetRange(HMSPatCharges."Visit No", HMSPatient."Active Visit No");
        HMSPatCharges.SetRange(Posted, true);
        if HMSPatCharges.FindSet() then
            repeat
                HMSPatCharges.posted := false;
                HMSPatCharges.Closed := false;
                HMSPatCharges.Modify();
            until HMSPatCharges.Next() = 0;

        // 2. Get Relevant Charges to make the Modifications from
        // 2.1 Exclude Rebates and Receipts
        HMSPatCharges.Reset();
        HMSPatCharges.SetRange(HMSPatCharges."Patient No.", HMSPatient."Patient No.");
        HMSPatCharges.SetRange(HMSPatCharges."Visit No", HMSPatient."Active Visit No");
        HMSPatCharges.SetRange(Posted, false);
        // HMSPatCharges.SetFilter(HMSPatCharges."Transaction Type", '<>%1|%2', 'Rebates', 'ZReceipt');
        HMSPatCharges.SetAutoCalcFields("Posted Invoice No.");
        if HMSPatCharges.FindSet() then begin
            repeat
                if (HMSPatCharges."Transaction Type" <> 'ZRECEIPT') then begin
                    if HMSPatCharges."Invoice Number" <> '' then begin
                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SetRange("No.", HMSPatCharges."Posted Invoice No.");
                        if not SalesInvoiceHeader.IsEmpty() then Error('Please Note the Pateint has a posted Invoice: %1. Please Reverse it before Continuing', HMSPatCharges."Posted Invoice No.");
                    end;
                    if HMSPatient."Patient Type" = HMSPatient."Patient Type"::Corporate then begin
                        HMSPatCharges."Shortcut Dimension 4 Code" := 'Corporate';
                        HMSPatCharges."Insurance No" := HMSPatient."Insurance No.";
                        HMSPatCharges.Validate("Insurance No");
                    end else
                        if HMSPatient."Patient Type" = HMSPatient."Patient Type"::Cash then begin
                            HMSPatCharges."Shortcut Dimension 4 Code" := 'CASH';
                            HMSPatCharges."Insurance No" := '';
                            HMSPatCharges."Invoice Number" := '';
                        end;
                        
                    if HMSPatCharges."Transaction Type" <> 'PHARMACY' then
                        HMSPatCharges.Validate(Code);

                    HMSPatCharges.Closed := false;
                    HMSPatCharges.Modify();
                end;

            until HMSPatCharges.Next() = 0;

            if GuiAllowed then
                Message('Completed Successfully');
            returnValue := true;
        end;
    end;

}
