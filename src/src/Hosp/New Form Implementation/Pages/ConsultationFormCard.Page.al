namespace PTL.HMIS;

page 52203211 "Consultation Form Card"
{
    ApplicationArea = All;
    Caption = 'Consultation Form Card';
    PageType = List;
    SourceTable = "Consultation Notes Form";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date Taken"; Rec."Date Taken")
                {
                    ToolTip = 'Specifies the value of the Date Taken field.', Comment = '%';
                }
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.', Comment = '%';
                }
                field("Treatment No"; Rec."Encounter No")
                {
                    ToolTip = 'Specifies the value of the Treatment No field.', Comment = '%';
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
            }
        }
    }
    actions
    {
    }
}
