namespace HMISBC.HMISBC;

query 85037 "HMS Signs Setup"
{
    Caption = 'HMS Signs Setup';
    QueryType = Normal;

    elements
    {
        dataitem(HMSSignsSetup; "HMS Signs Setup")
        {
            column(SignCode; "Sign Code")
            {
            }
            column(SignsName; "Signs Name")
            {
            }
            column(System; System)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
