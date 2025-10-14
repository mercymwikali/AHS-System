namespace PTL.Hospital;

using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Journal;

report 52202695 "Synch Imported Stock"
{
    ApplicationArea = All;
    Caption = 'Synch Imported Stock';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Import Stock Buffer";"Import Stock Buffer")
        {
            RequestFilterFields = "Location Code";
            trigger OnAfterGetRecord()
            var
                ItemJournalLine: Record "Item Journal Line";
            begin
                if "Import Stock Buffer".Synched then
                    exit;
                // We are only to modify the records that are imported in the buffer
                ItemJournalLine.Reset();
                ItemJournalLine.SetRange(ItemJournalLine."Item No.", "Import Stock Buffer"."Item No");
                ItemJournalLine.SetRange(ItemJournalLine."Location Code", "Import Stock Buffer"."Location Code");
                ItemJournalLine.SetRange(ItemJournalLine."Document No.", "Import Stock Buffer"."Document No");
                if ItemJournalLine.FindFirst() then begin
                    ItemJournalLine."Qty. (Phys. Inventory)" := "Import Stock Buffer".Quantity;
                    ItemJournalLine.Validate("Qty. (Phys. Inventory)");
                    ItemJournalLine.Modify();
                    Sleep(2); // Simulate processing time
                    "Import Stock Buffer".Synched := true;
                    "Import Stock Buffer".Modify();
                    RecCount := RecCount + 1;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnPostReport()
    begin
        Message('done');
    end;
    var
        RecCount: Integer;

}
