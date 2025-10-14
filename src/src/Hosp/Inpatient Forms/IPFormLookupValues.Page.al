namespace PTL.HMIS;

page 52203170 "IP Form Lookup Values"
{
    ApplicationArea = All;
    Caption = 'IP Form Lookup Values';
    PageType = List;
    SourceTable = "IP Form Lookup Values";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                }
                field("Sub Category"; Rec."Sub Category")
                {
                    ToolTip = 'Specifies the value of the Sub Category field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
