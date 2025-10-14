Page 52202478 "Flt Driver Vehicle List"
{
    PageType = List;
    SourceTable = "Flt Driver Vehicle";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Driver; Rec.Driver)
                {
                    ToolTip = 'Specifies the value of the Driver field.';
                }
                field(DriverName; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field(LicenseNumber; Rec."License Number")
                {
                    ToolTip = 'Specifies the value of the License Number field.';
                }
                field(LicenseExpiry; Rec."License Expiry")
                {
                    ToolTip = 'Specifies the value of the License Expiry field.';
                }
                field(Vehicle; Rec.Vehicle)
                {
                    ToolTip = 'Specifies the value of the Vehicle field.';
                }
                field(VehicleMake; Rec."Vehicle Make")
                {
                    ToolTip = 'Specifies the value of the Vehicle Make field.';
                }
                field(VehicleModel; Rec."Vehicle Model")
                {
                    ToolTip = 'Specifies the value of the Vehicle Model field.';
                }
                field(VehicleRegistrationNo; Rec."Vehicle Registration No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle Registration No. field.';
                }
                field(FromDate; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field(ToDate; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field(RotationNo; Rec."Rotation No")
                {
                    ToolTip = 'Specifies the value of the Rotation No field.';
                }
            }
        }
    }

    actions
    {
    }
}
