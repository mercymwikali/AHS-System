namespace PTL.HMIS;
using Microsoft.Inventory.Journal;
using Microsoft.Foundation.NoSeries;
using Microsoft.Inventory.Posting;

codeunit 85033 "HMS Pharmacy Processes"
{
    var
        HMSPatient: Record "HMS Patient";
        HMSPharmacyHeader: Record "HMS Pharmacy Header";
        HMSPharmacyLine: Record "HMS Pharmacy Line";
        HMSPatientCharges: Record "HMS Patient Charges";
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
        TbHMSSetup: Record "HMS Setup";
        NoSeriesManagement: Codeunit "No. Series";

    procedure PostPharmacyReturns(var PharmacyLine: Record "HMS Pharmacy Line") ReturnValue: Boolean
    begin
        ReturnValue := false;
        if GuiAllowed then
            if Confirm('Do you wish to post the record?', false) = false then
                exit;
        if HMSPharmacyHeader.Get(PharmacyLine."Pharmacy No.") then begin
            /*
             IF HMSPharmacyHeader."Cash Sale"=TRUE THEN BEGIN
              HMSPharmacyHeader.CALCFIELDS("Receipt Count");
              IF HMSPharmacyHeader."Receipt Count"=0 THEN ERROR('Please note that the selected Record has not been receipted');
             END;
             */
            //check visit
            HMSPatientCharges.Reset();
            HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", HMSPharmacyHeader."Patient No.");
            HMSPatientCharges.SetRange(HMSPatientCharges.Code, PharmacyLine."No.");
            HMSPatientCharges.SetRange(HMSPatientCharges.Date, HMSPharmacyHeader."Pharmacy Date");
            if HMSPatientCharges.FindFirst() then begin
                HMSPatientCharges.CalcFields("Posted Invoice No.");
                if HMSPatientCharges.Posted = true then
                    Error('This charge has already been posted to the relevent GL. Kindly reverse the charge first');
                if HMSPatientCharges."Posted Invoice No." <> '' then
                    Error('Invoice already posted');

                //CALCFIELDS("Patient Type");
                // HMSPatient.SetRange(HMSPatient."Patient No.", HMSPharmacyHeader."Patient No.");
                // if HMSPatient.Find('-') then
                //     if HMSPatient."Patient Type" = HMSPatient."patient type"::Corporate then
                ReturnStock(PharmacyLine);
                ReverseChargePatient(HMSPatientCharges, PharmacyLine);

                PharmacyLine."Returns Posted" := true;
                PharmacyLine.Modify();

                ReturnValue := true;
            end;
        end;
        exit(ReturnValue);
    end;

    local procedure ReverseChargePatient(var PatientCharge: Record "HMS Patient Charges"; var PharmacyLine: Record "HMS Pharmacy Line")
    var
        HMSPatCharges: record "HMS Patient Charges";
        Ln: Integer;
    begin
        //IF "Cash Sale"=FALSE THEN  BEGIN
        HMSPatientCharges.Reset();
        ln := HMSPatientCharges.count;

        // HMSPatientCharges.Reset();
        // HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", HMSPharmacyHeader."Patient No.");
        // HMSPatientCharges.SetRange(HMSPatientCharges.Code, PharmacyLine."No.");
        // HMSPatientCharges.SetRange(HMSPatientCharges.Date, HMSPharmacyHeader."Pharmacy Date");
        // if HMSPatientCharges.Find('-') then begin
        HMSPatCharges.init();
        HMSPatCharges."Line No" := ln + 1000;
        HMSPatCharges."Link No" := PatientCharge."Link No";
        HMSPatCharges."Patient No." := PatientCharge."Patient No.";
        HMSPatCharges.code := PatientCharge.code;
        HMSPatCharges."Visit No" := PatientCharge."Visit No";
        HMSPatCharges.Remarks := 'Reversal';
        HMSPatCharges.Description := CopyStr('Rev- ' + PatientCharge.Description, 1, MaxStrLen(HMSPatCharges.Description));
        HMSPatCharges.date := Today;
        HMSPatCharges."Shortcut Dimension 1 Code" := PatientCharge."Shortcut Dimension 1 Code";
        HMSPatCharges."Shortcut Dimension 2 Code" := PatientCharge."Shortcut Dimension 2 Code";
        HMSPatCharges."Shortcut Dimension 3 Code" := PatientCharge."Shortcut Dimension 3 Code";
        HMSPatCharges."Shortcut Dimension 4 Code" := PatientCharge."Shortcut Dimension 4 Code";
        HMSPatCharges."Transaction Type" := PatientCharge."Transaction Type";
        HMSPatCharges.Amount := PharmacyLine."Unit Price" * -1;
        HMSPatCharges.Validate(Amount);
        HMSPatCharges.Quantity := PharmacyLine."Returns Quantity";
        HMSPatCharges.Validate(Quantity);
        // HMSPatCharges."Total Amount" := PatientCharge."Total Amount" * -1;
        HMSPatCharges."Insurance No" := PatientCharge."Insurance No";
        HMSPatCharges."Insurance Amount" := PatientCharge."Insurance Amount";
        HMSPatCharges."G/L Account No" := PatientCharge."G/L Account No";
        HMSPatCharges."G/L Account" := PatientCharge."G/L Account";
        // HMSPatCharges.Closed := true;// closed
        HMSPatCharges.insert();
        // Close the Charge we are reversing
        // PatientCharge.Closed := true; // closed
        PatientCharge.modify();
        // end;
    end;

    local procedure ReturnStock(var PharmLine: Record "HMS Pharmacy Line")
    var
        HMSSetup: Record "HMS Setup";
        ItemJournalLine: Record "Item Journal Line";
        TreatmentLine: Record "HMS Treatment Form Drug";
        LineNo: Integer;
    begin
        HMSSetup.Reset();
        HMSSetup.Get();
        PharmLine.CalcFields("Patient No");
        HMSPatient.get(PharmLine."Patient No");
        HMSSetup.TestField("Pharmacy Department");
        ItemJournalLine.Reset();
        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        if ItemJournalLine.Find('-') then
            ItemJournalLine.DeleteAll();
        LineNo := 0;
        PharmLine.Reset();
        PharmLine.SetRange(PharmLine."Pharmacy No.", PharmLine."Pharmacy No.");
        PharmLine.SetRange(PharmLine."No.", PharmLine."No.");
        PharmLine.SetRange(SystemId, PharmLine.SystemId);
        //PharmLine.SETFILTER(PharmLine."Returns Quantity",'>%1',0);
        if PharmLine.Find('-') then begin
            repeat
                if PharmLine."Returns Quantity" > 0 then begin
                    if PharmLine."Issued Quantity" < PharmLine."Issued Quantity" then
                        Error('You cannot return more than you gave issued');
                    if PharmLine.Quantity < PharmLine.Quantity then
                        Error('You cannot return more than you gave issued');
                    if PharmLine."Issued Units" < PharmLine."Issued Units" then
                        Error('You cannot return more than you gave issued');

                    PharmLine.TestField(PharmLine.Location);
                    LineNo := LineNo + 1000;
                    ItemJournalLine.Init();
                    ItemJournalLine."Journal Template Name" := CopyStr(HMSSetup."Pharmacy Item Journal Template", 1, MaxStrLen(ItemJournalLine."Journal Template Name"));
                    ItemJournalLine."Journal Batch Name" := CopyStr(HMSSetup."Pharmacy Item Journal Batch", 1, MaxStrLen(ItemJournalLine."Journal Batch Name"));
                    ItemJournalLine."Line No." := LineNo;
                    ItemJournalLine."Posting Date" := Today;
                    ItemJournalLine."Entry Type" := ItemJournalLine."entry type"::"Positive Adjmt.";
                    ItemJournalLine."Document No." := CopyStr(PharmLine."Pharmacy No." + ':' + PharmLine."No.", 1, MaxStrLen(ItemJournalLine."Document No."));
                    ItemJournalLine."Item No." := PharmLine."No.";
                    ItemJournalLine.Validate(ItemJournalLine."Item No.");
                    ItemJournalLine."Location Code" := CopyStr(PharmLine.Location, 1, MaxStrLen(ItemJournalLine."Location Code"));
                    // ItemJournalLine.Validate(ItemJournalLine."Location Code");
                    ItemJournalLine."Gen. Prod. Posting Group" := 'DRUGS';
                    if PharmLine."Returns Quantity" <= 0 then
                        Error('Please enter returns quantity');
                    ItemJournalLine.Quantity := PharmLine."Returns Quantity";
                    ItemJournalLine.Validate(ItemJournalLine.Quantity);
                    ItemJournalLine."Unit of Measure Code" := CopyStr(PharmLine."Measuring Unit", 1, MaxStrLen(ItemJournalLine."Unit of Measure Code"));
                    ItemJournalLine.Validate(ItemJournalLine."Unit of Measure Code");
                    ItemJournalLine."Unit Amount" := PharmLine."Unit Price";
                    ItemJournalLine."Shortcut Dimension 1 Code" := HMSPatient."Global Dimension 1 Code";
                    ItemJournalLine."Shortcut Dimension 2 Code" := HMSSetup."Pharmacy Department";
                    // ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount");
                    //    ItemJournalLine.Validate("Shortcut Dimension 1 Code");
                    //   ItemJournalLine.Validate("Shortcut Dimension 2 Code");
                    ItemJournalLine."Source Code" := 'Return';
                    ItemJournalLine.Insert();

                    // ReverseChargePatient(); //Modify bill

                    PharmLine.Remaining := PharmLine.Remaining + PharmLine."Returns Quantity";
                    PharmLine."Issued Quantity" := PharmLine."Issued Quantity" - PharmLine."Returns Quantity";
                    PharmLine.Quantity := PharmLine.Quantity - PharmLine."Returns Quantity";
                    PharmLine."Issued Units" := PharmLine."Issued Units" - PharmLine."Returns Quantity";
                    //PharmLine.
                    PharmLine.Modify();
                    LineNo := LineNo + 1;
                    /*Update the treatment lines*/
                    TreatmentLine.Reset();
                    TreatmentLine.SetRange(TreatmentLine."Treatment No.", HMSPharmacyHeader."Link No.");
                    TreatmentLine.SetRange(TreatmentLine."Drug No.", PharmLine."No.");
                    if TreatmentLine.Find('-') then begin
                        TreatmentLine.Issued := true;
                        TreatmentLine.Modify();
                    end;
                end;
            until PharmLine.Next() = 0;
            ItemJournalLine.Reset();
            ItemJournalLine.SetRange("Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
            ItemJournalLine.SetRange("Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
            if ItemJournalLine.Find('-') then
                Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJournalLine);
            //ERROR('Mtg');
            HMSPharmacyHeader.Status := HMSPharmacyHeader.Status::Completed;
            HMSPharmacyHeader.Modify();
        end;
    end;

    procedure SendInpatientOrdersheetToPharmacy(AdmissionNo: Code[20]) return: Boolean
    var
        NurseOrderSheet: Record "Nurse Order Sheet";
        NewNo: Code[20];
    begin
        return := false;
        NurseOrderSheet.Reset();
        NurseOrderSheet.SetRange("Admission No", AdmissionNo);
        NurseOrderSheet.SetRange(Posted, false);
        if not NurseOrderSheet.IsEmpty() then begin
            // Create Pharmacy Header
            HMSAdmissionFormHeader.Get(AdmissionNo);

            TbHMSSetup.Reset();
            TbHMSSetup.Get();
            NewNo := NoSeriesManagement.GetNextNo(TbHMSSetup."Pharmacy Nos", 0D, true);

            HMSPharmacyHeader.Reset();
            HMSPharmacyHeader.Init();
            HMSPharmacyHeader."Pharmacy No." := NewNo;
            HMSPharmacyHeader."Pharmacy Date" := Today;
            HMSPharmacyHeader."Pharmacy Time" := Time;
            HMSPharmacyHeader."Request Area" := HMSPharmacyHeader."request area"::Doctor;
            HMSPharmacyHeader."Patient No." := HMSAdmissionFormHeader."Patient No.";
            HMSPharmacyHeader.InPatient := true;
            HMSPharmacyHeader."Doctor ID" := HMSAdmissionFormHeader.Doctor;
            HMSPharmacyHeader."Global Dimension 1 Code" := HMSAdmissionFormHeader.Branch; //REFACTOR: Change this to be 1. Setup Based, or Come from API.
            HMSPharmacyHeader.Validate("Global Dimension 1 Code");
            HMSPharmacyHeader."Transaction Type" := 'PHARMACY';
            HMSPharmacyHeader."Link Type" := 'Admission';
            HMSPharmacyHeader."Pharmacy Type" := HMSPharmacyHeader."Pharmacy Type"::Inpatient;
            HMSPharmacyHeader."ADM No" := AdmissionNo;
            HMSPharmacyHeader."Link No." := CopyStr(AdmissionNo, 1, MaxStrLen(HMSPharmacyHeader."Link No."));
            HMSPharmacyHeader.Insert(true);
        end;

        NurseOrderSheet.Reset();
        NurseOrderSheet.SetRange("Admission No", AdmissionNo);
        NurseOrderSheet.SetRange(Posted, false);
        if NurseOrderSheet.FindSet() then
            repeat
                HMSPharmacyLine.Init();
                HMSPharmacyLine."Pharmacy No." := NewNo;
                HMSPharmacyLine."No." := NurseOrderSheet."Drug No";
                HMSPharmacyLine.Validate("No.");
                HMSPharmacyLine.Dosage := NurseOrderSheet.Dosage;
                HMSPharmacyLine.Location := HMSPharmacyHeader."Issuing Location";
                HMSPharmacyLine."Prescription Dose" := NurseOrderSheet."Prescription Dose";
                HMSPharmacyLine.Pharmacy := HMSPharmacyHeader."Issuing Location";
                HMSPharmacyLine."Link Code" := AdmissionNo;
                HMSPharmacyLine.Insert();

                NurseOrderSheet.Posted := true;
                NurseOrderSheet.Modify();

            until NurseOrderSheet.Next() = 0;

        return := true;

        exit(return);
    end;
}
