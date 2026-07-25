Page 85413 "HMS Posted Discharge header"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "HMS Admission Discharge Header";
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            group(Control1)
            {
                field(AdmissionNo; Rec."Admission No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission No. field.';
                }
                field(DischargeDateTime; Rec."Discharge Date")
                {
                    Caption = 'Discharge Date/Time';
                    ToolTip = 'Specifies the value of the Discharge Date/Time field.';
                }
                field(DischargeTime; Rec."Discharge Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Discharge Time field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Surname; Rec.Surname)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Surname field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(DateofAdmission; Rec."Date of Admission")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date of Admission field.';
                }
                field(TimeOfAdmission; Rec."Time Of Admission")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Time Of Admission field.';
                }
                field(DischargeType; Rec."Discharge Type")
                {
                    ToolTip = 'Specifies the value of the Discharge Type field.';
                }
                field(WardNo; Rec."Ward No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Ward No. field.';
                }
                field(BedNo; Rec."Bed No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bed No. field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                part(Control1102760003; "HMS Discharge Summary Listpart")
                {
                    Caption = 'Clinical Summary';
                    SubPageLink = "Discharge Code" = field("Admission No.");
                    SubPageView = where(Type = filter("Clinical Summary"));
                }
                part(Control3; "HMS Discharge Summary Listpart")
                {
                    Caption = 'Investigations';
                    SubPageLink = "Discharge Code" = field("Admission No.");
                    SubPageView = where(Type = filter(Investigation));
                }
                part(Control5; "HMS Discharge Summary Listpart")
                {
                    Caption = 'Management';
                    SubPageLink = "Discharge Code" = field("Admission No.");
                    SubPageView = where(Type = filter(Management));
                }
                part(Control7; "HMS Discharge Summary Listpart")
                {
                    Caption = 'Recommendation';
                    SubPageLink = "Discharge Code" = field("Admission No.");
                    SubPageView = where(Type = filter(Recommendation));
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Discharge)
            {
                Caption = '&Discharge';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the &Discharge action.';

                trigger OnAction()
        var
            HMSEncounterMgmt: Codeunit "HMS Encounter Management";
                RecRef: RecordRef;
                begin
                    if Confirm('Discharge Patient?', false) = false then
                        exit;
                    Lines.Reset();
                    Lines.SetRange(Lines."Admission No.", Rec."Admission No.");
                    if Lines.Find('-') then
                        repeat
                            Lines.CalcFields(Lines.Mandatory);
                            blnMand := Lines.Mandatory;
                            if blnMand <> Lines.Done then
                                Message('Please ensure that the Mandatory processes are finished first');
                        until Lines.Next() = 0;
                    if Patient.Get(Rec."Patient No.") then begin
                        Patient."Discharge Date" := Today;
                        Patient.Inpatient := false;
                        Patient."Discharged Type" := Rec."Discharge Type";
                        RecRef.SetTable(Patient);
                        HMSEncounterMgmt.ModifyRecord(RecRef);
                    end;

                    Admission.Reset();
                    if Admission.Get(Rec."Admission No.") then begin
                        Admission.Status := Admission.Status::Discharged;
                        RecRef.SetTable(Admission);
                        HMSEncounterMgmt.ModifyRecord(RecRef);
                        Rec."Discharge Date" := Today;
                        Rec."Discharge Time" := DT2Time(System.CurrentDateTime);
                        Rec.Status := Rec.Status::Completed;

                        RecRef.SetTable(Rec);
                        HMSEncounterMgmt.ModifyRecord(RecRef);
                    end;
                end;
            }
            action(CancelDischarge)
            {
                Caption = '&Cancel Discharge';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the &Cancel Discharge action.';
                trigger OnAction()
                var
                    AdmH: Record "HMS Admission Form Header";
                    PatRec: Record "HMS Patient";
                    HMSEncounterMgmt: Codeunit "HMS Encounter Management";
                        RecRef: RecordRef;
                begin
                    if Confirm('Do you really want to cancel discharge?', false) then begin
                        if patrec.get(Rec."Patient No.") then begin
                            PatRec.Activated := true;
                            PatRec.Inpatient := true;
                            RecRef.SetTable(PatRec);
                            HMSEncounterMgmt.ModifyRecord(RecRef);
                        end;
                        if AdmH.get(Rec."Admission No.") then begin
                            AdmH.Status := AdmH.Status::Admitted;
                            RecRef.SetTable(AdmH);
                            HMSEncounterMgmt.ModifyRecord(RecRef);
                        end;
                        RecRef.SetTable(Rec);
                        HMSEncounterMgmt.DeleteRecord(RecRef);
                    end;
                end;
            }
            separator(Action9)
            {
            }
            action("Create Splitting Invoince No")
            {
                Image = SplitChecks;
                Visible = false;
                ToolTip = 'Executes the Create Splitting Invoince No action.';
                trigger OnAction()
                var
                    HMSAPP: Record "HMS Appointment Form Header";
                    NoSeriesMgt: Codeunit "No. Series";
                    HMSEncounterMgmt: Codeunit "HMS Encounter Management";
                        RecRef: RecordRef;
                    NewNo: code[20];
                begin
                    if Patients.Get(Rec."Patient No.") then begin
                        NewNo := NoSeriesMgt.GetNextNo('APSP', 0D, true);
                        HmsAPP.Init();
                        HmsAPP."Appointment No." := NewNo;
                        HmsAPP."Appointment Date" := Today;
                        HmsAPP."Appointment Time" := Time;
                        HmsAPP."Appointment Type" := 'SPLIT INVOICE';
                        HmsAPP."Patient No." := Rec."Patient No.";
                        HmsAPP.Doctor := '';
                        HmsAPP.Validate("Patient No.");
                        HmsAPP."Settlement Type" := HmsAPP."Settlement Type"::Insurance;
                        HmsAPP."Patient Type" := HmsAPP."Patient Type"::Corporate;
                        HmsAPP."User ID" := UserId;
                        HmsAPP.Status := HmsAPP.Status::Rescheduled;
                        HmsAPP."No. Series" := 'APSP';
                        HmsAPP."Dispatch To" := HmsAPP."Dispatch To";
                        HmsAPP."Insurance No" := Patients."Insurance No.";
                        HmsAPP."Insurance Member No" := Patients."Membership No";
                        HmsAPP.Gender := Patients.Gender;
                        RecRef.SetTable(HmsAPP);
                        HMSEncounterMgmt.InsertRecord(RecRef);
                    end;

                    HmsAPP.Reset();
                    HmsAPP.SetRange(HmsAPP."Appointment No.", NewNo);
                    if HmsAPP.Find('-') then
                        PAGE.Run(51964, HmsAPP);
                end;
            }
            action("PatientCharges")
            {
                Caption = 'Patient Charges';
                Image = SuggestFinancialCharge;
                RunObject = page "HMS Patient Charges List";
                RunPageLink = "Patient No." = field("Patient No.");
                Visible = false;
                ToolTip = 'Executes the Patient Charges action.';
            }
            action("Post Consumables")
            {
                Caption = 'Post Consumable';
                Image = Calculate;
                RunObject = page "HMS Admission Form Drug";
                RunPageLink = "Admission No." = field("Admission No.");
                Visible = false;
                ToolTip = 'Executes the Post Consumable action.';
            }
            action("Posted Consumables")
            {
                Caption = 'Posted Consumables';
                Image = Calculate;
                RunObject = page "HMS Posted Admission Form Drug";
                RunPageLink = "Admission No." = field("Admission No.");
                visible = false;
                ToolTip = 'Executes the Posted Consumables action.';
            }
            action("Allocate NHIF Rebates")
            {
                Image = Allocations;
                visible = false;
                ToolTip = 'Executes the Allocate NHIF Rebates action.';
                trigger OnAction()
                begin
                    Patients.Reset();
                    Patients.SetFilter(Patients."Patient No.", Rec."Patient No.");
                    if Patients.Find('-') then
                        Report.Run(Report::"HMS NHIF Rebates Calculations", true, true, Patients);
                end;
            }
            action("Allocate Discount")
            {
                Image = Allocate;
                visible = false;
                ToolTip = 'Executes the Allocate Discount action.';
                trigger OnAction()
                begin
                    Patients.Reset();
                    Patients.SetFilter(Patients."Patient No.", Rec."Patient No.");
                    if Patients.Find('-') then
                        Report.Run(70134702, true, true, Patients);
                end;
            }
            action("Generate Insurance Invoice")
            {
                Image = Invoice;
                visible = false;
                ToolTip = 'Executes the Generate Insurance Invoice action.';
                trigger OnAction()
                begin
                    if HMSPat.Get(Rec."Patient No.") then begin

                        HMSPatientCharges.Reset();
                        HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                        HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", HMSPat."Active Visit No");
                        if HMSPatientCharges.Find('-') then
                            Report.Run(51932, true, true, HMSPatientCharges);
                    end;
                    //HMS.GenerateInvoice("Patient No.");
                end;
            }
            separator(Action13)
            {
            }
            action("Create Debtor Account")
            {
                Image = AddAction;
                visible = false;
                ToolTip = 'Executes the Create Debtor Account action.';
                trigger OnAction()
        var
            HMSEncounterMgmt: Codeunit "HMS Encounter Management";
                RecRef: RecordRef;
                begin
                    if HMSPat.Get(Rec."Patient No.") then
                        if HMSPat."Patient Type" = HMSPat."patient type"::Cash then begin
                            Cust.Init();
                            Cust."No." := HMSPat."Patient No.";
                            Cust.Name := HMSPat.Surname + ' ' + HMSPat."Middle Name" + ' ' + HMSPat."Last Name";
                            Cust."Customer Posting Group" := 'CASH DEBTO';
                            Cust."Gen. Bus. Posting Group" := 'LOCAL';
                            RecRef.SetTable(Cust);
                            HMSEncounterMgmt.InsertRecord(RecRef);

                            objPatientCharges.Reset();
                            objPatientCharges.SetRange(objPatientCharges."Patient No.", Rec."Patient No.");
                            objPatientCharges.SetRange(objPatientCharges."Visit No", HMSPat."Active Visit No");
                            // objPatientCharges.SETRANGE(objPatientCharges.Posted,FALSE);
                            if objPatientCharges.Find('-') then
                                repeat
                                    objPatientCharges."Insurance No" := HMSPat."Patient No.";
                                    objPatientCharges."Insurance Amount" := objPatientCharges.Amount;
                                    objPatientCharges."Own Debtor" := true;
                                    RecRef.SetTable(objPatientCharges);
                                    HMSEncounterMgmt.ModifyRecord(RecRef);
                                until objPatientCharges.Next() = 0;
                            HMSPat."Patient Type" := HMSPat."patient type"::Corporate;
                            HMSPat."Insurance No." := HMSPat."Patient No.";
                            RecRef.SetTable(HMSPat);
                            HMSEncounterMgmt.ModifyRecord(RecRef);
                            Message('Debtor Account created successfuly');
                        end;
                end;
            }
            separator(Action22)
            {
            }
            action("Post Discharge")
            {
                Image = ReleaseDoc;
                ToolTip = 'Executes the Post Discharge action.';

                trigger OnAction()
        var
            HMSEncounterMgmt: Codeunit "HMS Encounter Management";
                RecRef: RecordRef;
                begin
                    if Confirm('Do you really want to discharge the selected patient?', false) then begin
                        if HMSPat.Get(Rec."Patient No.") then begin
                            // HMSPat.SETFILTER(HMSPAT.
                            HMSPat.CalcFields(HMSPat."Invoice Amount");
                            HMSPat.CalcFields(HMSPat."Receipt Amount");
                            HMSPat.CalcFields(HMSPat."Visit Invoice No");
                            HMSPat.CalcFields(HMSPat."Bill Balance");
                            HMSPat.CalcFields(HMSPat.Balance);
                            mBillBal := HMSPat."Bill Balance";

                            if (HMSPat."Visit Invoice No" = '') and (HMSPat."Patient Type" = HMSPat."patient type"::Corporate) and (mBillBal > 0) then
                                Error('Please note that you can not clear a Patient with open bills, Either raise the invoice or clear the bill');

                            if (mBillBal > 0) and (HMSPat."Patient Type" = HMSPat."patient type"::Cash) then
                                Error('Please note that you can not clear a Patient with open bills, Either raise the invoice or clear the bill');
                        end;

                        HMS.CloseBill(Rec."Patient No.");

                        if HMSPat.Get(Rec."Patient No.") then begin
                            HMSPat.Inpatient := false;
                            HMSPat."Discharge Date" := Today;
                            HMSPat."Discharged Type" := Rec."Discharge Type";
                            HMSPat.Activated := false;
                            RecRef.SetTable(HMSPat);
                            HMSEncounterMgmt.ModifyRecord(RecRef);
                        end;
                        HMSBeds.Reset();
                        HMSBeds.SetRange(HMSBeds."Bed No", Rec."Bed No.");
                        if HMSBeds.Find('-') then begin
                            HMSBeds.Occupied := false;
                            RecRef.SetTable(HMSBeds);
                            HMSEncounterMgmt.ModifyRecord(RecRef);
                        end;
                        Admission.Reset();
                        Admission.SetRange(Admission."Admission No.", Rec."Admission No.");
                        if Admission.Find('-') then begin
                            Admission.Status := Admission.Status::Discharged;
                            RecRef.SetTable(Admission);
                            HMSEncounterMgmt.ModifyRecord(RecRef);
                        end;

                        Rec.Status := Rec.Status::Completed;
                        Rec."Discharge Date" := Today;
                        Rec."Discharge Time" := Time;
                        Rec."Discharged By" := UserId;
                        HMSSetup.Get();
                        SecurityCode := NoSeriesManagement.GetNextNo(HMSSetup."Security Nos", Today, true);
                        Rec."Security Code" := SecurityCode;
                        RecRef.SetTable(Rec);
                        HMSEncounterMgmt.ModifyRecord(RecRef);
                    end;
                    HMSAdmissionDischargeHeader.Reset();
                    HMSAdmissionDischargeHeader.SetRange(HMSAdmissionDischargeHeader."Admission No.", Rec."Admission No.");
                    HMSAdmissionDischargeHeader.SetRange(HMSAdmissionDischargeHeader."Security Code", SecurityCode);
                    if HMSAdmissionDischargeHeader.Find('-') then
                        Report.Run(70134984, false, false, HMSAdmissionDischargeHeader);
                    //CurrPage.CLOSE;
                end;
            }
            separator(Action12)
            {
            }
            action("Release Bed")
            {
                Image = ReleaseDoc;
                ToolTip = 'Executes the Release Bed action.';

                trigger OnAction()
        var
            HMSEncounterMgmt: Codeunit "HMS Encounter Management";
                RecRef: RecordRef;
                begin
                    if Confirm('Do you really want to Release the selected Bed?', false) then begin
                        HMSBeds.Reset();
                        HMSBeds.SetRange(HMSBeds."Bed No", Rec."Bed No.");
                        HMSBeds.SetRange("Ward No", Rec."Ward No.");
                        if HMSBeds.Find('-') then begin
                            HMSBeds.Occupied := false;
                            RecRef.SetTable(HMSBeds);
                            HMSEncounterMgmt.ModifyRecord(RecRef);
                            if Patient.Get(Rec."Patient No.") then begin
                                Patient.Activated := false;
                                RecRef.SetTable(Patient);
                                HMSEncounterMgmt.ModifyRecord(RecRef);
                            end;
                        end;
                    end;
                end;
            }
            separator(Action24)
            {
            }
            action("Generate NHIF Cash Rebates Invoice")
            {
                Caption = 'Generate NHIF Cash Rebates Invoice';
                Image = Invoice;
                ToolTip = 'Executes the Generate NHIF Cash Rebates Invoice action.';

                trigger OnAction()
                begin
                    if HMSPat.Get(Rec."Patient No.") then
                        if HMSPat."Patient Type" = HMSPat."patient type"::Cash then begin
                            HMSPatientCharges.Reset();
                            HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                            HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", HMSPat."Active Visit No");
                            HMSPatientCharges.SetFilter(HMSPatientCharges."Cash Rebates Posted", '%1', false);
                            HMSPatientCharges.SetFilter(HMSPatientCharges.Code, 'REBATES');
                            if HMSPatientCharges.Find('-') then begin
                                HMSPatientCharges.TestField(HMSPatientCharges."Insurance No");
                                HMS.GenerateNHIF_Rebates_Invoice(HMSPatientCharges."Patient No.", HMSPatientCharges."Visit No", HMSPatientCharges."Insurance No");
                            end;
                        end;
                    CurrPage.Update();
                    //HMS.GenerateInvoice("Patient No.");
                end;
            }
        }
    }

    var
        HMSEncounterMgmt: Codeunit "HMS Encounter Management";
        RecRef: RecordRef;
        Cust: Record Customer;
        HMSAdmissionDischargeHeader: Record "HMS Admission Discharge Header";
        Lines: Record "HMS Admission Discharge Line";
        Admission: Record "HMS Admission Form Header";
        HMSBeds: Record "HMS Beds";
        HMSPat: Record "HMS Patient";
        Patient: Record "HMS Patient";
        Patients: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        objPatientCharges: Record "HMS Patient Charges";
        HMSPatIns: Record "HMS Patient Insuarance";
        HMSSetup: Record "HMS Setup";
        Doctor: Record "HMS Setup Doctor";
        User: Record "User Setup";
        HMS: Codeunit "HMS Patient-integration";
        NoSeriesManagement: Codeunit "No. Series";
        blnMand: Boolean;
        SecurityCode: Code[20];
        mBillBal: Decimal;
        DoctorName: Text[200];
        NurseName: Text[200];
        PatientName: Text[200];

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Doctor.Reset();
        DoctorName := '';
        if Doctor.Get(Rec."Doctor ID") then begin
            Doctor.CalcFields(Doctor."Doctors Name");
            DoctorName := Doctor."Doctors Name";
        end;
        User.Reset();
        NurseName := '';
        if User.Get(Rec."Nurse ID") then;
        // NurseName:=User.Name;
        Patient.Reset();
        PatientName := '';
        if Patient.Get(Rec."Patient No.") then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    local procedure GenerateInvoice()
    var
        Patients: Record "HMS Patient";
        PatientCharges: Record "HMS Patient Charges";
        SalesSetup: Record "Sales & Receivables Setup";
        SaleH: Record "Sales Header";
        SLine: Record "Sales Line";
        NoSeriesMgt: Codeunit "No. Series";
        HMSEncounterMgmt: Codeunit "HMS Encounter Management";
            RecRef: RecordRef;
        NewNo: Code[20];
        LineNo: Integer;
    begin

        // Generate Default insurance invoice
        Patients.Get(Rec."Patient No.");
        Patients.TestField(Patients."Insurance No.");
        SalesSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(SalesSetup."Invoice Nos.", 0D, true);

        SaleH.Init();
        SaleH."Document Type" := SaleH."document type"::Invoice;
        SaleH."No." := NewNo;
        SaleH."Sell-to Customer No." := Patients."Insurance No.";
        SaleH."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
        SaleH."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
        SaleH."Patient No." := Rec."Patient No.";
        RecRef.SetTable(SaleH);
        HMSEncounterMgmt.InsertRecord(RecRef);

        if SaleH.Get(SaleH."document type"::Invoice, NewNo) then begin

            SaleH.Validate("Sell-to Customer No.");
            SaleH.Validate("Shortcut Dimension 1 Code");
            SaleH.Validate("Shortcut Dimension 2 Code");

            SLine.Reset();
            SLine.SetRange("Document No.", SaleH."No.");
            if SLine.Find('-') then
                RecRef.SetTable(SLine);
                HMSEncounterMgmt.DeleteAllRecords(RecRef);

            if SLine.FindLast() then
                LineNo := SLine."Line No." + 1;

            PatientCharges.Reset();
            PatientCharges.SetRange(PatientCharges."Patient No.", Rec."Patient No.");
            PatientCharges.SetRange(PatientCharges."Insurance No", Patients."Insurance No.");
            PatientCharges.SetRange(PatientCharges.Posted, false);
            if PatientCharges.Find('-') then
                repeat
                    if PatientCharges.Amount > 0 then begin
                        SLine.Init();
                        SLine."Line No." := LineNo;
                        SLine."Document No." := SaleH."No.";
                        SLine."Document Type" := SaleH."Document Type";
                        SLine."Sell-to Customer No." := Patients."Insurance No.";
                        SLine.Type := SLine.Type::"G/L Account";
                        PatientCharges.CalcFields("G/L Account");
                        SLine."No." := PatientCharges."G/L Account";
                        SLine.Description := PatientCharges.Description;
                        if PatientCharges.Quantity > 0 then
                            SLine.Quantity := PatientCharges.Quantity
                        else
                            SLine.Quantity := 1;
                        SLine.Validate(SLine.Quantity);
                        SLine."Unit Price" := PatientCharges.Amount;
                        if PatientCharges."Insurance Amount" > 0 then begin
                            SLine.Amount := PatientCharges."Insurance Amount";
                            SLine."Unit Price" := PatientCharges."Insurance Amount";
                        end else begin
                            SLine.Amount := PatientCharges.Amount;
                            SLine."Unit Price" := PatientCharges.Amount;
                        end;

                        SLine.Validate("Unit Price");
                        SLine."Gen. Bus. Posting Group" := 'LOCAL';
                        SLine."Gen. Prod. Posting Group" := 'SERVICES';
                        SLine."Charge Code" := PatientCharges.Code;
                        SLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                        SLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                        RecRef.SetTable(SLine);
                        HMSEncounterMgmt.InsertRecord(RecRef);
                        LineNo := LineNo + 1;

                        PatientCharges."Invoice Number" := SaleH."No.";
                        PatientCharges.Posted := true;
                        RecRef.SetTable(PatientCharges);
                        HMSEncounterMgmt.ModifyRecord(RecRef);
                    end;
                until PatientCharges.Next() = 0;
            // Generate Other Insurance Invoices
            HMSPatIns.Reset();
            HMSPatIns.SetRange(HMSPatIns."Patient No", Rec."Patient No.");
            HMSPatIns.SetFilter(HMSPatIns."Open Invoices", '>%1', 0);
            if HMSPatIns.Find('-') then
                repeat
                    if HMSPatIns."Insurance No" <> Patients."Insurance No." then begin
                        NewNo := NoSeriesMgt.GetNextNo(SalesSetup."Invoice Nos.", 0D, true);
                        SaleH.Init();
                        SaleH."Document Type" := SaleH."document type"::Invoice;
                        SaleH."No." := NewNo;
                        SaleH."Sell-to Customer No." := HMSPatIns."Insurance No";
                        SaleH."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                        SaleH."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                        SaleH."Patient No." := Rec."Patient No.";
                        RecRef.SetTable(SaleH);
                        HMSEncounterMgmt.InsertRecord(RecRef);
                        if SaleH.Get(SaleH."document type"::Invoice, NewNo) then begin
                            SaleH.Validate("Sell-to Customer No.");
                            SaleH.Validate("Shortcut Dimension 1 Code");
                            SaleH.Validate("Shortcut Dimension 2 Code");
                            SLine.Reset();
                            SLine.SetRange("Document No.", SaleH."No.");
                            if SLine.Find('-') then
                                RecRef.SetTable(SLine);
                                HMSEncounterMgmt.DeleteAllRecords(RecRef);
                        end;
                        if SLine.FindLast() then
                            LineNo := SLine."Line No." + 1;
                        PatientCharges.Reset();
                        PatientCharges.SetRange(PatientCharges."Patient No.", Rec."Patient No.");
                        PatientCharges.SetRange(PatientCharges."Insurance No", HMSPatIns."Insurance No");
                        PatientCharges.SetRange(PatientCharges.Posted, false);
                        if PatientCharges.Find('-') then
                            repeat
                                if PatientCharges.Amount > 0 then begin
                                    SLine.Init();
                                    SLine."Line No." := LineNo;
                                    SLine."Document No." := NewNo;
                                    SLine."Document Type" := SaleH."Document Type";
                                    SLine."Sell-to Customer No." := HMSPatIns."Insurance No";
                                    SLine.Type := SLine.Type::"G/L Account";
                                    PatientCharges.CalcFields("G/L Account");
                                    SLine."No." := PatientCharges."G/L Account";
                                    SLine.Description := PatientCharges.Description;
                                    SLine.Quantity := 1;
                                    SLine.Validate(SLine.Quantity);

                                    if PatientCharges."Insurance Amount" > 0 then begin
                                        SLine.Amount := PatientCharges."Insurance Amount";
                                        SLine."Unit Price" := PatientCharges."Insurance Amount";
                                    end else begin
                                        SLine.Amount := PatientCharges.Amount;
                                        SLine."Unit Price" := PatientCharges.Amount;
                                    end;
                                    SLine.Validate("Unit Price");
                                    SLine."Gen. Bus. Posting Group" := 'LOCAL';
                                    SLine."Gen. Prod. Posting Group" := 'SERVICES';
                                    SLine."Charge Code" := PatientCharges.Code;
                                    SLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                                    SLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                                    RecRef.SetTable(SLine);
                                    HMSEncounterMgmt.InsertRecord(RecRef);
                                    LineNo := LineNo + 1;

                                    PatientCharges."Invoice Number" := NewNo;
                                    PatientCharges.Posted := true;
                                    RecRef.SetTable(PatientCharges);
                                    HMSEncounterMgmt.ModifyRecord(RecRef);
                                end;
                            until PatientCharges.Next() = 0;
                    end;
                until HMSPatIns.Next() = 0;

            Message('Invoice No ' + NewNo + ' has been successfuly created');
        end;
    end;
}


