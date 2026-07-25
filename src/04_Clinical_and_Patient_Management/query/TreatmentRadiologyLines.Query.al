namespace HMISBC.HMISBC;

query 85057 "Treatment Radiology Lines"
{
    Caption = 'Treatment Radiology Lines';
    QueryType = Normal;

    elements
    {
        dataitem(HMSTreatmentFormRadiology; "HMS Treatment Form Radiology")
        {
            column(Branch; Branch)
            {
            }
            column(ClinicalSummaryDiagnosis; "Clinical Summary &  Diagnosis")
            {
            }
            column(DateDue; "Date Due")
            {
            }
            column(DateTaken; "Date Taken")
            {
            }
            column(LMP; LMP)
            {
            }
            column(PreviousInvestigation; "Previous Investigation")
            {
            }
            column(RadiologyTypeCode; "Radiology Type Code")
            {
            }
            column(RadiologyTypeName; "Radiology Type Name")
            {
            }
            column(RequestType; "Request Type")
            {
            }
            column(RequiredInvestigation; "Required Investigation")
            {
            }
            column(Status; Status)
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
            column(TreatmentNo; "Treatment No.")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
