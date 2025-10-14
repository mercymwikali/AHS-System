tableextension 52202444 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(70134671; "Appointment No"; code[20])
        {
        }
        field(70134672; "Patient No."; code[20])
        {
            trigger OnValidate()
            var
                PatRec: Record "HMS Patient";
            begin
                if patrec.get("Patient No.") then
                    "Patient Name" := Patrec."Search Name";
            end;
        }
        field(70134673; "Treatment No"; code[20])
        {
        }
        field(70134774; "Patient Search Names"; text[200])
        {
        }
        field(70134775; "Patient Name"; text[200])
        {
        }
        field(70134776; Paid; Boolean)
        {
        }
        field(70134777; "Payment Date"; date)
        {
        }
        field(70134778; "Receipt No"; code[20])
        {
        }
        field(70134779; "Paid Amount"; Decimal)
        {
        }
        field(70134780; "Dispatched"; Boolean)
        {
        }
        field(70134781; "Dispatch No"; code[20])
        {
        }
        field(70134783; "Reversed By"; code[20])
        {
        }
        field(70134784; "Reversed On	Date"; date)
        {
        }
        field(70134793; "Search Name"; Text[200])
        {
        }
        field(70134785; "No of Services"; Integer)
        {
        }
        field(70134786; "Diagnosis"; code[20])
        {
        }
        field(70134787; "Posted Count"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("Sell-to Customer No."), "Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(70134788; "NHIF No"; code[20])
        {
        }
        field(51003; "Shortcut Dimension 3 Code"; Code[20])
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
        field(51004; "Shortcut Dimension 4 Code"; Code[20])
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
