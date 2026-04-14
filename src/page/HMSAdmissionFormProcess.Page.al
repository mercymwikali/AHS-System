Page 85301 "HMS Admission Form Process"
{
    PageType = ListPart;
    SourceTable = "HMS Admission Form Process";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(ProcessCode; Rec."Process Code")
                {
                    ToolTip = 'Specifies the value of the Process Code field.';
                }
                field(Process; Rec.Process)
                {
                    ToolTip = 'Specifies the value of the Process field.';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ToolTip = 'Specifies the value of the Mandatory field.';
                }
                field(Performed; Rec.Performed)
                {
                    ToolTip = 'Specifies the value of the Performed field.';
                }
                field(Time; Time)
                {
                    ToolTip = 'Specifies the value of the Time field.';
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
