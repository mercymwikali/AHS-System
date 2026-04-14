pageextension 85021 "Purchase Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        addbefore("Qty. to Receive")
        {
            field("VAT Prod. Posting Group1"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the VAT product posting group. Links business transactions made for the item, resource, or G/L account with the general ledger, to account for VAT amounts resulting from trade with that record.';
            }
            field("Requisition No"; Rec."Requisition No")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Requisition No field.';
            }
            field("Patient No"; Rec."Patient No")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Patient No field.';
            }

            field("Line Discount Amount1"; Rec."Line Discount Amount")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
            }
            field("Line Discount %1"; Rec."Line Discount %")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        TransH: Record "Purchase Header";
    begin
        TransH.reset();
        TransH.setrange("No.", Rec."Document No.");
        if TransH.find('-') then
            TransH.TestField("Shortcut Dimension 1 Code");
    end;
}