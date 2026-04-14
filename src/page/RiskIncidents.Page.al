page 85811 "Risk Incidents"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Risk Incidences";
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
                field("Incidence Desc 1"; Rec."Incidence Desc 1")
                {
                    ToolTip = 'Specifies the value of the Incidence Desc 1 field.';
                }
                field("Incidence Desc 2"; Rec."Incidence Desc 2")
                {
                    ToolTip = 'Specifies the value of the Incidence Desc 2 field.';
                }
                field("Incidence Desc 3"; Rec."Incidence Desc 3")
                {
                    ToolTip = 'Specifies the value of the Incidence Desc 3 field.';
                }
                field("Incidence Desc 4"; Rec."Incidence Desc 4")
                {
                    ToolTip = 'Specifies the value of the Incidence Desc 4 field.';
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