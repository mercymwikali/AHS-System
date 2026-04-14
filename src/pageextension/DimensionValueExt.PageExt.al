pageextension 85010 "Dimension Value Ext" extends "Dimension Values"
{
    layout
    {
        addafter(Name)
        {
            field("Default Pharmacy Location"; Rec."Default Pharmacy Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Pharmacy Location field.', Comment = '%';
            }
            field("Invoice No. Series"; Rec."Invoice No. Series")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Invoice No. Series field.';
            }
            field("Receipt No. Series"; Rec."Receipt No. Series")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Receipt No. Series field.';
            }
            field(Picture; Rec.Picture)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Picture field.';
            }
            field("Email Address"; Rec."Email Address")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Email Address field.';
            }
            field(HOD; Rec.HOD)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the HOD field.', Comment = '%';
            }

            field("Phone No."; Rec."Phone No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Phone No. field.';
            }

        }
    }

    actions
    {
        // Add changes to page actions here
        addbefore("F&unctions")
        {
            action(DimensionCard)
            {
                Caption = 'Dimension Card';
                Image = MapDimensions;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Dimension Card";
                RunPageLink = "Dimension Code" = field("Dimension Code"), Code = field(Code);
                ToolTip = 'Executes the Dimension Card action.';
            }
        }
    }
}