Report 52202629 "Final Patient Invoice-NHIF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FinalPatientInvoice.rdl';

    dataset
    {
        dataitem("HMS Patient Charges"; "HMS Patient Charges")
        {
            DataItemTableView = sorting("Patient No.", "Transaction Type", Date) order(ascending) where(Amount = filter(<> 0), Reversed = filter(false), "Receipt Reversed" = filter(false));
            RequestFilterFields = "Patient No.", "Visit No", "Invoice Number";
            CalcFields = "Posted Invoice No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(PatientNo_HMSPatientCharges; "HMS Patient Charges"."Patient No.")
            {
            }
            column(ShortcutDimension1Code_HMSPatientCharges; "HMS Patient Charges"."Shortcut Dimension 1 Code")
            {
            }
            column(TransactionType_HMSPatientCharges; TranType)
            {
            }
            column(Code_HMSPatientCharges; "HMS Patient Charges".Code)
            {
            }
            column(Description_HMSPatientCharges; UpperCase("HMS Patient Charges".Description))
            {
            }
            column(TranDate; "HMS Patient Charges".Date)
            {
            }
            column(Amount_HMSPatientCharges; "HMS Patient Charges".Amount)
            {
            }
            column(Remarks_HMSPatientCharges; "HMS Patient Charges".Remarks)
            {
            }
            column(Qty; Qty)
            {
            }
            column(AmountPaid_HMSPatientCharges; "HMS Patient Charges"."Amount Paid")
            {
            }
            column(ShortcutDimension2Code_HMSPatientCharges; "HMS Patient Charges"."Shortcut Dimension 2 Code")
            {
            }
            column(AppliedAmount_HMSPatientCharges; "HMS Patient Charges"."Applied Amount")
            {
            }
            column(Applyto_HMSPatientCharges; "HMS Patient Charges"."Apply to")
            {
            }
            column(Recognized_HMSPatientCharges; "HMS Patient Charges".Recognized)
            {
            }
            column(Posted_HMSPatientCharges; "HMS Patient Charges".Posted)
            {
            }
            column(PharmacyNo_HMSPatientCharges; "HMS Patient Charges"."Pharmacy No")
            {
            }
            column(Location_HMSPatientCharges; "HMS Patient Charges".Location)
            {
            }
            column(Unit_HMSPatientCharges; "HMS Patient Charges"."Doctors Amount")
            {
            }
            column(RecoveredFirst_HMSPatientCharges; "HMS Patient Charges"."Recovered First")
            {
            }
            column(Transfer_HMSPatientCharges; "HMS Patient Charges".Transfer)
            {
            }
            column(TransferAmount_HMSPatientCharges; "HMS Patient Charges"."Transfer Amount")
            {
            }
            column(Transfered_HMSPatientCharges; "HMS Patient Charges".Transfered)
            {
            }
            column(TransactonID_HMSPatientCharges; "HMS Patient Charges"."Invoice ID")
            {
            }
            column(NoSeries_HMSPatientCharges; "HMS Patient Charges"."No. Series")
            {
            }
            column(FullyPaid_HMSPatientCharges; "HMS Patient Charges"."Fully Paid")
            {
            }
            column(RoomAllocation_HMSPatientCharges; "HMS Patient Charges"."Room Allocation")
            {
            }
            column(Charge_HMSPatientCharges; "HMS Patient Charges".Charge)
            {
            }
            column(Reversed_HMSPatientCharges; "HMS Patient Charges".Reversed)
            {
            }
            column(Distribution_HMSPatientCharges; "HMS Patient Charges".Distribution)
            {
            }
            column(Quantity_HMSPatientCharges; decQuantity)
            {
            }
            column(Course_HMSPatientCharges; "HMS Patient Charges"."Invoice Number")
            {
            }
            column(AppliedPayment_HMSPatientCharges; "HMS Patient Charges"."Applied Payment")
            {
            }
            column(RecoveryPriority_HMSPatientCharges; "HMS Patient Charges"."Recovery Priority")
            {
            }
            column(FullTuitionFee_HMSPatientCharges; "HMS Patient Charges"."Full Tuition Fee")
            {
            }
            column(DistributionAccount_HMSPatientCharges; "HMS Patient Charges"."Distribution Account")
            {
            }
            column(Currency_HMSPatientCharges; "HMS Patient Charges".Currency)
            {
            }
            column(OverCharged_HMSPatientCharges; "HMS Patient Charges"."Over Charged")
            {
            }
            column(OverChargedAmount_HMSPatientCharges; "HMS Patient Charges"."Over Charged Amount")
            {
            }
            column(SystemCreated_HMSPatientCharges; "HMS Patient Charges"."System Created")
            {
            }
            column(ChargeGender_HMSPatientCharges; "HMS Patient Charges"."Charge Gender")
            {
            }
            column(CustomerNo_HMSPatientCharges; "HMS Patient Charges"."Customer No.")
            {
            }
            column(BillSection_HMSPatientCharges; "HMS Patient Charges"."Bill Section")
            {
            }
            column(LineNo_HMSPatientCharges; "HMS Patient Charges"."Line No")
            {
            }
            column(GLAccount_HMSPatientCharges; "HMS Patient Charges"."G/L Account")
            {
            }
            column(TreatmentNo_HMSPatientCharges; "HMS Patient Charges"."Treatment No.")
            {
            }
            column(InvoiceCounter_HMSPatientCharges; "HMS Patient Charges"."Invoice Counter")
            {
            }
            column(ApplicableSection_HMSPatientCharges; "HMS Patient Charges"."Applicable Section")
            {
            }
            column(LinkNo_HMSPatientCharges; "HMS Patient Charges"."Link No")
            {
            }
            column(LinkNoLk_HMSPatientCharges; "HMS Patient Charges"."Link No Lk")
            {
            }
            column(AppointmentNo_HMSPatientCharges; "HMS Patient Charges"."Appointment No.")
            {
            }
            column(PatientTypeLk_HMSPatientCharges; "HMS Patient Charges"."Patient Type Lk")
            {
            }
            column(AppointmentNoLk_HMSPatientCharges; "HMS Patient Charges"."Appointment No Lk")
            {
            }
            column(BillingType_HMSPatientCharges; "HMS Patient Charges"."Billing Type")
            {
            }
            column(BillingStartDate_HMSPatientCharges; "HMS Patient Charges"."Billing Start Date")
            {
            }
            column(BillingEndDate_HMSPatientCharges; "HMS Patient Charges"."Billing End Date")
            {
            }
            column(AdmissionNo_HMSPatientCharges; "HMS Patient Charges"."Admission No")
            {
            }
            column(DoctorID_HMSPatientCharges; "HMS Patient Charges"."Doctor ID")
            {
            }
            column(DimensionSetID_HMSPatientCharges; "HMS Patient Charges"."Dimension Set ID")
            {
            }
            column(NewDimensionSetID_HMSPatientCharges; "HMS Patient Charges"."New Dimension Set ID")
            {
            }
            column(GLAccountNo_HMSPatientCharges; "HMS Patient Charges"."G/L Account No")
            {
            }
            column(DoctorsAmount_HMSPatientCharges; "HMS Patient Charges"."Doctors Amount")
            {
            }
            column(InsuranceAmount_HMSPatientCharges; "HMS Patient Charges"."Insurance Amount")
            {
            }
            column(RunBal; Round(RunBal, 1, '='))
            {
            }
            column(InsNo; HMSPatRec."Insurance No.")
            {
            }
            column(InsName; HMSPatRec."Insurance Name")
            {
            }
            column(MemberNo; HMSPatRec."Membership No")
            {
            }
            column(PMemberName; HMSPatRec."Principal Member Name")
            {
            }
            column(AdmDate; AdmissionDates)
            {
            }
            column(Cashier; Cashier)
            {
            }
            column(dischargeDate; DischargeDates)
            {
            }
            column(Ward; Ward_)
            {
            }
            column(Bed; Beds_)
            {
            }
            column(InvoiceNo; InvoiceNumber)
            {
            }
            column(PatName; HMSPatRec."Search Name")
            {
            }
            column(Balance; HMSPatRec."Bill Balance")
            {
            }
            column(PatientAdress; UpperCase(HMSPatRec."Place of Birth Village"))
            {
            }
            column(InvAmt; Round(InvAmt, 1, '='))
            {
            }
            column(RecAmt; Receipts)
            {
            }
            column(LogoName; CompInf.Picture)
            {
            }
            column(LogoName2; Cust.Image)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(CompInfAddress; CompInf.Address)
            {
            }
            column(CompInfAddress2; CompInf."Address 2")
            {
            }
            column(CompInfPhone; CompInf."Phone No.")
            {
            }
            column(Cemail; CompInf."E-Mail")
            {
            }
            column(chomepage; CompInf."Home Page")
            {
            }
            column(CompanyInfPostCode; Compinf."Post Code")
            {

            }
            column(CompanyCity; UpperCase(Compinf.City))
            {

            }
            column(UserN; UserId)
            {
            }
            column(Amt; Round(Amt, 1, '='))
            {
            }
            column(DocName; UpperCase(DocNM))
            {
            }
            column(UAmt; Round(UAmt, 1, '='))
            {
            }
            column(AdminNo; HMSPatRec."Current Ward")
            {
            }
            column(Names; HMSPatRec."Search Name")
            {
            }
            column(InsurancePaidAmount; "HMS Patient Charges"."Insurance Paid Amount")
            {
            }
            column(InPatient; HMSPatRec.Inpatient) { }
            column(ClaimedTxt; ClaimedTxt)
            {
            }
            column(ClaimedAmount; ClaimedAmount)
            {
            }
            column(Admin_Number; AdminNumber)
            {
            }
            column(Age; Age)
            {
            }
            column(Gender; Gender)
            {
            }
            column(Dr_Name; Dr)
            {
            }
            column(CustLogo; cust.image)
            {
            }
            column(Signature; UserRec.Signature)
            {
            }

            column(hideAdmissionDetails; hideAdmissionDetails)
            {

            }
            column(patientInsuranceName; patientInsuranceName)
            {

            }
            column(patientSchemeName; patientSchemeName)
            {

            }
            column(InvoiceHeaderTXT; InvoiceHeaderTXT)
            {

            }
            column(DoctorCategoryTxt; DoctorCategoryTxt) { }

            trigger OnAfterGetRecord()
            begin
                hideAdmissionDetails := true;
                InvoiceHeaderTXT := '';
                Receipts := 0;
                Cashier := '';
                // patientInsuranceName := 'Social Health Insurance Fund';
                patientSchemeName := '';
                // InvoiceNumber := '';

                if HMSPatRec.Get("HMS Patient Charges"."Patient No.") then begin

                    Age := Date2dmy(Today, 3) - Date2dmy(HMSPatRec."Date Of Birth", 3);
                    Gender := Format(HMSPatRec.Gender);
                    HMSPatRec.SetFilter(HMSPatRec."Appointment No Filter", "HMS Patient Charges"."Appointment No.");
                    HMSPatRec.CalcFields(HMSPatRec."Current Ward");
                    if HMSPatRec.Inpatient = false then
                        "HMS Patient Charges".SetFilter("HMS Patient Charges"."Visit No", GetFilter("Visit No"));
                    HMSPatRec.CalcFields("Bill Balance");
                    HMSPatRec.CalcFields("Invoice Amount");
                    HMSPatRec.CalcFields("Receipt Amount");
                    if Cust.Get(HMSPatRec."Insurance No.") then;

                    /* if Cust."Claimed Amount">0 then begin
                    ClaimedAmount := Cust."Claimed Amount";
                    ClaimedTxt := 'Claimed Amount';
                    end; */


                    /* 
                        ***********Get The Posting User****************
                    */
                    // if PatientCharges."Posted Invoice No." <> '' then begin
                    //     SalesInvoiceHeader.Get(PatientCharges."Posted Invoice No.");
                    //     Cashier := SalesInvoiceHeader."User ID";
                    // end;
                    // /* Get The Full Cashier Name */
                    // if Cashier <> '' then begin
                    //     UserRec.Get(Cashier);
                    //     Cashier := UserRec.UserName;
                    // end;

                end;
                if "HMS Patient Charges".Quantity = 0 then
                    Qty := 1
                else
                    Qty := "HMS Patient Charges".Quantity;
                Amt := 0;
                UAmt := 0;

                if "HMS Patient Charges".InPatient then begin
                    hideAdmissionDetails := false;
                    InvoiceHeaderTXT := 'INPATIENT INVOICE'
                end else
                    InvoiceHeaderTXT := 'OUTPATIENT INVOICE';

                if "HMS Patient Charges".Quantity = 0 then
                    Qty := 1
                else
                    Qty := "HMS Patient Charges".Quantity;

                Amt := "HMS Patient Charges".Amount * Qty;
                UAmt := "HMS Patient Charges".Amount;
                /* 
                    - Since it is a Rebates Invoice only add amounts that are related to the invoice
                 */
                if "HMS Patient Charges".Amount < 0 then
                    ReceiptAmt := ReceiptAmt + "HMS Patient Charges".Amount;

                if "HMS Patient Charges".Amount > 0 then
                    if "HMS Patient Charges"."Insurance Amount" > 0 then begin
                        Amt := Round("HMS Patient Charges".Amount, 1, '=') * Qty;
                    end else begin
                        Amt := Round("HMS Patient Charges".Amount, 1, '=') * Qty;
                        UAmt := Round("HMS Patient Charges".Amount, 1, '=');
                    end;

                if ("HMS Patient Charges"."Transaction Type" <> 'ZRECEIPT') then
                    InvAmt := InvAmt + Amt;


                //Get Receipts
                if Cust.get(HMSPatRec."Insurance No.") then begin
                    patientInsuranceName := Cust.Name;
                    patientSchemeName := HMSPatRec."Scheme Name";
                    if Cust."NHIF Package" = false then begin
                        PatientCharges.Reset();
                        PatientCharges.SetRange(PatientCharges."Patient No.", "Patient No.");
                        PatientCharges.SetFilter(PatientCharges.Amount, '<0');
                        PatientCharges.SetFilter(PatientCharges."Visit No", "HMS Patient Charges"."Visit No");
                        PatientCharges.SetFilter(PatientCharges."Receipt Reversed", '%1', false);
                        PatientCharges.SetFilter(PatientCharges."Transaction Type", '%1', 'ZRECEIPT');
                        // PatientCharges.SetFilter();
                        /*
                        IF "HMS Patient Charges"."Visit No"<>'' THEN
                         PatientCharges.SETRANGE(PatientCharges."Visit No","HMS Patient Charges"."Visit No");
                         */
                        if PatientCharges.Find('-') then
                            repeat
                                Receipts := Receipts + PatientCharges."Total Amount";
                            until PatientCharges.Next() = 0;
                    end;
                end else begin
                    PatientCharges.Reset();
                    PatientCharges.SetRange(PatientCharges."Patient No.", "Patient No.");
                    PatientCharges.SetFilter(PatientCharges.Amount, '<0');
                    PatientCharges.SetFilter(PatientCharges."Visit No", "HMS Patient Charges"."Visit No");
                    PatientCharges.SetFilter(PatientCharges."Receipt Reversed", '%1', false);
                    PatientCharges.SetFilter(PatientCharges."Transaction Type", '%1', 'ZRECEIPT');
                    // PatientCharges.SetFilter();
                    /*
                    IF "HMS Patient Charges"."Visit No"<>'' THEN
                     PatientCharges.SETRANGE(PatientCharges."Visit No","HMS Patient Charges"."Visit No");
                     */
                    if PatientCharges.Find('-') then
                        repeat
                            Receipts := Receipts + PatientCharges."Total Amount";
                        until PatientCharges.Next() = 0;
                end;
                RunBal := RunBal + Amt;
                Bal := RunBal;

                DocNM := '';
                DoctorCategoryTxt := '';

                if DocRec.Get("HMS Patient Charges"."Doctor ID") then begin
                    DoctorCategoryTxt := DocRec.Specialization;
                    DocNM := DocRec."Doctors Name" + ' (' + DocRec.Specialization + ')';
                end;

                if DocNM = '' then begin //REFACTOR: Get the Active Visits Doctor
                    HMSAppointmentFormHeader.Reset();
                    HMSAppointmentFormHeader.SetRange("Appointment No.", "HMS Patient Charges"."Visit No");
                    if HMSAppointmentFormHeader.FindFirst() then begin
                        HMSAppointmentFormHeader.CalcFields("Doctor Name");
                        DocNM := HMSAppointmentFormHeader."Doctor Name";

                        if DocNM <> '' then
                            if DocRec.Get(HMSAppointmentFormHeader.Doctor) then begin
                                DoctorCategoryTxt := DocRec.Specialization;
                                DocNM := DocRec."Doctors Name" + ' (' + DocRec.Specialization + ')';
                            end;
                    end;

                end;

                AdmissionDates := '';
                DischargeDates := '';
                // if HMSPatRec."Admissions Date" <> 0D then
                //     AdmissionDates := Format(HMSPatRec."Admissions Date");

                // get discharge date if discharge requested
                HMSAdmissionDischargeHeader.Reset();
                HMSAdmissionDischargeHeader.SetRange("Admission No.", "HMS Patient Charges"."Visit No");
                if HMSAdmissionDischargeHeader.FindFirst() then
                    if HMSAdmissionDischargeHeader."Discharge Date" <> 0D then begin
                        AdmissionDates := Format(HMSAdmissionDischargeHeader."Date of Admission");
                        DischargeDates := Format(HMSAdmissionDischargeHeader."Discharge Date");
                    end;

                Ward_ := '';

                AdmRec.Reset();
                AdmRec.SetRange(AdmRec."Patient No.", "HMS Patient Charges"."Patient No.");
                AdmRec.SetRange("Admission No.", "HMS Patient Charges"."Visit No");
                // AdmRec.SETRANGE(AdmRec.Status,AdmRec.Status::Admitted);
                if AdmRec.FindLast() then begin
                    AdmRec.CalcFields("Dr Name");
                    Ward_ := 'Ward: ' + AdmRec.Ward;
                    Beds_ := 'Bed: ' + AdmRec.Bed;
                    AdminNumber := AdmRec."Admission No.";
                    Dr := AdmRec."Dr Name";
                    if DocRec.Get(AdmRec.Doctor) then begin
                        DoctorCategoryTxt := DocRec.Specialization;
                        DocNM := DocRec."Doctors Name" + ' (' + DocRec.Specialization + ')';
                    end;
                end;
                // TODO:Get the Doctor Name from admission Header. for inpatient
                HMSPatientCharges.Reset();
                HMSPatientCharges.SetRange("Visit No", "HMS Patient Charges"."Visit No");
                HMSPatientCharges.SetRange("Patient No.", "HMS Patient Charges"."Patient No.");
                HMSPatientCharges.SetRange(Code, 'REBATES');
                if HMSPatientCharges.FindFirst() then begin
                    if HMSPatientCharges."Invoice Number" <> '' then begin
                        InvoiceNumber := HMSPatientCharges."Invoice Number";
                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SetRange("No.", HMSPatientCharges."Invoice Number");
                        if SalesInvoiceHeader.FindFirst() then
                            Cashier := SalesInvoiceHeader."User ID";
                    end;
                    if Cashier <> '' then begin
                        UsersTable.Reset();
                        UsersTable.SetRange("User Name", Cashier);
                        if UsersTable.FindFirst() then
                            Cashier := UsersTable."Full Name";
                    end;
                end;

                if "HMS Patient Charges"."Transaction Type" = 'ZRECEIPT' then begin
                    TranType := 'RECEIPTS';

                    if "HMS Patient Charges".Code = 'REBATES' then begin
                        TransDec := 'SHIF Rebates';
                        TranType := 'REBATES';
                        // Get invoice number

                    end
                    else
                        TransDec := 'Payment Receipt';
                end else begin
                    TranType := "HMS Patient Charges"."Transaction Type";
                    TransDec := "HMS Patient Charges".Description;
                end;

                // Since We are using Hide Insurance Details
            end;

            trigger OnPreDataItem()
            var
                sInv: Record "Sales Invoice Header";
            begin
                CompInf.Get();
                sInv.reset();
                sinv.SetFilter("No.", "HMS Patient Charges".getfilter("Posted Invoice No."));
                if sinv.FindFirst() then
                    if Cust.Get(sinv."Bill-to Customer No.") then begin
                        if Cust.Image.HasValue then
                            // Cust.CalcFields(image)
                            exit
                        else
                            CompInf.CalcFields(Picture);
                    end else
                        CompInf.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInf: Record "Company Information";
        Cust: Record Customer;
        AdmRec: Record "HMS Admission Form Header";
        HMSAdmissionDischargeHeader: Record "HMS Admission Discharge Header";
        HMSPatRec: Record "HMS Patient";
        UserRec: Record "User Setup";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PatientCharges: Record "HMS Patient Charges";
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
        DocRec: Record "HMS Setup Doctor";
        HMSPatientCharges: Record "HMS Patient Charges";
        UsersTable: Record User;
        DoctorCategoryTxt: Text;
        AdminNumber: Code[30];
        TranType: Code[50];
        Amt: Decimal;
        Bal: Decimal;
        ClaimedAmount: Decimal;
        decQuantity: Decimal;
        InvAmt: Decimal;
        Qty: Decimal;
        ReceiptAmt: Decimal;
        patientInsuranceName: Text[250];
        patientSchemeName: Text[250];
        Receipts: Decimal;
        RunBal: Decimal;
        UAmt: Decimal;
        hideAdmissionDetails: Boolean;
        InvoiceHeaderTXT: Text[30];
        Age: Integer;
        AdmissionDates: Text;
        Beds_: Text;
        ClaimedTxt: Text;
        DischargeDates: Text;
        DocNM: Text;
        Dr: Text;
        Gender: Text;
        Ward_: Text;
        TransDec: Text[150];
        Cashier: Text[100];
        InvoiceNumber: Text[30];
}
