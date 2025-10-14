Page 52202462 "HR Back To Office List"
{
    CardPageID = "Hr Back To Office Form";
    Editable = false;
    PageType = List;
    SourceTable = "HRBack To Office Form";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DocumentNo; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field(CourseTitle; Rec."Course Title")
                {
                    ToolTip = 'Specifies the value of the Course Title field.';
                }
                field(FromDate; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field(ToDate; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field(DurationUnits; Rec."Duration Units")
                {
                    ToolTip = 'Specifies the value of the Duration Units field.';
                }
                field(Duration; Rec.Duration)
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field(CostOfTraining; Rec."Cost Of Training")
                {
                    ToolTip = 'Specifies the value of the Cost Of Training field.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(TrainingEvaluationResults; Rec."Training Evaluation Results")
                {
                    ToolTip = 'Specifies the value of the Training Evaluation Results field.';
                }
                field(Trainer; Rec.Trainer)
                {
                    ToolTip = 'Specifies the value of the Trainer field.';
                }
                field(PurposeofTraining; Rec."Purpose of Training")
                {
                    ToolTip = 'Specifies the value of the Purpose of Training field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(UserID; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(Campus; Rec.Campus)
                {
                    ToolTip = 'Specifies the value of the Campus field.';
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(TrainingInstitution; Rec."Training Institution")
                {
                    ToolTip = 'Specifies the value of the Training Institution field.';
                }
                field(Trainingcategory; Rec."Training category")
                {
                    ToolTip = 'Specifies the value of the Training category field.';
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ToolTip = 'Specifies the value of the Supervisor field.';
                }
                field(SupervisorName; Rec."Supervisor Name")
                {
                    ToolTip = 'Specifies the value of the Supervisor Name field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("School Code"; Rec."School Code")
                {
                    ToolTip = 'Specifies the value of the School Code field.';
                }
                field(TrainingStatus; Rec."Training Status")
                {
                    ToolTip = 'Specifies the value of the Training Status field.';
                }
            }
        }
    }

    actions
    {
    }
}
