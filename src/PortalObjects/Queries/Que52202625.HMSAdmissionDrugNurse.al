namespace HMISBC.HMISBC;

query 52202625 "HMS Admission Drug Nurse"
{
    Caption = 'HMS Admission Drug Nurse';
    QueryType = Normal;

    elements
    {
        dataitem(HMSAdmissionDrugNurse; "HMS Admission Drug Nurse")
        {
            column(ActualQuantity; "Actual Quantity")
            {
            }
            column(AdmissionNo; "Admission No.")
            {
            }
            column(Dosage; Dosage)
            {
            }
            column(DrugName; "Drug Name")
            {
            }
            column(DrugNo; "Drug No.")
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(Issued; Issued)
            {
            }
            column(IssuedBy; "Issued By")
            {
            }
            column(IssuedDate; "Issued Date")
            {
            }
            column(IssuedTime; "Issued Time")
            {
            }
            column(MarkedasIncompatible; "Marked as Incompatible")
            {
            }
            column(PharmacyCode; "Pharmacy Code")
            {
            }
            column(PrescribedBy2; "Prescribed By2")
            {
            }
            column(PrescriptionDose; "Prescription Dose")
            {
            }
            column(Quantity; Quantity)
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
            column(UnitOfMeasure; "Unit Of Measure")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
