Page 52202855 "HMS Setup Process Card"
{
    PageType = Card;
    SourceTable = "HMS Setup Process";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Range; Rec.Range)
                {
                    ToolTip = 'Specifies the value of the Range field.';
                }
                field(SystolicLower; Rec."Systolic Lower")
                {
                    ToolTip = 'Specifies the value of the Systolic Lower field.';
                }
                field(SystolicUpper; Rec."Systolic Upper")
                {
                    ToolTip = 'Specifies the value of the Systolic Upper field.';
                }
                field(DiastolicLower; Rec."Diastolic Lower")
                {
                    ToolTip = 'Specifies the value of the Diastolic Lower field.';
                }
                field(DiastolicUpper; Rec."Diastolic Upper")
                {
                    ToolTip = 'Specifies the value of the Diastolic Upper field.';
                }
                field(MinRange; Rec."Min Range")
                {
                    ToolTip = 'Specifies the value of the Min Range field.';
                }
                field(MaxRange; Rec."Max Range")
                {
                    ToolTip = 'Specifies the value of the Max Range field.';
                }
                field(Min2; Rec."Min 2")
                {
                    ToolTip = 'Specifies the value of the Min 2 field.';
                }
                field(Max2; Rec."Max 2")
                {
                    ToolTip = 'Specifies the value of the Max 2 field.';
                }
                field(NormalRange; Rec."Normal Range")
                {
                    ToolTip = 'Specifies the value of the Normal Range field.';
                }
            }
        }
    }

    actions
    {
    }
}
