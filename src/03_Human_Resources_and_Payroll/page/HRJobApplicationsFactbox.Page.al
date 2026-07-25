Page 85662 "HR Job Applications Factbox"
{
    PageType = ListPart;
    SourceTable = Applicants;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            field(GeneralInfo; GeneralInfo)
            {
                Style = Strong;
                StyleExpr = true;
                ToolTip = 'Specifies the value of the GeneralInfo field.';
            }
            field(ApplicationNo; Rec."Application No")
            {
                ToolTip = 'Specifies the value of the Application No field.';
            }
            field(DateApplied; Rec."Date Applied")
            {
                ToolTip = 'Specifies the value of the Date Applied field.';
            }
            field(FirstName; Rec."First Name")
            {
                ToolTip = 'Specifies the value of the First Name field.';
            }
            field(MiddleName; Rec."Middle Name")
            {
                ToolTip = 'Specifies the value of the Middle Name field.';
            }
            field(LastName; Rec."Last Name")
            {
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
            field(IDNumber; Rec."ID Number")
            {
                ToolTip = 'Specifies the value of the ID Number field.';
            }
            field(PersonalInfo; PersonalInfo)
            {
                Style = Strong;
                StyleExpr = true;
                ToolTip = 'Specifies the value of the PersonalInfo field.';
            }
            field(Status; Rec.Status)
            {
                ToolTip = 'Specifies the value of the Status field.';
            }
            field(Age; Rec.Age)
            {
                ToolTip = 'Specifies the value of the Age field.';
            }
            field(MaritalStatus; Rec."Marital Status")
            {
                ToolTip = 'Specifies the value of the Marital Status field.';
            }
            field(CommunicationInfo; CommunicationInfo)
            {
                Style = Strong;
                StyleExpr = true;
                ToolTip = 'Specifies the value of the CommunicationInfo field.';
            }
            field(CellPhoneNumber; Rec."Cell Phone Number")
            {
                ExtendedDatatype = PhoneNo;
                ToolTip = 'Specifies the value of the Cell Phone Number field.';
            }
            field(EMail; Rec."E-Mail")
            {
                ExtendedDatatype = EMail;
                ToolTip = 'Specifies the value of the E-Mail field.';
            }
            field(WorkPhoneNumber; Rec."Work Phone Number")
            {
                ExtendedDatatype = PhoneNo;
                ToolTip = 'Specifies the value of the Work Phone Number field.';
            }
        }
    }

    actions
    {
    }

    var
        CommunicationInfo: label 'Communication Information';
        GeneralInfo: label 'General Applicant Information';
        PersonalInfo: label 'Personal Infomation';
}
