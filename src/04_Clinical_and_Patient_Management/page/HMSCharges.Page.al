Page 85325 "HMS Charges"
{
    CardPageId = "HMS Charge Card";
    // Editable = false;
    PageType = List;
    SourceTable = "HMS Charges";
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Accounttype; Rec."Account type")
                {
                    ToolTip = 'Specifies the value of the Account type field.';
                }
                field(IncomeGLAccountNo; Rec."Income G/L Account No")
                {
                    ToolTip = 'Specifies the value of the Income G/L Account No field.';
                }
                field(ExpenseGLAccountNo; Rec."Expense G/L Account No")
                {
                    ToolTip = 'Specifies the value of the Expense G/L Account No field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Reccuring Type"; Rec."Reccuring Type")
                {
                    ToolTip = 'Specifies the value of the Reccuring Type field.';
                }
                field(ApplicableSection; Rec."Applicable Section")
                {
                    ToolTip = 'Specifies the value of the Applicable Section field.';
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(PercentageRate; Rec."Percentage Rate")
                {
                    ToolTip = 'Specifies the value of the Percentage Rate field.';
                }
                field(AllowDeletion; Rec."Allow Deletion")
                {
                    ToolTip = 'Specifies the value of the Allow Deletion field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Prices)
            {
                Caption = 'Charge Prices';
                promoted = true;
                RunObject = page "HMS Charges Prices";
                RunPageLink = "Charge Code" = field(Code);
                ToolTip = 'Executes the Charge Prices action.';
            }
        }
    }
}
