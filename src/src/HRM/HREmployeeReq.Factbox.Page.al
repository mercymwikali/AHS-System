Page 52202433 "HR Employee Req. Factbox"
{
    PageType = ListPart;
    SourceTable = "HR Jobs";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            field(JobID; Rec."Job ID")
            {
                ToolTip = 'Specifies the value of the Job ID field.';
            }
            field(NoofPosts; Rec."No of Posts")
            {
                ToolTip = 'Specifies the value of the No of Posts field.';
            }
            field(PositionReportingto; Rec."Position Reporting to")
            {
                ToolTip = 'Specifies the value of the Position Reporting to field.';
            }
            field(OccupiedPositions; Rec."Occupied Positions")
            {
                ToolTip = 'Specifies the value of the Occupied Positions field.';
            }
            field(VacantPositions; Rec."Vacant Positions")
            {
                ToolTip = 'Specifies the value of the Vacant Positions field.';
            }
            field(Category; Rec.Category)
            {
                ToolTip = 'Specifies the value of the Category field.';
            }
            field(Grade; Rec.Grade)
            {
                ToolTip = 'Specifies the value of the Grade field.';
            }
            field(EmployeeRequisitions; Rec."Employee Requisitions")
            {
                ToolTip = 'Specifies the value of the Employee Requisitions field.';
            }
            field(SupervisorName; Rec."Supervisor Name")
            {
                ToolTip = 'Specifies the value of the Supervisor Name field.';
            }
            field(Status; Rec.Status)
            {
                ToolTip = 'Specifies the value of the Status field.';
            }
            field(ResponsibilityCenter; Rec."Responsibility Center")
            {
                ToolTip = 'Specifies the value of the Responsibility Center field.';
            }
        }
    }

    actions
    {
    }
}
