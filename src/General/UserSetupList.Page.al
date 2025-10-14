namespace PTL.HMISBC;

using System.Security.User;

page 52203244 "User Setup List"
{
    ApplicationArea = All;
    Caption = 'User Setup List';
    PageType = List;
    SourceTable = "User Setup";
    CardPageId = "User Setup Card";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ToolTip = 'Specifies the user ID of the person who must approve records that are made by the user in the User ID field before the record can be released.';
                }
                field("Purchase Amount Approval Limit"; Rec."Purchase Amount Approval Limit")
                {
                    ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                }
                field(Substitute; Rec.Substitute)
                {
                    ToolTip = 'Specifies the User ID of the user who acts as a substitute for the original approver.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the email address of the user in the User ID field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the user''s phone number.';
                }
                field("Request Amount Approval Limit"; Rec."Request Amount Approval Limit")
                {
                    ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                }
                field("License Type"; Rec."License Type")
                {
                    ToolTip = 'Specifies the value of the License Type field.', Comment = '%';
                }
            }
        }
    }
}
