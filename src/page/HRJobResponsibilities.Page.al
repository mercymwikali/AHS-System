Page 85668 "HR Job Responsibilities"
{
    Caption = 'HR Job Responsibilities';
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = list;
    PromotedActionCategories = 'New,Process,Reports,Qualification';
    SourceTable = "Employee Responsibility";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'Job Details';
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
                field(ResponsibilityDescription; Rec."Responsibility Description")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Responsibility Description field.';
                }
                field(ResponsibilityCode; Rec."Responsibility Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Responsibility Code field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Evaluation Areas")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Import Evaluation Areas action.';

                trigger OnAction()
                begin

                    //DELETE RESPONSIBILITIES PREVIOUSLY IMPORTED
                    HRJobResponsibilities.Reset();
                    HRJobResponsibilities.SetRange(HRJobResponsibilities."Responsibility Description", Rec."Responsibility Description");
                    if HRJobResponsibilities.Find('-') then
                        HRJobResponsibilities.DeleteAll();

                    //IMPORT EVALUATION AREAS FOR THIS JOB
                    HRAppraisalEvaluationAreas.Reset();
                    HRAppraisalEvaluationAreas.SetRange(HRAppraisalEvaluationAreas."Assign To", Rec."Responsibility Description");
                    if HRAppraisalEvaluationAreas.Find('-') then
                        HRAppraisalEvaluationAreas.FindFirst();
                    begin
                        HRJobResponsibilities.Reset();
                        repeat
                            HRJobResponsibilities.Init();
                            HRJobResponsibilities."Responsibility Description" := Rec."Responsibility Description";
                            HRJobResponsibilities."Responsibility Code" := HRAppraisalEvaluationAreas.Code;
                            HRJobResponsibilities.Remarks := HRAppraisalEvaluationAreas.Description;
                            HRJobResponsibilities.Insert();
                        until HRAppraisalEvaluationAreas.Next() = 0;
                    end;
                end;
            }
        }
    }

    var
        HRJobResponsibilities: Record "Employee Responsibility";
        HRAppraisalEvaluationAreas: Record "HR Appraisal Evaluation Areas";
}
