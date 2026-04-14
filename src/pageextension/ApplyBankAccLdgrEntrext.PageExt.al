pageextension 85005 "Apply Bank Acc Ldgr Entr ext" extends "Apply Bank Acc. Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("External Document No"; Rec."External Document No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
            }
        }
    }
}
