Page 85780 "prMembership Groups"
{
    PageType = List;
    SourceTable = "prMembership Groups";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(GroupNo; Rec."Group No")
                {
                    ToolTip = 'Specifies the value of the Group No field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(MemberDetails)
            {
                Caption = 'Member Details';
                action(InstitutionalListing)
                {
                    Caption = 'Institutional Listing';
                    RunObject = Page "prInstitutional Membership";
                    RunPageLink = "Group No" = field("Group No");
                    ToolTip = 'Executes the Institutional Listing action.';
                }
            }
        }
    }
}
