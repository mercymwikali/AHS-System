page 85488 "HMS Ward Charges"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "HMS Ward Charges";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Charge Code"; Rec."Charge Code")
                {
                    ToolTip = 'Specifies the value of the Charge Code field.';
                }
                field("Charge Description"; Rec."Charge Description")
                {
                    ToolTip = 'Specifies the value of the Charge Description field.';
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