page 85759 "Job_Salary grade/steps"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Job_Salary grade/steps";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Employee Category"; Rec."Employee Category")
                {
                    ToolTip = 'Specifies the value of the Employee Category field.';
                }
                field("Salary Grade code"; Rec."Salary Grade code")
                {
                    ToolTip = 'Specifies the value of the Salary Grade code field.';
                }
                field("Grade Level"; Rec."Grade Level")
                {
                    ToolTip = 'Specifies the value of the Grade Level field.';
                }
                field("Grade Description"; Rec."Grade Description")
                {
                    ToolTip = 'Specifies the value of the Grade Description field.';
                }
                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                    ToolTip = 'Specifies the value of the Annual Leave Days field.';
                }
                field("House Allowance"; Rec."House Allowance")
                {
                    ToolTip = 'Specifies the value of the House Allowance field.';
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ToolTip = 'Specifies the value of the Basic Salary field.';
                }
                field("Medical Ceilling"; Rec."Medical Ceilling")
                {
                    ToolTip = 'Specifies the value of the Medical Ceilling field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ToolTip = 'Executes the ActionName action.';

                trigger OnAction()
                begin
                end;
            }
        }
    }
}