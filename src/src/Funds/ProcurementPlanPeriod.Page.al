Page 52202770 "Procurement Plan Period"
{
    PageType = List;
    SourceTable = "Procurement Plan Period";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(PeriodName; Rec."Period Name")
                {
                    ToolTip = 'Specifies the value of the Period Name field.';
                }
            }
        }
    }

    actions
    {
    }
}
