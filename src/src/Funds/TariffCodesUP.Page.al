Page 52203009 "Tariff Codes UP"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Tariff Codes";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                field("Code"; Rec.Code)
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
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field.';
                }
                field(GLAccount; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.';
                }
                field(AccountType; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(AccountNo; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
            }
        }
    }

    actions
    {
    }
}
