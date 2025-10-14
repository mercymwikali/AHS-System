Page 52202636 "Audit Meetings Agenda List"
{
    PageType = List;
    SourceTable = "Audit Meetings Agenda List";
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
                field(MeetingCode; Rec."Meeting Code")
                {
                    ToolTip = 'Specifies the value of the Meeting Code field.';
                }
                field(AgendaDesc1; Rec."Agenda Desc 1")
                {
                    ToolTip = 'Specifies the value of the Agenda Desc 1 field.';
                }
                field(AgendaDesc2; Rec."Agenda Desc 2")
                {
                    ToolTip = 'Specifies the value of the Agenda Desc 2 field.';
                }
                field(Discussed; Rec."Discussed?")
                {
                    ToolTip = 'Specifies the value of the Discussed? field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(CreatedBy; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(DateEdited; Rec."Date Edited")
                {
                    ToolTip = 'Specifies the value of the Date Edited field.';
                }
                field(EditedBy; Rec."Edited By")
                {
                    ToolTip = 'Specifies the value of the Edited By field.';
                }
            }
        }
    }

    actions
    {
    }
}
