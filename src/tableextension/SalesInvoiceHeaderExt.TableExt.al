tableextension 85022 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "Appointment No"; code[20]) { }
        field(50101; "Patient No."; code[20])
        {
            // Removed the OnValidate trigger entirely. 
            // The data flows automatically from the Sales Header on posting.
        }
        field(50102; "Treatment No"; code[20]) { }
        field(50103; "Patient Search Names"; text[200]) { }
        field(50104; "Patient Name"; text[200]) { } 
        field(50105; Paid; Boolean) { }
        field(50106; "Payment Date"; date) { }
        field(50107; "Receipt No"; code[20]) { }
        field(50108; "Paid Amount"; Decimal) { }
        field(50109; "Dispatched"; Boolean) { }
        field(50110; "Dispatch No"; code[20]) { }
        field(50111; "Reversed By"; code[20]) { }
        field(50112; "Reversed On Date"; date) { } 
        field(50113; "Search Name"; Text[200]) { }
        field(50114; "No of Services"; Integer) { }
        field(50115; "Diagnosis"; code[20]) { }
        field(50116; "Posted Count"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("Sell-to Customer No."), "Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50117; "NHIF No"; code[20]) { }
        field(50118; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50119; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(50120; "Posted By"; Code[30]) { } 
    }

    var
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);

        // Let the platform service handle data values in memory before the core system commits the entry
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        
        // REMOVED: If "No." <> "" then Modify(); 
        // REMOVED: If OldDimSetID <> "Dimension Set ID" then Modify();

        OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCode(var PurchHeader: Record "Sales Invoice Header"; xPurchHeader: Record "Sales Invoice Header"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateShortcutDimCode(var PurchaseHeader: Record "Sales Invoice Header"; var xPurchaseHeader: Record "Sales Invoice Header"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;
}