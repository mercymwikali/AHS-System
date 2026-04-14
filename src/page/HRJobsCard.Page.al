page 85671 "HR Jobs Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approval,Job';
    SourceTable = "HR Jobs";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Control1102755000)
            {
                Caption = 'General';
                field("Job ID"; Rec."Job ID")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
                field("Job Description"; Rec."Job Description")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Job Description field.';
                }
                field("Position Reporting to"; Rec."Position Reporting to")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Position Reporting to field.';
                }
                field("Directorate Code"; Rec."Directorate Code")
                {
                    Caption = 'Branch Code';
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Directorate Name"; Rec."Directorate Name")
                {
                    Caption = 'Branch Name';
                    ToolTip = 'Specifies the value of the Branch Name field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    Caption = 'Department';
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Main Objective"; Rec."Main Objective")
                {
                    ToolTip = 'Specifies the value of the Main Objective field.';
                }
                field("Reason for Job creation"; Rec."Reason for Job creation")
                {
                    ToolTip = 'Specifies the value of the Reason for Job creation field.';
                }
                field("Supervisor/Manager"; Rec."Supervisor/Manager")
                {
                    ToolTip = 'Specifies the value of the Supervisor/Manager field.';
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ToolTip = 'Specifies the value of the Supervisor Name field.';
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ToolTip = 'Specifies the value of the No of Posts field.';
                }
                field("Occupied Positions"; Rec."Occupied Positions")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Occupied Positions field.';
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ToolTip = 'Specifies the value of the Vacant Positions field.';
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ToolTip = 'Specifies the value of the Basic Salary field.';
                }
                field("House Allowance"; Rec."House Allowance")
                {
                    ToolTip = 'Specifies the value of the House Allowance field.';
                }
                field("Salary Scale From"; Rec."Salary Scale From")
                {
                    ToolTip = 'Specifies the value of the Salary Scale From field.';
                }
                field("Salary Scale To"; Rec."Salary Scale To")
                {
                    ToolTip = 'Specifies the value of the Salary Scale To field.';
                }
                field("Medical Insurance Cover IN"; Rec."Medical Insurance Cover IN")
                {
                    ToolTip = 'Specifies the value of the Medical Insurance Cover IN field.';
                }
                field("Medical Insurance Cover OUT"; Rec."Medical Insurance Cover OUT")
                {
                    ToolTip = 'Specifies the value of the Medical Insurance Cover OUT field.';
                }
                field("Type Of Contract"; Rec."Type Of Contract")
                {
                    ToolTip = 'Specifies the value of the Type Of Contract field.';
                }
                field("Employee Requisitions"; Rec."Employee Requisitions")
                {
                    ToolTip = 'Specifies the value of the Employee Requisitions field.';
                }
                field("Key Position"; Rec."Key Position")
                {
                    ToolTip = 'Specifies the value of the Key Position field.';
                }
                field("Memo Ref No."; Rec."Memo Ref No.")
                {
                    ToolTip = 'Specifies the value of the Memo Ref No. field.';
                }
                field("Memo Approval Date"; Rec."Memo Approval Date")
                {
                    ToolTip = 'Specifies the value of the Memo Approval Date field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                    Enabled = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Employment Category"; Rec."Employment Category")
                {
                    ToolTip = 'Specifies the value of the Employment Category field.';
                }
                field("Employment Grade"; Rec."Employment Grade")
                {
                    ToolTip = 'Specifies the value of the Employment Grade field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Enabled = false;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Executes the Approvals action.';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition",Job;
                begin
                    DocumentType := DocumentType::Job;
                    ApprovalEntries.SetRecordFilters(DATABASE::"HR Jobs", DocumentType, Rec."Job ID");
                    ApprovalEntries.Run();
                end;
            }
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Enabled = false;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Executes the Send Approval Request action.';

                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    VarVariant: Variant;
                begin
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = false;
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Executes the Cancel Approval Request action.';

                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    VarVariant: Variant;
                begin
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }

            group(Job)
            {
                Caption = 'Job';
                action("Raise Requisition")
                {
                    Caption = 'Raise Requisition';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Employee Requisitions List";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                    RunPageOnRec = false;
                    ToolTip = 'Executes the Raise Requisition action.';

                    trigger OnAction()
                    begin
                        CurrPage.Close();
                    end;
                }
                action(Occupants)
                {
                    Caption = 'Occupants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Occupants";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                    ToolTip = 'Executes the Occupants action.';
                }
                action(Requirements)
                {
                    Caption = 'Requirements';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = field("Job ID");
                    ToolTip = 'Executes the Requirements action.';
                }
                action("Job Responsibilities")
                {
                    Caption = 'Job Responsibilities';
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Responsibilities";
                    RunPageLink = "Job ID" = field("Job ID");
                    Visible = true;
                    ToolTip = 'Executes the Job Responsibilities action.';
                }
                action("Job Supervisor")
                {
                    Caption = 'Position Supervisor';
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Position Supervised";
                    RunPageLink = "Job ID" = field("Job ID");
                    Visible = true;
                    ToolTip = 'Executes the Position Supervisor action.';
                }
                action("Job RelationShip")
                {
                    Caption = 'Job Working Relationship';
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Job Working Relationships";
                    RunPageLink = "Job ID" = field("Job ID");
                    Visible = true;
                    ToolTip = 'Executes the Job Working Relationship action.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.Validate("Vacant Positions");
    end;
    //  AppMgmt: Codeunit "Approvals Management";
}
