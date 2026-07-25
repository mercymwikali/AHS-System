namespace HMISBC.HMISBC;

query 85052 "HMS Observation Dressings"
{
    Caption = 'HMS Observation Dressings';
    QueryType = Normal;

    elements
    {
        dataitem(HMSObservationDressings; "HMS Observation Dressings")
        {
            column(ItemNo; "Item No.")
            {
            }
            column(ObservationNo; "Observation No.")
            {
            }
            column(Posted; Posted)
            {
            }
            column(ProcessNo; "Process No.")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(UnitofMeasure; "Unit of Measure")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
