Page 85020 "Fuel and Maintenance List"
{
    PageType = List;
    SourceTable = "FLT-Fuel & Maintenance Req.";
    SourceTableView = order(ascending)
                      where(Status = filter(Approved));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(RequisitionNo; Rec."Requisition No")
                {
                    ToolTip = 'Specifies the value of the Requisition No field.';
                }
                field(VehicleRegNo; Rec."Vehicle Reg No")
                {
                    ToolTip = 'Specifies the value of the Vehicle Reg No field.';
                }
                field(VendorDealer; Rec."Vendor(Dealer)")
                {
                    ToolTip = 'Specifies the value of the Vendor(Dealer) field.';
                }
                field(OdometerReading; Rec."Odometer Reading")
                {
                    ToolTip = 'Specifies the value of the Odometer Reading field.';
                }
                field(RequestDate; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field(QuantityofFuelLitres; Rec."Quantity of Fuel(Litres)")
                {
                    ToolTip = 'Specifies the value of the Quantity of Fuel(Litres) field.';
                }
                field(TotalPriceofFuel; Rec."Total Price of Fuel")
                {
                    ToolTip = 'Specifies the value of the Total Price of Fuel field.';
                }
                field(DateTakenforFueling; Rec."Date Taken for Fueling")
                {
                    ToolTip = 'Specifies the value of the Date Taken for Fueling field.';
                }
            }
        }
    }

    actions
    {
    }
}
