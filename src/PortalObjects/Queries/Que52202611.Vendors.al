namespace HMISBC.HMISBC;

using Microsoft.Purchases.Vendor;

query 52202611 Vendors
{
    Caption = 'Vendors';
    QueryType = Normal;

    elements
    {
        dataitem(Vendor; Vendor)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Blocked; Blocked)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
