namespace PTL.HMIS;

page 52203209 "Form Items Setup"
{
    ApplicationArea = All;
    Caption = 'Form Items Setup';
    PageType = List;
    SourceTable = "Form Items";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item ID"; Rec."Item ID")
                {
                    ToolTip = 'Specifies the value of the Item ID field.', Comment = '%';
                }
                field("Category ID"; Rec."Category ID")
                {
                    ToolTip = 'Specifies the value of the Category ID field.', Comment = '%';
                }
                field("Category Name"; Rec."Category Name")
                {
                    ToolTip = 'Specifies the value of the Category Name field.', Comment = '%';
                    Editable = false;
                }
                field("Item Name"; Rec."Item Name")
                {
                    ToolTip = 'Specifies the value of the Item Name field.', Comment = '%';
                }
                field("Is Text Item"; Rec."Is Text Item")
                {
                    ToolTip = 'Specifies the value of the Is Text Item field.';
                }
                field("Input Type"; Rec."Input Type")
                {
                    ToolTip = 'Specifies the value of the Input Type field.', Comment = '%';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ValidateCategory)
            {
                ApplicationArea = All;
                Caption = 'Validate Category';
                ToolTip = 'Execute the Validate Cateogry Action';
                trigger OnAction()
                var
                    FormItems: Record "Form Items";
                begin
                    FormItems.Reset();
                    if FormItems.FindSet() then
                        repeat
                            FormItems.Validate("Category ID");
                            FormItems.Modify();
                        until FormItems.Next() = 0;
                end;
            }
        }
    }
}
