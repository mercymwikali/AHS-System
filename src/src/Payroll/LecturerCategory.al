page 52202653 "Lecturer Category"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Lecturers Category";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Max. Parttime Units"; Rec."Max. Parttime Units")
                {
                    ToolTip = 'Specifies the value of the Max. Parttime Units field.';
                }
                field("Max. Fulltime Units"; Rec."Max. Fulltime Units")
                {
                    ToolTip = 'Specifies the value of the Max. Fulltime Units field.';
                }
                field("Max. Units"; Rec."Max. Units")
                {
                    ToolTip = 'Specifies the value of the Max. Units field.';
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