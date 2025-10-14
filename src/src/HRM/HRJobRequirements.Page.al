Page 52202941 "HR Job Requirements"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            group("Job Specification")
            {
                Caption = 'Job Details';
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
                field(JobDescription; Rec."Job Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Job Description field.';
                }
            }
            part("Job Requirement Lines"; "Applicant Qualification lines")
            {
                Caption = 'Job Requirements';
                SubPageLink = "Job ID" = field("Job ID");
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Job Requirements")
            {
                ApplicationArea = Basic, Suite;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Employee Pay Element Summary";
                ToolTip = 'Executes the Job Requirements action.';

                trigger OnAction()
                begin
                    HRJobReq.Reset();
                    HRJobReq.SetRange(HRJobReq."Job Id", Rec."Job ID");
                    if HRJobReq.Find('-') then
                        Report.Run(39003924, true, true, HRJobReq);
                end;
            }
        }
    }

    var
        HRJobReq: Record "Job Requirement";
}
