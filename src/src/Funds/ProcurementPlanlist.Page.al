Page 52202991 "Procurement Plan list"
{
    CardPageID = "Procurement Plan";
    PageType = List;
    SourceTable = "Procurement Plan Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(BudgetName; Rec."Budget Name")
                {
                    ToolTip = 'Specifies the value of the Budget Name field.';
                }
                field(DepartmentCode; Rec."Department Code")
                {
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field(CampusCode; Rec."Campus Code")
                {
                    ToolTip = 'Specifies the value of the Campus Code field.';
                }
                field(ProcurementPlanPeriod; Rec."Procurement Plan Period")
                {
                    ToolTip = 'Specifies the value of the Procurement Plan Period field.';
                }
            }
        }
    }

    actions
    {
    }
}
