pageextension 52202438 "Purchase Quote Subform Ext" extends "Purchase Quote Subform"
{
    layout
    {
        addafter(Description)
        {
            field("G/L Account"; Rec."G/L Account")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Budget G/L Account';
                Editable = false;
                ToolTip = 'Specifies the value of the Budget G/L Account field.';
            }
            field("Patient No"; Rec."Patient No")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Patient No field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}