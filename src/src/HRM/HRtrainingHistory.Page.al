Page 52202976 "HR training History"
{
    PageType = List;
    SourceTable = "HR Training Applications";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ApplicationNo; Rec."Application No")
                {
                    ToolTip = 'Specifies the value of the Application No field.';
                }
                field(CourseTitle; Rec."Course Title")
                {
                    ToolTip = 'Specifies the value of the Course Title field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(FromDate; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field(ToDate; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field(CostOfTraining; Rec."Cost Of Training")
                {
                    ToolTip = 'Specifies the value of the Cost Of Training field.';
                }
            }
        }
    }

    actions
    {
    }
}
