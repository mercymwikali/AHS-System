Report 52202532 "HMS Lab Diagnosis Report"
{
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSLabDiagnosisReport.rdl';

    dataset
    {
        dataitem("HMS Laboratory Results Entry"; "HMS Laboratory Results Entry")
        {
            CalcFields = "Lab Test  Date";
            RequestFilterFields = "Lab Test  Date", "Laboratory Test Code", Remarks, Flag, "Specimen Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(LabTestDate_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Lab Test  Date")
            {
            }
            column(LaboratoryNo_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Laboratory No.")
            {
            }
            column(LaboratoryTestCode_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Laboratory Test Code")
            {
            }
            column(LaboratoryTestName_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Laboratory Test Name")
            {
            }
            column(SpecimenCode_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Specimen Code")
            {
            }
            column(SpecimenName_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Specimen Name")
            {
            }
            column(AssignedUserID_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Staff Name")
            {
            }
            column(CollectionDate_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Collection Date")
            {
            }
            column(CollectionTime_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Collection Time")
            {
            }
            column(MeasuringUnitCode_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Measuring Unit Code")
            {
            }
            column(MeasuringUnitName_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Measuring Unit Name")
            {
            }
            column(Results_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Results)
            {
            }
            column(Remarks_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Remarks)
            {
            }
            column(Completed_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Completed)
            {
            }
            column(Positive_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Positive)
            {
            }
            column(TestNormalRanges_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Test Normal Ranges")
            {
            }
            column(TestUnits_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Test Units")
            {
            }
            column(Flag_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Flag)
            {
            }
            column(Reactive_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Reactive)
            {
            }
            column(NormalRange_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Normal Range")
            {
            }
            column(SortTest_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Sort Test")
            {
            }
            column(LabDate; LabDate)
            {
            }
            column(PatientNo; PatientNo)
            {
            }
            column(PatientNames; PatientNames)
            {
            }
            column(Logo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(Adress; CompInf.Address)
            {
            }
            column(Adress2; CompInf."Address 2")
            {
            }
            column(Phone; CompInf."Phone No.")
            {
            }
            column(labTest; labTest)
            {
            }
            column(Testcode; Testcode)
            {
            }
            column(ResultsRemarks; ResultsRemarks)
            {
            }
            column(ResultsFlag; ResultsFlag)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LabH.Reset();
                LabH.SetRange(LabH."Laboratory No.", "HMS Laboratory Results Entry"."Laboratory No.");
                if LabH.Find('-') then begin
                    //LabH.SETFILTER(LabH."Laboratory Date",'%1..',DateFilter);
                    LabDate := LabH."Laboratory Date";
                    PatientNo := LabH."Patient No.";
                    LabH.CalcFields(LabH."Patient Names");
                    PatientNames := LabH."Patient Names";
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(Picture);

                labTest := CopyStr(GetFilter("HMS Laboratory Results Entry"."Laboratory Test Name"), 1, 28);
                Testcode := CopyStr(GetFilter("HMS Laboratory Results Entry"."Specimen Code"), 1, 28);
                ResultsRemarks := CopyStr(GetFilter("HMS Laboratory Results Entry".Remarks), 11, 28);
                ResultsFlag := CopyStr(GetFilter("HMS Laboratory Results Entry".Flag), 11, 28);
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

    trigger OnPreReport()
    begin
        DateFilter := 0D;
        PatientNo := '';
        PatientNames := '';
    end;

    var
        CompInf: Record "Company Information";
        LabH: Record "HMS Laboratory Form Header";
        PatientNo: Code[20];
        DateFilter: Date;
        LabDate: Date;
        labTest: Text;
        PatientNames: Text;
        ResultsFlag: Text;
        ResultsRemarks: Text;
        Testcode: Text;
}
