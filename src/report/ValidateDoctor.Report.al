namespace PTL.Hospital;

report 85149 "Validate Doctor"
{
    ApplicationArea = All;
    Caption = 'Validate Doctor';
    UsageCategory = Tasks;
    processingonly = true;
    dataset
    {
        dataitem(HMSPatient; "HMS Patient")
        {
            column(PatientNo; "Patient No.")
            {
            }
            column(DateRegistered; "Date Registered")
            {
            }
            column(PatientType; "Patient Type")
            {
            }
            trigger OnAfterGetRecord()
            var
                HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
                HMSAdmissionFormHeader: Record "HMS Admission Form Header";
                HMSPatientCharges: Record "HMS Patient Charges";
            begin
                // HMSPatientCharges.Reset();
                // HMSPatientCharges.SetRange("Patient No.", HMSPatient."Patient No.");
                // HMSPatientCharges.SetRange("Doctors Amount");
                HMSTreatmentFormHeader.Reset();
                HMSTreatmentFormHeader.SetRange("Patient No.", HMSPatient."Patient No.");
                if HMSTreatmentFormHeader.FindSet() then
                    repeat
                        HMSTreatmentFormHeader.Validate("Doctor ID");
                        HMSTreatmentFormHeader.Modify();
                    until HMSTreatmentFormHeader.Next() = 0;

                HMSAdmissionFormHeader.Reset();
                HMSAdmissionFormHeader.SetRange("Patient No.", HMSPatient."Patient No.");
                if HMSAdmissionFormHeader.FindSet() then
                    repeat
                        HMSAdmissionFormHeader.Validate(Doctor);
                        HMSAdmissionFormHeader.Modify();
                    until HMSAdmissionFormHeader.Next() = 0;
            end;
            trigger OnPostDataItem()
            begin
                Message('done');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
