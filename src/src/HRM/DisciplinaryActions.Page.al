Page 52203107 "Disciplinary Actions"
{
    PageType = List;
    SourceTable = "Disciplinary Actions";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Terminate; Rec.Terminate)
                {
                    ToolTip = 'Specifies the value of the Terminate field.';
                }
                field(Document; Rec.Document)
                {
                    ToolTip = 'Specifies the value of the Document field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
            }
        }
    }

    actions
    {
    }
}
