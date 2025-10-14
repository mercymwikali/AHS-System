Report 52202451 "HMS Lab Results2"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Lab/HMSLabResults2.rdl';

    dataset
    {

        dataitem(HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry")
        {
            DataItemTableView = sorting("Laboratory No.", "Laboratory Test Code", "Sort Test", "Specimen Code") order(ascending);
            CalcFields = "Laboratory Test Name", "Specimen Name";
            RequestFilterFields = "Laboratory No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(LaboratoryNo_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Laboratory No.")
            {
            }
            column(LaboratoryTestCode_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Laboratory Test Code")
            {
            }
            column(SpecimenCode_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Specimen Code")
            {
            }
            column(SpecimenName_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Specimen Name")
            {
            }
            column(MeasuringUnitCode_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Measuring Unit Code")
            {
            }
            column(MeasuringUnitName_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Measuring Unit Name")
            {
            }
            column(TestNormalRanges_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Test Normal Ranges")
            {
            }
            column(CountValue_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry.Results)
            {
            }
            column(Remarks_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry.Remarks)
            {
            }
            column(FinalRemarks; HMSLaboratoryTestLine.Remarks) { }
            column(Positive_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry.Positive)
            {
            }
            column(AssignedUserID_HMSLaboratoryResultsEntry; HMSLaboratoryTestLine."Staff Name")
            {
            }
            column(Completed_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry.Completed)
            {
            }
            column(PatNo; HMSPatient."Patient No.")
            {
            }
            column(PatNames; HMSPatient."Search Name")
            {
            }
            column(DoctID; Doc)
            {
            }
            column(ReceivedDate; LabFormHeader."Laboratory Date")
            {
            }
            column(CompletionDate; LabFormHeader."Completion Date")
            {
            }
            column(TiemRequested; LabFormHeader."Laboratory Time")
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(CompanyAddress; CompInf.Address)
            {
            }
            column(CompInfEmail; CompInf."E-Mail") { }
            column(CompInfPhone; CompInf."Phone No.") { }
            column(CompLogo; CompInf.Picture)
            {
            }
            column(Measurement; LabTestSetup.MeasurementProc)
            {
            }
            column(TestDesc; LabTestSetup.Description)
            {
            }
            column(Flag_HMSLaboratoryResultsEntry; TestFlag)
            {
            }
            column(SupervisorID; LabFormHeader."Supervisor ID")
            {
            }
            column(AgeinYrs; Age)
            {
            }
            column(PatGender; HMSPatient.Gender)
            {
            }
            column(LaboratoryTestName_HMSLaboratoryResultsEntry; TestName)
            {
            }
            column(Reactive_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry.Reactive)
            {
            }
            column(Results; reslt)
            {
            }
            column(Counts; Counts)
            {
            }
            column(SortTest_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Sort Test")
            {
            }
            column(ReviewedBy_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Reviewed By")
            {
            }
            column(ReveiwDate_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Reveiw Date")
            {
            }
            column(ReviewTime_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Review Time")
            {
            }
            column(CollectionDate_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Collection Date")
            {
            }
            column(CollectionTime_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Collection Time")
            {
            }
            column(CriticalValue_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Critical Value")
            {
            }
            column(CriticalRanges_HMSLaboratoryResultsEntry; HMSLaboratoryResultsEntry."Critical Ranges")
            {
            }
            column(LabComments1; LabComments[1])
            {
            }
            column(LabComments2; LabComments[2])
            {
            }
            column(LabComments3; LabComments[3])
            {
            }
            column(LabComments4; LabComments[4])
            {
            }
            column(LabComments5; LabComments[5])
            {
            }
            column(LabComments6; LabComments[6])
            {
            }
            column(LabComments7; LabComments[7])
            {
            }
            column(LabComments8; LabComments[8])
            {
            }
            column(LabComments9; LabComments[9])
            {
            }
            column(LabComments10; LabComments[10])
            {
            }
            column(Testmethod; Testmethod)
            {
            }
            column(ReviewedBy; HMSLaboratoryTestLine."Reviewed By")
            {
            }
            column(ReviewTime; HMSLaboratoryTestLine."Review Time")
            {
            }
            column(ReviewDate; HMSLaboratoryTestLine."Reveiw Date")
            {
            }
            column(Dept; LabFormHeader.Branch)
            {
            }
            column(PrimarySample; HMSSample."Type of Tube")
            {
            }
            column(TestModification; LabNotes."Modification Comments")
            {
            }
            column(Signature1_; Signature1)
            {
            }
            column(Signature2_; Signature2)
            {
            }
            column(Sample_Collection_Date; HMSSample."Collection Date")
            {
            }
            column(Sample_Collection_Time; HMSSample."Collection Time")
            {
            }
            column(Sample_Collected_By; HMSSample."Collected By")
            {
            }
            column(ReceivedBy; HMSSample."Received Rejected By")
            {
            }
            column(LabReqDate; HMSLaboratoryTestLine."Lab Request Date")
            {
            }
            column(LabReqTime; HMSLaboratoryTestLine."Lab Request Time")
            {
            }
            column(NormRange; NormRange)
            {
            }
            column(CriticalRange; CriticalRange)
            {
            }
            column(TestCategory; UpperCase(TestCategory))
            {
            }
            column(HideNarrationField; HideNarrationField)
            {

            }
            column(NarrationResult; NarrationResult) { }
            column(HideMeasurementColumn; HideMeasurementColumn) { }

            trigger OnAfterGetRecord()
            begin
                TestCategory := '';
                TestFlag := '';
                Counts := 0;
                NormRange := '';
                CriticalRange := '';
                HideNarrationField := true;
                HideMeasurementColumn := true;
                NarrationResult := '';
                reslt := '';

                case HMSLaboratoryResultsEntry.Flag of
                    HMSLaboratoryResultsEntry.Flag::High:
                        TestFlag := 'HIGH';
                    HMSLaboratoryResultsEntry.Flag::Low:
                        TestFlag := 'LOW';
                end;

                // Get Laboratory Parameter Ranges Formats
                LabParameterSetup.Reset();
                LabParameterSetup.SetRange(LabParameterSetup."Laboratory Test Code", "Laboratory Test Code");
                LabParameterSetup.SetRange(LabParameterSetup."Specimen Code", "Specimen Code");
                if LabParameterSetup.Find('-') then begin
                    NormRange := Format(LabParameterSetup."Min Range") + '-' + Format(LabParameterSetup."Max Range");
                    CriticalRange := Format(LabParameterSetup."Critical Value Low") + '-' + Format(LabParameterSetup."Critical Value High");
                end;
                /* ***Results Input*** */
                /* 
                    - If the Results field is empty, it means that the test results input is a narration. Thus show the remarks field.
                    - Show the Narration table row only if result type is narration.
                */
                HMSLaboratoryResultsEntry.Validate(Results);
                case HMSLaboratoryResultsEntry."Result Type" of
                    HMSLaboratoryResultsEntry."Result Type"::Number:
                        begin
                            HideMeasurementColumn := false;
                            reslt := Format(HMSLaboratoryResultsEntry.Results);
                            if HMSLaboratoryResultsEntry.Remarks <> '' then
                                reslt := HMSLaboratoryResultsEntry.Remarks;
                        end;
                    HMSLaboratoryResultsEntry."Result Type"::Narration:
                        begin
                            HideNarrationField := false;
                            NarrationResult := HMSLaboratoryResultsEntry.Remarks;
                        end;
                    HMSLaboratoryResultsEntry."Result Type"::"Short Description":
                        reslt := HMSLaboratoryResultsEntry.Remarks;
                end;

                /* *******Laboratory Form Header and Laboratory Test Setup Values*********** */
                /* 
                    - Requesting Doctor
                    - Patient Age
                    - Test name
                    - Test Category
                */
                if LabFormHeader.Get(HMSLaboratoryResultsEntry."Laboratory No.") then begin
                    if HMSDocHeader.Get(LabFormHeader."Doctor ID") then
                        Doc := HMSDocHeader."Doctors Name";

                    if Doc = '' then
                        Doc := 'WALKIN';
                    if HMSPatient.GET(LabFormHeader."Patient No.") then
                        if HMSPatient."Date Of Birth" <> 0D then
                            Age := HRDates.DetermineAge(HMSPatient."Date Of Birth", TODAY);

                    LabTestSetup.Reset();
                    LabTestSetup.SetRange(LabTestSetup.Code, HMSLaboratoryResultsEntry."Laboratory Test Code");
                    if LabTestSetup.Find('-') then begin
                        LabTestSetup.CalcFields(MeasurementProc);
                        TestName := LabTestSetup.Description;
                        TestCategory := LabTestSetup.Department;
                    end;
                end;

                /* ***Laboratory Test Line*** */
                /*
                    - Test Method 
                    - Reviewer Signature
                */

                HMSLaboratoryTestLine.Reset();
                HMSLaboratoryTestLine.SetRange("Laboratory No.", HMSLaboratoryResultsEntry."Laboratory No.");
                HMSLaboratoryTestLine.SetRange("Laboratory Test Code", HMSLaboratoryResultsEntry."Laboratory Test Code");
                if HMSLaboratoryTestLine.Find('-') then begin
                    Testmethod := HMSLaboratoryTestLine."Modification Comments";
                    Signature2 := GetSignature(HMSLaboratoryTestLine."Reviewed By");
                end;

                i := 0;
                LabNotes.Reset();
                LabNotes.SetRange(LabNotes."Laboratory No.", HMSLaboratoryResultsEntry."Laboratory No.");
                LabNotes.SetRange(LabNotes."Laboratory Test Code", HMSLaboratoryResultsEntry."Laboratory Test Code");
                LabNotes.SetFilter(LabNotes.Remarks, '<>%1', '');
                if LabNotes.Find('-') then begin

                    if LabNotes.Remarks = '' then
                        LabNotes.Remarks := 'N/A';
                    repeat
                        if i < 11 then begin
                            i := i + 1;

                            LabComments[i] := LabNotes.Remarks + '  ';
                        end;
                    until LabNotes.Next() = 0;
                end;

                Signature1 := GetSignature(HMSLaboratoryResultsEntry."Assigned User ID");
                // TODO: Update the Assigned user when finalizing the lab report

                HMSSample.Reset();
                HMSSample.SetRange("Laboratory No", HMSLaboratoryResultsEntry."Laboratory No.");
                HMSSample.SetRange("Lab Test Code", HMSLaboratoryResultsEntry."Laboratory Test Code");
                if HMSSample.Find('-') then;
                Counts := Counts + 1;
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(CompInf.Picture);
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
        CompInf: Record "Company Information";
        LabFormHeader: Record "HMS Laboratory Form Header";
        HMSLaboratoryTestLine: Record "HMS Laboratory Test Line";
        LabParameterSetup: Record "HMS Lab Parameters setup";
        HMSPatient: Record "HMS Patient";
        HMSSample: Record "HMS Sample";
        HMSDocHeader: Record "HMS Setup Doctor";
        LabTestSetup: Record "HMS Setup Lab Test";
        LabNotes: Record "Lab Notes";
        HRDates: Codeunit "HMS Patient-integration";
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        IStream: InStream;
        Counts: Integer;
        i: Integer;
        Age: Text;
        CriticalRange: Text;
        Doc: Text;
        NormRange: Text;
        Signature1: Text;
        Signature2: Text;
        TestName: Text;
        reslt: Text[2000];
        Testmethod: Text[250];
        LabComments: array[11] of Text[500];
        TestCategory: Text[50];
        TestFlag: Text;
        NarrationResult: Text;
        HideNarrationField: Boolean;
        HideMeasurementColumn: Boolean;

    local procedure GetSignature(userid: Code[50]) BaseImage: Text
    var
        userset: Record "User Setup";
    begin

        userset.Reset();
        userset.SetRange("User ID", userid);
        if userset.Find('-') then
            userset.CalcFields(userset.Signature);
        userset.Signature.CreateInstream(IStream);
        MemoryStream := MemoryStream.MemoryStream();
        CopyStream(MemoryStream, IStream);
        Bytes := MemoryStream.GetBuffer();
        BaseImage := Convert.ToBase64String(Bytes);
    end;
}
