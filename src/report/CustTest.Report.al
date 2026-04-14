report 85013 CustTest
{
    ApplicationArea = All;
    Caption = 'Customers List';
    DefaultLayout = RDLC;
    RDLCLayout = 'CustTest2.rdl';
    UsageCategory = Administration;
    WordLayout = 'CustTest2.docx';
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
        }
    }
}