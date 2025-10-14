pageextension 52202449 "G/L Entry Ext" extends "General Ledger Entries"
{
    layout
    {
        addafter("Source Code")
        {
            field("Global Dimension 1 Code1"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
            }
            field("Global Dimension 2 Code1"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
            }
            field("Dimension Set ID1"; Rec."Dimension Set ID")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies a reference to a combination of dimension values. The actual values are stored in the Dimension Set Entry table.';
            }
        }
    }
}