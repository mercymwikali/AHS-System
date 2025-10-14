Page 52202558 "Casual Employees Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Casual Employees";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(CasualNo; Rec."Casual No")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Casual No field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(EmployeeCode; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field(FullName; Rec."Full  Name")
                {
                    ToolTip = 'Specifies the value of the Full  Name field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(DOB; Rec."D O B")
                {
                    ToolTip = 'Specifies the value of the D O B field.';
                }
                field(RevenueDivision; Rec."Revenue Division")
                {
                    ToolTip = 'Specifies the value of the Revenue Division field.';
                }
                field(DivisionName; Rec."Division Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Division Name field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(DepartmentName; Rec."Department Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field(StartDate; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(NoofDays; Rec."No of Days")
                {
                    ToolTip = 'Specifies the value of the No of Days field.';
                }
                field(NoofDaysvalue; Rec."No of Days value")
                {
                    ToolTip = 'Specifies the value of the No of Days value field.';
                }
                field(BankCode; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field(BankName; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(BankBranchName; Rec."Bank Branch Name")
                {
                    ToolTip = 'Specifies the value of the Bank Branch Name field.';
                }
                field(BankAccountNumber; Rec."Bank Account Number")
                {
                    ToolTip = 'Specifies the value of the Bank Account Number field.';
                }
                field("KRA PIN"; Rec."PIN No")
                {
                    ToolTip = 'Specifies the value of the PIN No field.';
                }
                field(NSSFNO; Rec."NSSF NO")
                {
                    ToolTip = 'Specifies the value of the NSSF NO field.';
                }
                field(NHIFNO; Rec."NHIF NO")
                {
                    ToolTip = 'Specifies the value of the NHIF NO field.';
                }
                field(EndDate; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
            }
            group("Occupation Code")
            {
                field(OccupationCode; Rec."Task Code")
                {
                    Caption = 'Occupation Code';
                    ToolTip = 'Specifies the value of the Occupation Code field.';
                }
                field(TaskDescription; Rec."Task  Description")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Task  Description field.';
                }
                field(RatePerMonth; Rec."Rate Per Month")
                {
                    ToolTip = 'Specifies the value of the Rate Per Month field.';
                }
                field(RateperDay; Rec."Rate per Day")
                {
                    ToolTip = 'Specifies the value of the Rate per Day field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print Payslip")
            {
                Image = ViewDetails;
                Promoted = true;
                ToolTip = 'Executes the Print Payslip action.';

                trigger OnAction()
                begin
                    CasualEmployees.Reset();
                    CasualEmployees.SetRange(CasualEmployees."Casual No", Rec."Casual No");
                    if CasualEmployees.Find('-') then
                        Report.Run(70135586, true, false, CasualEmployees);
                    //
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        if Rec."ID Number" = '' then
            Error('ID Number Must have a value');
    end;

    var
        CasualEmployees: Record "Casual Employees";
}
