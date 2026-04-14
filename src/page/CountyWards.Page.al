namespace PTL.Hospital;

page 85005 "County Wards"
{
    ApplicationArea = All;
    Caption = 'County Wards';
    PageType = List;
    SourceTable = "County Wards";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field.', Comment = '%';
                }
                field("Sub-County"; Rec."Sub-County")
                {
                    ToolTip = 'Specifies the value of the Sub-County field.', Comment = '%';
                }
            }
        }
    }
}
