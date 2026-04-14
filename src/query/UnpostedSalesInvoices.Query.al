namespace PTL.HMISBC;

using Microsoft.Sales.Document;

query 85074 "Unposted Sales Invoices"
{
    Caption = 'Unposted Sales Invoices';
    QueryType = Normal;
    
    elements
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(No; "No.")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(AppointmentNo; "Appointment No")
            {
            }
            column(AmountIncludingVAT; "Amount Including VAT")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
