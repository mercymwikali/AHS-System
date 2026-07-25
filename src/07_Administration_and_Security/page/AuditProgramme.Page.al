page 85808 "Audit Programme"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Audit Programmes";
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
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field("Description/Comment"; Rec."Description/Comment")
                {
                    ToolTip = 'Specifies the value of the Description/Comment field.';
                }
                field("Notification Sent?"; Rec."Notification Sent?")
                {
                    ToolTip = 'Specifies the value of the Notification Sent? field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
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