namespace HMISBC.HMISBC;

query 85058 "Treatment Diagnosis Lines"
{
    Caption = 'Treatment Diagnosis Lines';
    QueryType = Normal;

    elements
    {
        dataitem(HMSTreatmentFormDiagnosis; "HMS Treatment Form Diagnosis")
        {
            column(Age; Age)
            {
            }
            column(AgeinYears; "Age in Years")
            {
            }
            column(Branch; Branch)
            {
            }
            column(Confirmed; Confirmed)
            {
            }
            column(DateOFBirth; "Date OF Birth")
            {
            }
            column(Ddate; Ddate)
            {
            }
            column(Description; Description)
            {
            }
            column(DiagnosisCode; "Diagnosis Code")
            {
            }
            column(DiagnosisDate; "Diagnosis Date")
            {
            }
            column(DiagnosisName; "Diagnosis Name")
            {
            }
            column(DiagnosisNo; "Diagnosis No.")
            {
            }
            column(DiagnosisType; "Diagnosis Type")
            {
            }
            column(Doctor; Doctor)
            {
            }
            column(Gender; Gender)
            {
            }
            column(PatientAppointments; "Patient Appointments")
            {
            }
            column(PatientName; "Patient Name")
            {
            }
            column(PatientNo; "Patient No")
            {
            }
            column(PatientNoF; PatientNoF)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(Treatment; Treatment)
            {
            }
            column(TreatmentDate; "Treatment Date")
            {
            }
            column(TreatmentNo; "Treatment No.")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
