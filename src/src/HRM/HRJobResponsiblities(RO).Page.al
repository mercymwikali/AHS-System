Page 52202975 "HR Job Responsiblities (RO)"
{
    Caption = 'Job Responsiblities';
    PageType = List;
    SourceTable = "Employee Responsibility";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(StartDate; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(ResponsibilityCode; Rec."Responsibility Code")
                {
                    ToolTip = 'Specifies the value of the Responsibility Code field.';
                }
                field(EndDate; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                }
            }
        }
    }

    actions
    {
    }
}
