namespace HMISBC.HMISBC;

using Microsoft.Bank.BankAccount;

query 85071 "Bank Accounts"
{
    Caption = 'Bank Accounts';
    QueryType = Normal;

    elements
    {
        dataitem(BankAccount; "Bank Account")
        {
            column(Name; Name)
            {
            }
            column(Name2; "Name 2")
            {
            }
            column(No; "No.")
            {
            }
            column(BankType; "Bank Type")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
