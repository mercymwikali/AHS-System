Page 52202909 "HMS Laboratory SubForm"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "HMS Laboratory Form Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(LaboratoryNo; Rec."Laboratory No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(LaboratoryDate; Rec."Laboratory Date")
                {
                    ToolTip = 'Specifies the value of the Laboratory Date field.';
                }
                field(LaboratoryTime; Rec."Laboratory Time")
                {
                    ToolTip = 'Specifies the value of the Laboratory Time field.';
                }
                field(ScheduledDate; Rec."Scheduled Date")
                {
                    ToolTip = 'Specifies the value of the Scheduled Date field.';
                }
                field(ScheduledTime; Rec."Scheduled Time")
                {
                    ToolTip = 'Specifies the value of the Scheduled Time field.';
                }
                field(SupervisorID; Rec."Supervisor ID")
                {
                    ToolTip = 'Specifies the value of the Supervisor ID field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
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
