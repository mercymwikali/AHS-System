tableextension 85016 "Transfer Order Line Ext" extends "Transfer Line"
{
    fields
    {
        field(50100; "Available Qty"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."), "Location Code" = field("Transfer-from Code")));
            FieldClass = FlowField;
        }
    }
    trigger OnBeforeInsert()
    var
        TransH: Record "Transfer Header";
    begin
        if TransH.get("Document No.") then
            TransH.TestField("Shortcut Dimension 1 Code");
    end;
}