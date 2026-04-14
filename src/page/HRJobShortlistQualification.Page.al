Page 85673 "HR Job Shortlist Qualification"
{
    PageType = List;
    SourceTable = "HR ShortListQualifications";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(ShortListType; Rec."ShortList Type")
                {
                    ToolTip = 'Specifies the value of the ShortList Type field.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}
