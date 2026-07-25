namespace HMISBC.HMISBC;

query 85022 Counties
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
