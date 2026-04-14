Page 85678 "Hr Movement List"
{
    PageType = List;
    SourceTable = "HR Staff Movement";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(CampusCode; Rec."Campus Code")
                {
                    ToolTip = 'Specifies the value of the Campus Code field.';
                }
                field(DepartmentCode; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field(ReportingReasons; Rec."Reporting Reasons")
                {
                    ToolTip = 'Specifies the value of the Reporting Reasons field.';
                }
                field(ReportingDate; Rec."Reporting Date")
                {
                    ToolTip = 'Specifies the value of the Reporting Date field.';
                }
                field(AbsentReasons; Rec."Absent Reasons")
                {
                    ToolTip = 'Specifies the value of the Absent Reasons field.';
                }
                field(AbsentFromDate; Rec."Absent From Date")
                {
                    ToolTip = 'Specifies the value of the Absent From Date field.';
                }
                field(ReleaseStaff; Rec."Release Staff")
                {
                    ToolTip = 'Specifies the value of the Release Staff field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(UserID; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(StaffMovementType; Rec."Staff Movement Type")
                {
                    ToolTip = 'Specifies the value of the Staff Movement Type field.';
                }
                field(RelieverNo; Rec."Reliever No.")
                {
                    ToolTip = 'Specifies the value of the Reliever No. field.';
                }
                field(RelieverName; Rec."Reliever Name")
                {
                    ToolTip = 'Specifies the value of the Reliever Name field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
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
                        DocumentType := Documenttype::StaffMovement;
                        ApprovalEntries.SetRecordFilters(Database::"HR Staff Movement", DocumentType, Rec."No.");
                        ApprovalEntries.Run();
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
                    var
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                        tableNo: Integer;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement;
                        VarVariant: Variant;
                    begin
                        Rec.TestField("Employee No");
                        Rec.TestField(Date);
                        //TESTFIELD("Reliever No.");
                        //  TESTFIELD(Purpose);

                        //Release the Imprest for Approval
                        State := State::Open;
                        if Rec.Status <> Rec.Status::Open then
                            State := State::"Pending Approval";
                        DocType := Doctype::StaffMovement;
                        Clear(tableNo);
                        tableNo := 39004312;
                        //   ApprovalMgt.SendApproval(tableNo,Rec."No.",DocType,State,'',"Responsibility Center"); // ,"Responsibility Center"
                        VarVariant := Rec;
                        IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                            CustomApprovals.OnSendDocForApproval(VarVariant);

                        //  IF ApprovalMgt.SendLeaveApprovalRequest(Rec) THEN;
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
                    var
                        CustomApprovals: Codeunit "Custom Approvals Codeunit";
                        ManualCancel: Boolean;
                        showmessage: Boolean;
                        tableNo: Integer;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement;
                        VarVariant: Variant;
                    begin
                        DocType := Doctype::StaffMovement;
                        showmessage := true;
                        ManualCancel := true;
                        Clear(tableNo);
                        tableNo := 39004312;
                        //  if ApprovalMgt.CancelApproval(tableNo, DocType, Rec."No.", showmessage, ManualCancel) then;
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        // IF ApprovalMgt.CancelLeaveApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action21)
                {
                }
                action(PrintPreview)
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
            }
        }
    }

    var
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement;
}
