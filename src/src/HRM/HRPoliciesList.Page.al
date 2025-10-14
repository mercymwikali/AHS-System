Page 52202631 "HR Policies"
{
    CardPageId = "HR Policies Card";
    PageType = List;
    SourceTable = "HR Policies";
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(RulesRegulations; Rec."Rules & Regulations")
                {
                    ToolTip = 'Specifies the value of the Rules & Regulations field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }
}
