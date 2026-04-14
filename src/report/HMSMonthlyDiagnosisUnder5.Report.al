Report 85093 "HMS Monthly Diagnosis Under 5"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSMonthlyDiagnosisUnder5.rdl';

    dataset
    {
        dataitem("HMS Setup Diagnosis"; "HMS Setup Diagnosis")
        {
            RequestFilterFields = "Code", "Total Treatments Under 5";
            column(ReportForNavId_1; 1)
            {
            }
            column(Code_HMSSetupDiagnosis; "HMS Setup Diagnosis".Code)
            {
            }
            column(Description_HMSSetupDiagnosis; "HMS Setup Diagnosis".Description)
            {
            }
            column(MaleCounter_HMSSetupDiagnosis; "HMS Setup Diagnosis"."Male Counter")
            {
            }
            column(FemaleCounter_HMSSetupDiagnosis; "HMS Setup Diagnosis"."Female Counter")
            {
            }
            column(TotalTreatments_HMSSetupDiagnosis; "HMS Setup Diagnosis"."Total Treatments")
            {
            }
            column(DateFilter_HMSSetupDiagnosis; "HMS Setup Diagnosis"."Date Filter")
            {
            }
            column(NewAppointments_HMSSetupDiagnosis; "HMS Setup Diagnosis"."New Appointments")
            {
            }
            column(Diagnosis_HMSSetupDiagnosis; "HMS Setup Diagnosis".Diagnosis)
            {
            }
            column(TotalTreatmentsUnder5_HMSSetupDiagnosis; "HMS Setup Diagnosis"."Total Treatments Under 5")
            {
            }
            column(TotalTreatmentsOver5_HMSSetupDiagnosis; "HMS Setup Diagnosis"."Total Treatments Over 5")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SetFilter("Date Filter", '%1..%2', Dmy2date(1, Date2dmy(WorkDate(), 2)), WorkDate());
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
}
