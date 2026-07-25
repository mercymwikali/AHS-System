Page 85075 "Internal Audit Meetings"
{
    CardPageID = "Audit Meetings Card";
    PageType = List;
    SourceTable = "Audit Meetings";
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
                field(AuditCode; Rec."Audit Code")
                {
                    ToolTip = 'Specifies the value of the Audit Code field.';
                }
                field(Description1; Rec."Description 1")
                {
                    ToolTip = 'Specifies the value of the Description 1 field.';
                }
                field(Description2; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field(AuditProgramme; Rec."Audit Programme")
                {
                    ToolTip = 'Specifies the value of the Audit Programme field.';
                }
                field(AuditNo; Rec."Audit No.")
                {
                    ToolTip = 'Specifies the value of the Audit No. field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(CreatedBy; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(MeetingDate; Rec."Meeting Date")
                {
                    ToolTip = 'Specifies the value of the Meeting Date field.';
                }
            }
        }
    }

    actions
    {
    }
}
