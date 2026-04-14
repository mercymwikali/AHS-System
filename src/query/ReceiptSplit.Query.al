namespace HMISBC.HMISBC;

query 85070 "Receipt Split"
{
    Caption = 'Receipt Split';
    QueryType = Normal;

    elements
    {
        dataitem(ReceiptSplit; "Receipt Split")
        {
            column(Amount; Amount)
            {
            }
            column(BankAccountNo; "Bank Account No")
            {
            }
            column(PayMode; "Pay Mode")
            {
            }
            column(ReceiptNo; "Receipt No")
            {
            }
            column(ShownOnReport; "Shown On Report")
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(TransactionNo; "Transaction No")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
