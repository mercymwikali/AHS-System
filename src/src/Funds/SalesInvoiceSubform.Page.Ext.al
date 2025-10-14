pageextension 52202442 "Sales Invoice Subform ext" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Location Code")
        {
            field("Gen. Prod Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}