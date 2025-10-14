page 52202521 "FLT Mgt Approval Setup Card"
{
    PageType = Card;
    SourceTable = "Flt Mgt Approval Setups";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(UserID; Rec.UserID)
                {
                    ToolTip = 'Specifies the value of the UserID field.';
                }
                field("Fleet Management Area"; Rec."Fleet Management Area")
                {
                    ToolTip = 'Specifies the value of the Fleet Management Area field.';
                }
                field(Create; Rec.Create)
                {
                    ToolTip = 'Specifies the value of the Create field.';
                }
                field("Line Manager Approver"; Rec."Line Manager Approver")
                {
                    ToolTip = 'Specifies the value of the Line Manager Approver field.';
                }
                field("Transport Mger Approver"; Rec."Transport Mger Approver")
                {
                    ToolTip = 'Specifies the value of the Transport Mger Approver field.';
                }
                field("Safari Notice Approver"; Rec."Safari Notice Approver")
                {
                    ToolTip = 'Specifies the value of the Safari Notice Approver field.';
                }
                field("Finance Approver"; Rec."Finance Approver")
                {
                    ToolTip = 'Specifies the value of the Finance Approver field.';
                }
                field("IS Director"; Rec."IS Director")
                {
                    ToolTip = 'Specifies the value of the IS Director field.';
                }
                field("IS HRM"; Rec."IS HRM")
                {
                    ToolTip = 'Specifies the value of the IS HRM field.';
                }
                field("Is Deputy Director"; Rec."Is Deputy Director")
                {
                    ToolTip = 'Specifies the value of the Is Deputy Director field.';
                }
                field("View Only Department"; Rec."View Only Department")
                {
                    ToolTip = 'Specifies the value of the View Only Department field.';
                }
                field("User Department"; Rec."User Department")
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
