page 52202629 "Audit Notifications Card"
{
    ApplicationArea = All;
    PageType = card;
    SourceTable = "Audit Notifications";
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
                field(Subject; Rec.Subject)
                {
                    ToolTip = 'Specifies the value of the Subject field.';
                }
                field("Message 1"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Message 2"; Rec."Message 2")
                {
                    ToolTip = 'Specifies the value of the Message 2 field.';
                }
                field(Sender; Rec.Sender)
                {
                    ToolTip = 'Specifies the value of the Sender field.';
                }
                field(Receiver; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Read?"; Rec."Read?")
                {
                    ToolTip = 'Specifies the value of the Read? field.';
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