page 52202717 "Receipt Split"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Receipt Split";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ToolTip = 'Specifies the value of the Bank Account No field.';
                }
                field("Transaction No"; Rec."Transaction No")
                {
                    ToolTip = 'Specifies the value of the Transaction No field.';
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