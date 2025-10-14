Page 52202917 "HMS Pharmacy Line History"
{
    PageType = ListPart;
    SourceTable = "HMS Pharmacy Line";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(No; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Drug No. field.';
                }
                field(DrugName; Rec."Drug Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Drug Name field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(MeasuringUnit; Rec."Measuring Unit")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Measuring Unit field.';
                }
                field(UnitPrice; Rec."Unit Price")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field(ActualQty; Rec."Actual Qty")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Actual Qty field.';
                }
                field(ActualPrice; Rec."Actual Price")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Actual Price field.';
                }
                field(IssuedQuantity; Rec."Issued Quantity")
                {
                    ToolTip = 'Specifies the value of the Issued Quantity field.';
                }
                field(IssuedUnits; Rec."Issued Units")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Issued Units field.';
                }
                field(IssuedPrice; Rec."Issued Price")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Issued Price field.';
                }
                field(Dosage; Rec.Dosage)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Dosage field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PrintLabel)
            {
                ApplicationArea = Basic, Suite;
                Image = Print;
                ToolTip = 'Print Label';
                RunObject = report "Prescription Label";
                RunPageOnRec = true;
            }
        }
    }
}
