page 52202669 "HMS Active Patient OutPatients"
{
    // CardPageID = "HMS Patients Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMS Patient";
    SourceTableView = WHERE(Activated = FILTER(true),
                            Inpatient = FILTER(false),
                            Blocked = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Active Appointment date"; "Current Appointment date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Registered"; "Date Registered")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Branch; "Global Dimension 1 Code")
                {
                    Caption = 'Branch';
                    ApplicationArea = Basic, Suite;
                }
                field("Current Special Clinics"; "Current Special Clinics")
                {
                    Caption = 'Special Clinics';
                    ApplicationArea = Basic, Suite;
                }
                field("Patient Type"; "Patient Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Patient No."; "Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID Number"; "ID Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance Name"; "Insurance Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Membership No"; "Membership No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Receipt Amount"; "Receipt Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bill Balance"; "Bill Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Invoice Amount"; "Invoice Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance No."; "Insurance No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Correspondence Address 1"; "Correspondence Address 1")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Correspondence Address 2"; "Correspondence Address 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Correspondence Address 3"; "Correspondence Address 3")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Telephone No. 1"; "Telephone No. 1")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Telephone No. 2"; "Telephone No. 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Email; Email)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Patient Current Location"; "Patient Current Location")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Refresh Active Patients")
            {
                Image = Refresh;
                Promoted = true;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                begin
                    Patients.Reset;
                    Patients.SetRange(Inpatient, false);
                    Patients.SetRange(Activated, true);
                    if Patients.Find('-') then begin
                        repeat
                            Patients.CalcFields("Bill Balance");
                            Patients.CalcFields(Patients."Last Appointment Date");
                            if Today > Patients."Last Appointment Date" then begin
                                if Patients."Bill Balance" < 1 then begin
                                    Patients.Activated := false;
                                    Patients.Modify;
                                end;
                            end;
                            HMSPatientCharges.SetRange(HMSPatientCharges."Visit No", Patients."Active Visit No");
                            if HMSPatientCharges.Find('-') then
                                HMSPatientCharges.CalcFields(HMSPatientCharges."Posted Invoice No.");
                            if HMSPatientCharges."Posted Invoice No." <> '' then begin

                                Patients.Activated := false;
                                Patients.Modify;
                            end;
                        until Patients.Next = 0;
                    end;
                    CurrPage.Update;
                end;
            }
            action(Receipt)
            {
                Caption = 'Generate Receipt';
                Image = Receipt;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    HMS: Codeunit "HMS Patient-integration";
                begin
                    HMS.CreateReceipt("Patient No.", "Active Visit No");
                end;
            }
            action(Charges)
            {
                Caption = 'Charges';
                Image = Invoice;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                RunObject = Page "HMS Patient Charges List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
            }
            action("Posted Charges")
            {
                Caption = 'Posted Charges';
                Image = Invoice;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                RunObject = Page "HMS Patient ClosedCharges List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
            }
            action("&Print Invoive")
            {
                Caption = '&Print Invoive';
                Image = PrintDocument;
                Promoted = true;
                ApplicationArea = Basic, Suite;
            }
            action("Print Discharge")
            {
                //Caption = 'Generate Receipt';
                Image = Discount;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    HMSTherapyFormHeader: Record "HMS Therapy Form Header";
                    HMSDoc: Record "HMS Treatment Form Header";
                    HMS: Codeunit "HMS Patient-integration";
                begin
                    if
                    HmsAPP.Get(Rec."Active Visit No") then begin
                        HMSDoc.Reset();
                        HMSDoc.SetRange(HMSDoc."Link No.", Rec."Active Visit No");
                        if HMSDoc.FindFirst() then begin
                            HMSTherapyFormHeader.Reset();
                            HMSTherapyFormHeader.SetRange(HMSTherapyFormHeader."Treatment No.", HMSDoc."Treatment No.");
                            if HMSTherapyFormHeader.Find('-') then
                                Report.RunModal(Report::"HMS Discharge Summary Dialysis", true, false, HMSTherapyFormHeader);
                        end;
                    end

                end;
            }
            action(Prescriptions)
            {
                Image = ProdBOMMatrixPerVersion;
                Caption = 'Consumables';
                RunObject = Page "HMS Admission Form Drug";
                RunPageLink = "Admission No." = FIELD("Current Adm No");
            }
            action(PostedPrescriptions)
            {
                Caption = 'Posted Consumables';
                Image = PostedDeposit;
                RunObject = Page "HMS Posted Admission Form Drug";
                RunPageLink = "Admission No." = FIELD("Current Adm No");
            }
            action("Create Splitting Invoince No")
            {
                Image = SplitChecks;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                begin
                    if Patients.Get("Patient No.") then begin
                        NewNo := NoSeriesMgt.GetNextNo('APSP', 0D, true);
                        HmsAPP.Init;
                        HmsAPP."Appointment No." := NewNo;
                        HmsAPP."Appointment Date" := Today;
                        HmsAPP."Appointment Time" := Time;
                        HmsAPP."Appointment Type" := 'SPLIT INVOICE';
                        HmsAPP."Patient No." := "Patient No.";
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
                        HmsAPP.Insert;
                    end;

                    HmsAPP.Reset;
                    HmsAPP.SetRange(HmsAPP."Appointment No.", NewNo);
                    if HmsAPP.Find('-') then
                        PAGE.Run(Page::"HMS Appointment Form Header", HmsAPP);
                end;
            }
            separator(Separator26)
            {
            }
            action("Charges Weiver")
            {
                Image = Discount;
                Caption = 'Charges Weiver/Discount';
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Patient Charges Weiver";
                RunPageLink = "Patient No" = FIELD("Patient No.");
            }
            separator(Separator28)
            {
            }
            action("Calculate Reccuring Charges")
            {
                Image = Calculate;
                ApplicationArea = Basic, Suite;
                Visible = false;
                trigger OnAction()
                begin
                    HMSPatientCharges.Reset;
                    HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", "Patient No.");
                    HMSPatientCharges.SetRange(HMSPatientCharges."Billing Type", HMSPatientCharges."Billing Type"::Reccuring);
                    HMSPatientCharges.SetCurrentKey(HMSPatientCharges."Patient No.", HMSPatientCharges."Billing Type", HMSPatientCharges."Reccuring Type", HMSPatientCharges.Date, HMSPatientCharges."Creation Time");
                    HMSPatientCharges.Ascending := false;
                    if HMSPatientCharges.Find('-') then begin
                        LastBillDate := HMSPatientCharges.Date;
                        Ln := HMSPatientCharges."Line No";
                        repeat
                            if HMSPatientCharges."Reccuring Type" = HMSPatientCharges."Reccuring Type"::Daily then begin
                                if Today <> LastBillDate then begin
                                    BillDays := Today - LastBillDate;
                                    for i := 1 to BillDays do begin
                                        Ln := Ln + 1;
                                        LastBillDate := LastBillDate + 1;
                                        HMSPatientCharges1.Init;
                                        HMSPatientCharges1."Line No" := Ln;
                                        HMSPatientCharges1."Patient No." := "Patient No.";
                                        HMSPatientCharges1."Link No" := HMSPatientCharges."Link No";
                                        HMSPatientCharges1."Treatment No." := HMSPatientCharges."Treatment No.";
                                        HMSPatientCharges1."Shortcut Dimension 1 Code" := HMSPatientCharges."Shortcut Dimension 1 Code";
                                        HMSPatientCharges1."Transaction Type" := HMSPatientCharges."Transaction Type";
                                        HMSPatientCharges1.Code := HMSPatientCharges.Code;
                                        HMSPatientCharges1.Description := HMSPatientCharges.Description;
                                        HMSPatientCharges1.Amount := HMSPatientCharges.Amount;
                                        HMSPatientCharges1.Date := LastBillDate;
                                        HMSPatientCharges1."Billing Type" := HMSPatientCharges."Billing Type";
                                        HMSPatientCharges1.Quantity := 1;
                                        HMSPatientCharges1.Insert;
                                    end;
                                end;
                            end;
                            if HMSPatientCharges."Reccuring Type" = HMSPatientCharges."Reccuring Type"::Hourly then begin
                                if Today >= LastBillDate then begin
                                    BillDays := Today - LastBillDate;
                                    for i := 1 to BillDays do begin
                                        Ln := Ln + 1;
                                        LastBillDate := LastBillDate + 1;
                                        HMSPatientCharges1.Init;
                                        HMSPatientCharges1."Line No" := Ln;
                                        HMSPatientCharges1.Quantity := 1;
                                        HMSPatientCharges1."Patient No." := "Patient No.";
                                        HMSPatientCharges1."Link No" := HMSPatientCharges."Link No";
                                        HMSPatientCharges1."Treatment No." := HMSPatientCharges."Treatment No.";
                                        HMSPatientCharges1."Shortcut Dimension 1 Code" := HMSPatientCharges."Shortcut Dimension 1 Code";
                                        HMSPatientCharges1."Transaction Type" := HMSPatientCharges."Transaction Type";
                                        HMSPatientCharges1.Code := HMSPatientCharges.Code;
                                        HMSPatientCharges1.Description := HMSPatientCharges.Description;
                                        if Today <> LastBillDate then
                                            HMSPatientCharges1.Quantity := 24
                                        else
                                            HMSPatientCharges1.Quantity := (Time - HMSPatientCharges."Creation Time");
                                        HMSPatientCharges1.Amount := HMSPatientCharges.Amount * HMSPatientCharges1.Quantity;
                                        HMSPatientCharges1.Date := LastBillDate;
                                        HMSPatientCharges1."Billing Type" := HMSPatientCharges."Billing Type";
                                        HMSPatientCharges1.Insert;
                                    end;
                                end;
                            end;
                        until HMSPatientCharges.Next = 0;
                    end;
                    Message('Completed Successfully');
                end;
            }
            separator(Separator33)
            {
            }
            action("Allocate NHIF Rebates")
            {
                Image = Allocate;
                ApplicationArea = Basic, Suite;
                Visible = false;
                trigger OnAction()
                begin
                    Patients.Reset;
                    Patients.SetFilter(Patients."Patient No.", "Patient No.");
                    if Patients.Find('-') then
                        REPORT.Run(Report::"HMS NHIF Rebates Calculations", true, true, Patients);
                end;
            }
            action("Allocate Discount")
            {
                Image = Allocate;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                begin
                    Patients.Reset;
                    Patients.SetFilter(Patients."Patient No.", "Patient No.");
                    if Patients.Find('-') then
                        REPORT.Run(Report::"HMS Discounts Calculations", true, true, Patients);
                end;
            }
            action("Allocate to Other Insurance")
            {
                Image = Allocate;
                ApplicationArea = Basic, Suite;
                Visible = false;
                trigger OnAction()
                begin
                    Patients.Reset;
                    Patients.SetFilter(Patients."Patient No.", "Patient No.");
                    if Patients.Find('-') then
                        REPORT.Run(70134703, true, true, Patients);
                end;
            }
            action("Generate Insurance Invoice")
            {
                Image = Invoice;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    HMSCU: Codeunit "HMS Patient-integration";
                begin

                    TestField("Active Visit No");
                    TestField("Insurance No.");

                    HMSPatientCharges.Reset;
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", "Patient No.");
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", "Active Visit No");
                    //HMSPatientCharges.SETRANGE(HMSPatientCharges.Posted, FALSE);
                    if HMSPatientCharges.Find('-') then
                        REPORT.Run(Report::"HMS Generate Patient Invoice", true, true, HMSPatientCharges);
                    //HMS.GenerateInvoice("Patient No.");
                    HMSPatientCharges.Reset;
                    HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", "Patient No.");
                    //HMSPatientCharges.SETRANGE(HMSPatientCharges."Visit No","Active Visit No");
                    HMSPatientCharges.SetRange(HMSPatientCharges."Invoice Number", '');
                    if HMSPatientCharges.Find('-') then begin
                        Activated := true;
                        // Modify;
                    end else begin
                        //Activated := false;
                        // Modify;
                    end;

                end;
            }
            action("Generate Debtor Invoice")
            {
                Image = Invoice;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    HMSCU: Codeunit "HMS Patient-integration";
                begin

                    TestField("Active Visit No");
                    TestField("Debtor Account");

                    HMSPatientCharges.Reset;
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", "Patient No.");
                    //HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", "Active Visit No");
                    HMSPatientCharges.SETRANGE(HMSPatientCharges."Own Debtor", true);
                    if HMSPatientCharges.Find('-') then
                        REPORT.Run(Report::"Generate Invoice Debtor", true, true, HMSPatientCharges);
                    //HMS.GenerateInvoice("Patient No.");
                    HMSPatientCharges.Reset;
                    HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", "Patient No.");
                    //HMSPatientCharges.SETRANGE(HMSPatientCharges."Visit No","Active Visit No");
                    HMSPatientCharges.SetRange(HMSPatientCharges."Invoice Number", '');
                    if HMSPatientCharges.Find('-') then begin
                        Activated := true;
                        // Modify;
                    end else begin
                        //Activated := false;
                        // Modify;
                    end;

                end;
            }
            separator(Separator30)
            {
            }
            action("Other Patient Insuarance")
            {
                Image = InsertTravelFee;
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Patient Insurance";
                RunPageLink = "Patient No" = FIELD("Patient No.");
            }
            separator(Separator9)
            {
            }
            action("Create Debtor Account")
            {
                ApplicationArea = Basic, Suite;
                Image = AddAction;

                trigger OnAction()
                var
                    Cust: Record Customer;
                    HMSPat: Record "HMS Patient";
                    objPatientCharges: Record "HMS Patient Charges";
                begin
                    if HMSPat.Get("Patient No.") then begin
                        //if HMSPat."Patient Type" = HMSPat."patient type"::Cash then begin
                        if not Cust.get(HMSPat."Patient No.") then begin
                            Cust.Init;
                            Cust."No." := HMSPat."Patient No.";
                            Cust.Name := HMSPat.Surname + ' ' + HMSPat."Middle Name" + ' ' + HMSPat."Last Name";
                            Cust."Customer Posting Group" := 'CASH DEBTO';
                            Cust."Gen. Bus. Posting Group" := 'LOCAL';
                            Cust.Insert;
                        end;

                        objPatientCharges.Reset;
                        objPatientCharges.SetRange(objPatientCharges."Patient No.", "Patient No.");
                        objPatientCharges.SetRange(objPatientCharges."Visit No", HMSPat."Active Visit No");
                        // objPatientCharges.SETRANGE(objPatientCharges.Posted,FALSE);
                        if objPatientCharges.Find('-') then begin
                            repeat
                            // objPatientCharges."Insurance No" := HMSPat."Patient No.";
                            // objPatientCharges."Insurance Amount" := objPatientCharges.Amount;
                            // objPatientCharges."Own Debtor" := true;
                            //objPatientCharges.Modify;
                            until objPatientCharges.Next = 0;
                        end;
                        HMSPat."Patient Type" := HMSPat."patient type"::Corporate;
                        HMSPat."Debtor Account" := HMSPat."Patient No.";
                        HMSPat.Modify;
                        Message('Debtor Account created successfuly');
                        //end;
                    end;//else
                        //  Error('You can only create debtor account for c');
                end;
            }
            action(CreateDirectAdmission)
            {
                Caption = 'Dispatch to Admission (Direct)';
                Image = SetPriorities;
                ApplicationArea = Basic, Suite;
                Visible = false;
                trigger OnAction()
                begin

                    //TESTFIELD("Settlement Type");
                    //TESTFIELD("Patient Type");

                    if Inpatient = true then Error('the patient is in the wards currently no need to re-admit');


                    if Confirm('Send the admission request?', false) = false then begin exit end;
                    /*
                    //---Insert into Treatment Table---------------------------------------------------------------------
                        HMSSetup.RESET;
                        HMSSetup.GET();
                        NewNo:=NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos",0D,TRUE);
                        IF "Settlement Type"="Settlement Type"::Insurance THEN BEGIN
                          TESTFIELD("Insurance Member No");
                          docHeader.INIT;
                          docHeader."Treatment No.":=NewNo;
                          docHeader."Treatment Date":=TODAY;
                          docHeader."Treatment Time":=TIME;
                          docHeader."Doctor ID":=Doctor;
                          docHeader."Treatment Type":=docHeader."Treatment Type"::Inpatient;
                          docHeader."Patient No.":="Patient No.";
                          docHeader.Direct:=TRUE;
                          docHeader."Link No.":="Appointment No.";
                          //:=LabHeader."Request Area"::Doctor;
                          docHeader."Link Type":='InPatient';
                    //      docHeader."Link No.":=TreatmentHeader."Appointment No.";
                          docHeader.INSERT;
                      END;
                    
                      IF AppType.GET("Appointment Type") THEN BEGIN
                        //DoctorsRec.GET(Doctor);
                        DoctorsRec.RESET;
                        DoctorsRec.SETRANGE(DoctorsRec."Doctor ID",Doctor);
                       IF DoctorsRec.FIND('-') THEN
                        DoctorsRec.TESTFIELD("Consultation Code");
                         HMSPatientsCharges.INIT;
                         //HMSPatientsCharges."Line No":=1;
                         HMSPatientsCharges."Transaction Type":='ADMISSION';
                         HMSPatientsCharges.VALIDATE("Transaction Type");
                         HMSPatientsCharges."Patient No."   :="Patient No.";
                         HMSPatientsCharges."Link No":=NewNo;
                         HMSPatientsCharges."Treatment No.":=NewNo;
                         HMSPatientsCharges."Appointment No.":="Appointment No.";
                         HMSPatientsCharges.Code:='ADMISSION FEE';
                         HMSPatientsCharges.Description:=DoctorsRec."Consultation Code";
                         //HMSCharges.GET(DoctorsRec."Consultation Code");
                         HMSPatientsCharges.Amount:=HMSCharges.Amount;
                         HMSPatientsCharges.VALIDATE(Amount);
                         HMSPatientsCharges.Date:=TODAY;
                         HMSPatientsCharges."Shortcut Dimension 1 Code":= HMSCharges."Shortcut Dimension 1 Code";
                         HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                         HMSPatientsCharges."Bill Section":=HMSPatientsCharges."Bill Section"::Appointment;
                         HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                         HMSPatientsCharges."User ID" := USERID;
                         HMSPatientsCharges."Creation Date" := TODAY;
                         HMSPatientsCharges."Creation Time" := TIME;
                    
                         //HMSPatientsCharges."Visit No" := PatientCU.vi
                        IF PatRec.GET("Patient No.") THEN BEGIN
                         HMSPatientsCharges."Admission No" := PatRec."Adm No.";
                         HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
                        END;
                    
                        HMSPatientsCharges.INSERT;
                      END;
                    
                    
                    
                      "Dispatch To":="Dispatch To";
                      "Dispatch Date":=TODAY;
                      "Dispatch Time":=TIME;
                      "User ID":=USERID;
                      Status:=Status::Dispatched;
                      "Link No":=NewNo;
                      MODIFY;
                    //--------------------------------------------------------------------------
                    */

                    HMSSetup.Reset;
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Admission Request Nos", 0D, true);

                    begin

                        AdmissionHeader.Reset;
                        AdmissionHeader.Init;
                        AdmissionHeader."Admission No." := NewNo;
                        AdmissionHeader."Admission Date" := Today;
                        AdmissionHeader."Admission Time" := Time;
                        AdmissionHeader."Admission Area" := AdmissionHeader."Admission Area"::Referral;
                        AdmissionHeader."Patient No." := "Patient No.";
                        //AdmissionHeader.Doctor:= Doctor;
                        AdmissionHeader.Remarks := 'Out Patient to Inpatient';
                        AdmissionHeader."Admission Reason" := 'Direct Admission';
                        AdmissionHeader."Link Type" := 'Direct Admission';
                        AdmissionHeader."Link No." := "Active Visit No";
                        AdmissionHeader.Insert();
                    end;

                    PatientCU.AssignCurrentAdmNo("Patient No.", NewNo);

                    PAGE.Run(Page::"HMS Admission Form Header", AdmissionHeader);

                end;
            }
        }
        area(reporting)
        {
            separator(Separator8)
            {
            }
            action("&Print Interim Invoice")
            {
                Caption = '&Print Interim Invoice';
                Image = PrintDocument;
                Promoted = true;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                begin
                    HMSPatientCharges.Reset;
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", "Patient No.");
                    HMSPatientCharges.SetFilter(HMSPatientCharges."Visit No", "Active Visit No");
                    if HMSPatientCharges.Find('-') then
                        REPORT.Run(Report::"HMS Patient Invoice", true, true, HMSPatientCharges);
                end;
            }
        }

    }
    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        if UserRec.get(Database.UserId) then begin
            if userrec."Branch Code" <> '' then
                setfilter("Global Dimension 1 Code", UserRec."Branch Code");
        end;
    end;

    var
        AdmissionHeader: Record "HMS Admission Form Header";
        HmsAPP: Record "HMS Appointment Form Header";
        HMSPatientCharges1: Record "HMS Patient Charges";
        HMSPatientCharges: Record "HMS Patient Charges";
        HMSPatIns: Record "HMS Patient Insuarance";
        HMSSetup: Record "HMS Setup";
        PatientCharges: Record "HMS Patient Charges";
        Patients: Record "HMS Patient";
        HMS: Codeunit "GLBudget-Open";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PatientCU: Codeunit "HMS Patient-integration";
        NewNo: Code[20];
        LastBillDate: Date;
        BillDays: Integer;
        i: Integer;
        Ln: Integer;

    local procedure GenerateInvoice()
    var
        HMSSetup: Record "HMS Setup";
        PatientCharges: Record "HMS Patient Charges";
        Patients: Record "HMS Patient";
        PharmLine: Record "HMS Pharmacy Line";
        SaleH: Record "Sales Header";
        SalesSetup: Record "Sales & Receivables Setup";
        SLine: Record "Sales Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        LineNo: Integer;
    begin

        // Generate Default insurance invoice
        if "Patient Type" = "Patient Type"::Corporate then begin
            Patients.Get("Patient No.");
            Patients.TestField(Patients."Insurance No.");
            SalesSetup.Get;
            NewNo := NoSeriesMgt.GetNextNo(SalesSetup."Invoice Nos.", 0D, true);

            SaleH.Init;
            SaleH."Document Type" := SaleH."Document Type"::Invoice;
            SaleH."No." := NewNo;
            SaleH."Sell-to Customer No." := Patients."Insurance No.";
            SaleH."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
            SaleH."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
            SaleH."Patient No." := "Patient No.";
            SaleH.Insert;

            if SaleH.Get(SaleH."Document Type"::Invoice, NewNo) then begin

                SaleH.Validate("Sell-to Customer No.");
                SaleH.Validate("Shortcut Dimension 1 Code");
                SaleH.Validate("Shortcut Dimension 2 Code");

                SLine.Reset;
                SLine.SetRange("Document No.", SaleH."No.");
                if SLine.Find('-') then SLine.DeleteAll;

                if SLine.FindLast() then LineNo := SLine."Line No." + 1;

                PatientCharges.Reset;
                PatientCharges.SetRange(PatientCharges."Patient No.", "Patient No.");
                PatientCharges.SetRange(PatientCharges."Insurance No", Patients."Insurance No.");
                PatientCharges.SetRange(PatientCharges.Posted, false);
                if PatientCharges.Find('-') then begin
                    repeat
                        if PatientCharges.Amount > 0 then begin
                            SLine.Init;
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
                            /*
                            IF PatientCharges."Transaction Type"='CO-PAY' THEN
                            SLine.Description:='CO-PAY Amount';
                            IF ( PatientCharges."Transaction Type"<>'CO-PAY') AND (SLine.Amount<0) THEN
                            SLine.Amount:=0;
                            */
                            SLine.Insert;
                            LineNo := LineNo + 1;

                            PatientCharges."Invoice Number" := SaleH."No.";
                            PatientCharges.Posted := true;
                            PatientCharges.Modify;
                        end;
                    until PatientCharges.Next = 0;
                end;
            end;
            // Generate Other Insurance Invoices
            HMSPatIns.Reset;
            HMSPatIns.SetRange(HMSPatIns."Patient No", "Patient No.");
            HMSPatIns.SetFilter(HMSPatIns."Open Invoices", '>%1', 0);
            if HMSPatIns.Find('-') then begin
                repeat
                    if HMSPatIns."Insurance No" <> Patients."Insurance No." then begin
                        NewNo := NoSeriesMgt.GetNextNo(SalesSetup."Invoice Nos.", 0D, true);
                        SaleH.Init;
                        SaleH."Document Type" := SaleH."Document Type"::Invoice;
                        SaleH."No." := NewNo;
                        SaleH."Sell-to Customer No." := HMSPatIns."Insurance No";
                        SaleH."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                        SaleH."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                        SaleH."Patient No." := "Patient No.";
                        SaleH.Insert;
                        if SaleH.Get(SaleH."Document Type"::Invoice, NewNo) then begin
                            SaleH.Validate("Sell-to Customer No.");
                            SaleH.Validate("Shortcut Dimension 1 Code");
                            SaleH.Validate("Shortcut Dimension 2 Code");
                            SLine.Reset;
                            SLine.SetRange("Document No.", SaleH."No.");
                            if SLine.Find('-') then SLine.DeleteAll;
                        end;
                        if SLine.FindLast() then LineNo := SLine."Line No." + 1;
                        PatientCharges.Reset;
                        PatientCharges.SetRange(PatientCharges."Patient No.", "Patient No.");
                        PatientCharges.SetRange(PatientCharges."Insurance No", HMSPatIns."Insurance No");
                        PatientCharges.SetRange(PatientCharges.Posted, false);
                        if PatientCharges.Find('-') then begin
                            repeat
                                if PatientCharges.Amount <> 0 then begin
                                    SLine.Init;
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
                                    if PatientCharges.Code = 'REBATES' then begin
                                        SLine.Amount := PatientCharges.Amount * -1;
                                        SLine."Unit Price" := PatientCharges.Amount * -1;
                                    end;
                                    SLine.Validate("Unit Price");
                                    SLine."Gen. Bus. Posting Group" := 'LOCAL';
                                    SLine."Gen. Prod. Posting Group" := 'SERVICES';
                                    SLine."Charge Code" := PatientCharges.Code;
                                    SLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                                    SLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";

                                    if SLine.Amount > 0 then
                                        SLine.Insert;
                                    LineNo := LineNo + 1;

                                    PatientCharges."Invoice Number" := NewNo;
                                    PatientCharges.Posted := true;
                                    PatientCharges.Modify;
                                end;
                            until PatientCharges.Next = 0;
                        end;
                    end;
                until HMSPatIns.Next = 0;
            end;

            Message('Invoice No ' + NewNo + ' has been successfuly created');
        end;

    end;
}

