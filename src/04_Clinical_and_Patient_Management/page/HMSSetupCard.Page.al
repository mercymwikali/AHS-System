Page 85160 "HMS Setup Card"
{
    PageType = Card;
    SourceTable = "HMS Setup";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(PatientNos; Rec."Patient Nos")
                {
                    ToolTip = 'Specifies the value of the Patient Nos field.';
                }
                field("In Patient No"; Rec."In Patient No")
                {
                    ToolTip = 'Specifies the value of the In Patient No field.';
                }
                field("Walkin Nos"; Rec."Walkin Nos")
                {
                    ToolTip = 'Specifies the value of the Walkin Nos field.';
                }
                field(AppointmentNos; Rec."Appointment Nos")
                {
                    ToolTip = 'Specifies the value of the Appointment Nos field.';
                }
                field(ObservationNos; Rec."Observation Nos")
                {
                    ToolTip = 'Specifies the value of the Observation Nos field.';
                }
                field(VisitNos; Rec."Visit Nos")
                {
                    ToolTip = 'Specifies the value of the Visit Nos field.';
                }
                field("Charges Posting Nos"; Rec."Charges Posting Nos")
                {
                    ToolTip = 'Specifies the value of the Charges Posting Nos field.';
                }
                field("Doctors Posting Nos"; Rec."Doctors Posting Nos")
                {
                    ToolTip = 'Specifies the value of the Doctors Posting Nos field.';
                }
                field(LaboratoryTestNos; Rec."Lab Test Request Nos")
                {
                    Caption = 'Laboratory Test Nos';
                    ToolTip = 'Specifies the value of the Laboratory Test Nos field.';
                }
                field(RadiologyNos; Rec."Radiology Nos")
                {
                    ToolTip = 'Specifies the value of the Radiology Nos field.';
                }
                field(PharmacyNos; Rec."Pharmacy Nos")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Nos field.';
                }
                field(AdmissionRequestNos; Rec."Admission Request Nos")
                {
                    ToolTip = 'Specifies the value of the Admission Request Nos field.';
                }
                field("Doctor Review Request Nos."; Rec."Doctor Review Request Nos.")
                {
                    ToolTip = 'Specifies the value of the Doctor Review Request Nos. field.';
                }
                field(ReferralNos; Rec."Referral Nos")
                {
                    ToolTip = 'Specifies the value of the Referral Nos field.';
                }
                field("Appointment Booking Nos"; Rec."Appointment Booking Nos")
                {
                    ToolTip = 'Specifies the value of the Appointment Booking Nos field.';
                }
                field(ChargesWeiverNos; Rec."Charges Weiver Nos")
                {
                    ToolTip = 'Specifies the value of the Charges Weiver Nos field.';
                }
                field(DoctorsPaymentNos; Rec."Doctors Payment Nos")
                {
                    ToolTip = 'Specifies the value of the Doctors Payment Nos field.';
                }
                field("Therapy Nos"; Rec."Therapy Nos")
                {
                    ToolTip = 'Specifies the value of the Therapy Nos field.';
                }
                field("Physio Nos"; Rec."Physio Nos")
                {
                    ToolTip = 'Specifies the value of the Physio Nos field.';
                }
                field("Theatre Nos"; Rec."Theatre Nos")
                {
                    ToolTip = 'Specifies the value of the Theatre Nos field.';
                }
                field("Security Nos"; Rec."Security Nos")
                {
                    ToolTip = 'Specifies the value of the Security Nos field.';
                }
                field("Treatment Plan Nos(Therapy)"; Rec."Treatment Plan Nos(Therapy)")
                {
                    ToolTip = 'Specifies the value of the Treatment Plan Nos(Therapy) field.';
                }
                field("File No"; Rec."File No")
                {
                    ToolTip = 'Specifies the value of the File No field.';
                }
                field("Weiver Transaction Code"; Rec."Weiver Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Weiver Transaction Code field.';
                }
                field("Smartlink Base URL"; Rec."Smartlink Base URL")
                {
                    ToolTip = 'Specifies the value of the Smartlink Base URL field.';
                }
                field("Portal Report Path"; Rec."Portal Report Path")
                {
                    ToolTip = 'Specifies the value of the Portal Report Path field.';
                }
                field("SMS Notification Email "; Rec."SMS Notification Email")
                {
                    ToolTip = 'Specifies the value of the SMS Notification Email field.';
                }
                field("SMS Notification Email 1"; Rec."SMS Notification Email 1")
                {
                    ToolTip = 'Specifies the value of the SMS Notification Email 1 field.';
                }
                field("Transcription Nos";Rec."Transcription Nos")
                {
                    ToolTip = 'Specified transcripiton NOs';
                }
            }
            group(Pharmacies)
            {
                Caption = 'Pharmacies';
                field(PharmacyItemJournalTemplate; Rec."Pharmacy Item Journal Template")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Item Journal Template field.';
                }
                field(PharmacyItemJournalBatch; Rec."Pharmacy Item Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Item Journal Batch field.';
                }
                field(PharmacyLocation; Rec."Pharmacy Location")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Location field.';
                }
                field(PharmacyGLAccount; Rec."Pharmacy G/L Account")
                {
                    ToolTip = 'Specifies the value of the Pharmacy G/L Account field.';
                }
                field("Pharmacy Department"; Rec."Pharmacy Department")
                {
                    ToolTip = 'Specifies the value of the Pharmacy Department field.';
                }
                field(ObservationRoom; Rec."Observation Room")
                {
                    ToolTip = 'Specifies the value of the Observation Room field.';
                }
                field(ObservationItemJournalTemp; Rec."Observation Item Journal Temp")
                {
                    ToolTip = 'Specifies the value of the Observation Item Journal Temp field.';
                }
                field(ObservationItemJournalBatch; Rec."Observation Item Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Observation Item Journal Batch field.';
                }
                field(DoctorRoom; Rec."Doctor Room")
                {
                    ToolTip = 'Specifies the value of the Doctor Room field.';
                }
                field(DoctorItemJournalTemplate; Rec."Doctor Item Journal Template")
                {
                    ToolTip = 'Specifies the value of the Doctor Item Journal Template field.';
                }
                field(DoctorItemJournalBatch; Rec."Doctor Item Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Doctor Item Journal Batch field.';
                }
                field(LaboratoryRoom; Rec."Laboratory Room")
                {
                    ToolTip = 'Specifies the value of the Laboratory Room field.';
                }
                field(LaboratoryItemJournalTemp; Rec."Laboratory Item Journal Temp")
                {
                    ToolTip = 'Specifies the value of the Laboratory Item Journal Temp field.';
                }
                field(LaboratoryItemJournalBatch; Rec."Laboratory Item Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Laboratory Item Journal Batch field.';
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("SHIF Customer Code"; Rec."SHIF Customer Code")
                {
                    ToolTip = 'Specifies the value of the SHIF Customer Code field.', Comment = '%';
                }

                field("Insurance Charges Price Type"; Rec."Insurance Charges Price Type")
                {
                    ToolTip = 'Specifies the value of the Insurance Charges Price Type field.';
                }
                field("Insurance Items Price Type"; Rec."Insurance Items Price Type")
                {
                    ToolTip = 'Specifies the value of the Insurance Items Price Type field.';
                }
                field(CashControlAccount; Rec."Cash Control Account")
                {
                    ToolTip = 'Specifies the value of the Cash Control Account field.';
                }

                field("Discount Exp. Account"; Rec."Discount Exp. Account")
                {
                    ToolTip = 'Specifies the value of the Discount Exp. Account field.';
                }
                field("Rebates Exp. Account"; Rec."Rebates Exp. Account")
                {
                    ToolTip = 'Specifies the value of the Rebates Exp. Account field.';
                }
                field("Doctors Expense Account"; Rec."Doctors Expense Account")
                {
                    ToolTip = 'Specifies the value of the Doctors Expense Account field.';
                }
                field("Capitation Customer No."; Rec."Capitation Customer No.")
                {
                    ToolTip = 'Specifies the value of the Capitation Customer No. field.';
                }
                field("NHIF Capitation Cost G/L"; Rec."NHIF Capitation Cost G/L")
                {
                    ToolTip = 'Specifies the value of the NHIF Capitation Cost G/L field.';
                }
                field("NHIF Capitation Control G/L"; Rec."NHIF Capitation Control G/L")
                {
                    ToolTip = 'Specifies the value of the NHIF Capitation Control G/L field.';
                }
                field("NHIF Package Cost G/L"; Rec."NHIF Package Cost G/L")
                {
                    ToolTip = 'Specifies the value of the NHIF Package Cost G/L field.';
                }
                field("Physio Fee Code"; Rec."Physio Fee Code")
                {
                    ToolTip = 'Specifies the value of the Physio Fee Code field.';
                }
                field("Nursing Fee Code"; Rec."Nursing Fee Code")
                {
                    ToolTip = 'Specifies the value of the Nursing Fee Code field.';
                }
                field("Day Case Fee Code"; Rec."Day Case Fee Code")
                {
                    ToolTip = 'Specifies the value of the Day Case Fee Code field.';
                }
                field("Admission Fee"; Rec."Admission Fee")
                {
                    ToolTip = 'Specifies the value of the Admission Fee field.';
                }
                field("Therapy Fee Code"; Rec."Therapy Fee Code")
                {
                    ToolTip = 'Specifies the value of the Therapy Fee Code field.';
                }
                field("MSE Fee"; Rec."MSE Fee Code")
                {
                    ToolTip = 'Specifies the value of the MSE Fee field.';
                }
                field("View Therapy"; Rec."View Therapy")
                {
                    ToolTip = 'Specifies the value of the View Therapy field.';
                }
                field(BillEmployees; Rec."Bill Employees")
                {
                    ToolTip = 'Specifies the value of the Bill Employees field.';
                }
                field(BillOtherCategories; Rec."Bill Other Categories")
                {
                    ToolTip = 'Specifies the value of the Bill Other Categories field.';
                }
                field(LimitOfNextOfKin; Rec."Limit Of Next Of Kin")
                {
                    ToolTip = 'Specifies the value of the Limit Of Next Of Kin field.';
                }
                field(LimitAgeOfNextOfKinYrs; Rec."Limit Age Of Next Of Kin(Yrs)")
                {
                    ToolTip = 'Specifies the value of the Limit Age Of Next Of Kin(Yrs) field.';
                }
                field(LabResultsRecallLimitHours; Rec."Lab Results Recall Limit")
                {
                    Caption = 'Lab Results Recall Limit(Hours)';
                    ToolTip = 'Specifies the value of the Lab Results Recall Limit(Hours) field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Validate Charges")
            {
                Caption = 'Validate Patient Charges Amount';
                RunObject = report "HMS Validate Charges Amount";
                ToolTip = 'Executes the Validate Patient Charges Amount action.';
            }
        }
    }
}
