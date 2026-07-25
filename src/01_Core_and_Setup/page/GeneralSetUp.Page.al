Page 85022 "General Set-Up"
{
    PageType = Card;
    SourceTable = "General Set-Up";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(StudentNos; Rec."Student Nos.")
                {
                    ToolTip = 'Specifies the value of the Student Nos. field.';
                }
                field(AdmissionNos; Rec."Admission Nos.")
                {
                    ToolTip = 'Specifies the value of the Admission Nos. field.';
                }
                field(RegistrationNos; Rec."Registration Nos.")
                {
                    ToolTip = 'Specifies the value of the Registration Nos. field.';
                }
                field(ReceiptNos; Rec."Receipt Nos.")
                {
                    ToolTip = 'Specifies the value of the Receipt Nos. field.';
                }
                field(ClassAllocationNos; Rec."Class Allocation Nos.")
                {
                    ToolTip = 'Specifies the value of the Class Allocation Nos. field.';
                }
                field(DeferedAccount; Rec."Defered Account")
                {
                    ToolTip = 'Specifies the value of the Defered Account field.';
                }
                field(OverPaymentAccount; Rec."Over Payment Account")
                {
                    ToolTip = 'Specifies the value of the Over Payment Account field.';
                }
                field(TransactionNos; Rec."Transaction Nos.")
                {
                    ToolTip = 'Specifies the value of the Transaction Nos. field.';
                }
                field(PrePaymentAccount; Rec."Pre-Payment Account")
                {
                    ToolTip = 'Specifies the value of the Pre-Payment Account field.';
                }
                field(ConsMarksheetKey2; Rec."Cons. Marksheet Key2")
                {
                    ToolTip = 'Specifies the value of the Cons. Marksheet Key2 field.';
                }
                field(BillSupplimentaryFee; Rec."Bill Supplimentary Fee")
                {
                    ToolTip = 'Specifies the value of the Bill Supplimentary Fee field.';
                }
                field(UnallocatedRcptsAccount; Rec."Unallocated Rcpts Account")
                {
                    ToolTip = 'Specifies the value of the Unallocated Rcpts Account field.';
                }
                field(BatchReceiptsNos; Rec."Batch Receipts Nos")
                {
                    ToolTip = 'Specifies the value of the Batch Receipts Nos field.';
                }
                field(MedicalConditionNos; Rec."Medical Condition Nos")
                {
                    ToolTip = 'Specifies the value of the Medical Condition Nos field.';
                }
                field(AttachmentNos; Rec."Attachment Nos")
                {
                    ToolTip = 'Specifies the value of the Attachment Nos field.';
                }
                field(ApplicationFee; Rec."Application Fee")
                {
                    ToolTip = 'Specifies the value of the Application Fee field.';
                }
                field(EnquiryNos; Rec."Enquiry Nos")
                {
                    ToolTip = 'Specifies the value of the Enquiry Nos field.';
                }
                field(ClearanceNos; Rec."Clearance Nos")
                {
                    ToolTip = 'Specifies the value of the Clearance Nos field.';
                }
                field(MarksApprovalNos; Rec."Marks Approval Nos")
                {
                    ToolTip = 'Specifies the value of the Marks Approval Nos field.';
                }
                field(ProgrammeCapDeclarationNos; Rec."Programme Cap.Declaration Nos.")
                {
                    ToolTip = 'Specifies the value of the Programme Cap.Declaration Nos. field.';
                }
                field(ProformaNos; Rec."Proforma Nos")
                {
                    ToolTip = 'Specifies the value of the Proforma Nos field.';
                }
                field(AllowPostingFrom; Rec."Allow Posting From")
                {
                    ToolTip = 'Specifies the value of the Allow Posting From field.';
                }
                field(AllowPostingTo; Rec."Allow Posting To")
                {
                    ToolTip = 'Specifies the value of the Allow Posting To field.';
                }
                field(ApplicationsDateLine; Rec."Applications Date Line")
                {
                    ToolTip = 'Specifies the value of the Applications Date Line field.';
                }
                field(AllowUnPaidHostelBooking; Rec."Allow UnPaid Hostel Booking")
                {
                    ToolTip = 'Specifies the value of the Allow UnPaid Hostel Booking field.';
                }
                field(ConsMarksheetKey1; Rec."Cons. Marksheet Key1")
                {
                    ToolTip = 'Specifies the value of the Cons. Marksheet Key1 field.';
                }
                field(AllowedRegFeesPerc; Rec."Allowed Reg. Fees Perc.")
                {
                    ToolTip = 'Specifies the value of the Allowed Reg. Fees Perc. field.';
                }
                field(AllowOnlineResultsAccess; Rec."Allow Online Results Access")
                {
                    ToolTip = 'Specifies the value of the Allow Online Results Access field.';
                }
                field(BaseDate; Rec."Base Date")
                {
                    ToolTip = 'Specifies the value of the Base Date field.';
                }
                field(HelbAccount; Rec."Helb Account")
                {
                    ToolTip = 'Specifies the value of the Helb Account field.';
                }
                field(CDFAccount; Rec."CDF Account")
                {
                    ToolTip = 'Specifies the value of the CDF Account field.';
                }
                field(MaxHostelBookingPeriod; Rec."Max Hostel Booking Period")
                {
                    ToolTip = 'Specifies the value of the Max Hostel Booking Period field.';
                }
                field("Portal Reports File Path"; Rec."Portal Reports File Path")
                {
                    ToolTip = 'Specifies the value of the Portal Reports File Path field.';
                }
                field("Portal Attachment File Path"; Rec."Portal Attachment File Path")
                {
                    ToolTip = 'Specifies the value of the Portal Attachment File Path field.';
                }
            }
            group(IDSetup)
            {
                Caption = 'ID Setup';
                field(Picture; Rec.Picture)
                {
                    Caption = 'Signature';
                    ToolTip = 'Specifies the value of the Signature field.';
                }
                field(Logo; Rec."Bar Code")
                {
                    ToolTip = 'Specifies the value of the Bar Code field.';
                }
            }
        }
    }
}
