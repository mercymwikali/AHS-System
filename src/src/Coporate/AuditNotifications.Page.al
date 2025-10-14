Page 52203157 "Internal Audit Notifications"
{
    PageType = List;
    SourceTable = "Audit Notifications";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Sender; Rec.Sender)
                {
                    ToolTip = 'Specifies the value of the Sender field.';
                }
                field(Receiver; Rec.Receiver)
                {
                    ToolTip = 'Specifies the value of the Receiver field.';
                }
                field(Message1; Rec."Message 1")
                {
                    ToolTip = 'Specifies the value of the Message 1 field.';
                }
                field(Message2; Rec."Message 2")
                {
                    ToolTip = 'Specifies the value of the Message 2 field.';
                }
                field(Read; Rec."Read?")
                {
                    ToolTip = 'Specifies the value of the Read? field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(Subject; Rec.Subject)
                {
                    ToolTip = 'Specifies the value of the Subject field.';
                }
            }
        }
    }

    actions
    {
    }
}
