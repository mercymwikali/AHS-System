Report 85037 "Receipts Disbursment Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ReceiptsDisbursmentSummary.rdl';

    dataset
    {
        dataitem("Receipts Header"; "Receipts Header")
        {
            DataItemTableView = where("Disbursable Amount" = filter(> 0), Posted = const(true));
            RequestFilterFields = Date, "Bank Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_ReceiptsHeader; "Receipts Header"."No.")
            {
            }
            column(Date_ReceiptsHeader; "Receipts Header".Date)
            {
            }
            column(ReceivedFrom_ReceiptsHeader; "Receipts Header"."Received From")
            {
            }
            column(ChequeNo_ReceiptsHeader; "Receipts Header"."Cheque No.")
            {
            }
            column(DisbursableAmount_ReceiptsHeader; "Receipts Header"."Disbursable Amount")
            {
            }
            column(DisbursedAmount_ReceiptsHeader; "Receipts Header"."Disbursed Amount")
            {
            }
            column(Balance; "Receipts Header"."Disbursable Amount" - "Receipts Header"."Disbursed Amount")
            {
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
}
