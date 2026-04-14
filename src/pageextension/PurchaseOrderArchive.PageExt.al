pageextension 85003 "Purchase Order Archive" extends "Purchase Order Archive"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document Date")
        {
        }
    }

    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            action("Print Order")
            {
                ApplicationArea = all;
                Caption = 'Print Order';
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Executes the Print Order action.';
                trigger OnAction()
                var
                    PurchRec: Record "Purchase Header Archive";
                begin
                    // TestField(Status, Status::Released);
                    PurchRec.reset();
                    PurchRec.setfilter("No.", Rec."No.");
                    if PurchRec.find('-') then
                        report.Run(50008, true, true, PurchRec);
                end;
            }
            action("Print LSO")
            {
                ApplicationArea = all;
                Caption = 'Print LSO';
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Executes the Print LSO action.';
                trigger OnAction()
                var
                    PurchRec: Record "Purchase Header Archive";
                begin
                    // TestField(Status, Status::Released);
                    PurchRec.reset();
                    PurchRec.setfilter("No.", Rec."No.");
                    if PurchRec.find('-') then
                        report.Run(50009, true, true, PurchRec);
                end;
            }
        }
    }
}
