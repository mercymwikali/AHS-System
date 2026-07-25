namespace PTL.Hospital;
using Microsoft.Sales.Customer;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Posting;
using Microsoft.Foundation.NoSeries;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Setup;

codeunit 85000 "PTL Factory"
{

    var
        Cust: Record Customer;
        HMSPatientsCharges: Record "HMS Patient Charges";
        HMSSetup: Record "HMS Setup";
        ItemJnlLine: Record "Item Journal Line";
        objItem: Record Item;
        Patient: Record "HMS Patient";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        TreatmentLine: Record "HMS Treatment Form Drug";
        LineNo: Integer;

    procedure PostPharmLine(PharmHeaderNo: Code[20]): Boolean
    begin

        PharmHeader.Get(PharmHeaderNo);
        Patient.Get(PharmHeader."Patient No.");
        if PharmHeader."Cash Sale" = true then begin
            Patient.CalcFields(Patient."Bill Balance");
            PharmHeader.CalcFields("Receipt Count");

            // if Patient."Bill Balance" > 0 then Error('Please note that the selected Record has not been receipted');
        end;

        HMSSetup.Reset();
        HMSSetup.Get();

        if Cust.Get(Patient."Insurance No.") then;
        LineNo := 0;



        PharmLine.Reset();
        PharmLine.SetRange(PharmLine."Pharmacy No.", PharmHeader."Pharmacy No.");
        //PharmLine.SetRange(PharmLine."Item Journal", false);
        if PharmLine.Find('-') then begin
            repeat
                PharmLine.TestField(PharmLine.Location);
                objItem.Reset();
                objItem.SetRange(objItem."No.", PharmLine."No.");
                ItemJnlLine.Reset();
                ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
                ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
                if ItemJnlLine.Find('-') then ItemJnlLine.DeleteAll();
                //objItem.SetRange(objItem."Item Tracking Code", '');
                if objItem.Find('-') then begin

                    LineNo := LineNo + 1000;
                    ItemJnlLine.Init();
                    ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                    ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                    ItemJnlLine."Line No." := LineNo;
                    ItemJnlLine."Posting Date" := Today;
                    ItemJnlLine."Document No." := PharmHeaderNo;
                    ItemJnlLine."Item No." := PharmLine."No.";
                    ItemJnlLine.Validate(ItemJnlLine."Item No.");
                    ItemJnlLine."Location Code" := PharmLine.Location;
                    ItemJnlLine.Validate(ItemJnlLine."Location Code");
                    ItemJnlLine.Quantity := PharmLine.Quantity;
                    ItemJnlLine.Validate(ItemJnlLine.Quantity);
                    ItemJnlLine."Unit of Measure Code" := PharmLine."Measuring Unit";
                    ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                    ItemJnlLine."Gen. Prod. Posting Group" := objItem."Gen. Prod. Posting Group";
                    // ItemJnlLine."Gen. Bus. Posting Group" := 
                    if (Cust."NHIF Capitation" = true) then begin
                        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                        ItemJnlLine."Unit Amount" := PharmLine."Unit Cost";
                    end else begin
                        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Sale;
                        ItemJnlLine."Unit Amount" := PharmLine."Unit Price";
                    end;
                    ItemJnlLine.Validate("Unit Amount");
                    ItemJnlLine."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                    ItemJnlLine."Shortcut Dimension 2 Code" := 'PHARMACY';
                    ItemJnlLine.Validate(ItemJnlLine."Unit Amount");
                    ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                    ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                    ItemJnlLine."External Document No." := PharmHeaderNo;
                    ItemJnlLine."Source No." := Patient."Patient No.";
                    ItemJnlLine.Insert();

                    LineNo := ItemJnlLine."Line No.";
                end;
                // end ;else begin

                //     ObjTracking.Reset();
                //     ObjTracking.SetRange(ObjTracking."Pharmacy No", PharmLine."Pharmacy No.");
                //     ObjTracking.SetRange(ObjTracking."Item No", PharmLine."No.");
                //     ObjTracking.SetRange(ObjTracking."Location Code", PharmLine.Location);
                //     if ObjTracking.Find('-') then begin
                //         repeat
                //             ItemJnlLine.Reset();
                //             if ItemJnlLine.FindLast() then begin
                //                 LNNO := LNNO + 1000;
                //                 LineNo := ItemJnlLine."Line No.";
                //             end;

                //             ItemJnlLine.Init();
                //             ItemJnlLine."Line No." := LineNo + 1000;
                //             ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                //             ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                //             ItemJnlLine."Posting Date" := TODAY;
                //             // ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Sale;
                //             ItemJnlLine."Document No." := "Pharmacy No.";
                //             ItemJnlLine."Item No." := PharmLine."No.";
                //             ItemJnlLine.Validate(ItemJnlLine."Item No.");
                //             ItemJnlLine."Location Code" := PharmLine.Location;
                //             ItemJnlLine.Validate(ItemJnlLine."Location Code");
                //             ItemJnlLine.Quantity := ObjTracking.Quantity;
                //             ItemJnlLine.Validate(Quantity);
                //             ItemJnlLine."Lot No." := ObjTracking."Lot No";
                //             ItemJnlLine."Expiration Date" := ObjTracking."Expiration Date";
                //             ItemJnlLine."Serial No." := ObjTracking."Serial No";
                //             ItemJnlLine."Job No." := PharmLine."No." + Format(ObjTracking."Line No");
                //             ItemJnlLine."Unit of Measure Code" := PharmLine."Measuring Unit";
                //             ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                //             if (Cust."NHIF Capitation" = true) then begin
                //                 ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                //                 ItemJnlLine."Unit Amount" := PharmLine."Unit Cost";
                //             end else begin
                //                 ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Sale;
                //                 ItemJnlLine."Unit Amount" := PharmLine."Unit Price";
                //             end;
                //             ItemJnlLine."External Document No." := PharmLine."Pharmacy No.";
                //             ItemJnlLine."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                //             ItemJnlLine."Source No." := Patient."Patient No.";
                //             ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                //             ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                //             // ItemJnlLine."Pharmacy No" := PharmLine."Pharmacy No.";
                //             ItemJnlLine.Insert();
                //             ItemJnlLine."Line No." := LineNo;
                //         until ObjTracking.Next = 0;

                //     end;
                // end;




                PharmLine.Remaining := PharmLine.Remaining - PharmLine.Quantity;
                PharmLine."Item Journal" := true;
                PharmLine.Modify();
                // LineNo := LineNo + 1000;
                /*Update the treatment lines*/
                TreatmentLine.Reset();
                TreatmentLine.SetRange(TreatmentLine."Treatment No.", PharmHeader."Treatment No.");
                TreatmentLine.SetRange(TreatmentLine."Drug No.", PharmLine."No.");
                if TreatmentLine.Find('-') then begin
                    TreatmentLine.Issued := true;
                    TreatmentLine.Status := TreatmentLine.Status::Completed;
                    TreatmentLine.Modify();
                end;

                //---------------------------------------
                objItem.Reset();
                objItem.SetRange(objItem."No.", PharmLine."No.");
                if objItem.Find('-') then begin
                    // objItem."Unit Price" := PharmLine."Unit Price";

                    objItem.Dosage := TreatmentLine.Dosage;
                    objItem.Take := TreatmentLine.Take;
                    objItem."Number of Days" := TreatmentLine."Number of Days";
                    objItem.Frequency := TreatmentLine.Frequency;
                    objItem.Modify();


                end;

            until PharmLine.Next = 0;
            ItemJnlLine.Reset();
            ItemJnlLine.SetRange("Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
            ItemJnlLine.SetRange("Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
            ItemJnlLine.SetRange(ItemJnlLine."Document No.", PharmHeaderNo);
            if ItemJnlLine.Find('-') then
                Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);
            PharmHeader.Get(PharmHeaderNo);
            PharmHeader.Status := PharmHeader.Status::Completed;
            PharmHeader.Modify();

        end;
    end;
    //
    procedure ChargePatient(PharmHeader: Record "HMS Pharmacy Header")
    begin
        //IF "Cash Sale"=FALSE THEN  BEGIN
        HMSPatientsCharges.Reset();
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PharmHeader."Patient No.");
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Link No", PharmHeader."Pharmacy No.");
        HMSPatientsCharges.SetRange(Posted, false);
        if HMSPatientsCharges.Find('-') then HMSPatientsCharges.DeleteAll();

        PharmLine.Reset();
        PharmLine.SetRange(PharmLine."Pharmacy No.", PharmHeader."Pharmacy No.");
        PharmLine.SetRange(Posted, false);
        if PharmLine.Find('-') then
            repeat
                Patient.SetRange(Patient."Patient No.", PharmHeader."Patient No.");
                if Patient.Find('-') then
                    // BEGIN
                    HMSPatientsCharges."Admission No" := Patient."Current Adm No";
                HMSPatientsCharges."Visit No" := Patient."Active Visit No";
                // END;
                // PharmHeader.Get("Pharmacy No.");
                HMSPatientsCharges.Init();
                HMSPatientsCharges."Line No" := PharmLine."line no";
                HMSPatientsCharges."Patient No." := PharmHeader."Patient No.";
                HMSPatientsCharges."Transaction Type" := PharmHeader."Transaction Type";
                HMSPatientsCharges.Validate("Transaction Type");
                HMSPatientsCharges."Link No" := PharmHeader."Pharmacy No.";
                HMSPatientsCharges."Treatment No." := PharmHeader."Link No.";
                HMSPatientsCharges."Appointment No." := PharmHeader."Link No.";
                HMSPatientsCharges.Code := PharmLine."No.";
                HMSPatientsCharges."Charge Type" := HMSPatientsCharges."Charge Type"::Item;
                HMSPatientsCharges.Validate(Code);
                PharmLine.CalcFields(PharmLine."Drug Name");
                HMSPatientsCharges.Description := PharmLine."Drug Name";
                if PharmLine."Unit Price" = 0 then Error('Kindly enter the issued price');
                HMSPatientsCharges.Amount := PharmLine."Unit Price";
                HMSPatientsCharges.Validate(Amount);
                HMSPatientsCharges.Quantity := PharmLine.Quantity;
                HMSPatientsCharges.Validate(Quantity);
                HMSPatientsCharges.Date := PharmHeader."Pharmacy Date";
                HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Pharmacy;
                HMSPatientsCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                HMSPatientsCharges."Pharmacy No" := PharmHeader."Pharmacy No.";
                HMSPatientsCharges."Location Code" := PharmHeader."Issuing Location";
                if Patient.Inpatient then
                    HMSPatientsCharges."Shortcut Dimension 2 Code" := 'PHARMACY'
                else
                    HMSPatientsCharges."Shortcut Dimension 2 Code" := 'PHARMACY';
                HMSPatientsCharges.Insert();
                PharmLine.Posted := true;
                PharmLine.Modify();
            until PharmLine.Next() = 0;

        PharmHeader.Status := PharmHeader.Status::Completed;
        PharmHeader.Modify();
    end;

    /* procedure DispatchToPharmacy(Patient: Record "HMS Patient"): Boolean
    var
        AppH: Record "HMS Appointment Form Header";
        PatientCharge: Record "HMS Patient Charges";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        TreatmentLine: Record "HMS Treatment Form Drug";
    begin
        // This is the OG Dispatch to Pharmacy function
        // It Will be used to create the Pharmacy header and lines for the patient.
        // 1. First we wil check if the patient has an active appointment.
        // 2. Then check if they have a treatment form.
        // 3. if they do, check if the treatment form is updated with the drugs.
        // 4. if they are, check if they are already forwarded to pharmacy.if not create the pharmacy header and lines. if so, return the pharmacy no.
        // 5. if the pharmacy no is posted, return the pharmacy no then ask if they need to add a completely new one for different drugs.
        

    end; */
    procedure DispatchToPharmacy(PatientDispatch: Record "HMS Patient"): Boolean
    var
        AppH: Record "HMS Appointment Form Header";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
        PharmHeader: Record "HMS Pharmacy Header";
        TreatmentLine: Record "HMS Treatment Form Drug";
        ActiveAppointmentExists: Boolean;
        AlreadyDispatched: Boolean;
        DrugsExist: Boolean;
        TreatmentExists: Boolean;
        PharmacyNo: Code[20];
    begin
        // 1. Check if the patient has an active appointment
        ActiveAppointmentExists := false;
        AppH.Reset();
        AppH.SetRange("Patient No.", PatientDispatch."Patient No.");
        AppH.SetFilter(Status, '=%1|%2', AppH.Status::New, AppH.Status::Dispatched);
        if AppH.FindLast() then
            ActiveAppointmentExists := true;

        if not ActiveAppointmentExists then
            Error('Patient %1 does not have an active appointment.', PatientDispatch."Patient No.");

        // 2. Check if they have a treatment form
        TreatmentExists := false;
        HMSTreatmentFormHeader.Reset();
        HMSTreatmentFormHeader.SetRange("Patient No.", PatientDispatch."Patient No.");
        HMSTreatmentFormHeader.SetRange("Link No.", AppH."Appointment No.");
        if HMSTreatmentFormHeader.FindLast() then
            TreatmentExists := true;

        /* if not TreatmentExists then begin
            Message('No treatment form found for patient %1.', Patient."Patient No.");
            exit;
        end; */

        // 3. Check if the treatment form has drugs
        DrugsExist := false;

        if TreatmentExists then begin
            TreatmentLine.Reset();
            TreatmentLine.SetRange("Treatment No.", HMSTreatmentFormHeader."Treatment No.");
            if not TreatmentLine.IsEmpty() then
                DrugsExist := true;
        end;

        // 4. Check if drugs are already forwarded to pharmacy
        AlreadyDispatched := false;
        PharmHeader.Reset();
        PharmHeader.SetRange("Patient No.", PatientDispatch."Patient No.");
        PharmHeader.SetRange(Status, PharmHeader.Status::New);
        if not TreatmentExists then
            PharmHeader.SetRange("Link No.", AppH."Appointment No.")
        else
            PharmHeader.SetRange("Link No.", HMSTreatmentFormHeader."Treatment No.");
        if PharmHeader.FindFirst() then begin
            AlreadyDispatched := true;
            PharmHeader."Pharmacy Date" := Today;
            PharmHeader."Pharmacy Type" := PharmHeader."Pharmacy Type"::Outpatient;
            PharmHeader.InPatient := PatientDispatch.Inpatient;
            PharmHeader."Global Dimension 1 Code" := PatientDispatch."Global Dimension 1 Code";
            PharmHeader.Validate("Global Dimension 1 Code");
            if PharmHeader.Modify() then
                exit(true);
        end else begin
            PharmHeader.Reset();
            PharmHeader.Init();
            PharmHeader."Pharmacy No." := GetNextPharmacyNo();
            PharmHeader."Pharmacy Date" := Today;
            PharmHeader."Pharmacy Time" := Time;
            PharmHeader."Global Dimension 1 Code" := PatientDispatch."Global Dimension 1 Code";
            PharmHeader.Validate("Global Dimension 1 Code");
            PharmHeader."Pharmacy Type" := PharmHeader."Pharmacy Type"::Outpatient;
            PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
            PharmHeader."Patient No." := PatientDispatch."Patient No.";
            PharmHeader.InPatient := PatientDispatch.Inpatient;
            PharmHeader."Transaction Type" := 'PHARMACY';
            PharmHeader."Link Type" := 'Doctor';
            if TreatmentExists then
                PharmHeader."Link No." := HMSTreatmentFormHeader."Treatment No."
            else
                PharmHeader."Link No." := AppH."Appointment No.";
            if PharmHeader.Insert(true) then
                exit(true);
        end;


    end;

    local procedure GetNextPharmacyNo(): Code[20]
    var
        TbHMSSetup: record "HMS Setup";
        CuNoSeries: Codeunit "No. Series";
        NewNo: Code[20];
    begin

        TbHMSSetup.Reset();
        TbHMSSetup.Get();
        NewNo := CuNoSeries.GetNextNo(TbHMSSetup."Pharmacy Nos", 0D, true);
        exit(NewNo);
    end;
}

