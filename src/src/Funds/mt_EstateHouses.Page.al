page 52202546 "Estate Houses"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Estate Houses";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Occupant Employee No"; Rec."Occupant Employee No")
                {
                    ToolTip = 'Specifies the value of the Occupant Employee No field.';
                }
                field("Outsider Name"; Rec."Outsider Name")
                {
                    ToolTip = 'Specifies the value of the Outsider Name field.';
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