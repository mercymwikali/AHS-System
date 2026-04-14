pageextension 85004 "Bank Acc Reconciliation" extends "Bank Acc. Reconciliation"
{
    actions
    {
        addafter("P&osting")
        {
            action("Print Test Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Category8;
                ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';

                trigger OnAction()
                var
                    BankRecon: Record "Bank Acc. Reconciliation";
                begin

                    BankRecon.reset();
                    BankRecon.SetRange(BankRecon."Bank Account No.", Rec."Bank Account No.");
                    BankRecon.SetRange(BankRecon."Statement No.", Rec."Statement No.");
                    BankRecon.SetRange(BankRecon."Statement Type", BankRecon."Statement Type"::"Bank Reconciliation");
                    if BankRecon.find('-') then
                        report.Run(51408, true, true, BankRecon);
                end;
            }
        }
        modify("&Test Report")
        {
            visible = false;
        }
    }
}
