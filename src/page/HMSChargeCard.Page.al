page 85324 "HMS Charge Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "HMS Charges";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Income G/L Account No"; Rec."Income G/L Account No")
                {
                    ToolTip = 'Specifies the value of the Income G/L Account No field.';
                }
                field("Expense G/L Account No"; Rec."Expense G/L Account No")
                {
                    ToolTip = 'Specifies the value of the Expense G/L Account No field.';
                }
                field("Billing Type"; Rec."Billing Type")
                {
                    ToolTip = 'Specifies the value of the Billing Type field.';
                }
                field("Reccuring Type"; Rec."Reccuring Type")
                {
                    ToolTip = 'Specifies the value of the Reccuring Type field.';
                }
                field("Percentage Rate"; Rec."Percentage Rate")
                {
                    ToolTip = 'Specifies the value of the Percentage Rate field.';
                }
                field("Doctor Percentage"; Rec."Doctor Percentage")
                {
                    ToolTip = 'Specifies the value of the Doctor Percentage field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(BranchPrices)
            {
                RunObject = page "HMS Charges Prices";
                RunPageLink = "Charge Code" = field(Code);
                ToolTip = 'Executes the BranchPrices action.';
            }
        }
    }
}