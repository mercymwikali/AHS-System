pageextension 85001 "Fixed Asset" extends "Fixed Asset Card"
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
