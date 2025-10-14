page 52202578 "GL List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "G/L Account";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the general ledger account.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the purpose of the account. Total: Used to total a series of balances on accounts from many different account groupings. To use Total, leave this field blank. Begin-Total: A marker for the beginning of a series of accounts to be totaled that ends with an End-Total account. End-Total: A total of a series of accounts that starts with the preceding Begin-Total account. The total is defined in the Totaling field.';
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                    ToolTip = 'Specifies whether a general ledger account is an income statement account or a balance sheet account.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ToolTip = 'Executes the ActionName action.';

                trigger OnAction()
                begin
                end;
            }
        }
    }
}