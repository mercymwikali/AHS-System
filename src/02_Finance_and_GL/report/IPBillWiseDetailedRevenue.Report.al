namespace PTL.HMISBC;
using Microsoft.Foundation.Company;
using Microsoft.Sales.Customer;

report 85185 "IP Bill Wise Detailed Revenue"
{
    ApplicationArea = All;
    Caption = 'IP Bill Wise Detailed Revenue';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Billing/IPBillWiseDetailedRevenue.rdl';
    dataset
    {
        dataitem(HMSAdmissionDischargeHeader; "HMS Admission Discharge Header")
        {
            RequestFilterFields = "Discharge Date";
            DataItemTableView = where(Status = filter(Completed));
            column(Visit_No; HMSAdmissionDischargeHeader."Admission No.")
            {
            }
            column(Date; HMSAdmissionDischargeHeader."Discharge Date")
            {
            }
            column(PatientType; "Patient Type")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(InsuranceMemberNo; InsuranceMemberNo)
            {
            }
            column(PatientNames; PatNames)
            {
            }
            column(Branch; EncounterBranch)
            {
            }
            column(Visit_Amount; VisitAmount)
            {
            }
            column(Insurance_Name; InsuranceName)
            {
            }
            column(Patient_No_; "Patient No.")
            {
            }
            column(CompInf; CompInf.Name)
            {
            }
            column(Settlement_Type; SettlementType) { }
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
            column(InsuranceName; InsuranceName) { }

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
                PatNames := '';
                InsuranceMemberNo := '';
                InsuranceName := '';
                Clear(ReceiptsSeen);

                InitdeleteDate := CalcDate('<+1D>', HMSAdmissionDischargeHeader."Discharge Date");

                // HMSPatientCharges2.Reset();
                // HMSPatientCharges2.SetRange("Visit No", HMSAdmissionDischargeHeader."Admission No.");
                // HMSPatientCharges2.SetRange(Posted, false);
                // HMSPatientCharges2.SetRange(Date, InitdeleteDate, Today);
                // if HMSPatientCharges2.FindSet() then
                //     repeat
                //         HMSPatientCharges2.Delete();
                //     until HMSPatientCharges2.Next() = 0;




                HMSPatientCharges2.Reset();
                HMSPatientCharges2.SetRange("Visit No", HMSAdmissionDischargeHeader."Admission No.");
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
                HMSPatientCharges2.SetRange("Visit No", HMSAdmissionDischargeHeader."Admission No.");
                HMSPatientCharges2.SetRange(Posted, true);
                if HMSPatientCharges2.FindFirst() then begin
                    HMSPatientInsuarance.Reset();
                    HMSPatientInsuarance.SetRange("Insurance No", HMSPatientCharges2."Insurance No");
                    HMSPatientInsuarance.SetRange("Patient No", HMSPatientCharges2."Patient No.");
                    if HMSPatientInsuarance.FindFirst() then begin
                        InsuranceName := HMSPatientInsuarance."Insurance Name";
                        InsuranceMemberNo := HMSPatientInsuarance."Member No";
                        SchemeName := HMSPatientInsuarance."Scheme Name";
                    end else begin

                        HMSPatientIns.Init();
                        HMSPatientIns."Patient No" := HMSPatientCharges2."Patient No.";
                        HMSPatientIns."Insurance No" := HMSPatientCharges2."Insurance No";
                        HMSPatientIns.Validate("Insurance No");

                        HMSPatient.Reset();
                        HMSPatient.SetRange("Patient No.", HMSAdmissionDischargeHeader."Patient No.");
                        if HMSPatient.FindFirst() then begin
                            if HMSPatient."Insurance No." = HMSPatientCharges2."Insurance No" then begin
                                HMSPatientIns."Member No" := HMSPatient."Membership No";
                                HMSPatientIns."Scheme Name" := HMSPatient."Scheme Name";
                            end
                        end;

                        HMSPatientIns.Insert();
                    end;

                    HMSPatientCharges2.CalcFields("Visit Amount");

                    EncounterBranch := HMSPatientCharges2."Shortcut Dimension 1 Code";
                    VisitAmount := HMSPatientCharges2."Visit Amount";
                    SettlementType := HMSPatientCharges2."Shortcut Dimension 4 Code";

                    if InsuranceName = '' then begin
                        Customer.Reset();
                        Customer.SetRange("No.", HMSPatientCharges2."Insurance No");
                        if Customer.FindFirst() then
                            InsuranceName := Customer.Name;
                    end;
                end;


                HMSPatient.Reset();
                HMSPatient.SetRange("Patient No.", HMSAdmissionDischargeHeader."Patient No.");
                if HMSPatient.FindFirst() then begin
                    PatNames := HMSPatient."Search Name";
                    if SchemeName = '' then
                        SchemeName := HMSPatient."Scheme Name";
                    if InsuranceMemberNo = '' then
                        InsuranceMemberNo := HMSPatient."Membership No";
                end;
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
        HMSPatientCharges2: Record "HMS Patient Charges";
        CompInf: Record "Company Information";
        ReceiptsHeader: Record "Receipts Header";
        HMSPatient: Record "HMS Patient";
        HMSPatientInsuarance: Record "HMS Patient Insuarance";
        HMSPatientIns: Record "HMS Patient Insuarance";
        Customer: Record Customer;
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
        InitdeleteDate: Date;
        SettlementType: Code[30];
        InsuranceMemberNo: Text;
        EncounterBranch: Text;

}
