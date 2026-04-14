Page 85713 "Other Incidents"
{
    PageType = Document;
    SourceTable = "Other Incidents";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(IncidentDate; Rec."Incident Date")
                {
                    ToolTip = 'Specifies the value of the Incident Date field.';
                }
                field(Incident; Rec.Incident)
                {
                    ToolTip = 'Specifies the value of the Incident field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
            }
        }
    }

    actions
    {
    }
}
