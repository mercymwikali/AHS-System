page 52202724 "HMS Charges Prices"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "HMS Charges Prices";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Branch Code"; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Cash Amount"; Rec."Cash Amount")
                {
                    ToolTip = 'Specifies the value of the Cash Amount field.';
                }
                field("Corporate Amount"; Rec."Corporate Amount")
                {
                    ToolTip = 'Specifies the value of the Corporate Amount field.';
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