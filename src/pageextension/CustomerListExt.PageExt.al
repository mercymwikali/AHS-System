pageextension 85037 "Customer List Ext" extends "Customer List"
{
    layout
    {
    }

    actions
    {
        // Add changes to page actions here
        addafter("Customer - Order Summary")
        {
            action("Print Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Account Statement';
                Image = "Report";
                ToolTip = 'Executes the Account Statement action.';
                trigger OnAction()
                var
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    DetailsAccountStatement: report "Cust. Account Statement Det.";
                begin
                    CustLedgerEntry.Reset();
                    CustLedgerEntry.SetRange("Customer No.", Rec."No.");
                    DetailsAccountStatement.SetTableView(CustLedgerEntry);
                    DetailsAccountStatement.RunModal();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserRec: record "User Setup";
    begin

        if UserRec.get(Database.UserId) then
            if (UserRec."Branch Code" <> '') then
                Rec.setfilter("Global Dimension 1 Code", '%1|%2', '', Userrec."Branch Code");
    end;
}