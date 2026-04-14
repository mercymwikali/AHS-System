namespace PTL.Hospital;

query 85082 "Receipt Split List"
{
    Caption = 'Receipt Split List';
    QueryType = Normal;
    
    elements
    {
        dataitem(ReceiptSplit; "Receipt Split")
        {
            column(ReceiptNo; "Receipt No")
            {
            }
            column(PayMode; "Pay Mode")
            {
            }
            column(Amount; Amount)
            {
            }
            column(BankAccountNo; "Bank Account No")
            {
            }
            column(TransactionNo; "Transaction No")
            {
            }
            column(ShownOnReport; "Shown On Report")
            {
            }
            column(SystemId; SystemId)
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
