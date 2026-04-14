pageextension 85031 "Posted Purchase Receipt Ext" extends "Posted Purchase Receipt"
{
    layout
    {
    }

    actions
    {
        modify("&Print")
        {
            Visible = false;
        }
        addafter("&Print")
        {
            action(PrintGRN)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print';
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Executes the Print action.';
                trigger OnAction()
                var
                    PurchReceipt: Record "Purch. Rcpt. Header";
                begin
                    PurchReceipt.reset();
                    PurchReceipt.setfilter(PurchReceipt."No.", Rec."No.");
                    if PurchReceipt.find('-') then
                        report.run(70135449, true, true, PurchReceipt);
                end;
            }
            action(PrintCert)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Inspection Certificate';
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Executes the Print Inspection Certificate action.';
                trigger OnAction()
                var
                    PurchReceipt: Record "Purch. Rcpt. Header";
                // InspecReport: report "Inspection Certificate1";
                begin
                    PurchReceipt.reset();
                    PurchReceipt.setfilter(PurchReceipt."No.", Rec."No.");
                    if PurchReceipt.find('-') then
                        report.run(70135481, true, true, PurchReceipt);
                end;
            }
        }
    }
}