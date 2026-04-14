namespace PTL.HMISBC;

query 85000 "Imprest Header"
{
    Caption = 'Imprest Header';
    QueryType = Normal;
    
    elements
    {
        dataitem(ImprestHeader; "Imprest Header")
        {
            column(No; "No.")
            {
            }
            column("Date"; "Date")
            {
            }
            column(Payee; Payee)
            {
            }
            column(OnBehalfOf; "On Behalf Of")
            {
            }
            column(Cashier; Cashier)
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(Status; Status)
            {
            }
            column(CurrentStatus; "Current Status")
            {
            }
            column(PayMode; "Pay Mode")
            {
            }
            column(Purpose; Purpose)
            {
            }
            column(ActualExpenditure; "Actual Expenditure")
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }

            column(imprestTYpe; "imprest TYpe")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
