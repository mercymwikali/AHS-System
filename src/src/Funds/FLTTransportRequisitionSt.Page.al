page 52203146 "FLT Transport Requisition St"
{
    PageType = ListPart;
    SourceTable = "FLT-Travel Requisition Staff";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                }
            }
        }
    }

    actions
    {
    }
}
