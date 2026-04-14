Page 85518 "HMS Laboratory List"
{
    CardPageID = "HMS Laboratory Form Test";
    PageType = List;
    SourceTable = "HMS Laboratory Form Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(LaboratoryNo; Rec."Laboratory No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(LinkType; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(LaboratoryDate; Rec."Laboratory Date")
                {
                    ToolTip = 'Specifies the value of the Laboratory Date field.';
                }
                field(LaboratoryTime; Rec."Laboratory Time")
                {
                    ToolTip = 'Specifies the value of the Laboratory Time field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(StudentNo; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.';
                    Visible = false;
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    Visible = false;
                }
                field(ADMNo; Rec."ADM No.")
                {
                    ToolTip = 'Specifies the value of the ADM No. field.';
                }
                field(MemeberNo; Rec."Memeber No")
                {
                    ToolTip = 'Specifies the value of the Memeber No field.';
                    Visible = false;
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the Surname field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(ScheduledDate; Rec."Scheduled Date")
                {
                    ToolTip = 'Specifies the value of the Scheduled Date field.';
                }
                field(ScheduledTime; Rec."Scheduled Time")
                {
                    ToolTip = 'Specifies the value of the Scheduled Time field.';
                }
                field(SupervisorID; Rec."Supervisor ID")
                {
                    ToolTip = 'Specifies the value of the Supervisor ID field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Inpatient; Rec.Inpatient)
                {
                    ToolTip = 'Specifies the value of the Inpatient field.';
                }
                /**
                ** //not visible fields (to be used in portal)
                **/
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the value of the Age field.';
                    Visible = false;
                }
                field("Appointment No"; Rec."Appointment No")
                {
                    ToolTip = 'Specifies the value of the Appointment No field.';
                    Visible = false;
                }
                field("Cash Sale"; Rec."Cash Sale")
                {
                    ToolTip = 'Specifies the value of the Cash Sale field.';
                    Visible = false;
                }
                field("Color Code"; Rec."Color Code")
                {
                    ToolTip = 'Specifies the value of the Color Code field.';
                    Visible = false;
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    ToolTip = 'Specifies the value of the Completion Date field.';
                    Visible = false;
                }
                field("Completion Time"; Rec."Completion Time")
                {
                    ToolTip = 'Specifies the value of the Completion Time field.';
                    Visible = false;
                }
                field("Correspondence Address 1"; Rec."Correspondence Address 1")
                {
                    ToolTip = 'Specifies the value of the Correspondence Address 1 field.';
                    Visible = false;
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                    Visible = false;
                }
                field("Doctor Names"; Rec."Doctor Names")
                {
                    ToolTip = 'Specifies the value of the Doctor Names field.';
                    Visible = false;
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                    Visible = false;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                    Visible = false;
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                    Visible = false;
                }
                field("Insurance No"; Rec."Insurance No")
                {
                    ToolTip = 'Specifies the value of the Insurance No field.', Comment = '%';
                    Visible = false;
                }
                field("Lab. Reference No."; Rec."Lab. Reference No.")
                {
                    ToolTip = 'Specifies the value of the Lab. Reference No. field.';
                    Visible = false;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                    Visible = false;
                }
                field("Open Charges"; Rec."Open Charges")
                {
                    ToolTip = 'Specifies the value of the Open Charges field.';
                    Visible = false;
                }
                field("Patient Names"; Rec."Patient Names")
                {
                    ToolTip = 'Specifies the value of the Patient Names field.';
                    Visible = false;
                }
                field("Patient Ref. No."; Rec."Patient Ref. No.")
                {
                    ToolTip = 'Specifies the value of the Patient Ref. No. field.';
                    Visible = false;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                    Visible = false;
                }
                field("Reason For Voiding"; Rec."Reason For Voiding")
                {
                    ToolTip = 'Specifies the value of the Reason For Voiding field.';
                    Visible = false;
                }
                field("Receipt Count"; Rec."Receipt Count")
                {
                    ToolTip = 'Specifies the value of the Receipt Count field.';
                    Visible = false;
                }
                field("Received by"; Rec."Received by")
                {
                    ToolTip = 'Specifies the value of the Received by field.';
                    Visible = false;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    ToolTip = 'Specifies the value of the Relative No. field.';
                    Visible = false;
                }
                field("Request Area"; Rec."Request Area")
                {
                    ToolTip = 'Specifies the value of the Request Area field.';
                    Visible = false;
                }
                field("Reveiw Date"; Rec."Reveiw Date")
                {
                    ToolTip = 'Specifies the value of the Reveiw Date field.', Comment = '%';
                    Visible = false;
                }
                field("Review Time"; Rec."Review Time")
                {
                    ToolTip = 'Specifies the value of the Review Time field.', Comment = '%';
                    Visible = false;
                }
                field("Reviewed By"; Rec."Reviewed By")
                {
                    ToolTip = 'Specifies the value of the Reviewed By field.', Comment = '%';
                    Visible = false;
                }
                field("Sampled Received"; Rec."Sampled Received")
                {
                    ToolTip = 'Specifies the value of the Sampled Received field.';
                    Visible = false;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ToolTip = 'Specifies the value of the Settlement Type field.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Visible = false;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                    Visible = false;
                }
                field("Test Voided"; Rec."Test Voided")
                {
                    ToolTip = 'Specifies the value of the Test Voided field.';
                    Visible = false;
                }
                field("Treatment No"; Rec."Treatment No")
                {
                    ToolTip = 'Specifies the value of the Treatment No field.', Comment = '%';
                    Visible = false;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    Visible = false;
                }
                field("Waiting At"; Rec."Waiting At")
                {
                    ToolTip = 'Specifies the value of the Waiting At field.';
                    Visible = false;
                }
                field("Walk-In"; Rec."Walk-In")
                {
                    ToolTip = 'Specifies the value of the Walk-In field.';
                    Visible = false;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;
}
