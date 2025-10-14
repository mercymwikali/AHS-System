Page 52202483 "FLT Transport Requisition List"
{
    CardPageID = "FLT Transport Requisition";
    PageType = List;
    SourceTable = "FLT-Transport Requisition";
    SourceTableView = where(Status = filter(Open));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransportRequisitionNo; Rec."Transport Requisition No")
                {
                    ToolTip = 'Specifies the value of the Transport Requisition No field.';
                }
                field(Commencement; Rec.Commencement)
                {
                    ToolTip = 'Specifies the value of the Commencement field.';
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                field(VehicleAllocated; Rec."Vehicle Allocated")
                {
                    ToolTip = 'Specifies the value of the Vehicle Allocated field.';
                }
                field(DriverAllocated; Rec."Driver Allocated")
                {
                    ToolTip = 'Specifies the value of the Driver Allocated field.';
                }
                field(RequestedBy; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.';
                }
                field(DateofRequest; Rec."Date of Request")
                {
                    ToolTip = 'Specifies the value of the Date of Request field.';
                }
                field(VehicleAllocatedby; Rec."Vehicle Allocated by")
                {
                    ToolTip = 'Specifies the value of the Vehicle Allocated by field.';
                }
                field(OpeningOdometerReading; Rec."Opening Odometer Reading")
                {
                    ToolTip = 'Specifies the value of the Opening Odometer Reading field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(ClosingOdometerReading; Rec."Closing Odometer Reading")
                {
                    ToolTip = 'Specifies the value of the Closing Odometer Reading field.';
                }
                field(WorkTicketNo; Rec."Work Ticket No")
                {
                    ToolTip = 'Specifies the value of the Work Ticket No field.';
                }
                field(NoofDaysRequested; Rec."No of Days Requested")
                {
                    ToolTip = 'Specifies the value of the No of Days Requested field.';
                }
                field(Timeout; Rec."Time out")
                {
                    ToolTip = 'Specifies the value of the Time out field.';
                }
                field(TimeIn; Rec."Time In")
                {
                    ToolTip = 'Specifies the value of the Time In field.';
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
                        DocumentType := Documenttype::TR;
                        ApprovalEntries.SetRecordFilters(Database::"FLT-Transport Requisition", DocumentType, Rec."Transport Requisition No");
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
                        Variant: Variant;
                    begin

                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField(Commencement);
                        Rec.TestField(Destination);
                        Rec.TestField("Date of Trip");
                        Rec.TestField("Purpose of Trip");

                        Rec."Date Requisition Received" := Today;
                        Rec."Time Requisition Received" := Time;

                        Variant := Rec;
                        ApprovalMgt.OnSendDocForApproval(Variant);
                        //IF ApprovalMgt.SendApproval(tableNo,Rec."Transport Requisition No",DocType,State) THEN;
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
                        ApprovalMgt: Codeunit "Custom Approvals Codeunit";
                        Variant: Variant;
                    begin

                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField(Commencement);
                        Rec.TestField(Destination);
                        Rec.TestField("Date of Trip");
                        Rec.TestField("Purpose of Trip");

                        Rec."Date Requisition Received" := Today;
                        Rec."Time Requisition Received" := Time;

                        Variant := Rec;
                        ApprovalMgt.OnCancelDocApprovalRequest(Variant);
                        //IF ApprovalMgt.SendApproval(tableNo,Rec."Transport Requisition No",DocType,State) THEN;
                    end;
                }
                separator(Action19)
                {
                }
                action(PrintPreview)
                {
                    Caption = 'Print/Preview';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Print/Preview action.';

                    trigger OnAction()
                    begin
                        TransRe.Reset();
                        TransRe.SetFilter(TransRe."Transport Requisition No", Rec."Transport Requisition No");
                        if TransRe.Find('-') then
                            Report.Run(70135479, true, true, TransRe);
                    end;
                }
            }
        }
    }

    var
        TransRe: Record "FLT-Transport Requisition";
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
}
