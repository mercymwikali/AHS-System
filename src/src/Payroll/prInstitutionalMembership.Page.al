Page 52202809 "prInstitutional Membership"
{
    PageType = List;
    SourceTable = "prInstitutional Membership";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(GroupNo; Rec."Group No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Group No field.';
                }
                field(InstitutionNo; Rec."Institution No")
                {
                    ToolTip = 'Specifies the value of the Institution No field.';
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
