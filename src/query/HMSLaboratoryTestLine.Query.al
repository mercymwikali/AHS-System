namespace HospitalSystem.HospitalSystem;

query 85226 "HMS Laboratory Test Line"
{
   
    QueryType = Normal;
    
    elements
    {
        dataitem(hmsLaboratoryTestLine; "HMS Laboratory Test Line")
        {
            column(amount; Amount)
            {
            }
            column(collectionDate; "Collection Date")
            {
            }
            column(collectionTime; "Collection Time")
            {
            }
            column(colorCode; "Color Code")
            {
            }
            column(completed; Completed)
            {
            }
            column(completionDate; "Completion Date")
            {
            }
            column(completionTime; "Completion Time")
            {
            }
            column(countValue; "Count Value")
            {
            }
            column(dateFilter; DateFilter)
            {
            }
            column(duplicateTest; "Duplicate test")
            {
            }
            column(insuranceAmount; "Insurance Amount")
            {
            }
            column(insuranceCode; "Insurance Code")
            {
            }
            column(insuranceName; "Insurance Name")
            {
            }
            column(insuranceNo; "Insurance No")
            {
            }
            column(labDate; "Lab Date")
            {
            }
            column(labRequestDate; "Lab Request Date")
            {
            }
            column(labRequestTime; "Lab Request Time")
            {
            }
            column(laboratoryNo; "Laboratory No.")
            {
            }
            column(laboratoryTestCode; "Laboratory Test Code")
            {
            }
            column(laboratoryTestName; "Laboratory Test Name")
            {
            }
            column(linkNo; "Link No")
            {
            }
            column(measuringUnitCode; "Measuring Unit Code")
            {
            }
            column(measuringUnitName; "Measuring Unit Name")
            {
            }
            column(modificationComments; "Modification Comments")
            {
            }
            column(outSourced; OutSourced)
            {
            }
            column(paid; Paid)
            {
            }
            column(patientNo; "Patient No")
            {
            }
            column(paymentExist; "Payment Exist")
            {
            }
            column(positive; Positive)
            {
            }
            column(receiptLineNo; "Receipt Line No")
            {
            }
            column(receiptNo; "Receipt No")
            {
            }
            column(remarks; Remarks)
            {
            }
            column(results; Results)
            {
            }
            column(resultsAdded; "Results Added")
            {
            }
            column(resultsType; "Results Type")
            {
            }
            column(reveiwDate; "Reveiw Date")
            {
            }
            column(reviewTime; "Review Time")
            {
            }
            column(reviewedBy; "Reviewed By")
            {
            }
            column(sampleCollected; "Sample Collected")
            {
            }
            column(specimen; Specimen)
            {
            }
            column(specimenCode; "Specimen Code")
            {
            }
            column(specimenName; "Specimen Name")
            {
            }
            column(staffName; "Staff Name")
            {
            }
            column(staffNo; "Staff No")
            {
            }
            column(status; Status)
            {
            }
            column(systemId; SystemId)
            {
            }
            column(systemModifiedAt; SystemModifiedAt)
            {
            }
            column(testAmount; "Test Amount")
            {
            }
            column(treatNo; "Treat No")
            {
            }
            column(treatmentNo; "Treatment No")
            {
            }
            column(patientType; "patient Type")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
