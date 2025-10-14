page 52202595 "PC Company Information"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Company Information";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Address; Rec.Address)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Address 2 field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Home Page"; Rec."Home Page")
                {
                    Caption = 'Website';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Website field.';
                }
                field(Vision; Rec.Vision)
                {
                    ToolTip = 'Specifies the value of the Vision field.';
                }
                field(Mission; Rec.Mission)
                {
                    ToolTip = 'Specifies the value of the Mission field.';
                }
                field(Philosophy; Rec.Philosophy)
                {
                    ToolTip = 'Specifies the value of the Philosophy field.';
                }
                field("Core values"; Rec."Core values")
                {
                    ToolTip = 'Specifies the value of the Core values field.';
                }
                field(Motto; Rec.Motto)
                {
                    ToolTip = 'Specifies the value of the Motto field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ToolTip = 'Executes the ActionName action.';

                trigger OnAction()
                begin
                end;
            }
        }
    }
}