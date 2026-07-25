page 85751 "Employee Categories"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Employee Categories";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Section; Rec.Section)
                {
                    ToolTip = 'Specifies the value of the Section field.';
                }
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Ritirement Age"; Rec."Ritirement Age")
                {
                    ToolTip = 'Specifies the value of the Ritirement Age field.';
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