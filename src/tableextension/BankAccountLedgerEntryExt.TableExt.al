TableExtension 85009 "Bank Account Ledger Entry Ext" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50100; "External Document No. 2"; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Statement Difference"; Decimal)
        {
        }
        field(50102; Test2; Code[20])
        {
        }
        field(50103; Test3; Code[20])
        {
        }
        field(50104; Test; Code[20])
        {
        }
        field(50105; Remarks; Text[50])
        {
        }
        field(50112; "Document Ref. No"; Code[30])
        {
        }
        field(50113; "Source Account Staff No"; Code[20])
        {
        }
        field(50114; "Customer Name"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Bal. Account No.")));
            FieldClass = FlowField;
        }
        field(50115; "Payee Name"; Text[100])
        {
            CalcFormula = lookup("Payments Header".Payee where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50116; "Amount Applied"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "ShortcutDim3Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50107; "ShortcutDim4Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50108; "ShortcutDim5Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(50109; "ShortcutDim6Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            CaptionClass = '1,2,6';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
        }
        field(50110; "ShortcutDim7Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            CaptionClass = '1,2,7';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
        }
        field(50111; "ShortcutDim8Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            CaptionClass = '1,2,8';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
        }
    }
}
