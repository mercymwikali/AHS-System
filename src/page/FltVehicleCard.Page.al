page 85018 "Flt Vehicle Card"
{
    PageType = Card;
    SourceTable = "FLT-Vehicle Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Responsible Employee field.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Serial No. field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(Inactive; Rec.Inactive)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Inactive field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Last Service Date"; Rec."Last Service Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Last Service Date field.';
                }
                field("Service Interval"; Rec."Service Interval")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Service Interval field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
            group(Posting)
            {
                field("FA Class Code"; Rec."FA Class Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the FA Class Code field.';
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the FA Subclass Code field.';
                }
                field("FA Location Code"; Rec."FA Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the FA Location Code field.';
                }
                field("Budgeted Asset"; Rec."Budgeted Asset")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Budgeted Asset field.';
                }
            }
            group(Maintenance)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Maintenance Vendor No."; Rec."Maintenance Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Maintenance Vendor No. field.';
                }
                field("Next Service Date"; Rec."Next Service Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Next Service Date field.';
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Warranty Date field.';
                }
                field(Insured; Rec.Insured)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insured field.';
                }
                field("Under Maintenance"; Rec."Under Maintenance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Under Maintenance field.';
                }
            }
            group("Vehicle Details")
            {
                field(Make; Rec.Make)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Make field.';
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field("Year Of Manufacture"; Rec."Year Of Manufacture")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Year Of Manufacture field.';
                }
                field("Country Of Origin"; Rec."Country Of Origin")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Country Of Origin field.';
                }
                field(Ownership; Rec.Ownership)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Ownership field.';
                }
                field("Body Color"; Rec."Body Color")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Body Color field.';
                }
                field("Interior Color"; Rec."Interior Color")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Interior Color field.';
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Registration No. field.';
                }
                field("Chassis Serial No."; Rec."Chassis Serial No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Chassis Serial No. field.';
                }
                field("Engine Serial No."; Rec."Engine Serial No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Engine Serial No. field.';
                }
                field("Ignition Key Code"; Rec."Ignition Key Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Ignition Key Code field.';
                }
                field("Door Key Code"; Rec."Door Key Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Door Key Code field.';
                }
                field("Tare Weight"; Rec."Tare Weight")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Tare Weight field.';
                }
                field("Passenger Capacity"; Rec."Passenger Capacity")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Passenger Capacity field.';
                }
            }
            group("Drive train")
            {
                field("Horse Power"; Rec."Horse Power")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Horse Power field.';
                }
                field(Cylinders; Rec.Cylinders)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cylinders field.';
                }
                field("Tire Size Rear"; Rec."Tire Size Rear")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Tire Size Rear field.';
                }
                field("Tire Size Front"; Rec."Tire Size Front")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Tire Size Front field.';
                }
            }
            group("Mileage/Hrs Worded Details")
            {
                field("Readings Based On"; Rec."Readings Based On")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Readings Based On field.';
                }
                field("Start Reading"; Rec."Start Reading")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Start Reading field.';
                }
                field("Current Reading"; Rec."Current Reading")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Current Reading field.';
                }
                field("Fuel Type"; Rec."Fuel Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Fuel Type field.';
                }
                field("Fuel Rating"; Rec."Fuel Rating")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Fuel Rating field.';
                }
                field("Total Consumption"; Rec."Total Consumption")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Total Consumption field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Open_Travel)
            {
                Caption = 'Open Travel Requests';
                Image = ResourceSetup;
                Promoted = true;
                RunObject = Page "Approved Transport Req";
                RunPageLink = "Vehicle Allocated" = FIELD("Registration No.");
                ToolTip = 'Executes the Open Travel Requests action.';
            }
            action(Open_Maint)
            {
                Caption = 'Open Maintenance/Fuel Requests';
                Image = History;
                Promoted = true;
                RunObject = Page "Fuel and Maintenance List";
                RunPageLink = "Vehicle Reg No" = FIELD("Registration No.");
                ToolTip = 'Executes the Open Maintenance/Fuel Requests action.';
            }
        }
    }
}
