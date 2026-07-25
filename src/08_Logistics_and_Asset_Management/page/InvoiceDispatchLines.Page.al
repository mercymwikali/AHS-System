Page 85505 "Invoice Dispatch Lines"
{
    PageType = ListPart;
    SourceTable = "Invoice Dispatch Linesd";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.', Comment = '%';
                }
                field(CustomerNo; Rec."Customer No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer No field.';
                    Visible = true;
                }
                field(InvoiceNo; Rec."Invoice No")
                {
                    ToolTip = 'Specifies the value of the Invoice No field.';
                }
                field(InvoiceDate; Rec."Invoice Date")
                {
                    ToolTip = 'Specifies the value of the Invoice Date field.';
                }
                field(PatientNo; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.';
                    Visible = false;
                }
                field(PatientName; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field(MemberNo; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field(OriginalAmount; Rec."Original Amount")
                {
                    ToolTip = 'Specifies the value of the Original Amount field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }

                field(Select; Rec.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.';
                }
            }
        }
    }

    actions
    {
    }
}
