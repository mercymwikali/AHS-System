Page 85086 "Corporate  Role Cue"
{
    PageType = CardPart;
    SourceTable = "Hr Cue";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            cuegroup(Control5)
            {
                Caption = 'Legal Matters Summary';
                field(NewLegal; Rec."New Legal")
                {
                    ToolTip = 'Specifies the value of the New Legal field.';
                }

                field(PostedLegal; Rec."Posted Legal")
                {
                    ToolTip = 'Specifies the value of the Posted Legal field.';
                }
            }
        }
    }
}