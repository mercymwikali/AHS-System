page 52202537 "Appraisal List"
{
    CardPageId = "Appraisal Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Appraisal Card1";
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Appraisal Code"; Rec."Appraisal Code")
                {
                    ToolTip = 'Specifies the value of the Appraisal Code field.';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ToolTip = 'Specifies the value of the Appraisal Period field.';
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ToolTip = 'Specifies the value of the Appraisal Type field.';
                }
            }
        }
    }
}
