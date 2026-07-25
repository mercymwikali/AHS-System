page 85642 "HR Employee Exit Requisition"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Exit Interview';
    SourceTable = "HR Employee Exit Interviews";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Exit Clearance No"; Rec."Exit Clearance No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Exit Clearance No field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Directorate Code"; Rec."Directorate Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Branch Code';
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Directorate Name"; Rec."Directorate Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Branch Name';
                    ToolTip = 'Specifies the value of the Branch Name field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Re Employ In Future"; Rec."Re Employ In Future")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Re Employ In Future field.';
                }
                field("Nature Of Separation"; Rec."Nature Of Separation")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Nature Of Separation field.';
                }
                field("Reason For Leaving (Other)"; Rec."Reason For Leaving (Other)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Reason For Leaving (Other) field.';
                }
                field("Date Of Clearance"; Rec."Date Of Clearance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Of Clearance field.';
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Of Leaving field.';
                }
                field("Form Submitted"; Rec."Form Submitted")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Form Submitted field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control1102755010; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Exit Interview")
            {
                Caption = '&Exit Interview';
                action(reprot)
                {
                    Caption = 'Report';
                    Image = "Report";
                    RunObject = Report "HR Exit Interviews";
                    RunPageOnRec = true;
                    ToolTip = 'Executes the Report action.';
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        DocumentType := DocumentType::ExitReq;
                        ApprovalEntries.SetRecordFilters(DATABASE::"HR Employee Exit Interviews", DocumentType, Rec."Exit Clearance No");
                        ApprovalEntries.Run();
                    end;
                }
                separator(Separator4)
                {
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Executes the Send Approval Request action.';

                    trigger OnAction()
                    var
                        tableNo: Integer;
                    begin
                        //Release the Imprest for Approval
                        if Rec.Status = Rec.Status::New then begin//State:=State::"Pending Approval";
                            DocumentType := DocumentType::ExitReq;
                            Clear(tableNo);
                            tableNo := 39005679;
                            //ApprovalMgt.SendApproval(tableNo, "Exit Clearance No", DocumentType, Status, '', "Responsibility Center");
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    ToolTip = 'Executes the Cancel Approval Request action.';

                    trigger OnAction()
                    var
                        ManualCancel: Boolean;
                        // ApprovalMgt: Codeunit "Approvals Management";
                        showmessage: Boolean;
                        tableNo: Integer;
                    begin
                        if Rec.Status = Rec.Status::"Pending Approval" then begin
                            DocumentType := DocumentType::ExitReq;

                            showmessage := true;
                            ManualCancel := true;
                            Clear(tableNo);
                            tableNo := 39005679;
                            // if ApprovalMgt.CancelApproval(tableNo, DocumentType, "Exit Clearance No", showmessage, ManualCancel) then;
                        end;
                    end;
                }
                separator(Separator1)
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if HREmp.Get(Rec."Employee No.") then begin
            JobTitle := HREmp."Job Title";
            sUserID := HREmp."User ID";
        end else begin
            JobTitle := '';
            sUserID := '';
        end;

        Rec.SetRange("Employee No.");
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        RecalcDates();
    end;

    var
        HREmp: Record "HR-Employee";
        ExitCl: Record "HR Employee Exit Interviews";
        Dates: Codeunit "HR Dates";
        sUserID: Code[30];
        DocumentType: Option Quote,"Order","In/voice","Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition","Staff Update",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary,MassPCA,ExitReq;
        JobTitle: Text[30];
        DAge: Text[100];
        DMedical: Text[100];
        DPension: Text[100];
        DService: Text[100];

    procedure RecalcDates()
    begin
        //Recalculate Important Dates
        if (HREmp."Date Of Leaving" = 0D) then begin
            if (HREmp."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(HREmp."Date Of Birth", Today);
            if (HREmp."Date Of Join" <> 0D) then
                DService := Dates.DetermineAge(HREmp."Date Of Join", Today);
            /* IF  (HREmp."Pension Scheme Join Date" <> 0D) THEN
             DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",TODAY);
             IF  (HREmp."Medical Scheme Join Date" <> 0D) THEN
             DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",TODAY);  */
            //MODIFY;
        end else begin
            if (HREmp."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(HREmp."Date Of Birth", HREmp."Date Of Leaving");
            if (HREmp."Date Of Join" <> 0D) then
                DService := Dates.DetermineAge(HREmp."Date Of Join", HREmp."Date Of Leaving");
            /* IF  (HREmp."Pension Scheme Join Date" <> 0D) THEN
             DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",HREmp."Date Of Leaving");
             IF  (HREmp."Medical Scheme Join Date" <> 0D) THEN
             DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",HREmp."Date Of Leaving");*/
            //MODIFY;
        end;
    end;

    local procedure EmployeeNoOnAfterValidate()
    begin
        CurrPage.SaveRecord();
        Rec.FilterGroup := 2;
        ExitCl.SetRange(ExitCl."Employee No.", Rec."Employee No.");
        Rec.FilterGroup := 0;
        if ExitCl.Find('-') then;
        CurrPage.Update(false);
    end;
}
