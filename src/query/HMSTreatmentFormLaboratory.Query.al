namespace HMISBC.HMISBC;

query 85055 "HMS Treatment Form Laboratory"
{
    Caption = 'HMS Treatment Form Laboratory';
    QueryType = Normal;

    elements
    {
        dataitem(HMSTreatmentFormLaboratory; "HMS Treatment Form Laboratory")
        {
            column(Branch; Branch)
            {
            }
            column(BriefHistory; "Brief History")
            {
            }
            column(DateDue; "Date Due")
            {
            }
            column(DateTaken; "Date Taken")
            {
            }
            column(Diagnosis; Diagnosis)
            {
            }
            column(LabNo; "Lab No")
            {
            }
            column(LaboratoryTestPackageCode; "Laboratory Test Package Code")
            {
            }
            column(LineNo; "Line No")
            {
            }
            column(Results; Results)
            {
            }
            column(Specimen; Specimen)
            {
            }
            column(Status; Status)
            {
            }
            column(Test; Test)
            {
            }
            column("Time"; "Time")
            {
            }
            column(TreatmentNo; "Treatment No.")
            {
            }
            column(UUID; UUID)
            {
            }
            column(LaboratoryTestPackageName; "Laboratory Test Package Name")
            {
            }
            column(Lab_No;"Lab No")
            {                
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
