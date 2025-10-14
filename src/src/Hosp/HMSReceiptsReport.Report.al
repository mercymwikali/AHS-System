Report 52202590 "HMS Receipts Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ReceiptsReport.rdl';
    UseRequestPage = false;
    dataset
    {
        dataitem("Receipts Header"; "Receipts Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1102755004; 1102755004)
            {
            }
            column(CompInfo; companyInfo.Name)
            {
            }
            column(CompAddr; companyInfo.Address)
            {
            }
            column(companyInfoEmail; companyInfo."E-Mail") { }
            column(companyInfoHomePage; companyInfo."Home Page") { }
            column(CompPhone; companyInfo."Phone No.")
            {
            }
            column(CompFax; companyInfo."Fax No.")
            {
            }
            column(CompPic; companyInfo.Picture)
            {
            }
            column(CompCity; companyInfo.City) { }
            column(companyPostCode; companyInfo."Post Code") { }
            column(HeaderNo; "Receipts Header"."No.")
            {
            }
            column(HeaderDate; "Receipts Header".Date)
            {
            }
            column(PatientNo_ReceiptsHeader; "Receipts Header"."Patient No.")
            {
            }
            column(TimePosted; PostTime)
            {
            }
            column(UserID; "Receipts Header".Cashier)
            {
            }
            column(AcctName; AcctName)
            {
            }
            column(RegNo; RegNo)
            {
            }
            column(RecFrom; "Receipts Header"."Received From")
            {
            }
            column(CheqNo; "Receipts Header"."Cheque No.")
            {
            }
            column(AmountReceived; "Receipts Header"."Amount Recieved")
            {
            }
            column(UserName; UserName)
            {
            }
            column(pic; companyInfo.Picture)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(On_Behalf_Of; "On Behalf Of")
            {
            }
            column(Patient_Appointment_No; "Receipts Header"."Patient Appointment No")
            {
            }
            column(patientName; UpperCase(patientName)) { }
            column(patientAddress; patientAddress) { }
            column(TransactionCode_ReceiptsHeader; "Transaction Code") { }
            column(patientEmail; patientEmail) { }
            column(ReceiptHeader; ReceiptHeader) { }
            column(Split_Amount; "Split Amount") { }
            column(HideSplitLines; HideSplitLines) { }
            column(HideHeaderTransaction; HideHeaderTransaction) { }
            column(PatientBillBalance;PatientBillBalance)
            {
                
            }
            dataitem("Receipt Line q"; "Receipt Line q")
            {
                DataItemLink = No = field("No.");
                column(RecLineNo; "Receipt Line q"."Account No.")
                {
                }
                column(RecLineAcctName; "Receipt Line q"."Account Name")
                {
                }
                column(Amount; "Receipt Line q".Amount)
                {
                }
                column(NumberText_1_; NumberText[1])
                {
                }
                column(PayMode; "Receipt Line q"."Pay Mode")
                {
                }
                column(TRanName; "Receipt Line q"."Transaction Name")
                {
                }
                column(BankCode; "Receipt Line q"."Bank Code")
                {
                }
                column(ChequeDepositSlipNo; "Receipt Line q"."Cheque/Deposit Slip No")
                {
                }
                column(Quantity_ReceiptLineq; Qty)
                {
                }
                column(BillAmount_ReceiptLineq; "Receipt Line q"."Bill Amount")
                {
                }
                column(BillBalance; "Receipt Line q"."Bill Amount" - "Receipt Line q".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //TotalAmount:=TotalAmount+"Receipt Line q".Amount;
                    //CheckReport.InitTextVariable;
                    //CheckReport.FormatNoText(NumberText,TotalAmount,'');

                    Qty := "Receipt Line q".Quantity;

                    if Qty = 0 then begin
                        pharmline.Reset();
                        pharmline.SetRange(pharmline."Patient No", "Receipt Line q"."Patient No");
                        pharmline.SetRange(pharmline."No.", "Receipt Line q".No);
                        if pharmline.Find('-') then
                            Qty := pharmline.Quantity;
                    end;
                end;
            }
            dataitem("Receipt Split"; "Receipt Split")
            {
                DataItemLink = "Receipt No" = field("No.");
                column(ReceiptNo_ReceiptSplit; "Receipt No")
                {
                }
                column(BankAccountNo_ReceiptSplit; "Bank Account No")
                {
                }
                column(TransactionNo_ReceiptSplit; "Transaction No")
                {
                }
                column(ShownOnReport_ReceiptSplit; "Shown On Report")
                {
                }

                column(RecSplitAmount; "Receipt Split".Amount)
                {
                }
                column(RecSplitPayMode; "Receipt Split"."Pay Mode")
                {
                }
                column(RecSplitQty; Qty)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                ReceiptHeader := '';
                TotalAmount := 0;
                HideSplitLines := true;
                HideHeaderTransaction := false;
                PatientBillBalance :=0;

                if "Receipts Header"."Split Amount" then begin
                    HideSplitLines := false;
                    HideHeaderTransaction := true;
                end;


                Clear(UserName);
                usersTable.Reset();
                usersTable.SetRange(usersTable."User Name", "Receipts Header".Cashier);
                if usersTable.Find('-') then begin
                    if usersTable."Full Name" <> '' then
                        UserName := usersTable."Full Name"
                    else
                        UserName := "Receipts Header".Cashier;
                end else
                    UserName := "Receipts Header".Cashier;
                //CheckReport.FormatNoText(NumberText,"Receipts Header"."Amount Recieved",'');

                //CheckReport.InitTextVariable();
                //CheckReport.FormatNoText(NumberText,"Receipts Header"."Amount Recieved",'');

                receiptLine.Reset();
                receiptLine.SetRange(receiptLine.No, "Receipts Header"."No.");
                if receiptLine.Find('-') then
                    repeat
                        TotalAmount := TotalAmount + receiptLine.Amount;
                    until receiptLine.Next() = 0;

                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, TotalAmount, '');

                PostTime := Format("Receipts Header"."Time Posted");

                HMSPatient.Reset();
                HMSPatient.SetRange("Patient No.", "Receipts Header"."Patient No.");
                if HMSPatient.FindFirst() then begin
                    patientName := HMSPatient."Search Name";
                    patientAddress := HMSPatient."Place of Birth Village";
                    patientEmail := HMSPatient.Email;

                    // Receipt Title
                    if HMSPatient.Inpatient then
                        ReceiptHeader := 'INPATIENT CASH RECEIPT'
                    else
                        ReceiptHeader := 'OUTPATIENT CASH RECEIPT';

                    // get the patient bill balance
                    HMSPatientCharges.Reset();
                    HMSPatientCharges.SetRange("Patient No.", HMSPatient."Patient No.");
                    HMSPatientCharges.SetRange("Visit No", "Receipts Header"."Patient Appointment No");
                    if HMSPatientCharges.Find('-') then begin
                        HMSPatientCharges.CalcSums("Total Amount");
                        PatientBillBalance := HMSPatientCharges."Total Amount";
                    end;

                end;

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

    trigger OnPreReport()
    begin
        companyInfo.Reset();
        if companyInfo.Find('-') then
            companyInfo.CalcFields(Picture);
    end;

    var
        companyInfo: Record "Company Information";
        pharmline: Record "HMS Pharmacy Line";
        receiptLine: Record "Receipt Line q";
        HMSPatient: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        usersTable: Record User;
        CheckReport: Report Check;
        RegNo: Code[30];
        Qty: Decimal;
        TotalAmount: Decimal;
        PostTime: Text;
        NumberText: array[2] of Text[120];
        AcctName: Text[150];
        UserName: Text[250];
        patientName: Text[250];
        patientAddress: Text[100];
        patientEmail: Text[100];
        ReceiptHeader: Text;
        HideSplitLines: Boolean;
        HideHeaderTransaction: Boolean;
        PatientBillBalance: Decimal;

}
