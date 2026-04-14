Page 85151 "FLT Transport - Closed List"
{
    CardPageID = "FLT Approved transport Req";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "FLT-Transport Requisition";
    SourceTableView = where(Status = filter(Closed));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(General)
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
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(DateofTrip; Rec."Date of Trip")
                {
                    ToolTip = 'Specifies the value of the Date of Trip field.';
                }
                field(NoOfPassangers; Rec."No Of Passangers")
                {
                    ToolTip = 'Specifies the value of the No Of Passangers field.';
                }
                field(AuthorizedBy; Rec."Authorized  By")
                {
                    ToolTip = 'Specifies the value of the Authorized  By field.';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                }
                field(TransportOfficerRemarks; Rec."Transport Officer Remarks")
                {
                    ToolTip = 'Specifies the value of the Transport Officer Remarks field.';
                }
                field(HODRecommendations; Rec."HOD Recommendations")
                {
                    ToolTip = 'Specifies the value of the HOD Recommendations field.';
                }
                field(FinanceOfficerComments; Rec."Finance Officer Comments")
                {
                    ToolTip = 'Specifies the value of the Finance Officer Comments field.';
                }
                field(NoofDaysRequested; Rec."No of Days Requested")
                {
                    ToolTip = 'Specifies the value of the No of Days Requested field.';
                }
                field(RequestedBy; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.';
                }
                field(DateRequisitionReceived; Rec."Date Requisition Received")
                {
                    ToolTip = 'Specifies the value of the Date Requisition Received field.';
                }
                field(DateofRequest; Rec."Date of Request")
                {
                    ToolTip = 'Specifies the value of the Date of Request field.';
                }
                field(TimeRequisitionReceived; Rec."Time Requisition Received")
                {
                    ToolTip = 'Specifies the value of the Time Requisition Received field.';
                }
                field(PNO; Rec."P/NO")
                {
                    ToolTip = 'Specifies the value of the P/NO field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(VehicleAllocated; Rec."Vehicle Allocated")
                {
                    ToolTip = 'Specifies the value of the Vehicle Allocated field.';
                }
                field(DriverAllocated; Rec."Driver Allocated")
                {
                    ToolTip = 'Specifies the value of the Driver Allocated field.';
                }
                field(VehicleAllocatedby; Rec."Vehicle Allocated by")
                {
                    ToolTip = 'Specifies the value of the Vehicle Allocated by field.';
                }
                field(OpeningOdometerReading; Rec."Opening Odometer Reading")
                {
                    ToolTip = 'Specifies the value of the Opening Odometer Reading field.';
                }
                field(PurposeofTrip; Rec."Purpose of Trip")
                {
                    ToolTip = 'Specifies the value of the Purpose of Trip field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
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
                        DocumentType := Documenttype::TransportRequest;
                        ApprovalEntries.SetRecordFilters(Database::"FLT-Transport Requisition", DocumentType, Rec."Transport Requisition No");
                        ApprovalEntries.Run();
                    end;
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
                        //RESET;
                        //SETFILTER("No.","No.");
                        //REPORT.RUN(70135036,TRUE,TRUE,Rec);
                        //RESET;
                    end;
                }
            }
        }
    }

    var
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest;
}
