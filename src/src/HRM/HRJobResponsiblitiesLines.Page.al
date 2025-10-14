Page 52203094 "HR Job Responsiblities Lines"
{
    CardPageID = "HR Job Responsibilities";
    PageType = List;
    SourceTable = "Employee Responsibility";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(ResponsibilityCode; Rec."Responsibility Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Responsibility Code field.';
                }
                field(ResponsibilityDescription; Rec."Responsibility Description")
                {
                    ToolTip = 'Specifies the value of the Responsibility Description field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
    }
}
