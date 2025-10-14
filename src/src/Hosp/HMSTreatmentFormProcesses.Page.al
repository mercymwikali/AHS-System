Page 52202875 "HMS Treatment Form Processes"
{
    PageType = ListPart;
    SourceTable = "HMS Treatment Form Process";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Pulse Rate"; Rec."Pulse Rate")
                {
                    ToolTip = 'Specifies the value of the Pulse Rate field.';
                }
                field("Blood Pressure"; Rec."Blood Pressure")
                {
                    ToolTip = 'Specifies the value of the Blood Pressure field.';
                }
                field(Pain; Rec.Pain)
                {
                    ToolTip = 'Specifies the value of the Pain field.';
                }
            }
        }
    }

    actions
    {
    }
}
