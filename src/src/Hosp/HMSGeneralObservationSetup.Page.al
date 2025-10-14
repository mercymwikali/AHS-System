Page 52202570 "HMS General Observation Setup"
{
    PageType = List;
    SourceTable = "HMS General Observation Setup";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(SignCode; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
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
