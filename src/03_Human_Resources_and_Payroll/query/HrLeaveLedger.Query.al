namespace PTL.HMISBC;

query 85108 "Hr Leave Ledger"
{
    Caption = 'Hr Leave Ledger';
    QueryType = Normal;
    
    elements
    {
        dataitem(HRLeaveLedger; "HR Leave Ledger")
        {
            column(EmployeeNo; "Employee No")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(DocumentNo; "Document No")
            {
            }
            column(LeaveType; "Leave Type")
            {
            }
            column(TransactionDate; "Transaction Date")
            {
            }
            column("TransactionType"; "Transaction Type")
            {
            }
            column(NoofDays; "No. of Days")
            {
            }
            column(TransactionDescription; "Transaction Description")
            {
            }
            column(LeavePeriod; "Leave Period")
            {
            }
            column(EntryType; "Entry Type")
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(ReversedBy; "Reversed By")
            {
            }
            column(CalendarCode; "Calendar Code")
            {
            }
            column(Closed; Closed)
            {
            }
            column(PostingSource; "Posting Source")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
