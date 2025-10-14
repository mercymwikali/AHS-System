page 52202553 "HMS Item Tracking Lines"
{
    PageType = ListPart;
    SourceTable = "HMS Item Tracking Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lot No Entry No"; Rec."Lot No Entry No")
                {
                    BlankZero = true;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Lot No Entry No field.';
                }
                field("Item No"; Rec."Item No")
                {
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Item No field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Lot No"; Rec."Lot No")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Lot No field.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Remaining Quantity field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
            }
        }
    }

    actions
    {
    }
}
