Page 52202762 "Applicant Employment Details"
{
    PageType = Listpart;
    SourceTable = "Current Employment Details";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(FromDate; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field(ToDate; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field(JobTitle; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(DutiesandResponsibility; Rec."Duties and Responsibility")
                {
                    ToolTip = 'Specifies the value of the Duties and Responsibility field.';
                }
                field(CurrentBasicSalary; Rec."Current Salary")
                {
                    Caption = 'Current Basic Salary';
                    ToolTip = 'Specifies the value of the Current Basic Salary field.';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                }
                field(MajorAchiements; Rec."Major Achiements")
                {
                    ToolTip = 'Specifies the value of the Major Achiements field.';
                }
                field(ContractType; Rec."Contract Type")
                {
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field(Displinary; Rec.Displinary)
                {
                    ToolTip = 'Specifies the value of the Displinary field.';
                }
                field(UserName; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field(EmailAddress; Rec."Email Address")
                {
                    ToolTip = 'Specifies the value of the Email Address field.';
                }
                field(LineNo; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                field(NoticePeriod; Rec."Notice Period")
                {
                    ToolTip = 'Specifies the value of the Notice Period field.';
                }
                field(CompanyName; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field(CurrSupervisor; Rec."Curr Supervisor")
                {
                    ToolTip = 'Specifies the value of the Curr Supervisor field.';
                }
                field(CurrSupervisorTitle; Rec."Curr Supervisor Title")
                {
                    ToolTip = 'Specifies the value of the Curr Supervisor Title field.';
                }
            }
        }
    }

    actions
    {
    }
}
