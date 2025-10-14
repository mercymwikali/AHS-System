tableextension 52202424 "Detailed Vendor Ledg. Entry" extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(50000; "External No"; Text[200])
        {
            CalcFormula = Lookup("Vendor Ledger Entry"."External Document No." WHERE("Entry No." = FIELD("Vendor Ledger Entry No.")));
            Caption = 'External No';
            FieldClass = FlowField;
        }
        field(50001; "Doc No"; Text[200])
        {
            CalcFormula = Lookup("Vendor Ledger Entry"."Document No." WHERE("Entry No." = FIELD("Vendor Ledger Entry No.")));
            Caption = 'Doc No';
            FieldClass = FlowField;
        }
        field(50002; Description; Text[200])
        {
            CalcFormula = Lookup("Vendor Ledger Entry".Description WHERE("Entry No." = FIELD("Vendor Ledger Entry No.")));
            Caption = 'Description';
            FieldClass = FlowField;
        }
    }
}
