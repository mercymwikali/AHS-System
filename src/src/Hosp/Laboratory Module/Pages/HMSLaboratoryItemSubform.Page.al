Page 52202930 "HMS Laboratory Item Subform"
{
    PageType = ListPart;
    SourceTable = "HMS Laboratory Item Usage";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(No; Rec."Item No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec."Item Name")
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Unitofmeasure; Rec."Item Unit Of Measure")
                {
                    Caption = 'Unit of measure';
                    ToolTip = 'Specifies the value of the Unit of measure field.';
                }
                field(Quantity; Rec."Item Quantity")
                {
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
            }
        }
    }

    actions
    {
    }
}
