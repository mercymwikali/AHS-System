page 85097 "Dimension Card"
{
    ApplicationArea = All;
    Caption = 'Dimension Card';
    PageType = CardPart;
    SourceTable = "Dimension Value";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Picture; Rec.Picture)
                {
                    ToolTip = 'Specifies the value of the Picture field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ToolTip = 'Specifies a descriptive name for the dimension value.';
                }
                field("Email Address"; Rec."Email Address")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Email Address field.';
                }
                field("Global Dimension No."; Rec."Global Dimension No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Global Dimension No. field.';
                }
            }
        }
    }
}
