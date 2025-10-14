namespace PTL.HMIS;

page 52203214 "Drug Generic Names Setup"
{
    ApplicationArea = All;
    Caption = 'Drug Generic Names Setup';
    PageType = List;
    SourceTable = "Drug Generic Names";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Generic Code"; Rec."Generic Code")
                {
                    ToolTip = 'Specifies the value of the Generic Code field.';
                }
                field("Generic Name"; Rec."Generic Name")
                {
                    ToolTip = 'Specifies the value of the Generic Name field.', Comment = '%';
                }
                field("No. of Drugs"; Rec."No. of Drugs")
                {
                    ToolTip = 'Specifies the value of the No. of Drugs field.', Comment = '%';
                }
            }
        }
    }
}
