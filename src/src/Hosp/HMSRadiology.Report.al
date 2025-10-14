Report 52202676 "HMS Radiology"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSRadiology.rdl';

    dataset
    {
        dataitem("HMS Treatment Form Radiology"; "HMS Treatment Form Radiology")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(StrNames; StrNames)
            {
            }
            column(logos; CompanyInfo.Picture)
            {
            }
            column(TreatmentNo_HMSTreatmentFormRadiology; "HMS Treatment Form Radiology"."Treatment No.")
            {
            }
            column(RadiologyTypeCode_HMSTreatmentFormRadiology; "HMS Treatment Form Radiology"."Radiology Type Code")
            {
            }
            column(RadiologyTypeName_HMSTreatmentFormRadiology; "HMS Treatment Form Radiology"."Radiology Type Name")
            {
            }
            column(DateDue_HMSTreatmentFormRadiology; "HMS Treatment Form Radiology"."Date Due")
            {
            }
            column(ClinicalSummaryDiagnosis_HMSTreatmentFormRadiology; "HMS Treatment Form Radiology"."Clinical Summary &  Diagnosis")
            {
            }
            column(Status_HMSTreatmentFormRadiology; "HMS Treatment Form Radiology".Status)
            {
            }
            column(RequiredInvestigation_HMSTreatmentFormRadiology; "HMS Treatment Form Radiology"."Required Investigation")
            {
            }
            column(PreviousInvestigation_HMSTreatmentFormRadiology; "HMS Treatment Form Radiology"."Previous Investigation")
            {
            }
            column(gender; objPat.Gender)
            {
            }
            column(tel1; objPat."Telephone No. 1")
            {
            }
            column(ageinyear; objPat."Age in Years")
            {
            }
            column(LMP_HMSTreatmentFormRadiology; "HMS Treatment Form Radiology".LMP)
            {
            }
            column(ReqType; "HMS Treatment Form Radiology"."Request Type")
            {
            }
            column(todaysDate; todaysDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                StrNames := '';

                objTreatment.Reset();
                objTreatment.SetRange(objTreatment."Treatment No.", "HMS Treatment Form Radiology"."Treatment No.");
                if objTreatment.Find('-') then begin
                    objPat.Reset();
                    objPat.SetRange(objPat."Patient No.", objTreatment."Patient No.");
                    if objPat.Find('-') then
                        StrNames := objPat.Surname + ' ' + objPat."Middle Name" + ' ' + objPat."Last Name";
                end;
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);

                todaysDate := Today;
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
        CompanyInfo: Record "Company Information";
        objPat: Record "HMS Patient";
        objTreatment: Record "HMS Treatment Form Header";
        todaysDate: Date;
        StrNames: Text;
}
