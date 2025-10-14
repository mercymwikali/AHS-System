Page 52203086 "HR Lookup Values List"
{
    PageType = List;
    SourceTable = "HR Lookup Values";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
    }
}