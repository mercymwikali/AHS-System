page 52202995 "Store Requisition Line UP"
{
    ApplicationArea = all;
    PageType = ListPart;
    SourceTable = "Store Requistion Lines";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    ToolTip = 'Specifies the value of the Issuing Store field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field("Quantity Requested"; Rec."Quantity Requested")
                {
                    ToolTip = 'Specifies the value of the Quantity Requested field.';
                }
                field("Quantity To Issue"; Rec."Quantity To Issue")
                {
                    ToolTip = 'Specifies the value of the Quantity To Issue field.';
                }
                field("Quantity Issued"; Rec."Quantity Issued")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity Issued field.';
                }
                field("Qty in store"; Rec."Qty in store")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Qty in store field.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
            }
        }
    }

    actions
    {
    }
}
