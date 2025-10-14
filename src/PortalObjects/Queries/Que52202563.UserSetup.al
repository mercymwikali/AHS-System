namespace HMISBC.HMISBC;

using System.Security.User;

query 52202563 "User Setup List"
{
    Caption = 'User Setup';
    QueryType = Normal;

    elements
    {
        dataitem(UserSetup; "User Setup")
        {
            column(UserID; "User ID")
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}
