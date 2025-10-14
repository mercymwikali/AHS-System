namespace HMISBC.HMISBC;

query 52202577 "Injection Lines"
{
    Caption = 'Injection Lines';
    QueryType = Normal;

    elements
    {
        dataitem(HMSObservationFormInjection; "HMS Observation Form Injection")
        {
            column(InjectionDate; "Injection Date")
            {
            }
            column(InjectionNo; "Injection No.")
            {
            }
            column(InjectionRemarks; "Injection Remarks")
            {
            }
            column(InjectionTime; "Injection Time")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(ItemUnitOfMeasure; "Item Unit Of Measure")
            {
            }
            column(Location; Location)
            {
            }
            column(ObservationNo; "Observation No.")
            {
            }
            column(Posted; Posted)
            {
            }
            column(Quantity; Quantity)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
