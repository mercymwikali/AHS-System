namespace PTL.HMISBC;
using Microsoft.Foundation.Company;

report 52202735 "OutPatientBilling"
{
    ApplicationArea = All;
    Caption = 'OutPatientBilling';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Billing/OPBillingSummary.rdl';

    dataset
    {
        dataitem(HMSPatientCharges; "HMS Patient Charges")
        {
            DataItemTableView = where(Posted = filter(true));
            column(Date; Date)
            {
            }
            column(Doctor_ID; "Doctor ID")
            {
            }
            column(Doctors_Posting_No; "Doctors Posting No")
            {
            }
            column(Posted_to_Doctor; "Posted to Doctor")
            {
            }
            column(Visit_Amount; "Visit Amount")
            {
            }
            column(Doctors_Amount; "Doctors Amount")
            {
            }
            column(Total_Amount; "Total Amount")
            {
            }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {
            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Shortcut_Dimension_3_Code; "Shortcut Dimension 3 Code")
            {
            }
            column(Shortcut_Dimension_4_Code; "Shortcut Dimension 4 Code")
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
            column(patientNames; PatNames)
            {
            }
            column(InPatient; InPatient)
            {
            }
            column(Visit_No; "Visit No")
            {
            }
            column(CompInf; CompInf.Name)
            {
            }
            column(CompInfLogo; CompInf.Picture)
            {
            }
            column(DocName; DocName)
            {
            }
            column(Weived; Weived)
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
            column(InsuranceName; InsuranceName) { }
            column(RTGSAmount; RTGSAmount) { }
            column(VisitType; VisitType) { }

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
                ShaAmount := 0;
                RTGSAmount := 0;
                VisitType := '';
                Clear(ReceiptsSeen);


                HMSPatientCharges2.Reset();
                HMSPatientCharges2.SetRange("Visit No", HMSPatientCharges."Visit No");
                HMSPatientCharges2.SetRange(Posted, true);
                if HMSPatientCharges2.FindSet() then
                    repeat
                        ChargeAmount := 0;

                        // Add Normal Charges + Rebates
                        if HMSPatientCharges2."Transaction Type" <> 'ZRECEIPT' then begin

                            ChargeAmount := HMSPatientCharges2.Amount * HMSPatientCharges2.Quantity;

                            BillAmount := BillAmount + ChargeAmount;
                        end;

                        // if HMSPatientCharges.Code = 'Rebates' then

                        if HMSPatientCharges2.Code = 'Discount' then
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

                HMSPatient.Reset();
                HMSPatient.SetRange("Patient No.", HMSPatientCharges."Patient No.");
                if HMSPatient.FindFirst() then begin
                    SchemeName := HMSPatient."Scheme Name";
                    InsuranceName := HMSPatient."Insurance Name";
                    PatNames := HMSPatient."Search Name";
                end;

                HMSAppointmentFormHeader.Reset();
                HMSAppointmentFormHeader.SetRange("Appointment No.", HMSPatientCharges."Visit No");
                if HMSAppointmentFormHeader.FindFirst() then
                    VisitType := 'OP'

                else begin
                    VisitType := 'IP';
                    HMSAdmissionDischargeHeader.Reset();
                    HMSAdmissionDischargeHeader.SetRange("Admission No.", HMSPatientCharges."Visit No");
                    HMSAdmissionDischargeHeader.SetRange(Status, HMSAdmissionDischargeHeader.Status::Completed);
                    // HMSAdmissionDischargeHeader.SetRange("Discharge Date", HMSPatientCharges.Date);
                    if HMSAdmissionDischargeHeader.IsEmpty() then
                        CurrReport.Skip();

                end;

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
        CompInf: Record "Company Information";
        ReceiptsHeader: Record "Receipts Header";
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
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
        CashAmount: Decimal;
        ShaAmount: Decimal;
        SchemeName: Text;
        InsuranceName: Text;
        VisitType: Text;
        ChargeAmount: Decimal;
}
