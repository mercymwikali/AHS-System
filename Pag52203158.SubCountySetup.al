namespace PTL.Hospital;

page 52203159 "Sub-County Setup"
{
    ApplicationArea = All;
    Caption = 'Sub-County Setup"';
    PageType = List;
    SourceTable = "Sub-County Setup";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("County Code"; Rec."County Code")
                {
                    ToolTip = 'Specifies the value of the County Code field.', Comment = '%';
                }
                field("Sub County Code"; Rec."Sub County Code")
                {
                    ToolTip = 'Specifies the value of the Sub County Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
            }
        }
    }
}
