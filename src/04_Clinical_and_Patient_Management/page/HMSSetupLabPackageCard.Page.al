Page 85526 "HMS Setup Lab Package Card"
{
    PageType = Card;
    SourceTable = "HMS Setup Lab Package";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            part(Control1102760000; "HMS Setup Lab Pack Test SF")
            {
                SubPageLink = "Lab Package" = field(Code);
            }
        }
    }

    actions
    {
    }
}
