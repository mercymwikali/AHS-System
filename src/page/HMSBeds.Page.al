Page 85320 "HMS Beds"
{
    PageType = List;
    SourceTable = "HMS Beds";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(WardNo; Rec."Ward No")
                {
                    ToolTip = 'Specifies the value of the Ward No field.';
                }
                field("Room No"; Rec."Room No")
                {
                    ToolTip = 'Specifies the value of the Room No field.';
                }                
                field(BedNo; Rec."Bed No")
                {
                    ToolTip = 'Specifies the value of the Bed No field.';
                }
                field(BedName; Rec."Bed Name")
                {
                    ToolTip = 'Specifies the value of the Bed Name field.';
                }
                field(Occupied; Rec.Occupied)
                {
                    ToolTip = 'Specifies the value of the Occupied field.';
                }
            }
        }
    }

    actions
    {
    }
}
