Page 85684 "HR Posting Groups"
{
    PageType = ListPart;
    SourceTable = "HR Posting Groups";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(PostingGroup; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the value of the Posting Group field.';
                }
                field(TrainingDebitAccount; Rec."Training Debit Account")
                {
                    ToolTip = 'Specifies the value of the Training Debit Account field.';
                }
                field(TrainingCreditACType; Rec."Training Credit A/C Type")
                {
                    ToolTip = 'Specifies the value of the Training Credit A/C Type field.';
                }
                field(TrainingCreditAccount; Rec."Training Credit Account")
                {
                    ToolTip = 'Specifies the value of the Training Credit Account field.';
                }
                field(CompActDebitAccount; Rec."Comp. Act. Debit Account")
                {
                    ToolTip = 'Specifies the value of the Comp. Act. Debit Account field.';
                }
                field(CompActCreditACType; Rec."Comp. Act. Credit A/C Type")
                {
                    ToolTip = 'Specifies the value of the Comp. Act. Credit A/C Type field.';
                }
                field(CompActCreditAccount; Rec."Comp. Act. Credit Account")
                {
                    ToolTip = 'Specifies the value of the Comp. Act. Credit Account field.';
                }
            }
        }
    }

    actions
    {
    }
}
