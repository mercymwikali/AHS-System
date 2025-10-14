Page 52202476 "HR Employee Weiver"
{
    PageType = Card;
    SourceTable = "HR Employee Tuition Waiver";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(ApplicationDate; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.';
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(DateofAppointment; Rec."Date of Appointment")
                {
                    ToolTip = 'Specifies the value of the Date of Appointment field.';
                }
                field(ContractType; Rec."Contract Type")
                {
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field(From; Rec.From)
                {
                    ToolTip = 'Specifies the value of the From field.';
                }
                field("To"; Rec."To")
                {
                    ToolTip = 'Specifies the value of the To field.';
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ToolTip = 'Specifies the value of the Beneficiary field.';
                }
                field(BeneficiaryRegNo; Rec."Beneficiary RegNo")
                {
                    ToolTip = 'Specifies the value of the Beneficiary RegNo field.';
                }
                field(NameofBeneficiary; Rec."Name of Beneficiary")
                {
                    ToolTip = 'Specifies the value of the Name of Beneficiary field.';
                }
                field(Relationship; Rec.Relationship)
                {
                    ToolTip = 'Specifies the value of the Relationship field.';
                }
                field(BeneficiaryBOB; Rec."Beneficiary BOB")
                {
                    ToolTip = 'Specifies the value of the Beneficiary BOB field.';
                }
                field(BeneficiaryAge; Rec."Beneficiary Age")
                {
                    ToolTip = 'Specifies the value of the Beneficiary Age field.';
                }
                field(NameofProgramme; Rec."Name of Programme")
                {
                    ToolTip = 'Specifies the value of the Name of Programme field.';
                }
                field(SchoolOffering; Rec."School Offering")
                {
                    ToolTip = 'Specifies the value of the School Offering field.';
                }
                field(DurationofStudy; Rec."Duration of Study")
                {
                    ToolTip = 'Specifies the value of the Duration of Study field.';
                }
                field(CurrentYear; Rec."Current Year")
                {
                    ToolTip = 'Specifies the value of the Current Year field.';
                }
                field(CurrentSemester; Rec."Current Semester")
                {
                    ToolTip = 'Specifies the value of the Current Semester field.';
                }
                field(CampusOffering; Rec."Campus Offering")
                {
                    ToolTip = 'Specifies the value of the Campus Offering field.';
                }
                field(TotalTuition; Rec."Total Tuition")
                {
                    ToolTip = 'Specifies the value of the Total Tuition field.';
                }
                field(AmountofWaiver; Rec."Amount of Waiver")
                {
                    ToolTip = 'Specifies the value of the Amount of Waiver field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
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
                        DocumentType := Documenttype::"Leave Application";
                        ApprovalEntries.SetRecordFilters(Database::"HR Employee Tuition Waiver", DocumentType, Rec."No.");
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
                        ApprovalMgt: Codeunit "Custom Approvals Codeunit";
                        tableNo: Integer;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition","Staff Update",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary,MassPCA,ExitReq;
                        VarVariant: Variant;
                    begin
                        /*
                         TESTFIELD("Employee No");
                        TESTFIELD("Applied Days");
                        TESTFIELD("Starting Date");
                         TESTFIELD("Reliever No.");
                          TESTFIELD(Purpose);
                          */
                        // IF "Availlable Days"<1 THEN ERROR('Please note that you dont have enough leave balance');

                        //Release the Imprest for Approval
                        State := State::Open;
                        if Rec.Status <> Rec.Status::Open then
                            State := State::"Pending Approval";
                        DocType := Doctype::"Tuition waiver";
                        Clear(tableNo);
                        tableNo := 39006272;

                        // ApprovalMgt.SendApproval(tableNo,Rec."No.",DocType,State,'',"Responsibility Center"); // ,"Responsibility Center"

                        VarVariant := Rec;
                        IF ApprovalMgt.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                            ApprovalMgt.OnSendDocForApproval(VarVariant);
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
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition","Staff Update",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary,MassPCA,ExitReq;
                        VarVariant: Variant;
                    begin
                        DocType := Doctype::"Tuition waiver";
                        showmessage := true;
                        ManualCancel := true;
                        Clear(tableNo);
                        tableNo := 39006272;
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                separator(Action32)
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
                separator(Action30)
                {
                }
                action(PostWeiver)
                {
                    Caption = 'Post Weiver';
                    Image = Post;
                    Promoted = true;
                    ToolTip = 'Executes the Post Weiver action.';

                    trigger OnAction()
                    begin
                        /*
                        IF Status<>Status::Released THEN ERROR('The Document Approval is not Complete');

                        TESTFIELD("Employee No");
                        TESTFIELD("Applied Days");
                        TESTFIELD("Starting Date");

                        LeaveEntry.INIT;
                        LeaveEntry."Document No":="No.";
                        LeaveEntry."Leave Period":=DATE2DWY(TODAY,3);
                        LeaveEntry."Transaction Date":=Date;
                        LeaveEntry."Employee No":="Employee No";
                        LeaveEntry."Leave Type":="Leave Type";
                        LeaveEntry."No. of Days":=-"Applied Days";
                        LeaveEntry."Transaction Description":=Purpose;
                        LeaveEntry."Entry Type":=LeaveEntry."Entry Type"::Application;
                        LeaveEntry."Created By":=USERID;
                        LeaveEntry."Transaction Type":=LeaveEntry."Transaction Type"::Application;
                        LeaveEntry.INSERT(TRUE);

                      Posted:=TRUE;
                      "Posted By":=USERID;
                      "Posting Date":=TODAY;
                      MODIFY;

                      IF HREmp.GET("Employee No") THEN BEGIN
                      HREmp."On Leave":=TRUE;
                      HREmp."Current Leave No":="No.";
                      HREmp.MODIFY;
                      END;
                      MESSAGE('Leave Posted Successfully');
                      */
                    end;
                }
            }
        }
    }

    var
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition","Staff Update",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary,MassPCA,ExitReq;
}
