namespace PTL.HMIS;

page 85544 "Consultation Notes Form"
{
    ApplicationArea = All;
    Caption = 'Consultation Notes Form';
    PageType = List;
    SourceTable = "Consultation Notes Form";
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Report,Form Actions';

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Date Taken"; Rec."Date Taken")
                {
                    ToolTip = 'Specifies the value of the Date Taken field.', Comment = '%';
                    Editable = false;
                }
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.', Comment = '%';
                    Editable = false;
                }
                field("Treatment No"; Rec."Encounter No")
                {
                    ToolTip = 'Specifies the value of the Treatment No field.', Comment = '%';
                    // Visible = false;
                }
                field("Item ID"; Rec."Item ID")
                {
                    ToolTip = 'Specifies the value of the Item ID field.', Comment = '%';
                }

                field("Form Type"; Rec."Form Type")
                {
                    ToolTip = 'Specifies the value of the Form Type field.', Comment = '%';
                    Editable = false;
                }
                field("Section ID";Rec."Section ID")
                {
                    // Visible = false;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ToolTip = 'Specifies the value of the Section Name field.', Comment = '%';
                    Editable = false;
                }
                field("Category ID"; Rec."Category ID")
                {
                    // Visible = false;
                }
                field("Category Name"; Rec."Category Name")
                {
                    ToolTip = 'Specifies the value of the Category Name field.', Comment = '%';
                    Editable = false;
                }
                field("Item Name"; Rec."Item Name")
                {
                    ToolTip = 'Specifies the value of the Item Name field.', Comment = '%';
                    Editable = false;
                }
                field(IsSelected; Rec.IsSelected)
                {
                    ToolTip = 'Specifies the value of the IsSelected field.', Comment = '%';
                }
                field("Other (Specify)"; Rec."Other (Specify)")
                {
                    ToolTip = 'Specifies the value of the Other (Specify) field.', Comment = '%';
                    Enabled = FreeTextEnabled;
                }
                field("Is Text Item"; Rec."Is Text Item")
                {
                    ToolTip = 'Specifies the value of the Is Text Item field.';
                    Enabled = false;
                }
                field("Input Type"; Rec."Input Type")
                {
                    ToolTip = 'Specifies the value of the Input Type field.', Comment = '%';
                    Editable = false;
                }
                // API Specifics
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                    Visible = false;
                }

            }
        }
    }
    var
        FreeTextEnabled: Boolean;

    trigger OnAfterGetRecord()
    begin
        FreeTextEnabled := true;

        if Rec."Is Text Item" then
            FreeTextEnabled := true
        else
            FreeTextEnabled := false;
    end;

}
