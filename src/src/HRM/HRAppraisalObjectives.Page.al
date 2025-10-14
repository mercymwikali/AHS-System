Page 52203134 "HR Appraisal Objectives"
{
    PageType = ListPart;
    SourceTable = "Appraisal Objective";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AppraisalCode; Rec."Appraisal Code")
                {
                    ToolTip = 'Specifies the value of the Appraisal Code field.';
                }
                field(CriteriaCode; Rec."Criteria Code")
                {
                    ToolTip = 'Specifies the value of the Criteria Code field.';
                }
                field(CriteriaDescription; Rec."Criteria Description")
                {
                    ToolTip = 'Specifies the value of the Criteria Description field.';
                }
                field(IndicatorCode; Rec."Performance Indicator Code")
                {
                    Caption = 'Indicator Code';
                    ToolTip = 'Specifies the value of the Indicator Code field.';
                }
                field(PerformanceIndicatorDescript; Rec."Performance Indicator Descript")
                {
                    ToolTip = 'Specifies the value of the Performance Indicator Descript field.';
                }
                field(Ratings; Rec.Ratings)
                {
                    ToolTip = 'Specifies the value of the Ratings field.';
                }
                field(RatingDescription; Rec."Rating Description")
                {
                    ToolTip = 'Specifies the value of the Rating Description field.';
                }
                field(HODAsssementSummary; Rec."HOD Asssement Summary")
                {
                    ToolTip = 'Specifies the value of the HOD Asssement Summary field.';
                }
                field(WeakAreasdiscussedwithemployeeHODGeneralComments; Rec."Weak Areas Discussed")
                {
                    Caption = 'Weak Areas discussed with employee(HOD General Comments)';
                    ToolTip = 'Specifies the value of the Weak Areas discussed with employee(HOD General Comments) field.';
                }
                field(EmployeeComments; Rec."Appraisee Comments")
                {
                    Caption = 'Employee Comments';
                    ToolTip = 'Specifies the value of the Employee Comments field.';
                }
            }
        }
    }

    actions
    {
    }
}
