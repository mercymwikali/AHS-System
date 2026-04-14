namespace PTL.HMISBC;

page 85071 "SMS Templates List"
{
    ApplicationArea = All;
    Caption = 'SMS Templates List';
    PageType = List;
    SourceTable = "SMS Templates Table";
    CardPageId = "SMS Template Card";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
        }
    }
}
