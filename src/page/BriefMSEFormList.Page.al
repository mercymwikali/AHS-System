namespace PTL.HMISBC;

page 85542 "Brief MSE Form List"
{
    ApplicationArea = All;
    Caption = 'Brief MSE Form List';
    PageType = List;
    SourceTable = "Brief MSE Form";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Date Taken"; Rec."Date Taken")
                {
                    ToolTip = 'Specifies the value of the Date Taken field.', Comment = '%';
                }
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.', Comment = '%';
                }
                field("Encounter No"; Rec."Encounter No")
                {
                    ToolTip = 'Specifies the value of the Encounter No field.', Comment = '%';
                }
                field("Section ID"; Rec."Section ID")
                {
                    ToolTip = 'Specifies the value of the Section ID field.', Comment = '%';
                }
                field("Category ID"; Rec."Category ID")
                {
                    ToolTip = 'Specifies the value of the Category ID field.', Comment = '%';
                }
                field("Item ID"; Rec."Item ID")
                {
                    ToolTip = 'Specifies the value of the Item ID field.', Comment = '%';
                }
                field("Item Name"; Rec."Item Name")
                {
                    ToolTip = 'Specifies the value of the Item Name field.', Comment = '%';
                }
                field(IsSelected; Rec.IsSelected)
                {
                    ToolTip = 'Specifies the value of the IsSelected field.', Comment = '%';
                }
                field("Other (Specify)"; Rec."Other (Specify)")
                {
                    ToolTip = 'Specifies the value of the Other (Specify) field.', Comment = '%';
                }
                field("Section Name"; Rec."Section Name")
                {
                    ToolTip = 'Specifies the value of the Section Name field.', Comment = '%';
                }
                field("Category Name"; Rec."Category Name")
                {
                    ToolTip = 'Specifies the value of the Category Name field.', Comment = '%';
                }
                field("Is Text Item"; Rec."Is Text Item")
                {
                    ToolTip = 'Specifies the value of the Is Text Item field.', Comment = '%';
                }
                field("Form Type"; Rec."Form Type")
                {
                    ToolTip = 'Specifies the value of the Form Type field.', Comment = '%';
                }
                field("Administered By"; Rec."Administered By")
                {
                    ToolTip = 'Specifies the value of the Administered By field.', Comment = '%';
                }

                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }
}
