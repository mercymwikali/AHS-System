page 52202587 "HR Recruitment Courses"
{
    ApplicationArea = All;
    PageType = list;
    SourceTable = "HR Recruitment Courses";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Specifies the value of the Course Code field.';
                }
                field("Course Description"; Rec."Course Description")
                {
                    ToolTip = 'Specifies the value of the Course Description field.';
                }
            }
        }
    }
}