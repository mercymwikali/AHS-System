Page 52202585 "Applicant References"
{
    PageType = List;
    SourceTable = "HR Applicant Referees";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Names; Rec.Names)
                {
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(Institution; Rec.Institution)
                {
                    ToolTip = 'Specifies the value of the Institution field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(TelephoneNo; Rec."Telephone No")
                {
                    ToolTip = 'Specifies the value of the Telephone No field.';
                }
                field(EMail; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field(LineNo; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                field(ApplicantUsername; Rec."Applicant Username")
                {
                    ToolTip = 'Specifies the value of the Applicant Username field.';
                }
                field(ApplicantEmailAddress; Rec."Applicant Email Address")
                {
                    ToolTip = 'Specifies the value of the Applicant Email Address field.';
                }
                field(ApplicantPostalAddress; Rec."Applicant Postal Address")
                {
                    ToolTip = 'Specifies the value of the Applicant Postal Address field.';
                }
            }
        }
    }

    actions
    {
    }
}
