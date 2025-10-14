Page 52202474 "HR Employee Vehicles"
{
    PageType = List;
    SourceTable = "HR Employee Vehicle";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(VehicleRegNo; Rec."Vehicle Reg No")
                {
                    ToolTip = 'Specifies the value of the Vehicle Reg No field.';
                }
                field(VehicleMake; Rec."Vehicle Make")
                {
                    ToolTip = 'Specifies the value of the Vehicle Make field.';
                }
                field(VehicleModel; Rec."Vehicle Model")
                {
                    ToolTip = 'Specifies the value of the Vehicle Model field.';
                }
            }
        }
    }

    actions
    {
    }
}
