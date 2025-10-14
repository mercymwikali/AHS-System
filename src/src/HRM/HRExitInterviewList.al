page 52202443 "HR Exit Interview List"
{
    CardPageID = "HR Employee Exit Requisition";
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Exit Interviews";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Exit Clearance No"; Rec."Exit Clearance No")
                {
                    ApplicationArea = Basic, Suite;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the value of the Exit Clearance No field.';
                }
                field("Date Of Clearance"; Rec."Date Of Clearance")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Date Of Clearance field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Interview Done By"; Rec."Clearer Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Clearer Name field.';
                }
                field("Nature Of Separation"; Rec."Nature Of Separation")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Nature Of Separation field.';
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Date Of Leaving field.';
                }
                field("Re Employ In Future"; Rec."Re Employ In Future")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Re Employ In Future field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004; Outlook)
            {
            }
            systempart(Control1102755006; Notes)
            {
            }
        }
    }

    actions
    {
    }
}
