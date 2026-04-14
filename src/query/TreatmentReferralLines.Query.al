namespace HMISBC.HMISBC;

query 85062 "Treatment Referral Lines"
{
    Caption = 'Treatment Referral Lines';
    QueryType = Normal;
    
    elements
    {
        dataitem(HMSTreatmentReferral; "HMS Treatment Referral")
        {
            column(Branch; Branch)
            {
            }
            column(ClinicalHistoryTreatment; "Clinical History & Treatment")
            {
            }
            column(Contactperson; "Contact person")
            {
            }
            column(DateReferred; "Date Referred")
            {
            }
            column(FindingsonExamInvestigtn; "Findings on Exam & Investigtn")
            {
            }
            column(HospitalName; "Hospital Name")
            {
            }
            column(HospitalNo; "Hospital No.")
            {
            }
            column(ReferralReason; "Referral Reason")
            {
            }
            column(ReferralRemarks; "Referral Remarks")
            {
            }
            column(Status; Status)
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
