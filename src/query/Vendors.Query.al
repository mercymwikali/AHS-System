namespace HMISBC.HMISBC;

using Microsoft.Purchases.Vendor;

query 85063 Vendors
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
