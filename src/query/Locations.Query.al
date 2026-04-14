namespace HMISBC.HMISBC;

using Microsoft.Inventory.Location;

query 85041 Locations
{
    Caption = 'Locations';
    QueryType = Normal;

    elements
    {
        dataitem(Location; Location)
        {
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
