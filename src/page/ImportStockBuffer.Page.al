namespace PTL.HMISBC;

page 85822 "Import Stock Buffer"
{
    ApplicationArea = All;
    Caption = 'Import Stock Buffer';
    PageType = List;
    SourceTable = "Import Stock Buffer";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No"; Rec."Item No")
                {
                    ToolTip = 'Specifies the value of the Item No field.', Comment = '%';
                }
                field("Item Name"; Rec."Item Name")
                {
                    ToolTip = 'Specifies the value of the Item Name field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field(Synched; Rec.Synched)
                {
                    ToolTip = 'Specifies the value of the Synched field.', Comment = '%';
                }
                field("Stock Date"; Rec."Stock Date")
                {
                    ToolTip = 'Specifies the value of the Stock Date field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                }
            }
        }
    }
}
