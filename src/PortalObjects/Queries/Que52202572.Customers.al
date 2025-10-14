namespace HMISBC.HMISBC;

using Microsoft.Sales.Customer;

query 52202572 Customers
{
    Caption = 'Customers';
    QueryType = Normal;

    elements
    {
        dataitem(Customer; Customer)
        {
            column(AccountType; "Account Type")
            {
            }
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Name2; "Name 2")
            {
            }
            column(SearchName; "Search Name")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
