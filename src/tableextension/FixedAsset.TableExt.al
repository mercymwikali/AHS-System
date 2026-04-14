tableextension 85020 FixedAsset extends "Fixed Asset"
{
    DrillDownPageId = "Fixed Asset List New";
    LookupPageId = "Fixed Asset List New";
    fields
    {
        field(50100; "Book Value"; Decimal)
        {
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50101; "Dialysis"; Boolean)
        {
        }
    }
}