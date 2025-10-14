Page 52202471 "Employee Qualifications 2"
{
    PageType = ListPart;
    SourceTable = "Employee Qualifications Fin";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EmployeeNo; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(Qualification; Rec.Qualification)
                {
                    ToolTip = 'Specifies the value of the Qualification field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(FromDate; Rec."From Date")
                {
                    ToolTip = 'Specifies the value of the From Date field.';
                }
                field(ToDate; Rec."To Date")
                {
                    ToolTip = 'Specifies the value of the To Date field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Institution; Rec.Institution)
                {
                    ToolTip = 'Specifies the value of the Institution field.';
                }
                field(InstitutionName; Rec."Institution Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Institution Name field.';
                }
                field(HighestQualification; Rec."Highest Qualification")
                {
                    ToolTip = 'Specifies the value of the Highest Qualification field.';
                }
                field(Rank; Rec.Rank)
                {
                    ToolTip = 'Specifies the value of the Rank field.';
                }
            }
        }
    }

    actions
    {
    }
}
