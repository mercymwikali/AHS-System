Report 85082 "HMS General Observation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSGeneralObservation.rdl';

    dataset
    {
        dataitem("HMS Admission Form Header"; "HMS Admission Form Header")
        {
            RequestFilterFields = "Patient No.", "Admission No.", "Admission Date";
            column(ReportForNavId_7; 7)
            {
            }
            column(AdmissionNo_HMSAdmissionFormHeader; "HMS Admission Form Header"."Admission No.")
            {
            }
            column(AdmissionDate_HMSAdmissionFormHeader; "HMS Admission Form Header"."Admission Date")
            {
            }
            column(AdmissionHeight_HMSAdmissionFormHeader; "HMS Admission Form Header"."Admission Height")
            {
            }
            column(AdmissionWeight_HMSAdmissionFormHeader; "HMS Admission Form Header"."Admission Weight")
            {
            }
            column(AdmissionBMI_HMSAdmissionFormHeader; "HMS Admission Form Header"."Admission BMI")
            {
            }
            column(Names; PatRec.Surname + ' ' + PatRec."Last Name")
            {
            }
            column(Gender; PatRec.Gender)
            {
            }
            column(DOB; PatRec."Date Of Birth")
            {
            }
            column(CompLogo; CompInf.Picture)
            {
            }
            dataitem("HMS General Observation"; "HMS General Observation")
            {
                DataItemLink = "Patient No" = field("Patient No."), "Admission No" = field("Admission No.");
                column(ReportForNavId_1; 1)
                {
                }
                column(PatientNo_HMSGeneralObservation; "HMS General Observation"."Patient No")
                {
                }
                column(Date_HMSGeneralObservation; "HMS General Observation".Date)
                {
                }
                column(Category_HMSGeneralObservation; "HMS General Observation".Category)
                {
                }
                column(CategoryValue_HMSGeneralObservation; "HMS General Observation"."Category Value")
                {
                }
                column(Timing_HMSGeneralObservation; "HMS General Observation".Timing)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if PatRec.Get("HMS General Observation"."Patient No") then;
                end;

                trigger OnPreDataItem()
                begin
                    CompInf.Get();
                    CompInf.CalcFields(CompInf.Picture);
                end;
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
        CompInf: Record "Company Information";
        PatRec: Record "HMS Patient";
}
