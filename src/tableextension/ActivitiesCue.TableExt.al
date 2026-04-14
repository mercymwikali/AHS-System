tableextension 85019 ActivitiesCue extends "Activities Cue"
{
    fields
    {
        field(50100; "Dispatched Sales Invoices"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line".Amount);
            FieldClass = FlowField;
        }
    }
}