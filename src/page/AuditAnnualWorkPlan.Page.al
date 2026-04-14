Page 85072 "Audit Annual WorkPlan"
{
    PageType = List;
    SourceTable = "Audit Programmes";
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
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(DescriptionComment; Rec."Description/Comment")
                {
                    ToolTip = 'Specifies the value of the Description/Comment field.';
                }
                field(CreatedBy; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(LastEditedBy; Rec."Last Edited By")
                {
                    ToolTip = 'Specifies the value of the Last Edited By field.';
                }
                field(DateEdited; Rec."Date Edited")
                {
                    ToolTip = 'Specifies the value of the Date Edited field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(ApprovalComments; Rec."Approval Comments")
                {
                    ToolTip = 'Specifies the value of the Approval Comments field.';
                }
                field(NotificationSent; Rec."Notification Sent?")
                {
                    ToolTip = 'Specifies the value of the Notification Sent? field.';
                }
            }
        }
    }

    actions
    {
    }
}
