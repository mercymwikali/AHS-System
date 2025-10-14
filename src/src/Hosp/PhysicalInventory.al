pageextension 52202457 "Physical Inventory" extends "Phys. Inventory Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Post and &Print")
        {
            action(RefreshPhysicalQty)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update Physical Quantity to Zero';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Update Physical Quantity to Zero action.';
                trigger OnAction()
                var
                    ItmJournal: Record "Item Journal Line";
                begin
                    ItmJournal.reset();
                    ItmJournal.setrange("Journal Template Name", Rec."Journal Template Name");
                    ItmJournal.setrange("Journal Batch Name", Rec."Journal Batch Name");
                    if ItmJournal.find('-') then
                        repeat
                            ItmJournal."Qty. (Phys. Inventory)" := 0;
                            ItmJournal.Validate("Qty. (Phys. Inventory)");
                            ItmJournal.modify();
                        until ItmJournal.next() = 0;
                    Message('Process Completed.');
                end;
            }
            action(UpdateDimension)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update Branch with User Branch';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Update Branch with User Branch action.';
                trigger OnAction()
                var
                    ItmJournal: Record "Item Journal Line";
                    UserRec: Record "User Setup";
                begin
                    UserRec.get(Database.UserId);
                    UserRec.TestField("Branch Code");
                    ItmJournal.reset();
                    ItmJournal.setrange("Journal Template Name", Rec."Journal Template Name");
                    ItmJournal.setrange("Journal Batch Name", Rec."Journal Batch Name");
                    if ItmJournal.find('-') then
                        repeat
                            ItmJournal."Shortcut Dimension 1 Code" := UserRec."Branch Code";
                            ItmJournal.validate("Shortcut Dimension 1 Code");
                            ItmJournal.modify();
                        until ItmJournal.next() = 0;
                    Message('Process Completed.');
                end;
            }
            action(SynchImportedStock)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Synch Imported Stock';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Synch Imported Stock action.';
                RunObject = report "Synch Imported Stock";
                Image = Synchronize;
            }
        }
    }
}