Page 52202639 "Internal Audit Meetings Card"
{
    PageType = Card;
    SourceTable = "Audit Meetings";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(AuditCode; Rec."Audit Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Audit Code field.';
                }
                field(Description1; Rec."Description 1")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description 1 field.';
                }
                field(Description2; Rec."Description 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field(AuditProgramme; Rec."Audit Programme")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Audit Programme field.';
                }
                field(AuditNo; Rec."Audit No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Audit No. field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(MeetingDate; Rec."Meeting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Meeting Date field.';
                }
            }
            part(Control13; "HR Policies")
            {
            }
            // part(Control14; "Risk Escallation")
            // {
            // }
        }
    }

    actions
    {
    }
}
