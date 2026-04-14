Report 85163 "Radiology Report Monthly"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RadiologyReportMonthly.rdl';

    dataset
    {
        dataitem("HMS Setup Radiology Type"; "HMS Setup Radiology Type")
        {
            column(ReportForNavId_14; 14)
            {
            }
            column(Code_HMSSetupRadiologyType; "HMS Setup Radiology Type".Code)
            {
            }
            column(Description_HMSSetupRadiologyType; "HMS Setup Radiology Type".Description)
            {
            }
            column(RadiologySection_HMSSetupRadiologyType; "HMS Setup Radiology Type"."Radiology Section")
            {
            }
            column(bignum; bignum)
            {
            }
            dataitem("HMS Radiology Form Line"; "HMS Radiology Form Line")
            {
                DataItemLink = "Radiology Type Code" = field(Code);
                column(ReportForNavId_1; 1)
                {
                }
                column(Radiologyno_HMSRadiologyFormLine; "HMS Radiology Form Line"."Radiology no.")
                {
                }
                column(RadiologyTypeCode_HMSRadiologyFormLine; "HMS Radiology Form Line"."Radiology Type Code")
                {
                }
                column(RadiologyTypeName_HMSRadiologyFormLine; "HMS Radiology Form Line"."Radiology Type Name")
                {
                }
                column(AssignedUserID_HMSRadiologyFormLine; "HMS Radiology Form Line"."Assigned User ID")
                {
                }
                column(Completed_HMSRadiologyFormLine; "HMS Radiology Form Line".Completed)
                {
                }
                column(PerformedDate_HMSRadiologyFormLine; "HMS Radiology Form Line"."Performed Date")
                {
                }
                column(PerformedTime_HMSRadiologyFormLine; "HMS Radiology Form Line"."Performed Time")
                {
                }
                column(Remarks_HMSRadiologyFormLine; "HMS Radiology Form Line".Remarks)
                {
                }
                column(ClinicalSummaryDiagnosis_HMSRadiologyFormLine; "HMS Radiology Form Line"."Clinical Summary &  Diagnosis")
                {
                }
                column(RequiredInvestigation_HMSRadiologyFormLine; "HMS Radiology Form Line"."Required Investigation")
                {
                }
                column(PreviousInvestigation_HMSRadiologyFormLine; "HMS Radiology Form Line"."Previous Investigation")
                {
                }
                column(num; num)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    num := num + 1;
                end;

                trigger OnPreDataItem()
                begin
                    num := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                bignum := bignum + 1;
            end;

            trigger OnPreDataItem()
            begin
                bignum := 0;
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
        bignum: Integer;
        num: Integer;
}
