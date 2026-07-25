Page 85637 "Hr Email Parameters List"
{
    // CardPageID = "HR E-Mail Parameters";
    PageType = List;
    SourceTable = "HR E-Mail Parameters";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AssociateWith; Rec."Associate With")
                {
                    ToolTip = 'Specifies the value of the Associate With field.';
                }
                field(SenderName; Rec."Sender Name")
                {
                    ToolTip = 'Specifies the value of the Sender Name field.';
                }
                field(SenderAddress; Rec."Sender Address")
                {
                    ToolTip = 'Specifies the value of the Sender Address field.';
                }
                field(Recipients; Rec.Recipients)
                {
                    ToolTip = 'Specifies the value of the Recipients field.';
                }
                field(Subject; Rec.Subject)
                {
                    ToolTip = 'Specifies the value of the Subject field.';
                }
                field(Body; Rec.Body)
                {
                    ToolTip = 'Specifies the value of the Body field.';
                }
                field(Body2; Rec."Body 2")
                {
                    ToolTip = 'Specifies the value of the Body 2 field.';
                }
                field(HTMLFormatted; Rec.HTMLFormatted)
                {
                    ToolTip = 'Specifies the value of the HTMLFormatted field.';
                }
                field(Body3; Rec."Body 3")
                {
                    ToolTip = 'Specifies the value of the Body 3 field.';
                }
                field(Body4; Rec."Body 4")
                {
                    ToolTip = 'Specifies the value of the Body 4 field.';
                }
                field(Body5; Rec."Body 5")
                {
                    ToolTip = 'Specifies the value of the Body 5 field.';
                }
            }
        }
    }

    actions
    {
    }
}
