namespace HMISBC.HMISBC;

query 85064 "Admission Form Nurse"
{
    Caption = 'Admission Form Nurse';
    QueryType = Normal;

    elements
    {
        dataitem(HMSAdmissionFormNurse; "HMS Admission Form Nurse")
        {
            column(AdmissionNo; "Admission No.")
            {
            }
            column(Dose; Dose)
            {
            }
            column(DrugName; "Drug Name")
            {
            }
            column(Drugs; Drugs)
            {
            }
            column(LineNo; LineNo)
            {
            }
            column(Notes; Notes)
            {
            }
            column(NotesDate; "Notes Date")
            {
            }
            column(NotesTime; "Notes Time")
            {
            }
            column(NurseID; "Nurse ID")
            {
            }
            column(NurseType; "Nurse Type")
            {
            }
            column(PatientNo; "Patient No")
            {
            }
            column(PrescriptionDose; "Prescription Dose")
            {
            }
            column(Routine; Routine)
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
            column("Type"; "Type")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
