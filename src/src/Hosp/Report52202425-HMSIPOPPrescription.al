report 52202425 "HMS IP/OP Prescription"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pharmacy/HMS IPOP Prescription.rdl';

    dataset
    {
        dataitem("HMS Pharmacy Header"; "HMS Pharmacy Header")
        {
            RequestFilterFields = "Pharmacy Date", InPatient, Walkin, "Global Dimension 1 Code", "Pharmacy Type";

            column(CLogo; CompanyInfo.Picture)
            {
            }
            column(PharmacyDate_HMSPharmacyHeader; "HMS Pharmacy Header"."Pharmacy Date")
            {
            }
            column(PharmacyTime_HMSPharmacyHeader; "HMS Pharmacy Header"."Pharmacy Time")
            {
            }
            column(PatientNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Patient No.")
            {
            }
            column(IssuedBy_HMSPharmacyHeader; "HMS Pharmacy Header"."Issued By")
            {
            }
            column(LinkType_HMSPharmacyHeader; "HMS Pharmacy Header"."Link Type")
            {
            }
            column(LinkNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Link No.")
            {
            }
            column(Status_HMSPharmacyHeader; "HMS Pharmacy Header".Status)
            {
            }
            column(Surname_HMSPharmacyHeader; "HMS Pharmacy Header".Surname)
            {
            }
            column(MiddleName_HMSPharmacyHeader; "HMS Pharmacy Header"."Middle Name")
            {
            }
            column(LastName_HMSPharmacyHeader; "HMS Pharmacy Header"."Last Name")
            {
            }
            column(IDNumber_HMSPharmacyHeader; "HMS Pharmacy Header"."ID Number")
            {
            }
            column(TotalPrice_HMSPharmacyHeader; "HMS Pharmacy Header"."Total Price")
            {
            }
            column(PatientType_HMSPharmacyHeader; "HMS Pharmacy Header"."Patient Type")
            {
            }
            column(CashSale_HMSPharmacyHeader; "HMS Pharmacy Header"."Cash Sale")
            {
            }
            column(ADMNo_HMSPharmacyHeader; "HMS Pharmacy Header"."ADM No")
            {
            }
            column(SearchName_HMSPharmacyHeader; "HMS Pharmacy Header"."Search Name")
            {
            }
            column(TreatmentNo_HMSPharmacyHeader; "HMS Pharmacy Header"."Treatment No.")
            {
            }
            column(IssuingLocation_HMSPharmacyHeader; "HMS Pharmacy Header"."Issuing Location")
            {
            }
            column(Remarks_HMSPharmacyHeader; "HMS Pharmacy Header".Remarks)
            {
            }
            column(InsuranceAmount_HMSPharmacyHeader; "HMS Pharmacy Header"."Insurance Amount")
            {
            }
            column(UserId_HMSPharmacyHeader; "HMS Pharmacy Header"."User Id")
            {
            }
            column(InsuranceCode_HMSPharmacyHeader; "HMS Pharmacy Header"."Insurance Code")
            {
            }
            column(DoctorID_HMSPharmacyHeader; "HMS Pharmacy Header"."Doctor ID")
            {
            }
            column(Walkin_HMSPharmacyHeader; "HMS Pharmacy Header".Walkin)
            {
            }
            column(Age_HMSPharmacyHeader; "HMS Pharmacy Header".Age)
            {
            }
            column(GlobalDimension1_HMSPharmacyHeader; "HMS Pharmacy Header"."Global Dimension 1 Code")
            {
            }
            column(PharmacyType_HMSPharmacyHeader; "HMS Pharmacy Header"."Pharmacy Type")
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

    var
        CompanyInfo: Record "Company Information";
}
