pageextension 85016 "Item Ledger Entry Ext" extends "Item Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Source No"; Rec."Source No.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Patient No.';
                ToolTip = 'Specifies where the entry originated.';
            }
            field("Patient Name"; Rec."Patient Name")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Patient Name field.';
            }
        }
        modify("Global Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
        }

        addafter("Global Dimension 2 Code")
        {
            field("ShortcutDim3Code"; Rec."ShortcutDim3Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
            }
            field("ShortcutDim4Code"; Rec."ShortcutDim4Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
            }
            field("ShortcutDim5Code"; Rec."ShortcutDim5Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
            }
            field("ShortcutDim6Code"; Rec."ShortcutDim6Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
            }
            field("ShortcutDim7Code"; Rec."ShortcutDim7Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.';
            }
            field("ShortcutDim8Code"; Rec."ShortcutDim8Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 8 Code field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}