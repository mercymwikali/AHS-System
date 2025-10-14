Page 52202557 "Casual Employees"
{
    CardPageID = "Casual Employees Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Casual Employees";
    SourceTableView = where(Type = const(Casual));
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
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(DOB; Rec."D O B")
                {
                    ToolTip = 'Specifies the value of the D O B field.';
                }
                field(NoofHours; Rec."No of Hours")
                {
                    ToolTip = 'Specifies the value of the No of Hours field.';
                }
                field(NoofDays; Rec."No of Days")
                {
                    ToolTip = 'Specifies the value of the No of Days field.';
                }
                field(BankName; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(StartDate; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(EndDate; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
        }
    }

    actions
    {
    }
}
