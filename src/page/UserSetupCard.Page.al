Page 85270 "User Setup Card"
{
    PageType = Card;
    SourceTable = "User Setup";
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(UserID; Rec."User ID")
                {
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field(UserName; Rec.UserName)
                {
                    ToolTip = 'Specifies the value of the UserName field.';
                }
                field(AllowPostingFrom; Rec."Allow Posting From")
                {
                    ToolTip = 'Specifies the earliest date on which the user is allowed to post to the company.';
                }
                field(AllowPostingTo; Rec."Allow Posting To")
                {
                    ToolTip = 'Specifies the last date on which the user is allowed to post to the company.';
                }
                field(RegisterTime; Rec."Register Time")
                {
                    ToolTip = 'Specifies whether to register the user''s time usage defined as the time spent from when the user logs in to when the user logs out. Unexpected interruptions, such as idle session timeout, terminal server idle session timeout, or a client crash are not recorded.';
                }
                field(SalespersPurchCode; Rec."Salespers./Purch. Code")
                {
                    ToolTip = 'Specifies the salesperson or purchaser code that relates to the User ID field.';
                }
                field(AllowFAPostingFrom; Rec."Allow FA Posting From")
                {
                    ToolTip = 'Specifies the value of the Allow FA Posting From field.';
                }
                field(AllowFAPostingTo; Rec."Allow FA Posting To")
                {
                    ToolTip = 'Specifies the value of the Allow FA Posting To field.';
                }
                field(SalesRespCtrFilter; Rec."Sales Resp. Ctr. Filter")
                {
                    ToolTip = 'Specifies the code for the responsibility center to which you want to assign the user.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(ShortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the School Code field.';
                }
                field(ShortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field(UserSignature; Rec."User Signature")
                {
                    ToolTip = 'Specifies the value of the User Signature field.';
                }
                field(ArchivingUser; Rec."Archiving User")
                {
                    ToolTip = 'Specifies the value of the Archiving User field.';
                }
                field(DefaultStoreLocation; Rec."Default Store Location")
                {
                    ToolTip = 'Specifies the value of the Default Store Location field.';
                }
                field(DefaultTransactionType; Rec."Default Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Default Transaction Type field.';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
            }
            group(Approval)
            {
                field(ApproverID; Rec."Approver ID")
                {
                    ToolTip = 'Specifies the user ID of the person who must approve records that are made by the user in the User ID field before the record can be released.';
                }
                field(Substitute; Rec.Substitute)
                {
                    ToolTip = 'Specifies the User ID of the user who acts as a substitute for the original approver.';
                }
                field(EMail; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the email address of the user in the User ID field.';
                }
                field(Approvername; Rec.Approvername)
                {
                    ToolTip = 'Specifies the value of the Approvername field.';
                }
                field(Approvermail; Rec.Approvermail)
                {
                    ToolTip = 'Specifies the value of the Approvermail field.';
                }
                field(SalesAmountApprovalLimit; Rec."Sales Amount Approval Limit")
                {
                    ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                }
                field(PurchaseAmountApprovalLimit; Rec."Purchase Amount Approval Limit")
                {
                    ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                }
                field(UnlimitedSalesApproval; Rec."Unlimited Sales Approval")
                {
                    ToolTip = 'Specifies that the user on this line is allowed to approve sales records with no maximum amount. If you select this check box, then you cannot fill the Sales Amount Approval Limit field.';
                }
                field(UnlimitedPurchaseApproval; Rec."Unlimited Purchase Approval")
                {
                    ToolTip = 'Specifies that the user on this line is allowed to approve purchase records with no maximum amount. If you select this check box, then you cannot fill the Purchase Amount Approval Limit field.';
                }
                field(RequestAmountApprovalLimit; Rec."Request Amount Approval Limit")
                {
                    ToolTip = 'Specifies the maximum amount in LCY that this user is allowed to approve for this record.';
                }
                field(UnlimitedRequestApproval; Rec."Unlimited Request Approval")
                {
                    ToolTip = 'Specifies that the user on this line can approve all purchase quotes regardless of their amount. If you select this check box, then you cannot fill the Request Amount Approval Limit field.';
                }
                field(ApprovalAdministrator; Rec."Approval Administrator")
                {
                    ToolTip = 'Specifies the user who has rights to unblock approval workflows, for example, by delegating approval requests to new substitute approvers and deleting overdue approval requests.';
                }
                field(ApprovalTitle; Rec."Approval Title")
                {
                    ToolTip = 'Specifies the value of the Approval Title field.';
                }                
                field(UnlimitedPVAmountApproval; Rec."Unlimited PV Amount Approval")
                {
                    ToolTip = 'Specifies the value of the Unlimited PV Amount Approval field.';
                }
                field(PVAmountApprovalLimit; Rec."PV Amount Approval Limit")
                {
                    ToolTip = 'Specifies the value of the PV Amount Approval Limit field.';
                }
                field(UnlimitedPettyAmountApproval; Rec."Unlimited PettyAmount Approval")
                {
                    ToolTip = 'Specifies the value of the Unlimited PettyAmount Approval field.';
                }
                field(PettyCAmountApprovalLimit; Rec."Petty C Amount Approval Limit")
                {
                    ToolTip = 'Specifies the value of the Petty C Amount Approval Limit field.';
                }
                field(UnlimitedImprestAmtApproval; Rec."Unlimited Imprest Amt Approval")
                {
                    ToolTip = 'Specifies the value of the Unlimited Imprest Amt Approval field.';
                }
                field(ImprestAmountApprovalLimit; Rec."Imprest Amount Approval Limit")
                {
                    ToolTip = 'Specifies the value of the Imprest Amount Approval Limit field.';
                }
                field(UnlimitedStoreRqAmtApproval; Rec."Unlimited Store RqAmt Approval")
                {
                    ToolTip = 'Specifies the value of the Unlimited Store RqAmt Approval field.';
                }
                field(StoreReqAmtApprovalLimit; Rec."Store Req. Amt Approval Limit")
                {
                    ToolTip = 'Specifies the value of the Store Req. Amt Approval Limit field.';
                }
                field(UnlimitedImprestSurrAmtAppr; Rec."Unlimited ImprestSurr Amt Appr")
                {
                    ToolTip = 'Specifies the value of the Unlimited ImprestSurr Amt Appr field.';
                }
                field(ImprestSurrAmtApprovalLimit; Rec."ImprestSurr Amt Approval Limit")
                {
                    ToolTip = 'Specifies the value of the ImprestSurr Amt Approval Limit field.';
                }
                field(UnlimitedInterbankAmtAppr; Rec."Unlimited Interbank Amt Appr")
                {
                    ToolTip = 'Specifies the value of the Unlimited Interbank Amt Appr field.';
                }
                field(InterbankAmtApprovalLimit; Rec."Interbank Amt Approval Limit")
                {
                    ToolTip = 'Specifies the value of the Interbank Amt Approval Limit field.';
                }
                field(UnlimitedReceiptAmtApproval; Rec."Unlimited Receipt Amt Approval")
                {
                    ToolTip = 'Specifies the value of the Unlimited Receipt Amt Approval field.';
                }
                field(ReceiptAmtApprovalLimit; Rec."Receipt Amt Approval Limit")
                {
                    ToolTip = 'Specifies the value of the Receipt Amt Approval Limit field.';
                }
                field(UnlimitedClaimAmtApproval; Rec."Unlimited Claim Amt Approval")
                {
                    ToolTip = 'Specifies the value of the Unlimited Claim Amt Approval field.';
                }
                field(ClaimAmtApprovalLimit; Rec."Claim Amt Approval Limit")
                {
                    ToolTip = 'Specifies the value of the Claim Amt Approval Limit field.';
                }
                field(UnlimitedAdvanceAmtApproval; Rec."Unlimited Advance Amt Approval")
                {
                    ToolTip = 'Specifies the value of the Unlimited Advance Amt Approval field.';
                }
                field(AdvanceAmtApprovalLimit; Rec."Advance Amt Approval Limit")
                {
                    ToolTip = 'Specifies the value of the Advance Amt Approval Limit field.';
                }
                field(UnlimitedAdvSurrAmtApproval; Rec."Unlimited AdvSurr Amt Approval")
                {
                    ToolTip = 'Specifies the value of the Unlimited AdvSurr Amt Approval field.';
                }
                field(AdvSurrAmtApprovalLimit; Rec."AdvSurr Amt Approval Limit")
                {
                    ToolTip = 'Specifies the value of the AdvSurr Amt Approval Limit field.';
                }

            }
            group(EmployeeDetails)
            {
                Caption = 'Employee Details';
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(Leave; Rec.Leave)
                {
                    ToolTip = 'Specifies the value of the Leave field.';
                }
                field(StaffTravelAccount; Rec."Staff Travel Account")
                {
                    ToolTip = 'Specifies the value of the Staff Travel Account field.';
                }
                field(OtherAdvanceStaffAccount; Rec."Other Advance Staff Account")
                {
                    ToolTip = 'Specifies the value of the Other Advance Staff Account field.';
                }
                field(CashAdvanceStaffAccount; Rec."Cash Advance Staff Account")
                {
                    ToolTip = 'Specifies the value of the Cash Advance Staff Account field.';
                }
                field(ReOpenRelease; Rec."ReOpen/Release")
                {
                    ToolTip = 'Specifies the value of the ReOpen/Release field.';
                }
                field(LocationCode; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(StaffNo; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field(JobTittle; Rec."Job Tittle")
                {
                    ToolTip = 'Specifies the value of the Job Tittle field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }

            }
            group(Finance)
            {
                Caption = 'Finance';

                field(PostBankRec; Rec."Post Bank Rec")
                {
                    ToolTip = 'Specifies the value of the Post Bank Rec field.';
                }
                field(EditPostedDimensions; Rec."Edit Posted Dimensions")
                {
                    ToolTip = 'Specifies the value of the Edit Posted Dimensions field.';
                }
                field(JournalTemplateName; Rec."Journal Template Name")
                {
                    ToolTip = 'Specifies the value of the Journal Template Name field.';
                }
                field(JournalBatchName; Rec."Journal Batch Name")
                {
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';
                }
                field(Signature; Rec.Signature)
                {
                    ToolTip = 'Specifies the value of the Signature field.';
                }
                field(PostJVs; Rec."Post JVs")
                {
                    ToolTip = 'Specifies the value of the Post JVs field.';
                }
                field(ReValidateLPOs; Rec."ReValidate LPOs")
                {
                    ToolTip = 'Specifies the value of the ReValidate LPOs field.';
                }
                field(ProcurementOfficer; Rec."Procurement Officer")
                {
                    ToolTip = 'Specifies the value of the Procurement Officer field.';
                }
            }
            group(Permissions)
            {
                
                field(AllowTransactionReversal; Rec."Allow Transaction Reversal")
                {
                    ToolTip = 'Specifies the value of the Allow Transaction Reversal field.';
                }
                field(CanEditCharges; Rec."Can Edit Charges")
                {
                    ToolTip = 'Specifies the value of the Can Edit Charges field.';
                }
                field("Can Edit HMS Setups"; Rec."Can Edit HMS Setups")
                {
                    ToolTip = 'Specifies the value of the Can Edit HMS Setups field.';
                }
                field("Can Create Customer"; Rec."Can Create Customer")
                {
                    ToolTip = 'Specifies the value of the Can Create Customer field.';
                }
                field("View Payroll"; Rec."View Payroll")
                {
                    ToolTip = 'Specifies the value of the View Payroll field.';
                }
                field("Can Adjust Stock"; Rec."Can Adjust Stock")
                {
                    ToolTip = 'Specifies the value of the Can Adjust Stock field.';
                }
                field("Can Ship Items"; Rec."Can Ship Items")
                {
                    ToolTip = 'Specifies the value of the Can Ship Items field.';
                }
                field("Can Create Vendor"; Rec."Can Create Vendor")
                {
                    ToolTip = 'Specifies the value of the Can Create Vendor field.';
                }
                field("Can Create Items"; Rec."Can Create Items")
                {
                    ToolTip = 'Specifies the value of the Can Create Items field.';
                }
                field("Can Create G/L Account"; Rec."Can Create G/L Account")
                {
                    ToolTip = 'Specifies the value of the Can Create G/L Account field.';
                }
                field("Can allocate Rebates"; Rec."Can allocate Rebates")
                {
                    ToolTip = 'Specifies the value of the Can allocate Rebates field.';
                }
                field("Can Add Discount"; Rec."Can Add Discount")
                {
                    ToolTip = 'Specifies the value of the Can Add Discount field.';
                }
                field("Can Delete Charges"; Rec."Can Delete Charges")
                {
                    ToolTip = 'Specifies the value of the Can Delete Charges field.';
                }
                field("Can Reverse Sales Invoice"; Rec."Can Reverse Sales Invoice")
                {
                    ToolTip = 'Specifies the value of the Can Reverse Sales Invoice field.';
                }
                field("Can Delete Employee"; Rec."Can Delete Employee")
                {
                    ToolTip = 'Specifies the value of the Can Delete Employee field.';
                }

                field("Can Delete Pharmacy"; Rec."Can Delete Pharmacy")
                {
                    ToolTip = 'Specifies the value of the Can Delete Pharmacy field.';
                }
                field("Can Change Profile"; Rec."Can Change Profile")
                {
                    ToolTip = 'Specifies the value of the Can Change Profile field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }
    // trigger OnOpenPage()
    // Var
    //     UserRec: Record "User Setup";
    // begin
    //     UserRec.get(Database.UserId);
    //     if UserRec."Approval Administrator" = false then
    //         error('Please note that you dont have rights to modify User Setup');
    // end;
}
