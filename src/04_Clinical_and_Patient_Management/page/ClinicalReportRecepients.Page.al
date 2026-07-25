namespace PTL.HMISBC;

page 85008 "Clinical Report Recepients"
{
    ApplicationArea = All;
    Caption = 'Clinical Report Recepients';
    PageType = List;
    SourceTable = "Clinical Report Recepients";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ToolTip = 'Specifies the value of the Phone No field.', Comment = '%';
                }
            }
        }
    }
}
