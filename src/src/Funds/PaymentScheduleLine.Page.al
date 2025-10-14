Page 52203059 "Payment Schedule Line"
{
    PageType = ListPart;
    SourceTable = "Payment Schedule Line";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DocumentType; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field(PaymentNo; Rec."Payment No")
                {
                    ToolTip = 'Specifies the value of the Payment No field.';
                }
                field(Payee; Rec.Payee)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field(PaymentNarration; Rec."Payment Narration")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payment Narration field.';
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(ChequeAmount; Rec."Cheque Amount")
                {
                    ToolTip = 'Specifies the value of the Cheque Amount field.';
                }
            }
        }
    }

    actions
    {
    }
}
