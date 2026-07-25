Page 85184 "Legal Card"
{
    PageType = Card;
    SourceTable = "Legal Management";

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
                field(RequestCategory; Rec."Visitor Category")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Request Category';
                    ToolTip = 'Specifies the value of the Request Category field.';
                }
                field(LitigationStatus; Rec."Litigation Status")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Litigation Status';
                    ToolTip = 'Specifies the value of the Litigation Status field.';
                }
                field(Control11; Rec."Visitor Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
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
                field(Description; Rec."Purpose of Visit")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(FunctionName; Rec."Function Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Function Name field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(DepartmentName; Rec."Budget Center Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Department Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field(ConcernedDepartmentNotified; Rec."Concerned Department Notified")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Concerned Department Notified field.';
                }
                field(DocumentsAttached; Rec."Documents Attached?")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Documents Attached? field.';
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
                field(CreatedDate; Rec."Created Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field(ClearedBy; Rec."Cleared By")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cleared By field.';
                }
                field(IssueDate; Rec."Issue Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Issue Date field.';
                }
            }
            group(Litigation)
            {
                Caption = 'Request Details';
                field("Settlement Details"; Rec."Settlement Details")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Settlement Details field.';
                }
                field("Settlement Date"; Rec."Settlement Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Settlement Date field.';
                }
                field("Settlement Out of Court"; Rec."Settlement Out of Court")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Settlement Out of Court field.';
                }
                field(Opinions; Rec.Opinions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Legal Opinions';
                    ToolTip = 'Specifies the value of the Legal Opinions field.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field(Feedback; Rec.Feedback)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Feedback field.';
                }
                field(SubmittedForLitigation; Rec."Send to Litigation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Submitted For Litigation';
                    ToolTip = 'Specifies the value of the Submitted For Litigation field.';
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
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                begin

                    /*
                    IF NOT LinesExists THEN
                       ERROR('There are no Lines created for this Document');
                    */
                    State := State::Open;
                    if Rec.Status <> Rec.Status::Released then
                        State := State::Open;
                    //TESTFIELD("Responsibility Center");
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
                ApplicationArea = Basic, Suite;
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
            action("Send To Litigation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send To Litigation';
                ToolTip = 'Executes the Send To Litigation action.';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to submit for Litigation?', false) = true then
                        Rec."Send to Litigation" := true;

                    Rec."Issue Date" := Today;
                    Rec."Cleared By" := UserId;
                    Rec."Cleared By Time" := Time;
                    Message('The legal Matter has been Submitted For Litigation.');
                end;
            }
        }
    }

    trigger OnInit()
    begin
        Rec."Created Date" := Today;
        Rec."Created Time" := Time;
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
