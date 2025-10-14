Page 52202936 "HMS Observation Signs"
{
    PageType = ListPart;
    SourceTable = "HMS Observation Signs";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(System; Rec.System)
                {
                    ToolTip = 'Specifies the value of the System field.';
                }
                field(SignCode; Rec."Sign Code")
                {
                    ToolTip = 'Specifies the value of the Sign Code field.';
                }
                field(SignDescription; Rec."Sign Description")
                {
                    ToolTip = 'Specifies the value of the Sign Description field.';
                }
            }
        }
    }

    actions
    {
    }
}
