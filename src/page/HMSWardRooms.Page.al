namespace PTL.HMIS;

page 85490 "HMS Ward Rooms"
{
    ApplicationArea = All;
    Caption = 'HMS Ward Rooms';
    PageType = List;
    SourceTable = "HMS Ward Rooms";
    UsageCategory = None;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Room No."; Rec."Room No.")
                {
                    ToolTip = 'Specifies the value of the Room No. field.', Comment = '%';
                }
                field("Ward No"; Rec."Ward No")
                {
                    ToolTip = 'Specifies the value of the Ward No field.', Comment = '%';
                }
                field("Room Name"; Rec."Room Name")
                {
                    ToolTip = 'Specifies the value of the Room Name field.', Comment = '%';
                }
            }
        }
    }
}
