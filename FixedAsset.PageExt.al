pageextension 52202460 "Fixed Asset" extends "Fixed Asset Card"
{
    layout
    {
        addafter(Description)
        {
            field(Dialysis; Rec.Dialysis)
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Dialysis field.';
            }
        }
    }
}
