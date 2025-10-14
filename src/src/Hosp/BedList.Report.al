report 52202487 "Bed List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/WardManagement/BedList.rdl';

    dataset
    {
        dataitem("HMS Beds"; "HMS Beds")
        {
            RequestFilterFields = Occupied;
            column(ReportForNavId_1; 1)
            {
            }
            column(WardNo_HMSBeds; "HMS Beds"."Ward No")
            {
            }
            column(BedNo_HMSBeds; "HMS Beds"."Bed No")
            {
            }
            column(Occupied_HMSBeds; "HMS Beds".Occupied)
            {
            }
            column(BedName_HMSBeds; "HMS Beds"."Bed Name")
            {
            }
            column(Admission_Date; AdmissionForm."Admission Date")
            {
            }
            column(Patient_No; AdmissionForm."Patient No.")
            {
            }
            column(PatientNAme; AdmissionForm."Search Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                AdmissionForm.Reset();
                AdmissionForm.SetRange(AdmissionForm.Bed, "HMS Beds"."Bed No");
                if AdmissionForm.Find('-') then;
                    //Ndio hii
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
        AdmissionForm: Record "HMS Admission Form Header";
}
