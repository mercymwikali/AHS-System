namespace PTL.HMIS;

page 85553 "Pharmacy List - All"
{
    ApplicationArea = All;
    Caption = 'Pharmacy List - All';
    PageType = List;
    SourceTable = "HMS Pharmacy Header";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Pharmacy No."; Rec."Pharmacy No.")
                {
                    ToolTip = 'Specifies the value of the Pharmacy No. field.';
                }
                field("Pharmacy Date"; Rec."Pharmacy Date")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Date field.';
                }
                field("Pharmacy Time"; Rec."Pharmacy Time")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Time field.';
                }
                field("Request Area"; Rec."Request Area")
                {
                    ToolTip = 'Specifies the value of the Request Area field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Relative No."; Rec."Relative No.")
                {
                    ToolTip = 'Specifies the value of the Relative No. field.';
                }
                field("Bill To Customer No."; Rec."Bill To Customer No.")
                {
                    ToolTip = 'Specifies the value of the Bill To Customer No. field.';
                }
                field("Issued By"; Rec."Issued By")
                {
                    ToolTip = 'Specifies the value of the Issued By field.';
                }
                field("Link Type"; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field("Link No."; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the Surname field.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.', Comment = '%';
                }
                field("Correspondence Address 1"; Rec."Correspondence Address 1")
                {
                    ToolTip = 'Specifies the value of the Correspondence Address 1 field.', Comment = '%';
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Patient Ref. No."; Rec."Patient Ref. No.")
                {
                    ToolTip = 'Specifies the value of the Patient Ref. No. field.', Comment = '%';
                }
                field("Total Price"; Rec."Total Price")
                {
                    ToolTip = 'Specifies the value of the Total Price field.';
                }
                field("Insurance No"; Rec."Insurance No")
                {
                    ToolTip = 'Specifies the value of the Insurance No field.';
                }
                field("Ref No"; Rec."Ref No")
                {
                    ToolTip = 'Specifies the value of the Ref No field.', Comment = '%';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field("Cash Sale"; Rec."Cash Sale")
                {
                    ToolTip = 'Specifies the value of the Cash Sale field.';
                }
                field("Receipt Count"; Rec."Receipt Count")
                {
                    ToolTip = 'Specifies the value of the Receipt Count field.';
                }
                field("ADM No"; Rec."ADM No")
                {
                    ToolTip = 'Specifies the value of the ADM No field.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies the value of the Search Name field.', Comment = '%';
                }
                field("Treatment No."; Rec."Treatment No.")
                {
                    ToolTip = 'Specifies the value of the Treatment No. field.', Comment = '%';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.', Comment = '%';
                }
                field("Issuing Location"; Rec."Issuing Location")
                {
                    ToolTip = 'Specifies the value of the Issuing Location field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field("Insurance Amount"; Rec."Insurance Amount")
                {
                    ToolTip = 'Specifies the value of the Insurance Amount field.', Comment = '%';
                }
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.', Comment = '%';
                }
                field("Doctor Name"; Rec."Doctor Name")
                {
                    ToolTip = 'Specifies the value of the Doctor Name field.';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the value of the Age field.', Comment = '%';
                }
                field("Visit Total"; Rec."Visit Total")
                {
                    ToolTip = 'Specifies the value of the Visit Total field.';
                }
                field("Total Receipts"; Rec."Total Receipts")
                {
                    ToolTip = 'Specifies the value of the Total Receipts field.';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                }
                field("Membership No"; Rec."Membership No")
                {
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
                field("Global Dimension1"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("Pharmacy Type"; Rec."Pharmacy Type")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Type field.', Comment = '%';
                }
                field(InPatient; Rec.InPatient)
                {
                    ToolTip = 'Specifies the value of the InPatient field.', Comment = '%';
                }
                field(Walkin; Rec.Walkin)
                {
                    ToolTip = 'Specifies the value of the Walkin field.', Comment = '%';
                }
                field("pharm count Walkin Cash"; Rec."pharm count Walkin Cash")
                {
                    ToolTip = 'Specifies the value of the pharm count Walkin Cash field.', Comment = '%';
                }
                field("Insurance code"; Rec."Insurance code")
                {
                    ToolTip = 'Specifies the value of the Insurance code field.', Comment = '%';
                }
                field(Charged; Rec.Charged)
                {
                    ToolTip = 'Specifies the value of the Charged field.', Comment = '%';
                }
                // API Fields
                field(SystemId; Rec.SystemId)
                {
                    Visible = false;
                }
            }
        }
    }
}
