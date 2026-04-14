pageextension 85033 "365 Cue Extensions" extends "O365 Activities"
{
    layout
    {
        addafter("Ongoing Sales Invoices")
        {
            field("Dispatched Sales Invoices"; Rec."Dispatched Sales Invoices")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Dispatched Sales Invoices field.';
            }
        }
    }
}