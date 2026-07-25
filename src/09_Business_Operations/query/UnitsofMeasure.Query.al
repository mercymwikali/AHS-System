namespace HMISBC.HMISBC;

using Microsoft.Foundation.UOM;

query 85042 "Units of Measure"
{
    Caption = 'Units of Measure';
    QueryType = Normal;

    elements
    {
        dataitem(UnitofMeasure; "Unit of Measure")
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
