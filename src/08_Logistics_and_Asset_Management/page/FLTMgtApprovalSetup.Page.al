Page 85141 "FLT Mgt Approval Setup"
{
    CardPageID = "FLT Mgt Approval Setup Card";
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Flt Mgt Approval Setups";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(UserID; Rec.UserID)
                {
                    ToolTip = 'Specifies the value of the UserID field.';
                }
                field(FleetManagementArea; Rec."Fleet Management Area")
                {
                    ToolTip = 'Specifies the value of the Fleet Management Area field.';
                }
                field(Create; Rec.Create)
                {
                    ToolTip = 'Specifies the value of the Create field.';
                }
                field(LineManagerApprover; Rec."Line Manager Approver")
                {
                    ToolTip = 'Specifies the value of the Line Manager Approver field.';
                }
                field(TransportMgerApprover; Rec."Transport Mger Approver")
                {
                    ToolTip = 'Specifies the value of the Transport Mger Approver field.';
                }
                field(SafariNoticeApprover; Rec."Safari Notice Approver")
                {
                    ToolTip = 'Specifies the value of the Safari Notice Approver field.';
                }
                field(FinanceApprover; Rec."Finance Approver")
                {
                    ToolTip = 'Specifies the value of the Finance Approver field.';
                }
                field(ISDirector; Rec."IS Director")
                {
                    ToolTip = 'Specifies the value of the IS Director field.';
                }
                field(ISHRM; Rec."IS HRM")
                {
                    ToolTip = 'Specifies the value of the IS HRM field.';
                }
                field(IsDeputyDirector; Rec."Is Deputy Director")
                {
                    ToolTip = 'Specifies the value of the Is Deputy Director field.';
                }
                field(ViewOnlyDepartment; Rec."View Only Department")
                {
                    ToolTip = 'Specifies the value of the View Only Department field.';
                }
                field(UserDepartment; Rec."User Department")
                {
                    ToolTip = 'Specifies the value of the User Department field.';
                }
            }
        }
    }

    actions
    {
    }
}
