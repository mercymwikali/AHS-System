page 52202627 "Risk Controls"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Risk Controls";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Control Desc 1"; Rec."Control Desc 1")
                {
                    ToolTip = 'Specifies the value of the Control Desc 1 field.';
                }
                field("Control Desc 2"; Rec."Control Desc 2")
                {
                    ToolTip = 'Specifies the value of the Control Desc 2 field.';
                }
                field("Control Desc 3"; Rec."Control Desc 3")
                {
                    ToolTip = 'Specifies the value of the Control Desc 3 field.';
                }
                field("Control Desc 4"; Rec."Control Desc 4")
                {
                    ToolTip = 'Specifies the value of the Control Desc 4 field.';
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