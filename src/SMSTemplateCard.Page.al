namespace PTL.HMISBC;

page 52203223 "SMS Template Card"
{
    ApplicationArea = All;
    Caption = 'SMS Template Card';
    PageType = Card;
    SourceTable = "SMS Templates Table";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.', Comment = '%';
                }
                field(Default; Rec.Default)
                {
                    ToolTip = 'Specifies the value of the Default field.', Comment = '%';
                }
                field("Entity Type"; Rec."Entity Type")
                {
                    ToolTip = 'Specifies the value of the Entity Type field.', Comment = '%';
                }
                field("Version No"; Rec."Version No")
                {
                    ToolTip = 'Specifies the value of the Version No field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
            }
            group( Template)
            {
                Caption = ' Template';
                
                field("Template Text"; Rec."Template Text")
                {
                    ToolTip = 'Specifies the value of the Template Text field.', Comment = '%';
                    MultiLine = true;
                }
            }
        }
    }
}
