page 85628 "Hr Back To Office Form"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approvals';
    SourceTable = "HRBack To Office Form";
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Course Title field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field(Trainer; Rec.Trainer)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Trainer field.';
                }
                field("Training Institution"; Rec."Training Institution")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Training Institution field.';
                }
                field("Purpose of Training"; Rec."Purpose of Training")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Purpose of Training field.';
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
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Branch Code';
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Text 1"; Rec."Text 1")
                {
                    Caption = '1.Please state how the course has benefited you and the organization';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the 1.Please state how the course has benefited you and the organization field.';
                }
                field("Text 2"; Rec."Text 2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '2.Which specific areas do you think need improvement in your area of operation?';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the 2.Which specific areas do you think need improvement in your area of operation? field.';
                }
                field("Text 4"; Rec."Text 4")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '4.Provide timeline within which you will cascade the skills learned to others in your Department/organization';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the 4.Provide timeline within which you will cascade the skills learned to others in your Department/organization field.';
                }
                field("Text 3"; Rec."Text 3")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '3.How will you use the skills acquired to address the problem?';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the 3.How will you use the skills acquired to address the problem? field.';
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
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Executes the Comments action.';
                    trigger OnAction()
                    begin
                        /*
                        DocumentType:=DocumentType::"Training Application";

                        ApprovalComments.SetRecordFilters(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        ApprovalComments.SetUpLine(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        ApprovalComments.RUN;
                        */
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Approvals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Approvals action.';
                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,BackToOffice;
                    begin

                        DocumentType := DocumentType::BackToOffice;
                        //ApprovalEntries.SetRecordFilters(DATABASE::"HRBack To Office Form",DocumentType,"Document No");
                        ApprovalEntries.Run();
                    end;
                }
                action("&Send Approval &Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Send Approval &Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Send Approval &Request action.';
                    trigger OnAction()
                    begin

                        if Confirm('Send this Application for Approval?', true) = false then
                            exit;
                        //ApprovalMgt.SendBackOfficeAppApprovalRequest(Rec);
                    end;
                }
                action("&Cancel Approval request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Cancel Approval request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Cancel Approval request action.';
                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to cancel the approval request', true) = false then
                            exit;
                        //ApprovalMgt.CancelBackOfficeAppApprovalReq(Rec,TRUE,TRUE);
                    end;
                }
                action("&Print")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the &Print action.';
                    trigger OnAction()
                    begin
                        /*
                        HRTrainingApplications.SETRANGE(HRTrainingApplications."Application No","Application No");
                        IF HRTrainingApplications.FIND('-') THEN
                        REPORT.RUN(70135375,TRUE,TRUE,HRTrainingApplications);
                        */
                    end;
                }
                separator(Separator1)
                {
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mark as Back to Office';
                    Image = Undo;
                    ToolTip = 'Executes the Mark as Back to Office action.';
                    trigger OnAction()
                    begin
                        if Confirm('Do you really want to mark the employee as back to office?') then begin
                            HREmp.Get(Rec."Employee No.");
                            HREmp."On Leave" := false;
                            HREmp.Modify();
                        end;
                    end;
                }
            }
        }
    }

    var
        //ApprovalMgt: Codeunit "Approvals Management";
        HREmp: Record "HR-Employee";
}
