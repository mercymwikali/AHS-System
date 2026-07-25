namespace HMISBC.HMISBC;

query 85059 "Treatment Injection Lines"
{
    Caption = 'Treatment Injection Lines';
    QueryType = Normal;
    
    elements
    {
        dataitem(HMSTreatmentFormInjection; "HMS Treatment Form Injection")
        {
            column("Duration"; "Duration")
            {
            }
            column(InjectionGiven; "Injection Given")
            {
            }
            column(InjectionName; "Injection Name")
            {
            }
            column(InjectionNo; "Injection No.")
            {
            }
            column(InjectionQuantity; "Injection Quantity")
            {
            }
            column(InjectionRemarks; "Injection Remarks")
            {
            }
            column(InjectionUnitofMeasure; "Injection Unit of Measure")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(Location; Location)
            {
            }
            column(Posted; Posted)
            {
            }
            column(TreatmentNo; "Treatment No.")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
