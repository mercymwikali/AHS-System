Page 85439 "HMS Setup Appointment Typ Card"
{
    PageType = Card;
    SourceTable = "HMS Setup Appointment Type";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Bill Consultancy Fee"; Rec."Bill Consultancy Fee")
                {
                    ToolTip = 'Specifies the value of the Bill Consultancy Fee field.';
                }
            }
        }
    }

    actions
    {
    }
}
