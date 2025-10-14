Page 52202702 "HMS Treatment Theatre Lines"
{
    PageType = List;
    SourceTable = "HMS Theatre Line Process";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ProcessNo; Rec."Process No.")
                {
                    ToolTip = 'Specifies the value of the Process No. field.';
                }
                field(ProcessName; Rec."Process Name")
                {
                    ToolTip = 'Specifies the value of the Process Name field.';
                }
                field(ProcessMandatory; Rec."Process Mandatory")
                {
                    ToolTip = 'Specifies the value of the Process Mandatory field.';
                }
                field(ProcessRemarks; Rec."Process Remarks")
                {
                    ToolTip = 'Specifies the value of the Process Remarks field.';
                }
                field(ProcessResult; Rec."Process Result")
                {
                    ToolTip = 'Specifies the value of the Process Result field.';
                }
            }
        }
    }

    actions
    {
    }
}
