Page 52202899 "HMS Admission Injection"
{
    PageType = ListPart;
    SourceTable = "HMS Admission Injection";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Time; Rec.Time)
                {
                    ToolTip = 'Specifies the value of the Time field.';
                }
                field(InjectionCode; Rec."Injection Code")
                {
                    ToolTip = 'Specifies the value of the Injection Code field.';
                }
                field(InjectionName; Rec."Injection Name")
                {
                    ToolTip = 'Specifies the value of the Injection Name field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
    }
}
