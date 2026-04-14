namespace HMISBC.HMISBC;

query 85061 "Treatment Admission Lines"
{
    Caption = 'Treatment Admission Lines';
    QueryType = Normal;

    elements
    {
        dataitem(HMSTreatmentAdmission; "HMS Treatment Admission")
        {
            column(AdmissionReason; "Admission Reason")
            {
            }
            column(AdmissionRemarks; "Admission Remarks")
            {
            }
            column(Assessmentandplan; "Assessment and plan")
            {
            }
            column(BedNo; "Bed No.")
            {
            }
            column(DateOfAdmission; "Date Of Admission")
            {
            }
            column(Investigations; Investigations)
            {
            }
            column(PastMedicalHistory; "Past Medical History")
            {
            }
            column(PastSurgicalHistory; "Past Surgical History")
            {
            }
            column(Reviewsofsystems; "Reviews of systems")
            {
            }
            column(SocialHistory; "Social History")
            {
            }
            column(Status; Status)
            {
            }
            column(TreatmentNo; "Treatment No.")
            {
            }
            column(WardNo; "Ward No.")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
