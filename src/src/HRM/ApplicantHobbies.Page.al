Page 52202439 "Applicant Hobbies"
{
    PageType = List;
    SourceTable = "HR Applicant Hobbies";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Interests; Rec.Interests)
                {
                    ToolTip = 'Specifies the value of the Interests field.';
                }
                field(Hobby; Rec.Hobby)
                {
                    ToolTip = 'Specifies the value of the Hobby field.';
                }
                field(CommunityServices; Rec."Community Services")
                {
                    ToolTip = 'Specifies the value of the Community Services field.';
                }
                field(MajorAchievements; Rec."Major Achievements")
                {
                    ToolTip = 'Specifies the value of the Major Achievements field.';
                }
                field(UserName; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field(EmailAddress; Rec."Email Address")
                {
                    ToolTip = 'Specifies the value of the Email Address field.';
                }
                field(LineNo; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                field(ReligiousAffiliation; Rec."Religious Affiliation")
                {
                    ToolTip = 'Specifies the value of the Religious Affiliation field.';
                }
                field(AttendingChurch; Rec."Attending Church")
                {
                    ToolTip = 'Specifies the value of the Attending Church field.';
                }
                field(ChurchAddress; Rec."Church Address")
                {
                    ToolTip = 'Specifies the value of the Church Address field.';
                }
                field(PastorsName; Rec."Pastors Name")
                {
                    ToolTip = 'Specifies the value of the Pastors Name field.';
                }
                field(ChurchActivities; Rec."Church Activities")
                {
                    ToolTip = 'Specifies the value of the Church Activities field.';
                }
                field(AcceptChrist; Rec."Accept Christ")
                {
                    ToolTip = 'Specifies the value of the Accept Christ field.';
                }
                field(PersonalMinistry; Rec."Personal Ministry")
                {
                    ToolTip = 'Specifies the value of the Personal Ministry field.';
                }
                field(ApplicantNames; Rec."Applicant Names")
                {
                    ToolTip = 'Specifies the value of the Applicant Names field.';
                }
            }
        }
    }

    actions
    {
    }
}
