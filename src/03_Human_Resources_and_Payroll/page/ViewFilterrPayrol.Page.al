Page 85798 "View Filterr Payrol"
{
    PageType = List;
    SourceTable = "Filter View Payroll";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(ViewPayroll; Rec."View Payroll")
                {
                    ToolTip = 'Specifies the value of the View Payroll field.';
                }
            }
        }
    }

    actions
    {
    }
}
