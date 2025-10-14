page 52203114 "HMS Physio Form Process"
{
    PageType = ListPart;
    SourceTable = "HMS Physio Line Process";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                ShowCaption = false;
                field("Process No."; Rec."Process No.")
                {
                    ToolTip = 'Specifies the value of the Process No. field.';
                }
                field("Process Name"; Rec."Process Name")
                {
                    ToolTip = 'Specifies the value of the Process Name field.';
                }
                field("Process Result"; Rec."Process Result")
                {
                    ToolTip = 'Specifies the value of the Process Result field.';
                }
                field("Process Mandatory"; Rec."Process Mandatory")
                {
                    ToolTip = 'Specifies the value of the Process Mandatory field.';
                }
                field("Process Remarks"; Rec."Process Remarks")
                {
                    ToolTip = 'Specifies the value of the Process Remarks field.';
                }
            }
        }
    }

    actions
    {
    }
}
