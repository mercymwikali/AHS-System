namespace PTL.HMIS;

page 52203206 "Form Sections Setup"
{
    ApplicationArea = All;
    Caption = 'Form Sections Setup';
    PageType = List;
    SourceTable = "Form Sections";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Form Type"; Rec."Form Type")
                {
                    ToolTip = 'Specifies the value of the Form Type field.';
                }
                field("Section ID"; Rec."Section ID")
                {
                    ToolTip = 'Specifies the value of the Section ID field.', Comment = '%';
                }
                field("Section Name"; Rec."Section Name")
                {
                    ToolTip = 'Specifies the value of the Section Name field.', Comment = '%';
                }
            }
        }
    }
}
