namespace HMISBC.HMISBC;

query 85060 "Treatment Prescriptions Lines"
{
    Caption = 'Treatment Prescriptions Lines';
    QueryType = Normal;

    elements
    {
        dataitem(HMSTreatmentFormDrug; "HMS Treatment Form Drug")
        {
            column(ActualQuantity; "Actual Quantity")
            {
            }
            column(Branch; Branch)
            {
            }
            column(DatePrescribed; "Date Prescribed")
            {
            }
            column(DateTaken; "Date Taken")
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
            column(Frequency; Frequency)
            {
            }
            column(IPStatus; "IP Status")
            {
            }
            column(Inpatient; Inpatient)
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(Issued; Issued)
            {
            }
            column(LlineNo; "Lline No")
            {
            }
            column(MarkedasIncompatible; "Marked as Incompatible")
            {
            }
            column(NumberofDays; "Number of Days")
            {
            }
            column(PatientNames; "Patient Names")
            {
            }
            column(PatientNo; "Patient No")
            {
            }
            column(PharmacyCode; "Pharmacy Code")
            {
            }
            column(PharmacyType; "Pharmacy Type")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PrescribedBy; "Prescribed By")
            {
            }
            column(PrescribedByname; "Prescribed By name")
            {
            }
            column(PrescriptionDose; "Prescription Dose")
            {
            }
            column(ProductGroup; "Product Group")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(RemainingDays; "Remaining Days")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Route; Route)
            {
            }
            column(SentDate; "Sent Date")
            {
            }
            column(Status; Status)
            {
            }
            column(StoppedDate; "Stopped Date")
            {
            }
            column(Stoppedby; "Stopped by")
            {
            }
            column(Take; Take)
            {
            }
            column(TotalPrice; "Total Price")
            {
            }
            column(TreatmentNo; "Treatment No.")
            {
            }
            column(UnitOfMeasure; "Unit Of Measure")
            {
            }
            column(UnitPrice; "Unit Price")
            {
            }            
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
