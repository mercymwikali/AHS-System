Page 85368 "HMS Observation SubForm"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "HMS Observation Form Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(ObservationNo; Rec."Observation No.")
                {
                    ToolTip = 'Specifies the value of the Observation No. field.';
                }
                field(ObservationType; Rec."Observation Type")
                {
                    ToolTip = 'Specifies the value of the Observation Type field.';
                }
                field(ObservationDate; Rec."Observation Date")
                {
                    ToolTip = 'Specifies the value of the Observation Date field.';
                }
                field(ObservationTime; Rec."Observation Time")
                {
                    ToolTip = 'Specifies the value of the Observation Time field.';
                }
                field(ObservationRemarks; Rec."Observation Remarks")
                {
                    ToolTip = 'Specifies the value of the Observation Remarks field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
    }
}
