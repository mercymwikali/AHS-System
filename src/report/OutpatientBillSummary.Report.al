// namespace PTL.Hospital;
// using Microsoft.Foundation.Company;

report 85187 "Outpatient Bill Summary"
{
    ApplicationArea = All;
    Caption = 'Outpatient Bill Summary';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Billing/OutPatientBillSummary.rdl';
    dataset
    {
        dataitem(HMSAppointmentFormHeader; "HMS Appointment Form Header")
        {
            DataItemTableView = where(Status = filter(AppointmentStatusEnum::Completed));
            RequestFilterFields = "Appointment Date", "Patient No.", "Settlement Type";
            column(Visit_No; "Appointment No.")
            {
            }
            column(Date; "Appointment Date")
            {
            }
            column(AppointmentTime; "Appointment Time")
            {
            }
            column(AppointmentType; "Appointment Type")
            {
            }
            column(PatientType; "Patient Type")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(InsuranceNo; "Insurance No")
            {
            }
            column(InsuranceMemberNo; "Insurance Member No")
            {
            }
            column(PatientNames; "Patient Names")
            {
            }
            column(Names; Names)
            {
            }
            column(Branch; Branch)
            {
            }
            column(Visit_Amount; VisitAmount)
            {
            }
            column(Insurance_No; "Insurance No")
            {
            }
            column(Insurance_Name; "Insurance Name")
            {
            }
            column(Patient_No_; "Patient No.")
            {
            }
            column(CompInf; CompInf.Name)
            {
            }
            column(Settlement_Type; "Settlement Type") { }
            column(CompInfLogo; CompInf.Picture)
            {
            }

            column(MpesaAmount; MpesaAmount) { }
            column(PDQAmount; PDQAmount) { }
            column(BankSlipAmount; BankSlipAmount) { }
            column(EFTAmount; EFTAmount) { }
            column(ChequeAmount; ChequeAmount) { }
            column(DiscountAmount; DiscountAmount) { }
            column(BillAmount; BillAmount) { }
            column(CashAmount; CashAmount) { }
            column(ShaAmount; ShaAmount) { }
            column(BankTransferAmount; BankTransferAmount) { }
            column(SchemeName; SchemeName) { }
            column(RTGSAmount; RTGSAmount) { }
            column(VisitType; VisitTypeLbl) { }

            trigger OnAfterGetRecord()
            var
                ReceiptsSeen: List of [Code[150]];
            begin
                MpesaAmount := 0;
                DiscountAmount := 0;
                PDQAmount := 0;
                BankSlipAmount := 0;
                EFTAmount := 0;
                ChequeAmount := 0;
                BillAmount := 0;
                BankTransferAmount := 0;
                CashAmount := 0;
                VisitAmount := 0;
                ShaAmount := 0;
                RTGSAmount := 0;
                VisitTypeLbl := '';
                Clear(ReceiptsSeen);


                HMSPatientCharges2.Reset();
                HMSPatientCharges2.SetRange("Visit No", HMSAppointmentFormHeader."Appointment No.");
                HMSPatientCharges2.SetRange(Posted, true);
                if HMSPatientCharges2.FindSet() then
                    repeat
                        ChargeAmount := 0;

                        // Add Normal Charges + Rebates
                        if HMSPatientCharges2."Transaction Type" <> 'ZRECEIPT' then begin

                            ChargeAmount := HMSPatientCharges2.Amount * HMSPatientCharges2.Quantity;

                            BillAmount := BillAmount + ChargeAmount;
                        end;


                        if HMSPatientCharges2.Code = 'DISCOUNT' then
                            DiscountAmount += HMSPatientCharges2."Total Amount";


                        if HMSPatientCharges2."Transaction Type" = 'ZRECEIPT' then begin
                            if HMSPatientCharges2.Code = 'REBATES' then begin
                                ChargeAmount := HMSPatientCharges2.Amount * HMSPatientCharges2.Quantity;
                                ShaAmount := ChargeAmount;
                            end;

                            if not ReceiptsSeen.Contains(HMSPatientCharges2.Code) then begin
                                ReceiptsSeen.Add(HMSPatientCharges2.Code);

                                ReceiptsHeader.Reset();
                                ReceiptsHeader.SetRange(ReceiptsHeader."No.", HMSPatientCharges2.Code);
                                if ReceiptsHeader.FindFirst() then begin

                                    if ReceiptsHeader."Pay Mode" = ReceiptsHeader."pay mode"::Cash then
                                        CashAmount += ReceiptsHeader."Total Amount";
                                    if ReceiptsHeader."Pay Mode" = ReceiptsHeader."pay mode"::MPESA then
                                        MpesaAmount += ReceiptsHeader."Total Amount";
                                    if ReceiptsHeader."Pay Mode" = ReceiptsHeader."pay mode"::Cheque then
                                        ChequeAmount += ReceiptsHeader."Total Amount";
                                    if ReceiptsHeader."Pay Mode" = ReceiptsHeader."pay mode"::"Deposit Slip" then
                                        BankSlipAmount += ReceiptsHeader."Total Amount";
                                    if ReceiptsHeader."Pay Mode" = ReceiptsHeader."pay mode"::EFT then
                                        EFTAmount += ReceiptsHeader."Total Amount";
                                    if ReceiptsHeader."Pay Mode" = ReceiptsHeader."pay mode"::RTGS then
                                        RTGSAmount += ReceiptsHeader."Total Amount";
                                    if ReceiptsHeader."Pay Mode" = ReceiptsHeader."pay mode"::PDQ then
                                        PDQAmount += ReceiptsHeader."Total Amount";
                                end;
                            end;

                        end;

                    until HMSPatientCharges2.Next() = 0;

                HMSPatientCharges2.Reset();
                HMSPatientCharges2.SetRange("Visit No", HMSAppointmentFormHeader."Appointment No.");
                HMSPatientCharges2.SetRange(Posted, true);
                if HMSPatientCharges2.FindFirst() then begin
                    HMSPatientInsuarance.Reset();
                    HMSPatientInsuarance.SetRange("Insurance No", HMSPatientCharges2."Insurance No");
                    HMSPatientInsuarance.SetRange("Patient No", HMSPatientCharges2."Patient No.");
                    if HMSPatientInsuarance.IsEmpty() then begin
                        HMSPatientIns.Init();
                        HMSPatientIns."Patient No" := HMSPatientCharges2."Patient No.";
                        HMSPatientIns."Insurance No" := HMSPatientCharges2."Insurance No";
                        HMSPatientIns.Validate("Insurance No");

                        HMSPatient.Reset();
                        HMSPatient.SetRange("Patient No.", HMSAppointmentFormHeader."Patient No.");
                        if HMSPatient.FindFirst() then begin
                            if HMSPatient."Insurance No." = HMSPatientCharges2."Insurance No" then begin
                                HMSPatientIns."Member No" := HMSPatient."Membership No";
                                HMSPatientIns."Scheme Name" := HMSPatient."Scheme Name";
                            end
                        end;

                        HMSPatientIns.Insert();
                    end;

                    HMSPatientCharges2.CalcFields("Visit Amount");
                    VisitAmount := HMSPatientCharges2."Visit Amount";

                end;



                HMSPatient.Reset();
                HMSPatient.SetRange("Patient No.", HMSAppointmentFormHeader."Patient No.");
                if HMSPatient.FindFirst() then begin
                    SchemeName := HMSPatient."Scheme Name";
                    InsuranceName := HMSPatient."Insurance Name";
                    PatNames := HMSPatient."Search Name";
                end;

                VisitTypeLbl := 'OP';
            end;

            trigger OnPreDataItem()
            begin
                CompInf.get();
                CompInf.CalcFields(Picture);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        HMSPatient: Record "HMS Patient";
        HMSPatientCharges2: Record "HMS Patient Charges";
        HMSPatientIns: Record "HMS Patient Insuarance";
        HMSPatientInsuarance: Record "HMS Patient Insuarance";
        CompInf: Record "Company Information";
        ReceiptsHeader: Record "Receipts Header";
        // HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
        PatRec: Record "HMS Patient";
        DocRec: Record "HMS Setup Doctor";
        HMSAdmissionDischargeHeader: Record "HMS Admission Discharge Header";
        DocName: text[200];
        PatNames: Text[250];
        MpesaAmount: Decimal;
        PDQAmount: Decimal;
        BankSlipAmount: Decimal;
        BankTransferAmount: Decimal;
        EFTAmount: Decimal;
        RTGSAmount: Decimal;
        ChequeAmount: Decimal;
        DiscountAmount: Decimal;
        BillAmount: Decimal;
        VisitAmount: Decimal;
        CashAmount: Decimal;
        ShaAmount: Decimal;
        SchemeName: Text;
        InsuranceName: Text;
        VisitTypeLbl: Text;
        ChargeAmount: Decimal;
}
