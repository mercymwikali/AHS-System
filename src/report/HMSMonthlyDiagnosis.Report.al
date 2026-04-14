Report 85092 "HMS Monthly Diagnosis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSMonthlyDiagnosis.rdl';

    dataset
    {
        dataitem("HMS Setup Diagnosis"; "HMS Setup Diagnosis")
        {
            DataItemTableView = where("Total Treatments" = filter(> 0));
            RequestFilterFields = "Code", "Total Treatments";
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
            column(TotalTreatments; "HMS Setup Diagnosis"."Total Treatments")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        EndDate: Date;
        StartDate: Date;
}
