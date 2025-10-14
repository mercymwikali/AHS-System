namespace PTL.HMIS;

page 52203166 "Mental Status Level Checklist"
{
    ApplicationArea = All;
    Caption = 'Mental Status Level Checklist';
    PageType = List;
    SourceTable = "Mental Status Level Checklist";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Doctor ID";Rec."Doctor ID")
                {

                }
                field("Created By";Rec."Created By")
                {

                }
            }
        }
    }
}
