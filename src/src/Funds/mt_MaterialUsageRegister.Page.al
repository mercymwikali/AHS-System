page 52202540 "Material Usage Register"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Items Usage Register";
    SourceTableView = where(Type = const(Materials));
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
                field("Type of Materials"; Rec."Type of Materials")
                {
                    ToolTip = 'Specifies the value of the Type of Materials field.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ToolTip = 'Specifies the value of the Quantity Received field.';
                }
                field("Quantity Used"; Rec."Quantity Used")
                {
                    ToolTip = 'Specifies the value of the Quantity Used field.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ToolTip = 'Specifies the value of the Responsible Person field.';
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
        area(Processing)
        {
            action(ActionName)
            {
                ToolTip = 'Executes the ActionName action.';

                trigger OnAction()
                begin
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.type::Materials;
    end;
}