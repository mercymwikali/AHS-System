Page 52203002 "Expense Code UP"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Expense Code";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
        }
    }

    actions
    {
    }
}
