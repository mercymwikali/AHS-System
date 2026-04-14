page 85195 "Equipment Maintainance"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Equipment Maint Register";
    SourceTableView = where(Type = const(Maintainance));
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
                field("Correction Measure"; Rec."Correction Measure")
                {
                    ToolTip = 'Specifies the value of the Correction Measure field.';
                }
                field("Time Frame"; Rec."Time Frame")
                {
                    ToolTip = 'Specifies the value of the Time Frame field.';
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
            action(EquipMaint)
            {
                Caption = 'Equipment Maintainance';
                RunObject = report "Plant & Equipment Maint";
                ToolTip = 'Executes the Equipment Maintainance action.';
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.type::Maintainance;
    end;
}