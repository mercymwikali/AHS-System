pageextension 52202432 CustomerCard extends "Customer Card"

{
    layout
    {
        addafter("Search Name")
        {
            field("Insurance Rate"; Rec."Insurance Rate")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the Insurance Rate field.';
            }
            field(Minet; Rec.Minet)
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the Minet field.';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
            }
            field("In Daily Clinical Report"; Rec."In Daily Clinical Report")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the In Daily Clinical Report field.';
            }
        }

        addafter(Blocked)
        {
            field("Account Type"; Rec."Account Type")
            {
                ApplicationArea = all;
                Caption = 'Account Type';
                ToolTip = 'Specifies the value of the Account Type field.';
            }
            field("Employee Job Group"; Rec."Employee Job Group")
            {
                ApplicationArea = all;
                Caption = 'Employee Job Group';
                ToolTip = 'Specifies the value of the Employee Job Group field.';
            }
            field("Co-Pay Amount"; Rec."Co-Pay Amount")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the Co-Pay Amount field.';
            }
            field("Co-Pay Percentage"; Rec."Co-Pay Percentage")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the Co-Pay Percentage field.';
            }
            field("Consultant Consultation Code"; Rec."Consultant Consultation Code")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the Consultant Consultation Code field.';
            }
            field("Resident Consultation Code"; Rec."Resident Consultation Code")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the Resident Consultation Code field.';
            }
            field("NHIF Capitation"; Rec."NHIF Capitation")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the NHIF Capitation field.';
            }
            field("NHIF Package"; Rec."NHIF Package")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the NHIF Package field.';
            }
            field("Visit Ceiling"; Rec."Visit Ceiling")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the Visit Ceiling field.';
            }
            field("NHIF FFF"; Rec."NHIF FFF")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the NHIF FFF field.';
            }
            field("Claimed Amount"; Rec."Claimed Amount")
            {
                ApplicationArea = basic;
                ToolTip = 'Specifies the value of the Claimed Amount field.';
            }
        }
    }
    actions
    {
        modify("Report Statement")
        {
            Visible = false;
        }
        addafter("Report Statement")
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
        addafter("Item References")
        {
            action(InsuracePackage)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Insurance Packages';
                Image = CreatePutawayPick;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = page "HMS Insurance Package";
                RunPageLink = "Insurance No" = field("No.");
                ToolTip = 'Executes the Insurance Packages action.';
                // ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
            }
        }
    }
}