Page 52202796 "Pr Bank Branches"
{
    PageType = List;
    SourceTable = "Pr Bank Branches";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(BankCode; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field(BankName; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(BranchName; Rec."Branch Name")
                {
                    ToolTip = 'Specifies the value of the Branch Name field.';
                }
            }
        }
    }

    actions
    {
    }
}
