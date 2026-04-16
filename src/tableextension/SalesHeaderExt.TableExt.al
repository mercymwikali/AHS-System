tableextension 85021 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50103; "Appointment No"; Code[20]) { }
        field(50104; "Patient No."; Code[20]) { }
        field(50105; "Treatment No"; Code[20]) { }
        field(50106; "Patient Search Names"; Text[200]) { }
        field(50107; "Patient Name"; Text[200]) { }
        field(50108; Paid; Boolean) { }
        field(50109; "Payment Date"; Date) { }
        field(50110; "Receipt No"; Code[20]) { }
        field(50111; "Paid Amount"; Decimal) { }
        field(50112; "Dispatched"; Boolean) { }
        field(50113; "Dispatch No"; Code[20]) { }
        field(50114; "Reversed By"; Code[20]) { }
        field(50115; "Reversed On Date"; Date) { }
        field(50120; "Search Name"; Text[200]) { }
        field(50116; "No of Services"; Integer) { }
        field(50117; "Diagnosis"; Code[20]) { }
        field(50118; "Posted Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(
                "Cust. Ledger Entry"
                WHERE(
                    "Customer No." = FIELD("Sell-to Customer No."),
                    "Document No." = FIELD("No.")
                )
            );
        }
        field(50119; "NHIF No"; Code[20]) { }
        field(50100; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code
                WHERE("Global Dimension No." = CONST(3),
                      Blocked = CONST(false));
        }
        field(50101; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code
                WHERE("Global Dimension No." = CONST(4),
                      Blocked = CONST(false));
        }
        field(50102; "Posted By"; Code[30]) { }
    }
}