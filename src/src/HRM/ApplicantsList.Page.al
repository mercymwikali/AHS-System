Page 52203120 "Applicants List"
{
    CardPageID = "Applicants Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Applicant,Functions,Print';
    SourceTable = Applicants;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control15)
            {
                Editable = false;
                field(ApplicationNo; Rec."Application No")
                {
                    Importance = Promoted;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Application No field.';
                }
                field(RequisitionNo; Rec."Requisition No")
                {
                    ToolTip = 'Specifies the value of the Requisition No field.';
                }
                field(DateApplied; Rec."Date Applied")
                {
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Date Applied field.';
                }
                field(JobAppliedFor; Rec."Job Applied For")
                {
                    ToolTip = 'Specifies the value of the Job Applied For field.';
                }
                field(FirstName; Rec."First Name")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(Qualified; Rec.Qualified)
                {
                    ToolTip = 'Specifies the value of the Qualified field.';
                }
                field(InterviewInvitationSent; Rec."Interview Invitation Sent")
                {
                    ToolTip = 'Specifies the value of the Interview Invitation Sent field.';
                }
                field(UserName; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field(EMail; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field(JobAppliedforDescription; Rec."Job Applied for Description")
                {
                    ToolTip = 'Specifies the value of the Job Applied for Description field.';
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
    }
}
