namespace PTL.HMIS;

using Microsoft.Inventory.Item;

page 85024 "Item API"
{
    ApplicationArea = All;
    Caption = 'Item API';
    PageType = List;    
    SourceTable = Item;
    UsageCategory = Lists;
    SourceTableView = ;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the item.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies a description of the item.';
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Specifies the base unit used to measure the item, such as piece, box, or pallet. The base unit of measure also serves as the conversion basis for alternate units of measure.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies if the item card represents a physical inventory unit (Inventory), a labor time unit (Service), or a physical unit that is not tracked in inventory (Non-Inventory).';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price for one unit of the item, in LCY.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the cost per unit of the item.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                }
                field("Number of Days"; Rec."Number of Days")
                {
                    ToolTip = 'Specifies the value of the Number of Days field.', Comment = '%';
                }
                field(Route; Rec.Route)
                {
                    ToolTip = 'Specifies the value of the Route field.', Comment = '%';
                }
                field(Dosage; Rec.Dosage)
                {
                    ToolTip = 'Specifies the value of the Dosage field.', Comment = '%';
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field.', Comment = '%';
                }

                field("Generic Name Code"; Rec."Generic Name Code")
                {
                    ToolTip = 'Specifies the value of the Generic Name field.';
                }
                field("Generic Name"; Rec."Generic Name")
                {
                    ToolTip = 'Specifies the value of the Generic Name field.', Comment = '%';
                }

                field(Inventory; Rec.Inventory)
                {
                    ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';
                }
                
            }
        }
    }
}
