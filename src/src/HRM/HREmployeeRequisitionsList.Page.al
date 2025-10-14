Page 52202584 "HR Employee Requisitions List"
{
    CardPageID = "HR Employee Requisition Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Job,Approval,Employee';
    ShowFilter = true;
    SourceTable = "HR Employee Requisitions";

    layout
    {
        area(content)
        {
            repeater(Control18)
            {
                Editable = false;
                field(RequisitionNo; Rec."Requisition No.")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                }
                field(RequisitionDate; Rec."Requisition Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Requisition Date field.';
                }
                field(JobDescription; Rec."Job Description")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job Description field.';
                }
                field(Requestor; Rec.Requestor)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Requestor field.';
                }
                field(ReasonForRequest; Rec."Reason For Request")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Reason For Request field.';
                }
                field(RequiredPositions; Rec."Required Positions")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Required Positions field.';
                }
                field(Contract; Rec."Type of Contract Required")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contract';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract field.';
                }
                field(RequisitionType; Rec."Requisition Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                }
                field(OpeningDate; Rec."Opening Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Opening Date field.';
                }
                field(ClosingDate; Rec."Closing Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Closing Date field.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field(Advertised; Rec.Advertised)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Advertised field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Style = StrongAccent;
                    StyleExpr = true;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(JobID; Rec."Job ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control2; Outlook)
            {
            }
            part(Control1; "HR Employee Req. Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {
                Caption = 'Job';
                action(Responsibilities)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Job Requirement Lines";
                    RunPageLink = "Job Id" = field("Job ID");
                    ToolTip = 'Executes the Responsibilities action.';
                }
            }
            group(Functions)
            {
                Caption = 'Fu&nctions';
                action(Advertise)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Advertise';
                    Image = Salutation;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = AdvertiseVisible;
                    ToolTip = 'Executes the Advertise action.';

                    trigger OnAction()
                    begin
                        /*
                        HREmp.RESET;
                        REPEAT
                        HREmp.TESTFIELD(HREmp."Company E-Mail");
                        SMTP.CreateMessage('Job Advertisement','dgithahu@coretec.co.ke',HREmp."Company E-Mail",
                        'URAIA Job Vacancy','A vacancy with the job description' +"Job Description"+'is open for applications',TRUE);
                        SMTP.Send();
                        UNTIL HREmp.NEXT=0;
                        */
                        Rec.TestField("Requisition Type", Rec."requisition type"::Internal);
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Normal);
                        if HREmp.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                            HREmailParameters.Reset();
                        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."associate with"::"Vacancy Advertisements");
                        if HREmailParameters.Find('-') then begin
                            repeat
                                HREmp.TestField(HREmp."Company E-Mail");
                                SMTP.Create(HREmailParameters."Sender Name", HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
                                HREmailParameters.Body + ' ' + Rec."Job Description" + ' ' + HREmailParameters."Body 2" + ' ' + Format(Rec."Closing Date") + '. ' +
                                HREmailParameters."Body 3"
                                );

                                Semail.Send(SMTP, Enum::"Email Scenario"::Default);
                            until HREmp.Next() = 0;

                            Message('All Employees have been notified about this vacancy');
                        end;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Executes the &Approvals action.';

                    trigger OnAction()
                    begin
                        DocumentType := Documenttype::"Employee Requisition";
                        ApprovalEntries.SetRecordFilters(Database::"HR Employee Requisitions", DocumentType, Rec."Requisition No.");
                        ApprovalEntries.Run();
                    end;
                }
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Executes the &Send Approval Request action.';

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Custom Approvals Codeunit";
                        Varvar: Variant;
                    begin
                        if Confirm('Send this Requisition for Approval?', true) = false then
                            exit;

                        TESTFIELDS();
                        Varvar := Rec;

                        ApprovalMgt.OnSendDocForApproval(Varvar);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Executes the &Cancel Approval Request action.';

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Custom Approvals Codeunit";
                        Varvar: Variant;
                    begin
                        if Confirm('Cancel Approval Request?', true) = false then
                            exit;
                        Varvar := rec;
                        ApprovalMgt.OnCancelDocApprovalRequest(Varvar);
                    end;
                }
                action(MarkasClosedOpen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mark as Closed/Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = AdvertiseVisible;
                    ToolTip = 'Executes the Mark as Closed/Open action.';

                    trigger OnAction()
                    begin
                        if Rec.Closed then begin
                            if not Confirm('Are you sure you want to Re-Open this Document', false) then
                                exit;
                            Rec.Closed := false;
                            Rec.Modify();
                            Message('Employee Requisition %1 has been Re-Opened', Rec."Requisition No.");

                        end else begin
                            if not Confirm('Are you sure you want to close this Document', false) then
                                exit;
                            Rec.Closed := true;
                            Rec.Modify();
                            Message('Employee Requisition %1 has been marked as Closed', Rec."Requisition No.");
                        end;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Executes the &Print action.';

                    trigger OnAction()
                    begin
                        HREmpReq.Reset();
                        HREmpReq.SetRange(HREmpReq."Requisition No.", Rec."Requisition No.");
                        if HREmpReq.Find('-') then
                            Report.Run(70134999, true, true, HREmpReq);
                    end;
                }
                action(ReOpen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = false;
                    ToolTip = 'Executes the Re-Open action.';

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify();
                    end;
                }
            }
            group(Employee)
            {
                Caption = 'Employee';
            }
        }
    }

    trigger OnInit()
    begin
        "Opening DateEditable" := false;
        "Opening DateEditable" := false;
        CloseVisible := false;
        AdvertiseVisible := false;

        UserPersonalization.Reset();
        UserPersonalization.SetRange("User ID", UserId);
        UserPersonalization.SetRange("Profile ID", 'HR');
        if UserPersonalization.Find('-') then begin
            "Opening DateEditable" := true;
            "Opening DateEditable" := true;
            CloseVisible := true;
            AdvertiseVisible := true;
        end
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //  UserPersonalization.RESET;
        //  UserPersonalization.SETRANGE("User ID",USERID);
        //  UserPersonalization.SETRANGE("Profile ID",'HR');
        //  IF UserPersonalization.FIND('-') THEN
        //   ERROR('Cannot add new record');
    end;

    var
        HREmp: Record "HR-Employee";
        HREmailParameters: Record "HR E-Mail Parameters";
        HREmpReq: Record "HR Employee Requisitions";
        UserPersonalization: Record "User Personalization";
        Semail: Codeunit Email;
        SMTP: Codeunit "Email Message";
        ApprovalEntries: Page "Approval Entries";
        AdvertiseVisible: Boolean;
        CloseVisible: Boolean;
        "Opening DateEditable": Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition";

    procedure TESTFIELDS()
    begin
        Rec.TestField("Job ID");
        Rec.TestField("Closing Date");
        Rec.TestField("Type of Contract Required");
        Rec.TestField("Requisition Type");
        Rec.TestField("Required Positions");
        if Rec."Reason For Request" = Rec."reason for request"::Other then
            Rec.TestField("Reason for Request(Other)");
    end;
}
