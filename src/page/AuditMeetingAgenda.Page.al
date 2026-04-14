page 85802 "Audit Meeting Agenda"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Audit Meetings Agenda List";
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
                field("Agenda Desc 1"; Rec."Agenda Desc 1")
                {
                    ToolTip = 'Specifies the value of the Agenda Desc 1 field.';
                }
                field("Agenda Desc 2"; Rec."Agenda Desc 2")
                {
                    ToolTip = 'Specifies the value of the Agenda Desc 2 field.';
                }
                field("Discussed?"; Rec."Discussed?")
                {
                    ToolTip = 'Specifies the value of the Discussed? field.';
                }
                field("Date Created"; Rec.Code)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Date Edited"; Rec."Date Edited")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Edited field.';
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Edited By"; Rec."Edited By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Edited By field.';
                }
            }
        }
    }
}