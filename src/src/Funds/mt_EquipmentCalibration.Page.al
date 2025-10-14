page 52202538 "Equipment Calibration"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Equipment Maint Register";
    SourceTableView = where(Type = const(Calibration));
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Asset No."; Rec."Asset No.")
                {
                    ToolTip = 'Specifies the value of the Asset No. field.';
                }
                field("Description."; Rec."Description.")
                {
                    ToolTip = 'Specifies the value of the Description. field.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.';
                }
                field("Date of Calibration"; Rec."Date of Calibration")
                {
                    ToolTip = 'Specifies the value of the Date of Calibration field.';
                }
                field("Date due for Calibration"; Rec."Date due for Calibration")
                {
                    ToolTip = 'Specifies the value of the Date due for Calibration field.';
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
            action(Calibration)
            {
                Caption = 'Equipment Calibration';
                RunObject = report "Equipment Calibration Register";
                ToolTip = 'Executes the Equipment Calibration action.';
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.type::Calibration;
    end;
}