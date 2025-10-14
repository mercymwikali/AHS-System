Page 52202730 "Lecturer casual list-buffer"
{
    PageType = List;
    SourceTable = "Casual Employees-buffer";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CasualNo; Rec."Casual No")
                {
                    ToolTip = 'Specifies the value of the Casual No field.';
                }
                field(FullName; Rec."Full  Name")
                {
                    ToolTip = 'Specifies the value of the Full  Name field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(RevenueDivision; Rec."Revenue Division")
                {
                    ToolTip = 'Specifies the value of the Revenue Division field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(TaskDescription; Rec."Task  Description")
                {
                    ToolTip = 'Specifies the value of the Task  Description field.';
                }
                field(PINNo; Rec."PIN No")
                {
                    ToolTip = 'Specifies the value of the PIN No field.';
                }
                field(BankAccountNumber; Rec."Bank Account Number")
                {
                    ToolTip = 'Specifies the value of the Bank Account Number field.';
                }
                field(BankCode; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
        }
    }

    actions
    {
    }
}
