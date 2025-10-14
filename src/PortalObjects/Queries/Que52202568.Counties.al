namespace HMISBC.HMISBC;

query 52202568 Counties
{
    Caption = 'Counties';
    QueryType = Normal;

    elements
    {
        dataitem(ApplicationSetupCounty; "Application Setup County")
        {
            column("Code"; "Code")
            {
            }
            column(Description; Description)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
