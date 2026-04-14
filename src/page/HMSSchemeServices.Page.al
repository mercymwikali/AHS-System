Page 85435 "HMS Scheme Services"
{
    PageType = ListPart;
    SourceTable = "HMS Scheme Plan Services";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Insurance; Rec.Insurance)
                {
                    ToolTip = 'Specifies the value of the Insurance field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(DoctorPercentage; Rec."Doctor Percentage")
                {
                    ToolTip = 'Specifies the value of the Doctor Percentage field.';
                }
                field(InsuranceAmount; Rec."Insurance Amount")
                {
                    ToolTip = 'Specifies the value of the Insurance Amount field.';
                }
                field(Branch2Amount; Rec."Branch2 Amount")
                {
                    ToolTip = 'Specifies the value of the Branch2 Amount field.';
                }
                field(Branch3Amount; Rec."Branch3 Amount")
                {
                    ToolTip = 'Specifies the value of the Branch3 Amount field.';
                }
            }
        }
    }

    actions
    {
    }
}
