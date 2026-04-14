page 85200 "Water Production"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Water Production";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Name of the Operator"; Rec."Name of the Operator")
                {
                    ToolTip = 'Specifies the value of the Name of the Operator field.';
                }
                field("Time In"; Rec."Time In")
                {
                    ToolTip = 'Specifies the value of the Time In field.';
                }
                field("Time Out"; Rec."Time Out")
                {
                    ToolTip = 'Specifies the value of the Time Out field.';
                }
                field("Chemical Code Used"; Rec."Chemical Code Used")
                {
                    ToolTip = 'Specifies the value of the Chemical Code Used field.';
                }
                field("Chemical Description"; Rec."Chemical Description")
                {
                    ToolTip = 'Specifies the value of the Chemical Description field.';
                }
                field("Chemicals Qty Used"; Rec."Chemicals Qty Used")
                {
                    ToolTip = 'Specifies the value of the Chemicals Qty Used field.';
                }
                field("Metering Type"; Rec."Metering Type")
                {
                    ToolTip = 'Specifies the value of the Metering Type field.';
                }
                field(Units; Rec.Units)
                {
                    ToolTip = 'Specifies the value of the Units field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action(WaterBillprod)
            {
                Caption = 'Water Production';
                RunObject = report "Water Production Register";
                ToolTip = 'Executes the Water Production action.';
            }
        }
    }
}