Report 85042 "Receipts Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ReceiptsSummary.rdl';

    dataset
    {
        dataitem("Receipts Header"; "Receipts Header")
        {
            DataItemTableView = where(Posted = const(true), Reversed = const(false));
            RequestFilterFields = Date, Cashier;
            column(ReportForNavId_1; 1)
            {
            }
            column(No_ReceiptsHeader; "Receipts Header"."No.")
            {
            }
            column(Date_ReceiptsHeader; "Receipts Header".Date)
            {
            }
            column(Cashier_ReceiptsHeader; "Receipts Header".Cashier)
            {
            }
            column(DatePosted_ReceiptsHeader; "Receipts Header"."Date Posted")
            {
            }
            column(TimePosted_ReceiptsHeader; "Receipts Header"."Time Posted")
            {
            }
            column(Posted_ReceiptsHeader; "Receipts Header".Posted)
            {
            }
            column(NoSeries_ReceiptsHeader; "Receipts Header"."No. Series")
            {
            }
            column(BankCode_ReceiptsHeader; "Receipts Header"."Bank Code")
            {
            }
            column(ReceivedFrom_ReceiptsHeader; "Receipts Header"."Received From")
            {
            }
            column(OnBehalfOf_ReceiptsHeader; "Receipts Header"."On Behalf Of")
            {
            }
            column(AmountRecieved_ReceiptsHeader; "Receipts Header"."Amount Recieved")
            {
            }
            column(GlobalDimension1Code_ReceiptsHeader; "Receipts Header"."Global Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_ReceiptsHeader; "Receipts Header"."Shortcut Dimension 2 Code")
            {
            }
            column(CurrencyCode_ReceiptsHeader; "Receipts Header"."Currency Code")
            {
            }
            column(CurrencyFactor_ReceiptsHeader; "Receipts Header"."Currency Factor")
            {
            }
            column(TotalAmount_ReceiptsHeader; "Receipts Header"."Total Amount")
            {
            }
            column(PostedBy_ReceiptsHeader; "Receipts Header"."Posted By")
            {
            }
            column(PrintNo_ReceiptsHeader; "Receipts Header"."Print No.")
            {
            }
            column(Status_ReceiptsHeader; "Receipts Header".Status)
            {
            }
            column(ChequeNo_ReceiptsHeader; "Receipts Header"."Cheque No.")
            {
            }
            column(NoPrinted_ReceiptsHeader; "Receipts Header"."No. Printed")
            {
            }
            column(CreatedBy_ReceiptsHeader; "Receipts Header"."Created By")
            {
            }
            column(CreatedDateTime_ReceiptsHeader; "Receipts Header"."Created Date Time")
            {
            }
            column(RegisterNo_ReceiptsHeader; "Receipts Header"."Register No.")
            {
            }
            column(FromEntryNo_ReceiptsHeader; "Receipts Header"."From Entry No.")
            {
            }
            column(ToEntryNo_ReceiptsHeader; "Receipts Header"."To Entry No.")
            {
            }
            column(DocumentDate_ReceiptsHeader; "Receipts Header"."Document Date")
            {
            }
            column(ResponsibilityCenter_ReceiptsHeader; "Receipts Header"."Responsibility Center")
            {
            }
            column(ShortcutDimension3Code_ReceiptsHeader; "Receipts Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_ReceiptsHeader; "Receipts Header"."Shortcut Dimension 4 Code")
            {
            }
            column(Dim3_ReceiptsHeader; "Receipts Header".Dim3)
            {
            }
            column(Dim4_ReceiptsHeader; "Receipts Header".Dim4)
            {
            }
            column(BankName_ReceiptsHeader; "Receipts Header"."Bank Name")
            {
            }
            column(ReceiptReference_ReceiptsHeader; "Receipts Header"."Receipt Reference")
            {
            }
            column(StaffNumber_ReceiptsHeader; "Receipts Header"."Staff Number")
            {
            }
            column(PatientNo_ReceiptsHeader; "Receipts Header"."Patient No.")
            {
            }
            column(PatientAppointmentNo_ReceiptsHeader; "Receipts Header"."Patient Appointment No")
            {
            }
            column(SurrenderNo_ReceiptsHeader; "Receipts Header"."Surrender No")
            {
            }
            column(ManualRefNumber_ReceiptsHeader; "Receipts Header"."Manual Ref.Number")
            {
            }
            column(ImprestNo_ReceiptsHeader; "Receipts Header"."Imprest No")
            {
            }
            column(ApplicationNo_ReceiptsHeader; "Receipts Header"."Application No")
            {
            }
            column(ApplicantName_ReceiptsHeader; "Receipts Header"."Applicant Name")
            {
            }
            column(PayMode_ReceiptsHeader; "Receipts Header"."Pay Mode Lk")
            {
            }
            column(PharmacyNo_ReceiptsHeader; "Receipts Header"."Pharmacy No")
            {
            }
            column(LaboratoryNo_ReceiptsHeader; "Receipts Header"."Laboratory No")
            {
            }
            column(Cash; Cash)
            {
            }
            column(Mpesa; Mpesa)
            {
            }
            column(Cheque; Cheque)
            {
            }
            column(EFT; EFT)
            {
            }
            column(DepositSlip; "Deposit Slip")
            {
            }
            column(BankersCheque; "Banker's Cheque")
            {
            }
            column(RTGS; RTGS)
            {
            }
            column(CompLogo; CompINf.Picture)
            {
            }

            trigger OnPreDataItem()
            begin
                CompINf.Get();
                CompINf.CalcFields(Picture);

                RecH := "Receipts Header";
                RecH.SetFilter(RecH.Date, "Receipts Header".GetFilter(Date));
                RecH.SetFilter(RecH."Posted By", "Receipts Header".GetFilter("Posted By"));
                RecH.SetFilter(RecH.Posted, '%1', true);
                if RecH.Find('-') then
                    repeat
                        RecH.CalcFields("Pay Mode Lk");
                        if RecH."Pay Mode Lk" = RecH."pay mode lk"::"Banker's Cheque" then
                            "Banker's Cheque" := "Banker's Cheque" + RecH."Amount Recieved";
                        if RecH."Pay Mode Lk" = RecH."pay mode lk"::Cash then
                            Cash := Cash + RecH."Amount Recieved";
                        if RecH."Pay Mode Lk" = RecH."pay mode lk"::MPESA then
                            Mpesa := Mpesa + RecH."Amount Recieved";
                        if RecH."Pay Mode Lk" = RecH."pay mode lk"::Cheque then
                            Cheque := Cheque + RecH."Amount Recieved";
                        if RecH."Pay Mode Lk" = RecH."pay mode lk"::"Deposit Slip" then
                            "Deposit Slip" := "Deposit Slip" + RecH."Amount Recieved";
                        if RecH."Pay Mode Lk" = RecH."pay mode lk"::EFT then
                            EFT := EFT + RecH."Amount Recieved";
                        if RecH."Pay Mode Lk" = RecH."pay mode lk"::RTGS then
                            RTGS := RTGS + RecH."Amount Recieved";
                    until RecH.Next() = 0;
                //ERROR('Test '+FORMAT(RecH."Pay Mode"));
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
        CompINf: Record "Company Information";
        RecH: Record "Receipts Header";
        "Banker's Cheque": Decimal;
        Cash: Decimal;
        Cheque: Decimal;
        "Deposit Slip": Decimal;
        EFT: Decimal;
        Mpesa: Decimal;
        RTGS: Decimal;
}
