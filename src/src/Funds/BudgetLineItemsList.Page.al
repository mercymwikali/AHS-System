Page 52202583 "Budget Line Items List"
{
    PageType = List;
    SourceTable = "Budget Line Items";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Use; Rec.Use)
                {
                    ToolTip = 'Specifies the value of the Use field.';
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
