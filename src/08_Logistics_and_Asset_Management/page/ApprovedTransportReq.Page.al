Page 85012 "Approved Transport Req"
{
    Caption = 'Approved Transport Requisition';
    PageType = List;
    SourceTable = "FLT-Transport Requisition";
    SourceTableView = order(ascending)
                      where(Status = filter(Approved));
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
                field(PurposeofTrip; Rec."Purpose of Trip")
                {
                    ToolTip = 'Specifies the value of the Purpose of Trip field.';
                }
                field(DateofTrip; Rec."Date of Trip")
                {
                    ToolTip = 'Specifies the value of the Date of Trip field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field(DateRequisitionReceived; Rec."Date Requisition Received")
                {
                    ToolTip = 'Specifies the value of the Date Requisition Received field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
            }
        }
    }

    actions
    {
    }
}
