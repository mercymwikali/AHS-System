namespace PTL.Hospital;

page 85007 "Replenshment Line"
{
    ApplicationArea = All;
    Caption = 'Replenshment Line';
    PageType = ListPart;
    Editable = false;
    SourceTable = "Replenshment Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Petty cash No"; Rec."Petty cash No")
                {
                    ToolTip = 'Specifies the value of the Petty cash No field.', Comment = '%';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ToolTip = 'Specifies the value of the Transaction Date field.', Comment = '%';
                }
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Petty cash Account"; Rec."Petty cash Account")
                {
                    ToolTip = 'Specifies the value of the Petty Cash Account field.', Comment = '%';
                }


                field(Reconciled; Rec.Reconciled)
                {
                    ToolTip = 'Specifies the value of the Reconciled field.', Comment = '%';
                }


            }
        }
    }
}
