Page 85708 "KNCHR Commitee Members"
{
    PageType = List;
    SourceTable = "KNCHR Commitee Members";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Membertype; Rec."Member type")
                {
                    ToolTip = 'Specifies the value of the Member type field.';
                }
                field(MemberNo; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field(MemberName; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
                field(Role; Rec.Role)
                {
                    ToolTip = 'Specifies the value of the Role field.';
                }
                field(DateAppointed; Rec."Date Appointed")
                {
                    ToolTip = 'Specifies the value of the Date Appointed field.';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.';
                }
            }
        }
    }

    actions
    {
    }
}
