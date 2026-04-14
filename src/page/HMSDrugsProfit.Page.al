Page 85343 "HMS Drugs Profit"
{
    PageType = List;
    SourceTable = "HMS Patients Drugs Profit";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PatientsType; Rec."Patients Type")
                {
                    ToolTip = 'Specifies the value of the Patients Type field.';
                }
                field(DrugsProfitPerc; Rec."Drugs Profit Perc.")
                {
                    ToolTip = 'Specifies the value of the Drugs Profit Perc. field.';
                }
            }
        }
    }

    actions
    {
    }
}
