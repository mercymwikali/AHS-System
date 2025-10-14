namespace PTL.Hospital;

page 52203199 "Receipts List Page"
{
    ApplicationArea = All;
    Caption = 'Receipts List Page';
    PageType = List;
    SourceTable = "Receipts Header";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Received From"; Rec."Received From")
                {
                    ToolTip = 'Specifies the value of the Received From field.';
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                }
                field("Amount Recieved"; Rec."Amount Recieved")
                {
                    ToolTip = 'Specifies the value of the Amount Recieved field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field("Print No."; Rec."Print No.")
                {
                    ToolTip = 'Specifies the value of the Print No. field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created Date Time"; Rec."Created Date Time")
                {
                    ToolTip = 'Specifies the value of the Created Date Time field.';
                }
                field("Register No."; Rec."Register No.")
                {
                    ToolTip = 'Specifies the value of the Register No. field.';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ToolTip = 'Specifies the value of the From Entry No. field.';
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                    ToolTip = 'Specifies the value of the To Entry No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Receipt Split Amount"; Rec."Receipt Split Amount")
                {
                    ToolTip = 'Specifies the value of the Receipt Split Amount field.', Comment = '%';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field(Dim3; Rec.Dim3)
                {
                    ToolTip = 'Specifies the value of the Dim3 field.';
                }
                field(Dim4; Rec.Dim4)
                {
                    ToolTip = 'Specifies the value of the Dim4 field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Receipt Reference"; Rec."Receipt Reference")
                {
                    ToolTip = 'Specifies the value of the Receipt Reference field.', Comment = '%';
                }
                field("Staff Number"; Rec."Staff Number")
                {
                    ToolTip = 'Specifies the value of the Staff Number field.', Comment = '%';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Patient Appointment No"; Rec."Patient Appointment No")
                {
                    ToolTip = 'Specifies the value of the Patient Appointment No field.';
                }
                field("Surrender No"; Rec."Surrender No")
                {
                    ToolTip = 'Specifies the value of the Surrender No field.';
                }
                field("Manual Ref.Number"; Rec."Manual Ref.Number")
                {
                    ToolTip = 'Specifies the value of the Manual Ref.Number field.', Comment = '%';
                }
                field("Imprest No"; Rec."Imprest No")
                {
                    ToolTip = 'Specifies the value of the Imprest No field.', Comment = '%';
                }
                field("Application No"; Rec."Application No")
                {
                    ToolTip = 'Specifies the value of the Application No field.', Comment = '%';
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ToolTip = 'Specifies the value of the Applicant Name field.', Comment = '%';
                }
                field("Pay Mode Lk"; Rec."Pay Mode Lk")
                {
                    ToolTip = 'Specifies the value of the Pay Mode Lk field.', Comment = '%';
                }
                field("Pharmacy No"; Rec."Pharmacy No")
                {
                    ToolTip = 'Specifies the value of the Pharmacy No field.', Comment = '%';
                }
                field("Laboratory No"; Rec."Laboratory No")
                {
                    ToolTip = 'Specifies the value of the Laboratory No field.', Comment = '%';
                }
                field("Customer No"; Rec."Customer No")
                {
                    ToolTip = 'Specifies the value of the Customer No field.', Comment = '%';
                }
                field("Co-Pay"; Rec."Co-Pay")
                {
                    ToolTip = 'Specifies the value of the Co-Pay field.', Comment = '%';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.', Comment = '%';
                }
                field("Mobile Money Type"; Rec."Mobile Money Type")
                {
                    ToolTip = 'Specifies the value of the Mobile Money Type field.', Comment = '%';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field.', Comment = '%';
                }
                field("Posted Count"; Rec."Posted Count")
                {
                    ToolTip = 'Specifies the value of the Posted Count field.', Comment = '%';
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.', Comment = '%';
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                    ToolTip = 'Specifies the value of the Bank Balance field.', Comment = '%';
                }
                field("InterBank No"; Rec."InterBank No")
                {
                    ToolTip = 'Specifies the value of the InterBank No field.', Comment = '%';
                }
                field("Disbursable Amount"; Rec."Disbursable Amount")
                {
                    ToolTip = 'Specifies the value of the Disbursable Amount field.', Comment = '%';
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                    ToolTip = 'Specifies the value of the Disbursed Amount field.', Comment = '%';
                }
                field("Fully Disbursed"; Rec."Fully Disbursed")
                {
                    ToolTip = 'Specifies the value of the Fully Disbursed field.', Comment = '%';
                }
                field("Reversal Date"; Rec."Reversal Date")
                {
                    ToolTip = 'Specifies the value of the Reversal Date field.', Comment = '%';
                }
                field("Reversed By"; Rec."Reversed By")
                {
                    ToolTip = 'Specifies the value of the Reversed By field.', Comment = '%';
                }
                field("Reversed Posted"; Rec."Reversed Posted")
                {
                    ToolTip = 'Specifies the value of the Reversed Posted field.', Comment = '%';
                }
            }
        }
    }
}
