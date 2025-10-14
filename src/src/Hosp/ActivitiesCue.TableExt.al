tableextension 52202423 ActivitiesCue extends "Activities Cue"
{
    fields
    {
        field(35; "Dispatched Sales Invoices"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line".Amount);
            FieldClass = FlowField;
        }
    }
}