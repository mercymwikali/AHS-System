namespace PTL.Hospital;

page 52203156 "HMS Clinics SetUp"
{
    ApplicationArea = All;
    Caption = 'HMS Clinics SetUp';
    PageType = List;
    SourceTable = "HMS Clinics Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(clinicType; Rec."Clinic Type")
                {
                    ToolTip = 'Specifies the value of the clinicType field.', Comment = '%';
                }
            }
        }
    }
}
