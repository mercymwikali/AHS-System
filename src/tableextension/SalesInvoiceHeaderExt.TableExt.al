tableextension 85022 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(50102; "Appointment No"; code[20])
        {
        }
        field(50103; "Patient No."; code[20])
        {
            trigger OnValidate()
            var
                PatRec: Record "HMS Patient";
            begin
                if patrec.get("Patient No.") then
                    "Patient Name" := Patrec."Search Name";
            end;
        }
        field(50104; "Treatment No"; code[20])
        {
        }
        field(50105; "Patient Search Names"; text[200])
        {
        }
        field(50106; "Patient Name"; text[200])
        {
        }
        field(50107; Paid; Boolean)
        {
        }
        field(50108; "Payment Date"; date)
        {
        }
        field(50109; "Receipt No"; code[20])
        {
        }
        field(50110; "Paid Amount"; Decimal)
        {
        }
        field(50111; "Dispatched"; Boolean)
        {
        }
        field(50112; "Dispatch No"; code[20])
        {
        }
        field(50113; "Reversed By"; code[20])
        {
        }
        field(50114; "Reversed On	Date"; date)
        {
        }
        field(50119; "Search Name"; Text[200])
        {
        }
        field(50115; "No of Services"; Integer)
        {
        }
        field(50116; "Diagnosis"; code[20])
        {
        }
        field(50117; "Posted Count"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("Sell-to Customer No."), "Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50118; "NHIF No"; code[20])
        {
        }
        field(50100; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));

            trigger OnValidate()

            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50101; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));

            trigger OnValidate()

            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
    }
    var
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
    begin
        OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then
            Modify();

        if OldDimSetID <> "Dimension Set ID" then
            Modify();

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
