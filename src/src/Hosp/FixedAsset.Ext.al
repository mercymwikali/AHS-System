tableextension 52202452 FixedAsset extends "Fixed Asset"
{
    DrillDownPageId = "Fixed Asset List New";
    LookupPageId = "Fixed Asset List New";
    fields
    {
        field(51000; "Book Value"; Decimal)
        {
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("No.")));
            FieldClass = FlowField;
        }
        field(51001; "Dialysis"; Boolean)
        {
        }
    }
}