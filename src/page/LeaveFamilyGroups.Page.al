page 85709 "Leave Family Groups"
{
    PageType = List;
    SourceTable = "Leave Family Groups";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Remarks"; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Leave Days"; Rec."Leave Days")
                {
                    ToolTip = 'Specifies the value of the Leave Days field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Leave Family Members")
            {
                Image = Lot;
                Promoted = true;
                RunObject = Page "Leave Family Employees";
                RunPageLink = Family = FIELD(Code);
                ToolTip = 'Executes the Leave Family Members action.';
            }
        }
    }
}
