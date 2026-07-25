page 85812 "Risk Mitigation"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Risk Mitigations";
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
                field("Mitigation Desc 1"; Rec."Mitigation Desc 1")
                {
                    ToolTip = 'Specifies the value of the Mitigation Desc 1 field.';
                }
                field("Mitigation Desc 2"; Rec."Mitigation Desc 2")
                {
                    ToolTip = 'Specifies the value of the Mitigation Desc 2 field.';
                }
                field("Mitigation Desc 3"; Rec."Mitigation Desc 3")
                {
                    ToolTip = 'Specifies the value of the Mitigation Desc 3 field.';
                }
                field("Mitigation Desc 4"; Rec."Mitigation Desc 4")
                {
                    ToolTip = 'Specifies the value of the Mitigation Desc 4 field.';
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