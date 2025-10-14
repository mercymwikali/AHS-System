Page 52202522 "Corporate Card"
{
    PageType = Card;
    SourceTable = "Corporate Management";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Requestdate; Rec."Request date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Request date field.';
                }
                field(RequiredDate; Rec."Required Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Required Date field.';
                }
                field(RequisitioningOfficer; Rec."Requisitioning Officer")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Requisitioning Officer field.';
                }
                field(Name; Rec."Visitor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(PhoneNumber; Rec."Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Phone Number field.';
                }
                field(MeetingScheduleDate; Rec."Meeting Schedule Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Meeting Schedule Date field.';
                }
                field(NatureofMeeting; Rec."Nature of Meeting")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Nature of Meeting field.';
                }
                field(NumberOfParticipants; Rec."Number  Of Participants")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Number  Of Participants field.';
                }
                field(EstimatedDurationOfMeeting; Rec."Estimated Duration Of Meeting")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Estimated Duration Of Meeting field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(InitiatedBy; Rec."Initiated By")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Initiated By field.';
                }
            }
            group(Details)
            {
                Caption = 'HOD';
                field(Reasons; Rec."Reason(s)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Reason(s) field.';
                }
                field(Feedback; Rec.Feedback)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Feedback field.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date field.';
                }
            }
            group(Litigation)
            {
                Caption = 'Communications Officer';
                field(RoomAvailability; Rec."Room Availability")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Room Availability field.';
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Reason field.';
                }
                field(IssueDate; Rec."Issue Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Issue Date field.';
                }
                field(ClearedBy; Rec."Cleared By")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cleared By field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Caption = 'Attachments';
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(admin)
            {
                ApplicationArea = Basic, Suite;
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
                ApplicationArea = Basic, Suite;
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
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send A&pproval Request action.';

                trigger OnAction()
                var
                    Varr: Variant;
                begin

                    Varr := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(Varr) then
                        CustomApprovals.OnSendDocForApproval(Varr);
                end;
            }
            action(cancellsApproval)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval Re&quest action.';

                trigger OnAction()
                begin

                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            separator(Action7)
            {
            }
            action("Allocate Room")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Allocate Room';
                Image = Allocate;
                ToolTip = 'Executes the Allocate Room action.';

                trigger OnAction()
                begin
                    if Rec."Room Availability" <> true then
                        if Confirm('Proceed to Avail this Room For this Meeting?', true) then
                            Rec."Meeting Held?" := true;
                    Rec."Room Availability" := true;
                    Rec.Date := Today;
                    Rec."Issue Date" := Today;
                    Rec."Cleared By" := UserId;
                    Rec."Cleared Date" := Today;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        Rec.Date := Today;
        Rec."Issue Date" := Today;
        Rec."Cleared By" := UserId;
        Rec.SDate := Today;
        Rec.LDate := Today;

        Rec."Initiated By" := UserId;
        Rec."Created Date" := Today;
        Rec."Request date" := Today;
        Rec."Initiated By Time" := Time;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Department;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Department;
    end;

    trigger OnOpenPage()
    begin
        Rec.Date := Today;
        Rec."Issue Date" := Today;
        Rec."Cleared By" := UserId;
        Rec.SDate := Today;
        Rec.LDate := Today;

        Rec."Initiated By" := UserId;
        Rec."Created Date" := Today;
        Rec."Request date" := Today;
        Rec."Initiated By Time" := Time;
    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
}
