Report 85133 Inpatient
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Inpatient.rdl';

    dataset
    {
        dataitem("HMS Admission Form Header"; "HMS Admission Form Header")
        {
            RequestFilterFields = "Admission Date", "Admission Time", "Patient No.", Status;
            column(ReportForNavId_1; 1)
            {
            }
            column(AdmissionNo_HMSAdmissionFormHeader; "HMS Admission Form Header"."Admission No.")
            {
            }
            column(PatientNo_HMSAdmissionFormHeader; "HMS Admission Form Header"."Patient No.")
            {
            }
            column(Names; mNames)
            {
            }
            column(AdmissionDate_HMSAdmissionFormHeader; mDates)
            {
            }
            column(AdmissionTime_HMSAdmissionFormHeader; "HMS Admission Form Header"."Admission Time")
            {
            }
            column(mCount; mCount)
            {
            }
            column(CurrentBill_HMSAdmissionFormHeader; "HMS Admission Form Header"."Current Bill")
            {
            }
            column(Receipts_HMSAdmissionFormHeader; "HMS Admission Form Header".Receipts)
            {
            }
            column(Balance_HMSAdmissionFormHeader; "HMS Admission Form Header".Balance)
            {
            }
            column(Ward_HMSAdmissionFormHeader; "HMS Admission Form Header".Ward)
            {
            }
            column(Bed_HMSAdmissionFormHeader; "HMS Admission Form Header".Bed)
            {
            }
            column(Doctor_HMSAdmissionFormHeader; "HMS Admission Form Header".Doctor)
            {
            }
            column(Status_HMSAdmissionFormHeader; "HMS Admission Form Header".Status)
            {
            }
            column(PatType; HMSPat."Patient Type")
            {
            }
            column(insNo; HMSPat."Insurance No.")
            {
            }
            column(InsNM; HMSPat."Insurance Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                mCount := mCount + 1;
                mNames := '';
                mDates := "Admission Date";

                HMSPat.Reset();
                HMSPat.SetRange(HMSPat."Patient No.", "HMS Admission Form Header"."Patient No.");
                if HMSPat.Find('-') then
                    mNames := HMSPat.Surname + ' ' + HMSPat."Middle Name" + ' ' + HMSPat."Last Name";
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
        HMSPat: Record "HMS Patient";
        mDates: Date;
        mCount: Integer;
        mNames: Text;
}
