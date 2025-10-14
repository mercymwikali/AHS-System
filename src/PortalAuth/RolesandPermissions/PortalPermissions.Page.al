namespace PTL.HMISBC;

page 52203232 "Portal Permissions"
{
    ApplicationArea = All;
    Caption = 'Portal Permissions';
    PageType = List;
    SourceTable = "Portal Permission Subjects";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }

                field(Subject; Rec.Subject)
                {
                    ToolTip = 'Specifies the value of the Subject field.', Comment = '%';
                }
            }
        }
    }
}
