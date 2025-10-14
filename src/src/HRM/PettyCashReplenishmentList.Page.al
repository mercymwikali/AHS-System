namespace PTL.HMISBC;

page 52203224 "Petty Cash Replenishment List"
{
    ApplicationArea = All;
    Caption = 'Petty Cash Requisition List';
    PageType = List;
    SourceTable = "Petty Cash Replenishment";
    CardPageId = "Petty Cash Replenishement Card";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Requisition No"; Rec."Replenishement No")
                {
                    ToolTip = 'Specifies the value of the Requisition No field.', Comment = '%';
                    Editable = false;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ToolTip = 'Specifies the value of the Requisition Date field.', Comment = '%';
                    Editable = false;
                }
                field("Requesting User"; Rec."Requesting User")
                {
                    ToolTip = 'Specifies the value of the Requesting User field.', Comment = '%';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                    Editable = false;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.', Comment = '%';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.', Comment = '%';
                    Editable = false;
                }
                field("Request Amount"; Rec."Request Amount")
                {
                    ToolTip = 'Specifies the value of the Request Amount field.', Comment = '%';
                }
                field("Max Cashier Holding"; Rec."Max Cashier Holding")
                {
                    ToolTip = 'Specifies the value of the Max Cashier Holding field.', Comment = '%';
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ToolTip = 'Specifies the value of the Approval Status field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                    Editable = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ToolTip = 'Specifies the value of the Posted Date field.', Comment = '%';
                    Editable = false;
                }
            }
        }
    }
}
