pageextension 85038 VendorLedger extends "Vendor Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(UnapplyEntries)
        {
            action(ForceUnapply)
            {
                ApplicationArea = Basic, Suite;
                caption = 'Force Unapply';
                ToolTip = 'Executes the Force Unapply action.';
                trigger OnAction()
                var
                    DCust: record "Detailed Vendor Ledg. Entry";

                begin
                    if confirm('Do you really want to force Unappy the selected entry?', false) then begin
                        DCust.reset();
                        dcust.setrange(DCust."Vendor No.", Rec."Vendor No.");
                        Dcust.setrange(DCust."Document No.", Rec."Document No.");
                        Dcust.setrange(DCust."Entry Type", DCust."Entry Type"::Application);
                        if DCust.find('-') then
                            repeat
                                DCust.Delete();
                            until Dcust.next() = 0;
                        Rec.Open := true;
                        Rec.modify();
                    end;
                end;
            }
        }
    }
}