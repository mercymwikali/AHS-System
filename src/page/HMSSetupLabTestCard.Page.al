Page 85529 "HMS Setup Lab Test Card"
{
    PageType = Card;
    SourceTable = "HMS Setup Lab Test";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            part(Control1102760000; "HMS Setup Lab Test Specimen SF")
            {
                SubPageLink = Test = field(Code);
            }
        }
    }

    actions
    {
    }
}
