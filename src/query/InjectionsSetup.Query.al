namespace HMISBC.HMISBC;

query 85032 "Injections Setup"
{
    Caption = 'Injections Setup';
    QueryType = Normal;

    elements
    {
        dataitem(HMSSetupInjection; "HMS Setup Injection")
        {
            column(Amount; Amount)
            {
            }
            column("Code"; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column(GLAccount; "G/L Account")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
