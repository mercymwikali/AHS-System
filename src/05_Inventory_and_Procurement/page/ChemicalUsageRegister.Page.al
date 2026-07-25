page 85197 "Chemical Usage Register"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Items Usage Register";
    SourceTableView = where(Type = const(Chemicals));
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
                field("SRN No"; Rec."SRN No")
                {
                    ToolTip = 'Specifies the value of the SRN No field.';
                }
                field("Item No"; Rec."Item No")
                {
                    ToolTip = 'Specifies the value of the Item No field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ToolTip = 'Specifies the value of the Quantity Received field.';
                }
                field("Quantity Used"; Rec."Quantity Used")
                {
                    ToolTip = 'Specifies the value of the Quantity Used field.';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.';
                }
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action(WaterBillReg)
            {
                Caption = 'Material Usage Report';
                RunObject = report "Material Usage";
                ToolTip = 'Executes the Material Usage Report action.';
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.type::Chemicals;
    end;
}