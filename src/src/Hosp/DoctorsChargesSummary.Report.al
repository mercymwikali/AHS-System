Report 52202530 "Doctors Charges Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Doctors/DoctorsChargesSummary.rdl';

    dataset
    {
        dataitem("HMS Setup Doctor"; "HMS Setup Doctor")
        {
            RequestFilterFields = "Doctor ID", "Date Filter";

            column(ReportForNavId_1; 1)
            {
            }
            column(DoctorID_HMSSetupDoctor; "HMS Setup Doctor"."Doctor ID")
            {
            }
            column(DoctorsName_HMSSetupDoctor; "HMS Setup Doctor"."Doctors Name")
            {
            }
            column(OpenCharges_HMSSetupDoctor; "HMS Setup Doctor"."Open Charges")
            {
            }
            column(ClaimedCharges_HMSSetupDoctor; "HMS Setup Doctor"."Claimed Charges")
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
