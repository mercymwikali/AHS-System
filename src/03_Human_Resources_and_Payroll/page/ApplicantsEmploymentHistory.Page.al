Page 85583 "Applicants Employment History"
{
    PageType = Listpart;
    SourceTable = "Applicants Employment History";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(From; Rec.From)
                {
                    ToolTip = 'Specifies the value of the From field.';
                }
                field("To"; Rec."To")
                {
                    ToolTip = 'Specifies the value of the To field.';
                }
                field(CompanyName; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field(PostalAddress; Rec."Postal Address")
                {
                    ToolTip = 'Specifies the value of the Postal Address field.';
                }
                field(Address2; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field(JobTitle; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                }
                field(KeyExperience; Rec."Key Experience")
                {
                    ToolTip = 'Specifies the value of the Key Experience field.';
                }
                field(SalaryOnLeaving; Rec."Salary On Leaving")
                {
                    ToolTip = 'Specifies the value of the Salary On Leaving field.';
                }
                field(ReasonForLeaving; Rec."Reason For Leaving")
                {
                    ToolTip = 'Specifies the value of the Reason For Leaving field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(LineNo; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                field(Username; Rec.Username)
                {
                    ToolTip = 'Specifies the value of the Username field.';
                }
                field(EmailAddress; Rec."Email Address")
                {
                    ToolTip = 'Specifies the value of the Email Address field.';
                }
                field(SupervisorNameTitle; Rec."Supervisor Name Title")
                {
                    ToolTip = 'Specifies the value of the Supervisor Name Title field.';
                }
            }
        }
    }

    actions
    {
    }
}
