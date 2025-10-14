namespace HMISBC.HMISBC;

using Microsoft.Foundation.Address;

query 52202567 Countries
{
    Caption = 'Countries';
    QueryType = Normal;

    elements
    {
        dataitem(CountryRegion; "Country/Region")
        {
            column(AddressFormat; "Address Format")
            {
            }
            column("Code"; "Code")
            {
            }
            column(Name; Name)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
