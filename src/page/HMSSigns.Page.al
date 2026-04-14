Page 85455 "HMS Signs"
{
    PageType = List;
    SourceTable = "HMS Signs Setup";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(SignCode; Rec."Sign Code")
                {
                    ToolTip = 'Specifies the value of the Sign Code field.';
                }
                field(SignsName; Rec."Signs Name")
                {
                    ToolTip = 'Specifies the value of the Signs Name field.';
                }
                field(System; Rec.System)
                {
                    ToolTip = 'Specifies the value of the System field.';
                }
            }
        }
    }

    actions
    {
    }
}
