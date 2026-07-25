tableextension 85021 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50100; "Appointment No"; Code[20]) { }
        
        field(50101; "Patient No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PatRec: Record "HMS Patient";
            begin
                // Fetch the patient record and assign the name automatically
                if PatRec.Get("Patient No.") then begin
                    "Patient Name" := PatRec."Search Name";
                    "Patient Search Names" := PatRec."Search Name"; // Optional: populates your other search field too
                end else begin
                    "Patient Name" := '';
                    "Patient Search Names" := '';
                end;
            end;
        }
        
        field(50102; "Treatment No"; Code[20]) { }
        field(50103; "Patient Search Names"; Text[200]) { }
        field(50104; "Patient Name"; Text[200]) { } // Will receive the value here
        field(50105; Paid; Boolean) { }
        field(50106; "Payment Date"; Date) { }
        field(50107; "Receipt No"; Code[20]) { }
        field(50108; "Paid Amount"; Decimal) { }
        field(50109; "Dispatched"; Boolean) { }
        field(50110; "Dispatch No"; Code[20]) { }
        field(50111; "Reversed By"; Code[20]) { }
        field(50112; "Reversed On Date"; Date) { }
        field(50113; "Search Name"; Text[200]) { }
        field(50114; "No of Services"; Integer) { }
        field(50115; "Diagnosis"; Code[20]) { }
        field(50116; "Posted Count"; Integer)
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
        field(50117; "NHIF No"; Code[20]) { }
        field(50118; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code
                WHERE("Global Dimension No." = CONST(3),
                      Blocked = CONST(false));
        }
        field(50119; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code
                WHERE("Global Dimension No." = CONST(4),
                      Blocked = CONST(false));
        }
        field(50120; "Posted By"; Code[30]) { }
    }
}