Page 52202931 "HMS ward Setup"
{
    PageType = Card;
    SourceTable = "HMS Ward Setup";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(WardCode; Rec."Ward Code")
                {
                    ToolTip = 'Specifies the value of the Ward Code field.';
                }
                field(WardName; Rec."Ward Name")
                {
                    ToolTip = 'Specifies the value of the Ward Name field.';
                }
                field("Charges Code"; Rec."Charges Code")
                {
                    ToolTip = 'Specifies the value of the Charges Code field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Rooms)
            {
                Caption = 'Ward Rooms';
                Promoted = true;
                RunObject = page "HMS Ward Rooms";
                RunPageLink = "Ward No" = field("Ward Code");
                ToolTip = 'Executes the Ward Rooms action.';
            }
            action(Beds)
            {
                Caption = 'Ward Beds';
                Promoted = true;
                RunObject = page "HMS Beds";
                RunPageLink = "Ward No" = field("Ward Code");
                ToolTip = 'Executes the Ward Beds action.';
            }
            action(WardCharges)
            {
                Caption = 'Ward Charges';
                Promoted = true;
                RunObject = page "HMS Ward Charges";
                RunPageLink = "Ward No" = field("Ward Code");
                ToolTip = 'Executes the Ward Charges action.';
            }
        }
    }
}