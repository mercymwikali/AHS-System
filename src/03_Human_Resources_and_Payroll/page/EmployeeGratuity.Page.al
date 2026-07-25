Page 85611 "Employee Gratuity"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "prSalary Card";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(GratuityPerc; Rec."Gratuity Perc.")
                {
                    ToolTip = 'Specifies the value of the Gratuity Perc. field.';
                }
            }
        }
    }

    actions
    {
    }
}
