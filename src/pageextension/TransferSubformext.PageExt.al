pageextension 85030 "Transfer Subform ext" extends "Transfer Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Transfer-from Code"; Rec."Transfer-from Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the code of the location that items are transferred from.';
            }
            field("Available Qty"; Rec."Available Qty")
            {
                ApplicationArea = Basic, Suite;
                Enabled = false;
                ToolTip = 'Specifies the value of the Available Qty field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}