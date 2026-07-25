Page 85509 "Hms Lab List"
{
    PageType = List;
    SourceTable = "HMS Laboratory Form Header";
    CardPageId = "HMS Laboratory Form Test";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LaboratoryNo; Rec."Laboratory No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
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
                field(StudentNo; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(RelativeNo; Rec."Relative No.")
                {
                    ToolTip = 'Specifies the value of the Relative No. field.';
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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(LinkType; Rec."Link Type")
                {
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(RequestArea; Rec."Request Area")
                {
                    ToolTip = 'Specifies the value of the Request Area field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(PatientType; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';
                }
                field(LabReferenceNo; Rec."Lab. Reference No.")
                {
                    ToolTip = 'Specifies the value of the Lab. Reference No. field.';
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
                field(CorrespondenceAddress1; Rec."Correspondence Address 1")
                {
                    ToolTip = 'Specifies the value of the Correspondence Address 1 field.';
                }
                field(TelephoneNo1; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(PatientRefNo; Rec."Patient Ref. No.")
                {
                    ToolTip = 'Specifies the value of the Patient Ref. No. field.';
                }
                field(SettlementType; Rec."Settlement Type")
                {
                    ToolTip = 'Specifies the value of the Settlement Type field.';
                }
                field(CashSale; Rec."Cash Sale")
                {
                    ToolTip = 'Specifies the value of the Cash Sale field.';
                }
                field(ADMNo; Rec."ADM No.")
                {
                    ToolTip = 'Specifies the value of the ADM No. field.';
                }
                field(MemeberNo; Rec."Memeber No")
                {
                    ToolTip = 'Specifies the value of the Memeber No field.';
                }
                field(ReceiptCount; Rec."Receipt Count")
                {
                    ToolTip = 'Specifies the value of the Receipt Count field.';
                }
                field(OpenCharges; Rec."Open Charges")
                {
                    ToolTip = 'Specifies the value of the Open Charges field.';
                }
                field(WalkIn; Rec."Walk-In")
                {
                    ToolTip = 'Specifies the value of the Walk-In field.';
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(CompletionDate; Rec."Completion Date")
                {
                    ToolTip = 'Specifies the value of the Completion Date field.';
                }
                field(CompletionTime; Rec."Completion Time")
                {
                    ToolTip = 'Specifies the value of the Completion Time field.';
                }
                field(InsuranceName; Rec."Insurance Name")
                {
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field(AppointmentNo; Rec."Appointment No")
                {
                    ToolTip = 'Specifies the value of the Appointment No field.';
                }
                field(WaitingAt; Rec."Waiting At")
                {
                    ToolTip = 'Specifies the value of the Waiting At field.';
                }
                field(PatientNames; Rec."Patient Names")
                {
                    ToolTip = 'Specifies the value of the Patient Names field.';
                }
                field(DoctorNames; Rec."Doctor Names")
                {
                    ToolTip = 'Specifies the value of the Doctor Names field.';
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the value of the Age field.';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field(TestVoided; Rec."Test Voided")
                {
                    ToolTip = 'Specifies the value of the Test Voided field.';
                }
                field(ReasonForVoiding; Rec."Reason For Voiding")
                {
                    ToolTip = 'Specifies the value of the Reason For Voiding field.';
                }
                field(SampledReceived; Rec."Sampled Received")
                {
                    ToolTip = 'Specifies the value of the Sampled Received field.';
                }
                field(Receivedby; Rec."Received by")
                {
                    ToolTip = 'Specifies the value of the Received by field.';
                }
                field(ColorCode; Rec."Color Code")
                {
                    ToolTip = 'Specifies the value of the Color Code field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Inpatient; Rec.Inpatient)
                {
                    ToolTip = 'Specifies the value of the Inpatient field.';
                }
            }
        }
    }

    actions
    {
    }
}
