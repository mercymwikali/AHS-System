Page 85232 "Procurement Plan Lines"
{
    PageType = ListPart;
    SourceTable = "Procurement Plan Lines";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(TypeNo; Rec."Type No")
                {
                    ToolTip = 'Specifies the value of the Type No field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Category; Rec.Category)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(UnitCost; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(RemainingQty; Rec."Remaining Qty")
                {
                    ToolTip = 'Specifies the value of the Remaining Qty field.';
                }
                field(PlanDate; Rec."Plan Date")
                {
                    ToolTip = 'Specifies the value of the Plan Date field.';
                }
            }
        }
    }

    actions
    {
    }
}
