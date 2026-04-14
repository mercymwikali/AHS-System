page 85040 "HR Leave Requisition"
{
    ApplicationArea = all;
    PageType = Card;
    SourceTable = "HR Leave Application";
    SourceTableView = where(Status = filter(<> Posted));
    UsageCategory = Documents;
    PromotedActionCategories = 'New,Process,Reports,Approval';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec."Application Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = "Employee NoEditable";
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = "Starting DateEditable";
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Reliever No."; Rec."Reliever No.")
                {
                    Editable = "Starting DateEditable";
                    ToolTip = 'Specifies the value of the Reliever No. field.';
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    Editable = "Starting DateEditable";
                    ToolTip = 'Specifies the value of the Reliever Name field.';
                }
                field("Campus Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Branch Code';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = "Starting DateEditable";
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    Editable = "Starting DateEditable";
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }
                field("Applied Days"; Rec."Applied Days")
                {
                    Editable = "Applied DaysEditable";
                    ToolTip = 'Specifies the value of the Applied Days field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Editable = "Starting DateEditable";
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = "Starting DateEditable";
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Return Date"; Rec."Return Date")
                {
                    Editable = "Starting DateEditable";
                    ToolTip = 'Specifies the value of the Return Date field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    Editable = "Starting DateEditable";
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
                field("Availlable Days"; Rec."Availlable Days")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Availlable Days field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = "Starting DateEditable";
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Approvals action.';
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)
                    end;
                }
                action(sendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Send A&pproval Request action.';

                    trigger OnAction()
                    begin
                        Rec.TestField("Employee No");
                        Rec.TestField("Applied Days");
                        Rec.TestField("Starting Date");
                        Rec.TestField("Reliever No.");
                        Rec.TestField(Purpose);
                        if Rec."Availlable Days" < 1 then
                            Error('Please note that you dont have enough leave balance');

                        //Release the Imprest for Approval
                        Rec.TestField(Status, Rec.Status::Open);
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(cancellsApproval)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Cancel Approval Re&quest action.';

                    trigger OnAction()
                    begin

                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                separator(Separator15)
                {
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Image = PrintReport;
                    Promoted = true;
                    ToolTip = 'Executes the Print/Preview action.';

                    trigger OnAction()
                    var
                        ApplicationForm: report "HR Leave Application Form";
                    begin
                        ApplicationForm.SetTableView(Rec);
                        ApplicationForm.RunModal();
                    end;
                }
                separator(Separator24)
                {
                }
                action("Post Leave Application")
                {
                    Caption = 'Post Leave Application';
                    Image = Post;
                    Promoted = true;
                    ToolTip = 'Executes the Post Leave Application action.';

                    trigger OnAction()
                    var
                    LeaveManagement: Codeunit "Leave Management";
                    begin
                        if Rec.Status <> Rec.Status::Released then
                            Error('The Document Approval is not Complete');

                        Rec.TestField("Employee No");
                        Rec.TestField("Applied Days");
                        Rec.TestField("Starting Date");

                        LeaveManagement.PostLeaveApplication(Rec);
                        
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls();
    end;

    trigger OnInit()
    begin
        PurposeEditable := true;
        "Starting DateEditable" := true;
        "Applied DaysEditable" := true;
        "Department CodeEditable" := true;
        "Campus CodeEditable" := true;
        "Employee NoEditable" := true;
        DateEditable := true;
        "No.Editable" := true;
    end;

    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */
        //SETFILTER("User ID",USERID);
        UpdateControls();
    end;

    var
        HREmp: Record "HR-Employee";
        // MinorAssetsIssue: Record "HMS Patient";
        LeaveEntry: Record "HR Leave Ledger";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        //  ApprovalMgtPortal: Codeunit "Webportal Approvals Mgt";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        [InDataSet]
        "Applied DaysEditable": Boolean;
        [InDataSet]
        "Campus CodeEditable": Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        "Department CodeEditable": Boolean;
        [InDataSet]
        "Employee NoEditable": Boolean;
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        PurposeEditable: Boolean;
        [InDataSet]
        "Starting DateEditable": Boolean;
        VarVariant: Variant;

    procedure UpdateControls()
    begin

        if Rec.Status <> Rec.Status::Open then begin
            "No.Editable" := false;
            DateEditable := false;
            "Employee NoEditable" := false;
            "Campus CodeEditable" := false;
            "Department CodeEditable" := false;
            "Applied DaysEditable" := false;
            "Starting DateEditable" := false;
            PurposeEditable := false;
            //  CurrForm."Process Leave Allowance".EDITABLE:=FALSE;
        end else begin
            "No.Editable" := true;
            DateEditable := true;
            "Employee NoEditable" := true;
            "Campus CodeEditable" := true;
            "Department CodeEditable" := true;
            "Applied DaysEditable" := true;
            "Starting DateEditable" := true;
            PurposeEditable := true;
            // CurrForm."Process Leave Allowance".EDITABLE:=TRUE;
        end;
    end;
}
