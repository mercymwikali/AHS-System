pageextension 85015 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addafter("Common Item No.")
        {
            field("Item G/L Budget Account1"; Rec."Item G/L Budget Account1")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the number of the production BOM that the item represents.';
            }
            field("Unit Price Insurance"; Rec."Unit Price Insurance")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Unit Price Insurance field.';
            }
            field("Minimum Unit Price"; Rec."Minimum Unit Price")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Minimum Unit Price field.';
            }
            field("Maximum Unit Price"; Rec."Maximum Unit Price")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Maximum Unit Price field.';
            }
            field("Sales Account"; Rec."Sales Account")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Sales Account field.';
            }
            field("NHIF Covered"; Rec."NHIF Covered")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the NHIF Covered field.';
            }
        }
        addafter(Description)
        {
            field("Generic Name Code"; Rec."Generic Name Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Generic Name field.';
            }
            field("Generic Name"; Rec."Generic Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Generic Name field.', Comment = '%';
            }

        }
    }
    actions
    {
        // Add changes to page actions here
    }
    trigger OnModifyRecord(): Boolean
    var
        UserRec: Record "User Setup";
    begin
        userrec.get(Database.UserId);
        UserRec.TestField("Can Create Items", true);
    end;
}