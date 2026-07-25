page 85152 "FLT Transport Requisition"
{
    ApplicationArea = all;
    PageType = Document;
    SourceTable = "FLT-Transport Requisition";
    SourceTableView = WHERE(Status = FILTER(Open));
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transport Requisition No"; Rec."Transport Requisition No")
                {
                    ToolTip = 'Specifies the value of the Transport Requisition No field.';
                }
                field(From; Rec.Commencement)
                {
                    Caption = 'From';
                    ToolTip = 'Specifies the value of the From field.';
                }
                field("To"; Rec.Destination)
                {
                    Caption = 'Destination';
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Date of Trip"; Rec."Date of Trip")
                {
                    ToolTip = 'Specifies the value of the Date of Trip field.';
                }
                field("Time of trip"; Rec."Time of trip")
                {
                    ToolTip = 'Specifies the value of the Time of trip field.';
                }
                field("No Of Passangers"; Rec."No Of Passangers")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the No Of Passangers field.';
                }
                field("No of Days Requested"; Rec."No of Days Requested")
                {
                    ToolTip = 'Specifies the value of the No of Days Requested field.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.';
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ToolTip = 'Specifies the value of the Date of Request field.';
                }
                field("Time Requisition Received"; Rec."Time Requisition Received")
                {
                    ToolTip = 'Specifies the value of the Time Requisition Received field.';
                }
                field("P/NO"; Rec."P/NO")
                {
                    ToolTip = 'Specifies the value of the P/NO field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Vehicle Allocated"; Rec."Vehicle Allocated")
                {
                    ToolTip = 'Specifies the value of the Vehicle Allocated field.';
                }
                field("Driver Allocated"; Rec."Driver Allocated")
                {
                    ToolTip = 'Specifies the value of the Driver Allocated field.';
                }
                field("Driver Allocated2"; Rec."Driver Allocated2")
                {
                    ToolTip = 'Specifies the value of the Driver Allocated2 field.';
                }
                field("Driver Allocated3"; Rec."Driver Allocated3")
                {
                    ToolTip = 'Specifies the value of the Driver Allocated3 field.';
                }
                field("Vehicle Allocated by"; Rec."Vehicle Allocated by")
                {
                    ToolTip = 'Specifies the value of the Vehicle Allocated by field.';
                }
                field("Opening Odometer Reading"; Rec."Opening Odometer Reading")
                {
                    ToolTip = 'Specifies the value of the Opening Odometer Reading field.';
                }
                field("Clossing ODO"; Rec."Clossing ODO")
                {
                    ToolTip = 'Specifies the value of the Clossing ODO field.';
                }
                field("Purpose of Trip"; Rec."Purpose of Trip")
                {
                    ToolTip = 'Specifies the value of the Purpose of Trip field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
            }
            group(Lines)
            {
                Caption = 'Lines';
                part(Control29; "FLT Transport Requisition St")
                {
                    SubPageLink = "Req No" = FIELD("Transport Requisition No");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Approvals action.';
                trigger OnAction()
                begin
                    DocumentType := DocumentType::TR;
                    ApprovalEntries.SetRecordFilters(DATABASE::"FLT-Transport Requisition", DocumentType, Rec."Transport Requisition No");
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
                    ApprovalCU: Codeunit "Custom Approvals Codeunit";
                    Variant: Variant;
                begin

                    Rec.TestField(Status, Rec.Status::Open);
                    // TESTFIELD( Commencement);
                    Rec.TestField(Destination);
                    Rec.TestField("Date of Trip");
                    Rec.TestField("Purpose of Trip");

                    Rec."Date Requisition Received" := Today;
                    Rec."Time Requisition Received" := Time;
                    Variant := rec;
                    ApprovalCU.CheckApprovalsWorkflowEnabled(Variant);
                    ApprovalCU.OnSendDocForApproval(Variant);
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
                    ApprovalCU: Codeunit "Custom Approvals Codeunit";
                    Variant: Variant;
                begin
                    Variant := rec;
                    ApprovalCU.CheckApprovalsWorkflowEnabled(Variant);
                    ApprovalCU.OnCancelDocApprovalRequest(Variant);
                end;
            }
            separator(Separator28)
            {
            }
            action("Print/Preview")
            {
                Caption = 'Print/Preview';
                Image = PrintReport;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Print/Preview action.';

                trigger OnAction()
                begin
                    transRe.Reset();
                    transRe.SetFilter(transRe."Transport Requisition No", Rec."Transport Requisition No");
                    if transRe.Find('-') then
                        REPORT.Run(70135479, true, true, transRe);
                    //RESET;
                end;
            }
        }
    }

    var
        transRe: Record "FLT-Transport Requisition";
        ApprovalEntries: Page "Approval Entries";
        // ApprovalMgt: Codeunit "Approvals Management";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
}
