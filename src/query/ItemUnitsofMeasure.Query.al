namespace HMISBC.HMISBC;

using Microsoft.Inventory.Item;

query 85035 "Item Units of Measure"
{
    Caption = 'Item Units of Measure';
    QueryType = Normal;

    elements
    {
        dataitem(ItemUnitofMeasure; "Item Unit of Measure")
        {
            column("Code"; "Code")
            {
            }
            column(Cubage; Cubage)
            {
            }
            column(Height; Height)
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(Length; Length)
            {
            }
            column(QtyRoundingPrecision; "Qty. Rounding Precision")
            {
            }
            column(QtyperUnitofMeasure; "Qty. per Unit of Measure")
            {
            }
            column(Weight; Weight)
            {
            }
            column(Width; Width)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
