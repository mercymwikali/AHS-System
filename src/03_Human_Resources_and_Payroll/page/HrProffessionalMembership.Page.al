Page 85685 "Hr Proffessional Membership"
{
    PageType = List;
    SourceTable = "Hr Proffessional Membership";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MembershipNo; Rec."Membership No")
                {
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
                field(NameofBody; Rec."Name of Body")
                {
                    ToolTip = 'Specifies the value of the Name of Body field.';
                }
                field(DateofMembership; Rec."Date of Membership")
                {
                    ToolTip = 'Specifies the value of the Date of Membership field.';
                }
                field(MembershipStatus; Rec."Membership Status")
                {
                    ToolTip = 'Specifies the value of the Membership Status field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(SubscriptionCommenceDate; Rec."Subscription Commence Date")
                {
                    ToolTip = 'Specifies the value of the Subscription Commence Date field.';
                }
                field(SubscriptionRenewalDate; Rec."Subscription Renewal Date")
                {
                    ToolTip = 'Specifies the value of the Subscription Renewal Date field.';
                }
            }
        }
    }

    actions
    {
    }
}
