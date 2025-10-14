Report 52202659 "Interbank Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/InterbankDetails.rdl';

    dataset
    {
        dataitem("InterBank Transfers"; "InterBank Transfers")
        {
            DataItemTableView = sorting(No);
            RequestFilterFields = No;
            column(ReportForNavId_5698; 5698)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(UserId; UserId)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(CompInfo_Address2; CompInfo."Address 2")
            {
            }
            column(CompInfo_Home_Page; CompInfo."Home Page")
            {
            }
            column(CompInfo_EMail; CompInfo."E-Mail")
            {
            }
            column(InterBank_Transfers_Date; Date)
            {
            }
            column(InterBank_Transfers_No; No)
            {
            }
            column(InterBank_Transfers_Status; Status)
            {
            }
            column(InterBank_Transfers__Receipt_Resp_Centre_; "Receipt Resp Centre")
            {
            }
            column(Receiving_Account_______Receiving_Bank_Account_Name_; "Receiving Account" + ':' + "Receiving Bank Account Name")
            {
            }
            column(InterBank_Transfers__Currency_Code_Destination_; "Currency Code Destination")
            {
            }
            column(Remarks_InterBankTransfers; "InterBank Transfers".Remarks)
            {
            }
            column(InterBank_Transfers__Amount_2_; "Amount 2")
            {
            }
            column(InterBank_Transfers__Exch__Rate_Destination_; "Exch. Rate Destination")
            {
            }
            column(InterBank_Transfers__Request_Amt_LCY_; "Request Amt LCY")
            {
            }
            column(InterBank_Transfers__Sending_Resp_Centre_; "Sending Resp Centre")
            {
            }
            column(Paying_Account_______Paying__Bank_Account_Name_; "Paying Account" + ':' + "Paying  Bank Account Name")
            {
            }
            column(InterBank_Transfers__Currency_Code_Source_; "Currency Code Source")
            {
            }
            column(InterBank_Transfers_Amount; Amount)
            {
            }
            column(InterBank_Transfers__Exch__Rate_Source_; "Exch. Rate Source")
            {
            }
            column(InterBank_Transfers__Pay_Amt_LCY_; "Pay Amt LCY")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(Bank_and_Cash_TransferCaption; Bank_and_Cash_TransferCaptionLbl)
            {
            }
            column(InterBank_Transfers_DateCaption; FieldCaption(Date))
            {
            }
            column(InterBank_Transfers_NoCaption; FieldCaption(No))
            {
            }
            column(InterBank_Transfers_StatusCaption; FieldCaption(Status))
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(InterBank_Transfers__Receipt_Resp_Centre_Caption; FieldCaption("Receipt Resp Centre"))
            {
            }
            column(Receiving_BankCaption; Receiving_BankCaptionLbl)
            {
            }
            column(Currency_CodeCaption; Currency_CodeCaptionLbl)
            {
            }
            column(ExternalDocNo; "InterBank Transfers"."External Doc No.")
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(InterBank_Transfers__Exch__Rate_Destination_Caption; FieldCaption("Exch. Rate Destination"))
            {
            }
            column(InterBank_Transfers__Request_Amt_LCY_Caption; FieldCaption("Request Amt LCY"))
            {
            }
            column(InterBank_Transfers__Sending_Resp_Centre_Caption; FieldCaption("Sending Resp Centre"))
            {
            }
            column(Paying_BankCaption; Paying_BankCaptionLbl)
            {
            }
            column(Currency_CodeCaption_Control1102756045; Currency_CodeCaption_Control1102756045Lbl)
            {
            }
            column(InterBank_Transfers_AmountCaption; FieldCaption(Amount))
            {
            }
            column(InterBank_Transfers__Exch__Rate_Source_Caption; FieldCaption("Exch. Rate Source"))
            {
            }
            column(Transferred_Amt_LCYCaption; Transferred_Amt_LCYCaptionLbl)
            {
            }
            column(Request_DetailsCaption; Request_DetailsCaptionLbl)
            {
            }
            column(Source_DetailsCaption; Source_DetailsCaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Name_Caption_Control1102756018; Name_Caption_Control1102756018Lbl)
            {
            }
            column(CreatedBy_InterBankTransfers; "InterBank Transfers"."Created By")
            {
            }
            column(Date_Caption_Control1102756019; Date_Caption_Control1102756019Lbl)
            {
            }
            column(Signature_Caption_Control1102756022; Signature_Caption_Control1102756022Lbl)
            {
            }
            column(AuthorisationsCaption; AuthorisationsCaptionLbl)
            {
            }
            column(AuthorisationsCaption_Control1102756028; AuthorisationsCaption_Control1102756028Lbl)
            {
            }
            column(Signature_Caption_Control1102756031; Signature_Caption_Control1102756031Lbl)
            {
            }
            column(Date_Caption_Control1102756034; Date_Caption_Control1102756034Lbl)
            {
            }
            column(Name_Caption_Control1102756037; Name_Caption_Control1102756037Lbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102756003; EmptyStringCaption_Control1102756003Lbl)
            {
            }
            column(EmptyStringCaption_Control1102756043; EmptyStringCaption_Control1102756043Lbl)
            {
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field(No);
                DataItemTableView = where(Status = const(Approved));
                column(ReportForNavId_1000000006; 1000000006)
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                dataitem("User Setup"; "User Setup")
                {
                    DataItemLink = "User ID" = field("Approver ID");
                    column(ReportForNavId_1000000003; 1000000003)
                    {
                    }
                    column(Signature_UserSetup; "User Setup"."User Signature")
                    {
                    }
                    column(ApprovalDesignation_UserSetup; "User Setup"."Approval Title")
                    {
                    }
                }

                trigger OnPreDataItem()
                begin
                    "Approval Entry".SetRange("Approval Entry".Status, "Approval Entry".Status::Approved)
                end;
            }
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
        if CompInfo.Get() then
            CompInfo.CalcFields(CompInfo.Picture);
    end;

    var
        CompInfo: Record "Company Information";
        AmountCaptionLbl: label 'Amount';
        AuthorisationsCaption_Control1102756028Lbl: label 'Authorisations';
        AuthorisationsCaptionLbl: label 'Authorisations';
        Bank_and_Cash_TransferCaptionLbl: label 'Bank and Cash Transfer';
        Currency_CodeCaption_Control1102756045Lbl: label 'Currency Code';
        Currency_CodeCaptionLbl: label 'Currency Code';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Date_Caption_Control1102756019Lbl: label 'Date:';
        Date_Caption_Control1102756034Lbl: label 'Date:';
        Date_CaptionLbl: label 'Date:';
        EmptyStringCaption_Control1102756003Lbl: label '===============================================================================================================================================';
        EmptyStringCaption_Control1102756043Lbl: label '===============================================================================================================================================';
        EmptyStringCaptionLbl: label '===============================================================================================================================================';
        Name_Caption_Control1102756018Lbl: label 'Name:';
        Name_Caption_Control1102756037Lbl: label 'Name:';
        Name_CaptionLbl: label 'Name:';
        Paying_BankCaptionLbl: label 'Paying Bank';
        Receiving_BankCaptionLbl: label 'Receiving Bank';
        RecipientCaptionLbl: label 'Recipient';
        Request_DetailsCaptionLbl: label 'Request Details';
        Signature_Caption_Control1102756022Lbl: label 'Signature:';
        Signature_Caption_Control1102756031Lbl: label 'Signature:';
        Signature_CaptionLbl: label 'Signature:';
        Source_DetailsCaptionLbl: label 'Source Details';
        Transferred_Amt_LCYCaptionLbl: label 'Transferred Amt LCY';
}
