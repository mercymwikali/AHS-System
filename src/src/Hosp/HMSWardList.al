page 52202658 "HMS Ward List"
{
    ApplicationArea = All;
    CardPageId = "HMS ward Setup";
    Editable = false;
    PageType = List;
    SourceTable = "HMS Ward Setup";
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Ward Code"; Rec."Ward Code")
                {
                    ToolTip = 'Specifies the value of the Ward Code field.';
                }
                field("Ward Name"; Rec."Ward Name")
                {
                    ToolTip = 'Specifies the value of the Ward Name field.';
                }
                field("Charges Code"; Rec."Charges Code")
                {
                    ToolTip = 'Specifies the value of the Charges Code field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
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