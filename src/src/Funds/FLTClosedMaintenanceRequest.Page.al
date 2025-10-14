Page 52202509 "FLT Closed Maintenance Request"
{
    PageType = Card;
    SourceTable = "FLT-Fuel & Maintenance Req.";
    SourceTableView = where(Status = filter(Closed),
                            Type = filter(Maintenance));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
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
                field(QuantityofFuelLitres; Rec."Quantity of Fuel(Litres)")
                {
                    ToolTip = 'Specifies the value of the Quantity of Fuel(Litres) field.';
                }
                field(TotalPriceofFuel; Rec."Total Price of Fuel")
                {
                    ToolTip = 'Specifies the value of the Total Price of Fuel field.';
                }
                field(OdometerReading; Rec."Odometer Reading")
                {
                    ToolTip = 'Specifies the value of the Odometer Reading field.';
                }
                field(RequestDate; Rec."Request Date")
                {
                    ToolTip = 'Specifies the value of the Request Date field.';
                }
                field(DateTakenforFueling; Rec."Date Taken for Fueling")
                {
                    ToolTip = 'Specifies the value of the Date Taken for Fueling field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(PreparedBy; Rec."Prepared By")
                {
                    ToolTip = 'Specifies the value of the Prepared By field.';
                }
                field(ClosedBy; Rec."Closed By")
                {
                    ToolTip = 'Specifies the value of the Closed By field.';
                }
                field(DateClosed; Rec."Date Closed")
                {
                    ToolTip = 'Specifies the value of the Date Closed field.';
                }
                field(VendorInvoiceNo; Rec."Vendor Invoice No")
                {
                    ToolTip = 'Specifies the value of the Vendor Invoice No field.';
                }
                field(PostedInvoiceNo; Rec."Posted Invoice No")
                {
                    ToolTip = 'Specifies the value of the Posted Invoice No field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(VendorName; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field(DateTakenforMaintenance; Rec."Date Taken for Maintenance")
                {
                    ToolTip = 'Specifies the value of the Date Taken for Maintenance field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(TypeofMaintenance; Rec."Type of Maintenance")
                {
                    ToolTip = 'Specifies the value of the Type of Maintenance field.';
                }
                field(Driver; Rec.Driver)
                {
                    ToolTip = 'Specifies the value of the Driver field.';
                }
                field(DriverName; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field(FixedAssetNo; Rec."Fixed Asset No")
                {
                    ToolTip = 'Specifies the value of the Fixed Asset No field.';
                }
                field(Oil; Rec.Oil)
                {
                    ToolTip = 'Specifies the value of the Oil field.';
                }
                field(QuoteNo; Rec."Quote No")
                {
                    ToolTip = 'Specifies the value of the Quote No field.';
                }
                field(PriceLitre; Rec."Price/Litre")
                {
                    ToolTip = 'Specifies the value of the Price/Litre field.';
                }
                field(TypeofFuel; Rec."Type of Fuel")
                {
                    ToolTip = 'Specifies the value of the Type of Fuel field.';
                }
                field(Coolant; Rec.Coolant)
                {
                    ToolTip = 'Specifies the value of the Coolant field.';
                }
                field(BatteryWater; Rec."Battery Water")
                {
                    ToolTip = 'Specifies the value of the Battery Water field.';
                }
                field(WheelAlignment; Rec."Wheel Alignment")
                {
                    ToolTip = 'Specifies the value of the Wheel Alignment field.';
                }
                field(WheelBalancing; Rec."Wheel Balancing")
                {
                    ToolTip = 'Specifies the value of the Wheel Balancing field.';
                }
                field(CarWash; Rec."Car Wash")
                {
                    ToolTip = 'Specifies the value of the Car Wash field.';
                }
            }
        }
    }

    actions
    {
    }
}
