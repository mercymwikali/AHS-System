Report 85191 "Suggest Doctor Payments"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HMS Patient Visit Nos"; "HMS Patient Visit Nos")
        {
            DataItemTableView = where(Posted = const(true), Completed = const(false), Show = const(false));
            RequestFilterFields = "Doctor ID", "Insurance No";
            column(ReportForNavId_1; 1)
            {
            }
            column(PatientNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Patient No")
            {
            }
            column(VisitNo_HMSPatientVisitNos; "HMS Patient Visit Nos"."Visit No")
            {
            }
            column(Balance_HMSPatientVisitNos; "HMS Patient Visit Nos".Balance)
            {
            }
            column(DoctorAmount_HMSPatientVisitNos; "HMS Patient Visit Nos"."Doctor Amount")
            {
            }
            column(DoctorID_HMSPatientVisitNos; "HMS Patient Visit Nos"."Doctor ID")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "HMS Patient Visit Nos".Show := true;
                "HMS Patient Visit Nos".Modify();
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
