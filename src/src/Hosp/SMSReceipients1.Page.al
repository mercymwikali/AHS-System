Page 52202710 "SMS Receipients1"
{
    PageType = List;
    SourceTable = "SMS Receipients";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(AccountNo; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field(PhoneNo; Rec."Phone No")
                {
                    ToolTip = 'Specifies the value of the Phone No field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}
