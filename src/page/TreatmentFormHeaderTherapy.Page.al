namespace PTL.HMIS;

page 85561 "Treatment Form Header(Therapy)"
{
    ApplicationArea = All;
    Caption = 'Treatment Form Header(Therapy)';
    PageType = Card;
    SourceTable = "HMS Treatment Form Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Treatment No."; Rec."Treatment No.")
                {
                    ToolTip = 'Specifies the value of the Treatment No. field.';
                }
                field("Treatment Date"; Rec."Treatment Date")
                {
                    ToolTip = 'Specifies the value of the Treatment Date field.';
                }
                field("Treatment Time"; Rec."Treatment Time")
                {
                    ToolTip = 'Specifies the value of the Treatment Time field.';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field(InPatient; Rec.InPatient)
                {
                    ToolTip = 'Specifies the value of the InPatient field.', Comment = '%';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.', Comment = '%';
                }
                field("Link No."; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Direct; Rec.Direct)
                {
                    ToolTip = 'Specifies the value of the Direct field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ToolTip = 'Specifies the value of the Settlement Type field.';
                }
                field("Membership No"; Rec."Membership No")
                {
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field("Next Appointment Date"; Rec."Next Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Next Appointment Date field.';
                }
                field("Appointment No"; Rec."Appointment No")
                {
                    ToolTip = 'Specifies the value of the Appointment No field.', Comment = '%';
                }
                field(isTherapy; Rec.isTherapy)
                {
                    ToolTip = 'Specifies the value of the isTherapy field.', Comment = '%';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.', Comment = '%';
                }
                field("Doctor's Name"; Rec."Doctor's Name")
                {
                    ToolTip = 'Specifies the value of the Doctor''s Name field.';
                }
                field("Special Clinics"; Rec."Special Clinics")
                {
                    ToolTip = 'Specifies the value of the Special Clinics field.', Comment = '%';
                }
                field(Clinic; Rec.Clinic)
                {
                    ToolTip = 'Specifies the value of the Clinic field.', Comment = '%';
                }
                field("Adm No."; Rec."Adm No.")
                {
                    ToolTip = 'Specifies the value of the Adm No. field.';
                }
            }
            group(PsychologyActions)
            {
                Caption = 'Vitals Activities';
                part(Triage; "HMS Observation Form Proc")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Observation No." = field("Observation No");
                    Caption = 'Vitals';
                }
            }
            group(TreatmentPlanGroup)
            {
                Caption = 'Treatment Plan';
                part(TreatmentPlanPage; "Treatement Plan(Psychology)")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Patient No." = field("Patient No.");  
                    SubPageView = sorting("Plan No.") order(descending);
                    Caption = 'Treatment Plan';
                    ToolTip = 'Executes the Add Treatment Plan Action';
                }
            }
        }

    }
    actions
    {
        // TODO : Add Request Psychiatric Consultation action
        // TODO : Add Get Next Appointment Date action. If the appointment next date is not set open the appointment booking page
        area(Processing)
        {
            group(TreatmentPlan)
            {                
                action(TherapySession)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Therapy Sessions';
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = ListPage;
                    ToolTip = 'Executes the Therapy Session Action';
                    RunObject = page "HMS Therapy List";
                    RunPageLink = "Treatment No." = field("Treatment No.");
                }
            }
        }

    }
}
