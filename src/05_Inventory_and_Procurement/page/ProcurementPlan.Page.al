Page 85231 "Procurement Plan"
{
    Caption = 'Procurement Plan ';
    PageType = Card;
    SourceTable = "Procurement Plan Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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

                    trigger OnValidate()
                    begin
                        Dim.Reset();
                        Dim.SetRange(Dim.Code, Rec."Department Code");
                        if Dim.Find('-') then
                            DptName := Dim.Name;
                    end;
                }
                field(DptName; DptName)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the DptName field.';
                }
                field(ProcurementPlanPeriod; Rec."Procurement Plan Period")
                {
                    ToolTip = 'Specifies the value of the Procurement Plan Period field.';
                }
            }
            part(Control1102755005; "Procurement Plan Lines")
            {
                SubPageLink = "Budget Name" = field("Budget Name"),
                              Department = field("Department Code"),
                              Campus = field("Campus Code"),
                              "Procurement Plan Period" = field("Procurement Plan Period");
            }
        }
    }

    actions
    {
    }

    var
        Dim: Record "Dimension Value";
        DptName: Text[50];
}
