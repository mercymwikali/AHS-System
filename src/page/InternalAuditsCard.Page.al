Page 85082 "Internal Audits Card"
{
    PageType = Card;
    SourceTable = audits;

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
                field(AuditFromDate; Rec."Audit From Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Audit From Date field.';
                }
                field(AuditToDate; Rec."Audit To Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Audit To Date field.';
                }
                field(LeadersAppointmentDate; Rec."Leaders Appointment Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Leaders Appointment Date field.';
                }
                field(MembersAppointmentDate; Rec."Members Appointment Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Members Appointment Date field.';
                }
                field(FollowUpToDate; Rec."Follow Up To Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Follow Up To Date field.';
                }
                field(ReviewToDate; Rec."Review To Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Review To Date field.';
                }
                field(FollowUpFromDate; Rec."Follow Up From Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Follow Up From Date field.';
                }
                field(ReviewFromDate; Rec."Review From Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Review From Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Sequence field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
            part(Control20; Auditors)
            {
                Caption = 'Auditors';
            }
            part(Control21; "Audit Checklists")
            {
                Caption = 'Auditors Checklist';
            }
            // part(Control22; "Approver Compliance journal Li")
            // {
            //     Caption = 'Findings';
            // }
        }
    }

    actions
    {
    }
}
