pageextension 52202441 "Purchase Invoice Subform Ext" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Prod Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
            }
        }
    }
}