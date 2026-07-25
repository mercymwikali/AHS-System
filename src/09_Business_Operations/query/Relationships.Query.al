namespace HMISBC.HMISBC;

using Microsoft.HumanResources.Setup;

query 85025 Relationships
{
    Caption = 'Relationships';
    QueryType = Normal;

    elements
    {
        dataitem(Relative; Relative)
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
