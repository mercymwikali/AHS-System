page 85648 "HR Employee Requisition Card"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approval,Job';
    SourceTable = "HR Employee Requisitions";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Requisition No.Editable";
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Requisition No. field.';
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Requisition Date field.';
                }
                field(Requestor; Rec.Requestor)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Requestor field.';
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job Description field.';
                }
                field("Job Ref No"; Rec."Job Ref No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Job Ref No field.';
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Job Grade field.';
                }
                field("Reason For Request"; Rec."Reason For Request")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Reason For RequestEditable";
                    ToolTip = 'Specifies the value of the Reason For Request field.';
                }
                field("Type of Contract Required"; Rec."Type of Contract Required")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Type of Contract Required field.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PriorityEditable;
                    ToolTip = 'Specifies the value of the Priority field.';
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Vacant Positions field.';
                }
                field("Required Positions"; Rec."Required Positions")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Required PositionsEditable";
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Required Positions field.';
                }
                field("Opening Date"; Rec."Opening Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Opening Date field.';
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Closing DateEditable";
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Closing Date field.';
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Requisition TypeEditable";
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                }
                field(Advertised; Rec.Advertised)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Advertised field.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            group("Additional Information")
            {
                Caption = 'Additional Information';
                field("Any Additional Information"; Rec."Any Additional Information")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = AnyAdditionalInformationEditab;
                    ToolTip = 'Specifies the value of the Any Additional Information field.';
                }
                field("Reason for Request(Other)"; Rec."Reason for Request(Other)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ReasonforRequestOtherEditable;
                    ToolTip = 'Specifies the value of the Reason for Request(Other) field.';
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755022; "HR Employee Req. Factbox")
            {
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            systempart(Control1102755020; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Fu&nctions")
            {
                Caption = 'Fu&nctions';
                action(Advertise)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Advertise';
                    Image = Salutation;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the Advertise action.';

                    trigger OnAction()
                    begin
                        //For external advertisement
                        //TESTFIELD("Requisition Type","Requisition Type"::Internal);
                        if Rec."Requisition Type" <> Rec."Requisition Type"::Internal then
                            if Rec.Advertised then begin
                                if not Confirm('Are you sure you want to Un do advertisement for this job', false) then
                                    exit;
                                Rec.Advertised := false;
                                Rec.Modify();
                                Message('Are you sure you want to Un do advertisement for this job', Rec."Job Ref No");

                            end else begin
                                if not Confirm('Are you sure you want to advertise this Job', false) then
                                    exit;
                                Rec.Advertised := true;
                                Rec.Modify();
                                Message('Job vacancy %1 has been successfuly advertised', Rec."Job Ref No");
                            end
                        else
                            //For Internal advertisement.
                            if Rec."Requisition Type" = Rec."Requisition Type"::Internal then
                                HREmp.SetRange(HREmp.Status, HREmp.Status::Normal);
                        if HREmp.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                            HREmailParameters.Reset();
                        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Vacancy Advertisements");
                        if HREmailParameters.Find('-') then begin
                            repeat
                            /*
                                HREmp.TestField(HREmp."Company E-Mail");
                                SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HREmp."Company E-Mail",
                                HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
                                HREmailParameters.Body + ' ' + "Job Description" + ' ' + HREmailParameters."Body 2" + ' ' + Format("Closing Date") + '. ' +
                                HREmailParameters."Body 3", true);
                                SMTP.Send();
                */
                            until HREmp.Next() = 0;

                            Message('All Employees have been notified about this vacancy');
                            HREmpReq.Advertised := true;
                        end;
                    end;
                }
                action("&Approvals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Approvals action.';
                    trigger OnAction()
                    begin
                        DocumentType := DocumentType::"Employee Requisition";
                        ApprovalEntries.SetRecordFilters(DATABASE::"HR Employee Requisitions", DocumentType, Rec."Requisition No.");
                        ApprovalEntries.Run();
                    end;
                }
                action("&Send Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Send Approval Request action.';
                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Custom Approvals Codeunit";
                        VarVar: Variant;
                    begin
                        if Confirm('Send this Requisition for Approval?', true) = false then
                            exit;

                        TESTFIELDS();
                        VarVar := rec;
                        ApprovalMgt.OnSendDocForApproval(VarVar);
                    end;
                }
                action("&Cancel Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Cancel Approval Request action.';
                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Custom Approvals Codeunit";
                        VarVar: Variant;
                    begin
                        if Confirm('Cancel Approval Request?', true) = false then
                            exit;

                        VarVar := rec;
                        ApprovalMgt.OnCancelDocApprovalRequest(VarVar);
                    end;
                }
                action("Mark as Closed/Open")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mark as Closed/Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category4;
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
                action("Re-Open")
                {
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
            group(Job)
            {
                Caption = 'Job';
                action(Requirements)
                {
                    Caption = 'Requirements';
                    Image = JobListSetup;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Job Requirements";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                    Visible = false;
                    ToolTip = 'Executes the Requirements action.';
                }
                action(Responsibilities)
                {
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Job Responsiblities Lines";
                    RunPageLink = "Responsibility Description" = FIELD("Job ID");
                    Visible = false;
                    ToolTip = 'Executes the Responsibilities action.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls();
        /*
        HRLookupValues.SETRANGE(HRLookupValues.Code,"Type of Contract Required");
        IF HRLookupValues.FIND('-') THEN
        ContractDesc:=HRLookupValues.Description;
        */
    end;

    trigger OnInit()
    begin
        TypeofContractRequiredEditable := true;
        AnyAdditionalInformationEditab := true;
        "Required PositionsEditable" := true;
        "Requisition TypeEditable" := true;
        "Closing DateEditable" := true;
        PriorityEditable := true;
        ReasonforRequestOtherEditable := true;
        "Reason For RequestEditable" := true;
        "Responsibility CenterEditable" := true;
        "Job IDEditable" := true;
        "Requisition DateEditable" := true;
        "Requisition No.Editable" := true;
    end;

    var
        HREmp: Record "HR-Employee";
        HREmailParameters: Record "HR E-Mail Parameters";
        //  ApprovalMgt: Codeunit "Approvals Management";
        HREmpReq: Record "HR Employee Requisitions";
        ApprovalEntries: Page "Approval Entries";
        [InDataSet]
        AnyAdditionalInformationEditab: Boolean;
        [InDataSet]
        "Closing DateEditable": Boolean;
        [InDataSet]
        "Job IDEditable": Boolean;
        [InDataSet]
        PriorityEditable: Boolean;
        [InDataSet]
        "Reason For RequestEditable": Boolean;
        [InDataSet]
        ReasonforRequestOtherEditable: Boolean;
        [InDataSet]
        "Required PositionsEditable": Boolean;
        [InDataSet]
        "Requisition DateEditable": Boolean;
        [InDataSet]
        "Requisition No.Editable": Boolean;
        [InDataSet]
        "Requisition TypeEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        TypeofContractRequiredEditable: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval";

    procedure TESTFIELDS()
    begin
        Rec.TestField("Job ID");
        Rec.TestField("Closing Date");
        Rec.TestField("Type of Contract Required");
        Rec.TestField("Requisition Type");
        Rec.TestField("Required Positions");
        if Rec."Reason For Request" = Rec."Reason For Request"::Other then
            Rec.TestField("Reason for Request(Other)");
    end;

    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Requisition No.Editable" := true;
            "Requisition DateEditable" := true;
            "Job IDEditable" := true;
            "Responsibility CenterEditable" := true;
            "Reason For RequestEditable" := true;
            ReasonforRequestOtherEditable := true;
            PriorityEditable := true;
            "Closing DateEditable" := true;
            "Requisition TypeEditable" := true;
            "Required PositionsEditable" := true;
            "Required PositionsEditable" := true;
            AnyAdditionalInformationEditab := true;
            TypeofContractRequiredEditable := true;
        end else begin
            "Requisition No.Editable" := false;
            "Requisition DateEditable" := false;
            "Job IDEditable" := false;
            "Responsibility CenterEditable" := false;
            "Reason For RequestEditable" := false;
            ReasonforRequestOtherEditable := false;
            PriorityEditable := false;
            "Closing DateEditable" := false;
            "Requisition TypeEditable" := false;
            "Required PositionsEditable" := false;
            "Required PositionsEditable" := false;
            AnyAdditionalInformationEditab := false;

            TypeofContractRequiredEditable := false;
        end;
    end;
}
