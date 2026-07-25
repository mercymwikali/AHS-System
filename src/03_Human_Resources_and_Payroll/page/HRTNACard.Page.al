page 85699 "HR TNA Card"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Show';
    SourceTable = "HR Training Needs Analysis";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Application NoEditable";
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Application Date field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Training category"; Rec."Training category")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Training category field.';
                }
                field("Quarter Offered"; Rec."Quarter Offered")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Employee No.Editable";
                    ToolTip = 'Specifies the value of the Quarter Offered field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Directorate; Rec.Directorate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Branch Code';
                    Editable = "Employee DepartmentEditable";
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Directorate Name"; Rec."Directorate Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Branch Name';
                    ToolTip = 'Specifies the value of the Branch Name field.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Need Source field.';
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Course Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = "Course TitleEditable";
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Course Version"; Rec."Course Version")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Course Version field.';
                }
                field("Course Version Description"; Rec."Course Version Description")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Course Version Description field.';
                }
                field("Individual Course"; Rec."Individual Course")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = false;
                    ToolTip = 'Specifies the value of the Individual Course field.';
                }
                field("Proposed Start Date"; Rec."Proposed Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Proposed Start Date field.';
                }
                field("Proposed End Date"; Rec."Proposed End Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Proposed End Date field.';
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Duration Units field.';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cost Of Training field.';
                }
                field("No of Participants"; Rec."No of Participants")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No of Participants field.';
                }
                field("No of Required Participants"; Rec."No of Required Participants")
                {
                    ApplicationArea = Basic, Suite;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the value of the No of Required Participants field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Executes the Comments action.';

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,"BackToOffice ","Training Needs";
                    begin
                        DocumentType := DocumentType::"Training Needs";

                        //ApprovalComments.SetRecordFilters(DATABASE::"HR Training Needs Analysis",DocumentType,Code);
                        //ApprovalComments.SetUpLine(DATABASE::"HR Training Needs Analysis",DocumentType,Code);
                        //ApprovalComments.RUN;
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Training Participants")
                {
                    Caption = 'Training Participants';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Training Partcipants";
                    RunPageLink = "Training Code" = FIELD(Code);
                    ToolTip = 'Executes the Training Participants action.';
                }
                action("Training Cost Elements")
                {
                    Caption = 'Training Cost Elements';
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Training Cost";
                    RunPageLink = "Training Id" = FIELD(Code);
                    ToolTip = 'Executes the Training Cost Elements action.';
                }
                action("&Approvals")
                {
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Approvals action.';

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,"BackToOffice ","Training Needs";
                    begin
                        DocumentType := DocumentType::"Training Needs";
                        ApprovalEntries.SetRecordFilters(DATABASE::"HR Training Needs Analysis", DocumentType, Rec.Code);
                        ApprovalEntries.Run();
                    end;
                }
                action("&Send Approval &Request")
                {
                    Caption = '&Send Approval &Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Send Approval &Request action.';

                    trigger OnAction()
                    begin
                        TESTFIELDS();
                        Rec.CalcFields("No of Participants");
                        if Rec."Training category" = Rec."Training category"::Group then
                            if (Rec."No of Participants" < 2) then begin
                                Error('Participants should not be less than two');
                                if (Rec."No of Participants" > Rec."No of Required Participants") then
                                    Error('Nominated Participants cannot exceed the Number of Participants Required ');
                                if (Rec."No of Participants" <= 0) then
                                    Error('Nominated Participants cannot be Less Than or Equal to Zero');
                            end;
                        if Confirm('Send this Application for Approval?', true) = false then
                            exit;
                        //ApprovalMgt.SendTNAApprovalRequest(Rec);
                    end;
                }
                action("&Cancel Approval request")
                {
                    Caption = '&Cancel Approval request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Cancel Approval request action.';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to cancel the approval request', true) = false then
                            exit;
                        //ApprovalMgt.CancelTNAApprovalReq(Rec,TRUE,TRUE);
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Print action.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        HRTNA.SetRange(HRTNA.Code, Rec.Code);
                        if HRTNA.Find('-') then
                            REPORT.Run(70135375, true, true, HRTNA);
                    end;
                }
                action("<A ction1102755042>")
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    ToolTip = 'Executes the Re-Open action.';

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Responsibility CenterEditable" := true;
            "Application NoEditable" := true;
            "Employee No.Editable" := true;
            "Employee NameEditable" := true;
            "Employee DepartmentEditable" := true;
            "Purpose of TrainingEditable" := true;
            "Course TitleEditable" := true;
        end else begin
            "Responsibility CenterEditable" := false;
            "Application NoEditable" := false;
            "Employee No.Editable" := false;
            "Employee NameEditable" := false;
            "Employee DepartmentEditable" := false;
            "Purpose of TrainingEditable" := false;
            "Course TitleEditable" := false;
        end;

        if Rec."Training category" = Rec."Training category"::Group then
            "Course TitleEditable" := true
        else
            "Course TitleEditable" := false;
    end;

    trigger OnInit()
    begin
        "Course TitleEditable" := true;
        "Purpose of TrainingEditable" := true;
        "Employee DepartmentEditable" := true;
        "Employee NameEditable" := true;
        "Employee No.Editable" := true;
        "Application NoEditable" := true;
        "Responsibility CenterEditable" := true;
        "Course DescriptionEditable" := true;
        "Course TitleEditable" := true;
    end;

    var
        HRTNA: Record "HR Training Needs Analysis";
        [InDataSet]
        "Application NoEditable": Boolean;
        "Course DescriptionEditable": Boolean;
        [InDataSet]
        "Course TitleEditable": Boolean;
        [InDataSet]
        "Employee DepartmentEditable": Boolean;
        [InDataSet]
        "Employee NameEditable": Boolean;
        [InDataSet]
        "Employee No.Editable": Boolean;
        [InDataSet]
        "Purpose of TrainingEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;

    procedure TESTFIELDS()
    begin
        Rec.TestField(Description);
        Rec.TestField("Proposed Start Date");
        Rec.TestField("Proposed End Date");
        //TESTFIELD("Duration Units");
        Rec.TestField(Duration);
        Rec.TestField("Cost Of Training");
        Rec.TestField(Location);
        Rec.TestField("Course Version Description");
        //TESTFIELD("Individual Course");
        Rec.TestField("Need Source")
    end;

    procedure UpdateControls()
    begin

        /*IF "Training category"="Training category"::Group THEN BEGIN
        CurrPage.Description.EDITABLE:=TRUE;
        END ELSE BEGIN
        CurrPage.Description.EDITABLE:=FALSE;
        END;
   */
    end;
}
