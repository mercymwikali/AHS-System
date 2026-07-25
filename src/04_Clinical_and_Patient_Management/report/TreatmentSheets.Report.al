Report 85194 "Treatment Sheets"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TreatmentSheets.rdl';

    dataset
    {
        dataitem("HMS Admission Drug Nurse"; "HMS Admission Drug Nurse")
        {
            RequestFilterFields = "Admission No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(Names; PatRec.Surname + ' ' + PatRec."Middle Name" + ' ' + PatRec."Last Name")
            {
            }
            column(AdmissionNo_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Admission No.")
            {
            }
            column(DrugNo_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Drug No.")
            {
            }
            column(DrugName_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Drug Name")
            {
            }
            column(Quantity_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse".Quantity)
            {
            }
            column(UnitOfMeasure_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Unit Of Measure")
            {
            }
            column(Remarks_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse".Remarks)
            {
            }
            column(PharmacyCode_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Pharmacy Code")
            {
            }
            column(ActualQuantity_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Actual Quantity")
            {
            }
            column(Inventory_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse".Inventory)
            {
            }
            column(Issued_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse".Issued)
            {
            }
            column(Dosage_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse".Dosage)
            {
            }
            column(MarkedasIncompatible_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Marked as Incompatible")
            {
            }
            column(ActualQuantityIssued_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Actual Quantity Issued")
            {
            }
            column(RemainingQuantity_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Remaining Quantity")
            {
            }
            column(IssuedDate_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Issued Date")
            {
            }
            column(IssuedTime_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Issued Time")
            {
            }
            column(IssuedBy_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Issued By")
            {
            }
            column(PrescriptionDose_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Prescription Dose")
            {
            }
            column(PatientNo_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Patient No")
            {
            }
            column(AdmDate; AdmRec."Admission Date")
            {
            }
            column(Logo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(Prescribedby_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Prescribed by")
            {
            }
            column(PrescribedByname_HMSAdmissionDrugNurse; "HMS Admission Drug Nurse"."Prescribed By name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "HMS Admission Drug Nurse".CalcFields("Patient No");
                if PatRec.Get("HMS Admission Drug Nurse"."Patient No") then;

                if AdmRec.Get("HMS Admission Drug Nurse"."Admission No.") then;
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInf: Record "Company Information";
        AdmRec: Record "HMS Admission Form Header";
        PatRec: Record "HMS Patient";
}
