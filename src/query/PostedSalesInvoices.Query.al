namespace PTL.HMISBC;

using Microsoft.Sales.History;

query 85015 "Posted Sales Invoices"
{
    Caption = 'Posted Sales Invoices';
    QueryType = Normal;
    
    elements
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(No; "No.")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(AppointmentNo; "Appointment No")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(PatientName; "Patient Name")
            {
            }
            column(AmountIncludingVAT; "Amount Including VAT")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
