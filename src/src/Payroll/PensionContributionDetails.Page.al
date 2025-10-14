Page 52202817 "Pension Contribution Details"
{
    PageType = Card;
    SourceTable = "prPension Details";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field(EmployeeCode; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field(InceptionDate; Rec."Inception Date")
                {
                    ToolTip = 'Specifies the value of the Inception Date field.';
                }
                field(PensionNumber; Rec."Pension Number")
                {
                    ToolTip = 'Specifies the value of the Pension Number field.';
                }
                field(Company; Rec.Company)
                {
                    ToolTip = 'Specifies the value of the Company field.';
                }
                field(TransactionCode; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
            }
        }
    }

    actions
    {
    }
}
