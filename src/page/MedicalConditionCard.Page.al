Page 85539 "Medical Condition Card"
{
    PageType = Card;
    SourceTable = "Medical Condition";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ToolTip = 'Specifies the value of the Mandatory field.';
                }
                field(Family; Rec.Family)
                {
                    ToolTip = 'Specifies the value of the Family field.';
                }
            }
        }
    }

    actions
    {
    }
}
