namespace PTL.HMIS;

page 52203207 "Section Categories Setup"
{
    ApplicationArea = All;
    Caption = 'Form Section Categories';
    PageType = List;
    SourceTable = "Form Category";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Section ID"; Rec."Section ID")
                {
                    ToolTip = 'Specifies the value of the Section ID field.', Comment = '%';
                }
                field("Category ID"; Rec."Category ID")
                {
                    ToolTip = 'Specifies the value of the Category ID field.', Comment = '%';
                }
                field("Category Name"; Rec."Category Name")
                {
                    ToolTip = 'Specifies the value of the Category Name field.', Comment = '%';
                }
                field("Parent Category ID"; Rec."Parent Category ID")
                {
                    ToolTip = 'Specifies the value of the Parent Category ID field.', Comment = '%';
                }
                field("Input Type"; Rec."Input Type")
                {
                    ToolTip = 'Specifies the value of the Input Type field.', Comment = '%';
                }

                field("Has Children"; Rec."Has Children")
                {
                    ToolTip = 'Specifies the value of the Has Children field.', Comment = '%';
                }
                field("Is Leaf Category"; Rec."Is Leaf Category")
                {
                    ToolTip = 'Specifies the value of the Is Leaf Category field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Validate)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    FormCategory: Record "Form Category";
                begin
                    if FormCategory.FindSet() then
                        repeat
                        FormCategory.Validate("Section ID");    
                        FormCategory.Modify();
                        until FormCategory.Next() = 0;
                end;
   
            }
        }
    }
}
