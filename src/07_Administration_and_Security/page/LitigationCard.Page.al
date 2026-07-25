Page 85190 "Litigation Card"
{
    PageType = Card;
    SourceTable = "Legal Management";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Requestdate; Rec."Request date")
                {
                    ToolTip = 'Specifies the value of the Request date field.';
                }
                field(RequiredDate; Rec."Required Date")
                {
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field(LitigationStatus; Rec."Litigation Status")
                {
                    ToolTip = 'Specifies the value of the Litigation Status field.';
                }
                field(Name; Rec."Visitor Name")
                {
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(PhoneNumber; Rec."Phone Number")
                {
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field(Description; Rec."Purpose of Visit")
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(FunctionName; Rec."Function Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Function Name field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(ResponsibilityCenter; Rec."Budget Center Name")
                {
                    Caption = 'Responsibility Center';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(MeetingHeld; Rec."Meeting Held?")
                {
                    ToolTip = 'Specifies the value of the Meeting Held? field.';
                }
                field(MeetingScheduleDate; Rec."Meeting Schedule Date")
                {
                    ToolTip = 'Specifies the value of the Meeting Schedule Date field.';
                }
                field(ConcernedDepartmentNotified; Rec."Concerned Department Notified")
                {
                    ToolTip = 'Specifies the value of the Concerned Department Notified field.';
                }
                field(DocumentsAttached; Rec."Documents Attached?")
                {
                    ToolTip = 'Specifies the value of the Documents Attached? field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(InitiatedBy; Rec."Initiated By")
                {
                    ToolTip = 'Specifies the value of the Initiated By field.';
                }
                field(ClearedBy; Rec."Cleared By")
                {
                    ToolTip = 'Specifies the value of the Cleared By field.';
                }
                field(IssueDate; Rec."Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.';
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field(Feedback; Rec.Feedback)
                {
                    ToolTip = 'Specifies the value of the Feedback field.';
                }
                field(Opinions; Rec.Opinions)
                {
                    ToolTip = 'Specifies the value of the Opinions field.';
                }
            }
            group(Litigation)
            {
                Caption = 'Litigation';
                field(CaseDetails; Rec."Case Details")
                {
                    ToolTip = 'Specifies the value of the Case Details field.';
                }
                field(LitigationCleared; Rec."Litigation Cleared")
                {
                    ToolTip = 'Specifies the value of the Litigation Cleared field.';
                }
                group(CourtProcedings)
                {
                    Caption = 'Court Procedings';
                }
                field(ProceedingsDate; Rec."Proceedings Date")
                {
                    ToolTip = 'Specifies the value of the Proceedings Date field.';
                }
                field(CourtNegotiations; Rec."Court Negotiations")
                {
                    ToolTip = 'Specifies the value of the Court Negotiations field.';
                }
                field(CourtSettlementDetails; Rec."Court Settlement Details")
                {
                    ToolTip = 'Specifies the value of the Court Settlement Details field.';
                }
                field(SettlementOutofCourt; Rec."Settlement Out of Court")
                {
                    ToolTip = 'Specifies the value of the Settlement Out of Court field.';
                }
                field(NextCourtSchedule; Rec."Next Court Schedule")
                {
                    ToolTip = 'Specifies the value of the Next Court Schedule field.';
                }
                field(SettlementDate; Rec."Settlement Date")
                {
                    ToolTip = 'Specifies the value of the Settlement Date field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(admin)
            {
                Caption = 'Admit';
                Image = AddContacts;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Admit action.';

                trigger OnAction()
                begin
                    Rec.TestField("Visitor Name");
                    Rec.TestField("ID Number");
                    Rec.TestField("Phone Number");
                    Rec.TestField("Person To See");
                    Rec.TestField("Purpose of Visit");
                    Rec.TestField(Department);
                    Rec.TestField("Visitor Pass No.");

                    if Confirm('Mark visitor as admitted?', true) = false then
                        Error('Cancelled by user: ' + UserId);

                    Rec."Initiated By" := UserId;
                    Rec."Initiated By Time" := Time;
                    Rec."Initiated Date" := Today;
                    Rec.Status := Rec.Status::Entered;
                    Rec.Modify();
                    Message('Admitted!');
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category9;
                ToolTip = 'Executes the Approvals action.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    /*DocumentType:=DocumentType::Requisition;
                    ApprovalEntries.SetRecordFilters(DATABASE::"Store Requistion Header",DocumentType,"No.");
                    ApprovalEntries.RUN;
                    */
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
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
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                begin

                    /*
                    IF NOT LinesExists THEN
                       ERROR('There are no Lines created for this Document');
                    */
                    State := State::Open;
                    if Rec.Status <> Rec.Status::Released then
                        State := State::Open;
                    Rec.TestField("Responsibility Center");
                    /* DocType:=DocType::Requisition;
                     CLEAR(tableNo);
                     tableNo:=DATABASE::"Store Requistion Header";
                     ApprovalMgt.SendApproval(tableNo,Rec."No.",DocType,State,'',"Responsibility Center");*/
                    //    ApprovalMgt.SendApproval(Table_id,Doc_No,Doc_Type,Status,WebUser)

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
                    /* DocType:=DocType::Requisition;
                     showmessage:=TRUE;
                     ManualCancel:=TRUE;
                     CLEAR(tableNo);
                     tableNo:=DATABASE::"Store Requistion Header";
                      IF ApprovalMgt.CancelApproval(tableNo,DocType,Rec."No.",showmessage,ManualCancel) THEN;*/

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            separator(Action7)
            {
            }
            action("Litigation Cleared")
            {
                Caption = 'Litigation Cleared';
                Image = Agreement;
                ToolTip = 'Executes the Litigation Cleared action.';

                trigger OnAction()
                begin
                    if Rec."Court Settlement Details" = '' then
                        Error('Court Settlement Details Have to Be Filled!.');
                    if Confirm('Are you sure you want to proceed and settle the matter out of court?', false) = true then
                        Rec."Send to Litigation" := true;
                    Rec."Settlement Date" := Today;
                    Rec."Settlement Out of Court" := true;
                    Rec."Issue Date" := Today;
                    Rec."Cleared By" := UserId;
                    Rec."Cleared By Time" := Time;
                    Message('The legal Matter has been Settled Out of Court.');
                    Rec."Litigation Status" := Rec."litigation status"::Cleared;
                    Rec."Litigation Cleared" := true;
                    Rec.Modify();
                    Rec.Status := Rec.Status::Approved;
                end;
            }
            separator(Action46)
            {
            }
            action("Settle Out Of Court")
            {
                Caption = 'Settle Out Of Court';
                Image = settle;
                ToolTip = 'Executes the Settle Out Of Court action.';

                trigger OnAction()
                begin
                    if Rec."Settlement Details" = '' then
                        Error('Out Of Court Settlement Details Have to Be Filled!.');
                    if Confirm('Are you sure you want to proceed and settle the matter out of court?', false) = true then
                        Rec."Send to Litigation" := true;
                    Rec."Settlement Date" := Today;
                    Rec."Settlement Out of Court" := true;
                    Rec."Issue Date" := Today;
                    Rec."Cleared By" := UserId;
                    Rec."Cleared By Time" := Time;
                    Message('The legal Matter has been Settled Out of Court.');
                    Rec."Litigation Status" := Rec."litigation status"::Cleared;
                    Rec."Litigation Cleared" := true;
                    Rec.Modify();
                    Rec.Status := Rec.Status::Approved;
                end;
            }
            action("Send To Litigation")
            {
                Caption = 'Send To Litigation';
                Visible = false;
                ToolTip = 'Executes the Send To Litigation action.';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to submit for Litigation?', false) = true then
                        Rec."Send to Litigation" := true;

                    Rec."Issue Date" := Today;
                    Rec."Cleared By" := UserId;
                    Rec."Cleared By Time" := Time;
                    Message('The legal Matter has been Submitted For Litigation.');
                    Rec."Litigation Status" := Rec."litigation status"::Cleared;
                    Rec.Status := Rec.Status::Approved;
                    Rec."Litigation Cleared" := true;
                    Rec.Modify();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        Rec."Created Date" := Today;
        Rec."Created Time" := Time;
        Rec."Initiated By" := UserId;
        Rec."Initiated By Time" := Time;
    end;

    trigger OnOpenPage()
    begin
        Rec."Created Date" := Today;
        Rec."Created Time" := Time;
        Rec."Initiated By" := UserId;
        Rec."Initiated By Time" := Time;
    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
}
