Page 85421 "HMS Radiology SubForm"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "HMS Radiology Form Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(RadiologyNo; Rec."Radiology No.")
                {
                    ToolTip = 'Specifies the value of the Radiology No. field.';
                }
                field(RadiologyDate; Rec."Radiology Date")
                {
                    ToolTip = 'Specifies the value of the Radiology Date field.';
                }
                field(RadiologyTime; Rec."Radiology Time")
                {
                    ToolTip = 'Specifies the value of the Radiology Time field.';
                }
                field(SupervisorID; Rec."Supervisor ID")
                {
                    ToolTip = 'Specifies the value of the Supervisor ID field.';
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
