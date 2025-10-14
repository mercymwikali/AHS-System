report 52202452 "HMS Diagnosis List"
{
    Caption = 'HMS Diagnosis Listing';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Doctors/HMSDiagnosisListing.rdl';

    dataset
    {
        dataitem("HMS Setup Diagnosis"; "HMS Setup Diagnosis")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Code_HMSSetupDiagnosis; "HMS Setup Diagnosis".Code)
            {
            }
            column(Description_HMSSetupDiagnosis; "HMS Setup Diagnosis".Description)
            {
            }
            column(Diagnosis_HMSSetupDiagnosis; "HMS Setup Diagnosis".Diagnosis)
            {
            }
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
}
