Page 85674 "HR Jobs List"
{
    CardPageID = "HR Jobs Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions,Job';
    RefreshOnActivate = true;
    SourceTable = "HR Jobs";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
                field(JobDescription; Rec."Job Description")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job Description field.';
                }
                field(NoofPosts; Rec."No of Posts")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No of Posts field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(OccupiedPositions; Rec."Occupied Positions")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Occupied Positions field.';
                }
                field(VacantPositions; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Vacant Positions field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Style = StandardAccent;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755004; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                Enabled = false;
                Visible = false;
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Enabled = false;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition",Job;
                    begin
                        DocumentType := Documenttype::Job;
                        ApprovalEntries.SetRecordFilters(Database::"HR Jobs", DocumentType, Rec."Job ID");
                        ApprovalEntries.Run();
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Approval Request';
                    Enabled = false;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    ToolTip = 'Executes the Send Approval Request action.';

                    trigger OnAction()
                    begin
                        /*
                        IF CONFIRM('Send this job position for Approval?',TRUE)=FALSE THEN EXIT;
                        AppMgmt.SendJobApprovalReq(Rec);
                        */
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Request';
                    Enabled = false;
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    ToolTip = 'Executes the Cancel Approval Request action.';

                    trigger OnAction()
                    begin
                        /*
                        IF CONFIRM('Cancel Approval Request?',TRUE)=FALSE THEN EXIT;
                        AppMgmt.CancelJobAppRequest(Rec,TRUE,TRUE);
                         */
                    end;
                }
            }
            group(Job)
            {
                Caption = 'Job';
                action(JobCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Jobs Card";
                    RunPageLink = "Job ID" = field("Job ID");
                    ToolTip = 'Executes the Job Card action.';
                }
                action(RaiseRequisition)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Raise Requisition';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Employee Requisitions List";
                    RunPageOnRec = false;
                    ToolTip = 'Executes the Raise Requisition action.';

                    trigger OnAction()
                    begin
                        CurrPage.Close();
                    end;
                }
                action(Requirements)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Requirements';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = field("Job ID");
                    ToolTip = 'Executes the Requirements action.';
                }
                action(ShortListingCriteria)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ShortListing Criteria';
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Job Shortlist Qualification";
                    Visible = false;
                    ToolTip = 'Executes the ShortListing Criteria action.';
                }
            }
        }
    }
}
