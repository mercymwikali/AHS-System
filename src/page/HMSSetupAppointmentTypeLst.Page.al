Page 85440 "HMS Setup Appointment Type Lst"
{
    CardPageId = "HMS Setup Appointment Typ Card";
    PageType = List;
    SourceTable = "HMS Setup Appointment Type";
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}
