Report 85130 "HMS Treatment Notes"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSTreatmentNotes.rdl';

    dataset
    {
        dataitem("HMS Treatment Form Header"; "HMS Treatment Form Header")
        {
            CalcFields = "Lab No";
            RequestFilterFields = "Treatment No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(TreatmentNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment No.")
            {
            }
            column(TreatmentType_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment Type")
            {
            }
            column(TreatmentDate_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment Date")
            {
            }
            column(TreatmentTime_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment Time")
            {
            }
            column(DoctorID_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Doctor ID")
            {
            }
            column(PatientNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Patient No.")
            {
            }
            column(StudentNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Student No.")
            {
            }
            column(EmployeeNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Employee No.")
            {
            }
            column(RelativeNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Relative No.")
            {
            }
            column(DoctorNotes_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Doctor Notes")
            {
            }
            column(Status_HMSTreatmentFormHeader; "HMS Treatment Form Header".Status)
            {
            }
            column(LinkNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Link No.")
            {
            }
            column(LinkType_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Link Type")
            {
            }
            column(NoSeries_HMSTreatmentFormHeader; "HMS Treatment Form Header"."No. Series")
            {
            }
            column(OffDutyDays_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Off Duty Days")
            {
            }
            column(LightDutyDays_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Light Duty Days")
            {
            }
            column(OffDutyComments_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Off Duty Comments")
            {
            }
            column(OffDuty_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Off Duty")
            {
            }
            column(TreatmentLocation_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment Location")
            {
            }
            column(PatientType_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Patient Type")
            {
            }
            column(Surname_HMSTreatmentFormHeader; "HMS Treatment Form Header".Surname)
            {
            }
            column(MiddleName_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Middle Name")
            {
            }
            column(LastName_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Last Name")
            {
            }
            column(IDNumber_HMSTreatmentFormHeader; "HMS Treatment Form Header"."ID Number")
            {
            }
            column(CorrespondenceAddress1_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Correspondence Address 1")
            {
            }
            column(TelephoneNo1_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Telephone No. 1")
            {
            }
            column(PatientName_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Patient Name")
            {
            }
            column(SettlementType_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Settlement Type")
            {
            }
            column(MembershipNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Membership No")
            {
            }
            column(InsuranceName_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Insurance Name")
            {
            }
            column(AdmNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Adm No.")
            {
            }
            column(NextAppointmentDate_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Next Appointment Date")
            {
            }
            column(SickOffStartDate_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Sick Off Start Date")
            {
            }
            column(SickOffEndDate_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Sick Off End Date")
            {
            }
            column(InPatient_HMSTreatmentFormHeader; "HMS Treatment Form Header".InPatient)
            {
            }
            column(StatusRemarks_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Status Remarks")
            {
            }
            column(Clinic_HMSTreatmentFormHeader; "HMS Treatment Form Header".Clinic)
            {
            }
            column(DoctorsName_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Doctor's Name")
            {
            }
            column(WaitingAt_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Waiting At")
            {
            }
            column(Names; strNm)
            {
            }
            column(DOB; strDateofBirth)
            {
            }
            column(Sex; strSex)
            {
            }
            column(Residence; strResident)
            {
            }
            column(Address; strAddress)
            {
            }
            column(DOA; strDOA)
            {
            }
            column(Age; strAge)
            {
            }
            column(Tel; strTel)
            {
            }
            column(PatNo; PatNo)
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
            column(PB; PB)
            {
            }
            column(Temp; Temp)
            {
            }
            column(Pulse; Pulse)
            {
            }
            column(Resp; Resp)
            {
            }
            column(Wt; Wt)
            {
            }
            column(O2; O2)
            {
            }
            column(HPI; HPI)
            {
            }
            column(HPIuser; HPIuser)
            {
            }
            column(Nt1; Nt[1])
            {
            }
            column(Nt2; Nt[2])
            {
            }
            column(Nt3; Nt[3])
            {
            }
            column(Nt4; Nt[4])
            {
            }
            column(Nt5; Nt[5])
            {
            }
            column(Nt6; Nt[6])
            {
            }
            column(Nt7; Nt[7])
            {
            }
            column(Nt8; Nt[8])
            {
            }
            column(Nt9; Nt[9])
            {
            }
            column(Nt10; Nt[10])
            {
            }
            column(Chiefcomplaints; Chiefcomplaints)
            {
            }
            column(ChiefcomplaintsUser; ChiefcomplaintsUser)
            {
            }
            column(CC1; CC[1])
            {
            }
            column(CC2; CC[2])
            {
            }
            column(CC3; CC[3])
            {
            }
            column(CC4; CC[4])
            {
            }
            column(CC5; CC[5])
            {
            }
            column(CC6; CC[6])
            {
            }
            column(CC7; CC[7])
            {
            }
            column(DoctorsAdvice; DoctorsAdvice)
            {
            }
            column(DoctorsAdviceUser; DoctorsAdviceUser)
            {
            }
            column(DA1; DA[1])
            {
            }
            column(DA2; DA[2])
            {
            }
            column(DA3; DA[3])
            {
            }
            column(DA4; DA[4])
            {
            }
            column(DA5; DA[5])
            {
            }
            column(DA6; DA[6])
            {
            }
            column(DA7; DA[7])
            {
            }
            column(DocNotes; DocNotes)
            {
            }
            column(DocNotesUser; DocNotesUser)
            {
            }
            column(DocNot1; DocNot[1])
            {
            }
            column(DocNot2; DocNot[2])
            {
            }
            column(DocNot3; DocNot[3])
            {
            }
            column(DocNot4; DocNot[4])
            {
            }
            column(DocNot5; DocNot[5])
            {
            }
            column(DocNot6; DocNot[6])
            {
            }
            column(DocNot7; DocNot[7])
            {
            }
            column(PastSurgicalH; PastSurgicalH)
            {
            }
            column(PastSurgicalHUser; PastSurgicalHUser)
            {
            }
            column(PSH1; PSH[1])
            {
            }
            column(PSH2; PSH[2])
            {
            }
            column(PSH3; PSH[3])
            {
            }
            column(PSH4; PSH[4])
            {
            }
            column(PSH5; PSH[5])
            {
            }
            column(PSH6; PSH[6])
            {
            }
            column(PSH7; PSH[7])
            {
            }
            column(PastMed; PastMed)
            {
            }
            column(PastMedUser; PastMedUser)
            {
            }
            column(PMH1; PMH[1])
            {
            }
            column(PMH2; PMH[2])
            {
            }
            column(PMH3; PMH[3])
            {
            }
            column(PMH4; PMH[4])
            {
            }
            column(PMH5; PMH[5])
            {
            }
            column(PMH6; PMH[6])
            {
            }
            column(PMH7; PMH[7])
            {
            }
            column(PastSocialHist; PastSocialHist)
            {
            }
            column(PastSocialHistUser; PastSocialHistUser)
            {
            }
            column(PSCH1; PSCH[1])
            {
            }
            column(PSCH2; PSCH[2])
            {
            }
            column(PSCH3; PSCH[3])
            {
            }
            column(PSCH4; PSCH[4])
            {
            }
            column(PSCH5; PSCH[5])
            {
            }
            column(PSCH6; PSCH[6])
            {
            }
            column(PSCH7; PSCH[7])
            {
            }
            column(MedicalReport; MedicalReport)
            {
            }
            column(MedicalReportUser; MedicalReportUser)
            {
            }
            column(MEDR1; MEDR[1])
            {
            }
            column(MEDR2; MEDR[2])
            {
            }
            column(MEDR3; MEDR[3])
            {
            }
            column(MEDR4; MEDR[4])
            {
            }
            column(MEDR5; MEDR[5])
            {
            }
            column(MEDR6; MEDR[6])
            {
            }
            column(MEDR7; MEDR[7])
            {
            }
            column(TreatmentPlan; TreatmentPlan)
            {
            }
            column(TreatmentPlanUser; TreatmentPlanUser)
            {
            }
            column(TreatP1; TreatP[1])
            {
            }
            column(TreatP2; TreatP[2])
            {
            }
            column(TreatP3; TreatP[3])
            {
            }
            column(TreatP4; TreatP[4])
            {
            }
            column(TreatP5; TreatP[5])
            {
            }
            column(TreatP6; TreatP[6])
            {
            }
            column(TreatP7; TreatP[7])
            {
            }
            column(Investigations; Investigations)
            {
            }
            column(InvestigationsUser; InvestigationsUser)
            {
            }
            column(Inves1; Inves[1])
            {
            }
            column(Inves2; Inves[2])
            {
            }
            column(Inves3; Inves[3])
            {
            }
            column(Inves4; Inves[4])
            {
            }
            column(Inves5; Inves[5])
            {
            }
            column(Inves6; Inves[6])
            {
            }
            column(Inves7; Inves[7])
            {
            }
            column(AssessmentPlan; AssessmentPlan)
            {
            }
            column(AssessmentPlanuser; AssessmentPlanuser)
            {
            }
            column(Asses1; Asses[1])
            {
            }
            column(Asses2; Asses[2])
            {
            }
            column(Asses3; Asses[3])
            {
            }
            column(Asses4; Asses[4])
            {
            }
            column(Asses5; Asses[5])
            {
            }
            column(Asses6; Asses[6])
            {
            }
            column(Asses7; Asses[7])
            {
            }
            column(ReviewsOfSytems; ReviewsOfSytems)
            {
            }
            column(ReviewsOfSytemsUser; ReviewsOfSytemsUser)
            {
            }
            column(RvwS1; RvwS[1])
            {
            }
            column(RvwS2; RvwS[2])
            {
            }
            column(RvwS3; RvwS[3])
            {
            }
            column(RvwS4; RvwS[4])
            {
            }
            column(RvwS5; RvwS[5])
            {
            }
            column(RvwS6; RvwS[6])
            {
            }
            column(RvwS7; RvwS[7])
            {
            }
            column(Impression; Impression)
            {
            }
            column(Impressionuser; Impressionuser)
            {
            }
            column(Impr1; Impr[1])
            {
            }
            column(Impr2; Impr[2])
            {
            }
            column(Impr3; Impr[3])
            {
            }
            column(Impr4; Impr[4])
            {
            }
            column(Impr5; Impr[5])
            {
            }
            column(Impr6; Impr[6])
            {
            }
            column(Impr7; Impr[7])
            {
            }
            column(VisualAcuity; VisualAcuity)
            {
            }
            column(VisualAcuityUser; VisualAcuityUser)
            {
            }
            column(VA1; VA[1])
            {
            }
            column(VA2; VA[2])
            {
            }
            column(VA3; VA[3])
            {
            }
            column(VA4; VA[4])
            {
            }
            column(VA5; VA[5])
            {
            }
            column(VA6; VA[6])
            {
            }
            column(VA7; VA[7])
            {
            }
            column(PastOcularHis; PastOcularHis)
            {
            }
            column(PastOcularHisUser; PastOcularHisUser)
            {
            }
            column(POCH1; POCH[1])
            {
            }
            column(POCH2; POCH[2])
            {
            }
            column(POCH3; POCH[3])
            {
            }
            column(POCH4; POCH[4])
            {
            }
            column(POCH5; POCH[5])
            {
            }
            column(POCH6; POCH[6])
            {
            }
            column(POCH7; POCH[7])
            {
            }
            column(PhysicalExam; PhysicalExam)
            {
            }
            column(PhysicalExamUser; PhysicalExamUser)
            {
            }
            column(PhyEx1; PhyEx[1])
            {
            }
            column(PhyEx2; PhyEx[2])
            {
            }
            column(PhyEx3; PhyEx[3])
            {
            }
            column(PhyEx4; PhyEx[4])
            {
            }
            column(PhyEx5; PhyEx[5])
            {
            }
            column(PhyEx6; PhyEx[6])
            {
            }
            column(PhyEx7; PhyEx[7])
            {
            }
            column(Diagnosis; Diagnosis)
            {
            }
            column(DiagnosisName1; DiagnosisName[1])
            {
            }
            column(DiagnosisName2; DiagnosisName[2])
            {
            }
            column(DiagnosisName3; DiagnosisName[3])
            {
            }
            column(DiagnosisName4; DiagnosisName[4])
            {
            }
            column(DiagnosisName5; DiagnosisName[5])
            {
            }
            column(DiagnosisName6; DiagnosisName[6])
            {
            }
            column(DiagnosisName7; DiagnosisName[7])
            {
            }
            column(TreatDone; TreatDone)
            {
            }
            column(TDone1; TDone[1])
            {
            }
            column(TDone2; TDone[2])
            {
            }
            column(TDone3; TDone[3])
            {
            }
            column(TDone4; TDone[4])
            {
            }
            column(TDone5; TDone[5])
            {
            }
            column(TDone6; TDone[6])
            {
            }
            column(TDone7; TDone[7])
            {
            }
            column(PastDental; PastDental)
            {
            }
            column(PastDentalUser; PastDentalUser)
            {
            }
            column(PDent1; PDent[1])
            {
            }
            column(PDent2; PDent[2])
            {
            }
            column(PDent3; PDent[3])
            {
            }
            column(PDent4; PDent[4])
            {
            }
            column(PDent5; PDent[5])
            {
            }
            column(PDent6; PDent[6])
            {
            }
            column(PDent7; PDent[7])
            {
            }
            column(PastFam; PastFam)
            {
            }
            column(PastFamUser; PastFamUser)
            {
            }
            column(PFam1; PFam[1])
            {
            }
            column(PFam2; PFam[2])
            {
            }
            column(PFam3; PFam[3])
            {
            }
            column(PFam4; PFam[4])
            {
            }
            column(PFam5; PFam[5])
            {
            }
            column(PFam6; PFam[6])
            {
            }
            column(PFam7; PFam[7])
            {
            }
            dataitem("HMS Laboratory Results Entry"; "HMS Laboratory Results Entry")
            {
                DataItemLink = "Laboratory No." = field("Lab No");
                DataItemTableView = sorting("Laboratory No.", "Laboratory Test Code", "Sort Test", "Specimen Code") order(ascending);
                PrintOnlyIfDetail = false;
                column(ReportForNavId_228; 228)
                {
                }
                column(LaboratoryNo_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Laboratory No.")
                {
                }
                column(LaboratoryTestCode_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Laboratory Test Code")
                {
                }
                column(SpecimenCode_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Specimen Code")
                {
                }
                column(SpecimenName_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Specimen Name")
                {
                }
                column(MeasuringUnitCode_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Measuring Unit Code")
                {
                }
                column(MeasuringUnitName_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Measuring Unit Name")
                {
                }
                column(TestNormalRanges_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Test Normal Ranges")
                {
                }
                column(CountValue_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Results)
                {
                }
                column(Remarks_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Remarks)
                {
                }
                column(Positive_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Positive)
                {
                }
                column(Completed_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Completed)
                {
                }
                column(PatNames; HMSPat."Search Name")
                {
                }
                column(DoctID; DocsRec."Doctors Name")
                {
                }
                column(ReceivedDate; LabH."Laboratory Date")
                {
                }
                column(CompletionDate; LabH."Completion Date")
                {
                }
                column(TestDesc; LabTest.Description)
                {
                }
                column(Flag_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Flag)
                {
                }
                column(SupervisorID; LabH."Supervisor ID")
                {
                }
                column(AgeinYrs; HMSPat."Age in Years")
                {
                }
                column(PatGender; HMSPat.Gender)
                {
                }
                column(LaboratoryTestName_HMSLaboratoryResultsEntry; TestName)
                {
                }
                column(Reactive_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry".Reactive)
                {
                }
                column(Results; Matokeo)
                {
                }
                column(Counts; Counts)
                {
                }
                column(SortTest_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Sort Test")
                {
                }
                column(AssignedUserID_HMSLaboratoryResultsEntry; "HMS Laboratory Results Entry"."Staff Name")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if LabH.Get("HMS Laboratory Results Entry"."Laboratory No.") then begin
                        if DocsRec.Get(LabH."Doctor ID") then;
                        if HMSPat.Get(LabH."Patient No.") then begin
                            LabTest.Reset();
                            LabTest.SetRange(LabTest.Code, "HMS Laboratory Results Entry"."Laboratory Test Code");
                            if LabTest.Find('-') then
                                //LabTest.CALCFIELDS(LabTest.Description);
                                TestName := LabTest.Description;
                        end;
                    end;
                    if ("HMS Laboratory Results Entry".Results > 0.0)
                      then
                        Matokeo := Format("HMS Laboratory Results Entry".Results)
                    else
                        Matokeo := "HMS Laboratory Results Entry".Remarks;

                    Counts := Counts + 1;
                end;

                trigger OnPreDataItem()
                begin
                    CompInf.Get();
                    CompInf.CalcFields(CompInf.Picture);
                    //CALCFIELDS("HMS Laboratory Results Entry"."Specimen Code");
                    CalcFields("HMS Laboratory Results Entry"."Specimen Name");
                    CalcFields("HMS Laboratory Results Entry"."Laboratory Test Name");
                    //Counts:=0;
                end;
            }
            dataitem("HMS Treatment Form Drug"; "HMS Treatment Form Drug")
            {
                DataItemLink = "Treatment No." = field("Treatment No.");
                PrintOnlyIfDetail = false;
                column(ReportForNavId_210; 210)
                {
                }
                column(TreatmentNo_HMSTreatmentFormDrug; "HMS Treatment Form Drug"."Treatment No.")
                {
                }
                column(DrugNo_HMSTreatmentFormDrug; "HMS Treatment Form Drug"."Drug No.")
                {
                }
                column(DrugName_HMSTreatmentFormDrug; "HMS Treatment Form Drug"."Drug Name")
                {
                }
                column(Quantity_HMSTreatmentFormDrug; "HMS Treatment Form Drug".Quantity)
                {
                }
                column(UnitOfMeasure_HMSTreatmentFormDrug; "HMS Treatment Form Drug"."Unit Of Measure")
                {
                }
                column(Remarks_HMSTreatmentFormDrug; "HMS Treatment Form Drug".Remarks)
                {
                }
                column(PharmacyCode_HMSTreatmentFormDrug; "HMS Treatment Form Drug"."Pharmacy Code")
                {
                }
                column(ActualQuantity_HMSTreatmentFormDrug; "HMS Treatment Form Drug"."Actual Quantity")
                {
                }
                column(Inventory_HMSTreatmentFormDrug; "HMS Treatment Form Drug".Inventory)
                {
                }
                column(Issued_HMSTreatmentFormDrug; "HMS Treatment Form Drug".Issued)
                {
                }
                column(Frequency_HMSTreatmentFormDrug; "HMS Treatment Form Drug".Frequency)
                {
                }
                column(Dosage_HMSTreatmentFormDrug; "HMS Treatment Form Drug".Dosage)
                {
                }
                column(NumberofDays_HMSTreatmentFormDrug; "HMS Treatment Form Drug"."Number of Days")
                {
                }
                column(Posted_HMSTreatmentFormDrug; "HMS Treatment Form Drug".Posted)
                {
                }
                column(PrescriptionDose_HMSTreatmentFormDrug; "HMS Treatment Form Drug"."Prescription Dose")
                {
                }
                column(Status_HMSTreatmentFormDrug; "HMS Treatment Form Drug".Status)
                {
                }
                column(UnitPrice_HMSTreatmentFormDrug; "HMS Treatment Form Drug"."Unit Price")
                {
                }
                column(TotalPrice_HMSTreatmentFormDrug; "HMS Treatment Form Drug"."Total Price")
                {
                }
                column(Take_HMSTreatmentFormDrug; "HMS Treatment Form Drug".Take)
                {
                }
            }
            dataitem("HMS Treatment Form Process"; "HMS Treatment Form Process")
            {
                DataItemLink = "Treatment No." = field("Treatment No.");
                column(ReportForNavId_289; 289)
                {
                }
                column(TreatmentNo_HMSTreatmentFormProcess; "HMS Treatment Form Process"."Treatment No.")
                {
                }
                column(Type_HMSTreatmentFormProcess; "HMS Treatment Form Process".Type)
                {
                }
                column(PatientNo_HMSTreatmentFormProcess; "HMS Treatment Form Process"."Patient No.")
                {
                }
                column(PatientName_HMSTreatmentFormProcess; "HMS Treatment Form Process"."Patient Name")
                {
                }
                column(Pain_HMSTreatmentFormProcess; "HMS Treatment Form Process".Pain)
                {
                }
                column(PulseRate_HMSTreatmentFormProcess; "HMS Treatment Form Process"."Pulse Rate")
                {
                }
                column(BloodPressure_HMSTreatmentFormProcess; "HMS Treatment Form Process"."Blood Pressure")
                {
                }
                column(Temperature_HMSTreatmentFormProcess; "HMS Treatment Form Process".Temperature)
                {
                }
                column(Height_HMSTreatmentFormProcess; "HMS Treatment Form Process".Height)
                {
                }
                column(Weight_HMSTreatmentFormProcess; "HMS Treatment Form Process".Weight)
                {
                }
                column(BMI_HMSTreatmentFormProcess; "HMS Treatment Form Process".BMI)
                {
                }
                column(SP02_HMSTreatmentFormProcess; "HMS Treatment Form Process".SP02)
                {
                }
                column(UniqueId_HMSTreatmentFormProcess; "HMS Treatment Form Process".UniqueId)
                {
                }
                column(DateCreated_HMSTreatmentFormProcess; "HMS Treatment Form Process"."Date Created")
                {
                }
                column(DateTaken_HMSTreatmentFormProcess; "HMS Treatment Form Process"."Date Taken")
                {
                }
                column(Time_HMSTreatmentFormProcess; "HMS Treatment Form Process".Time)
                {
                }
                column(LineNo_HMSTreatmentFormProcess; "HMS Treatment Form Process"."Line No")
                {
                }
                column(RespirationRate_HMSTreatmentFormProcess; "HMS Treatment Form Process"."Respiration Rate")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                TreatHD.Reset();
                TreatHD.SetRange(TreatHD."Treatment No.", "HMS Treatment Form Header"."Treatment No.");
                if TreatHD.Find('-') then begin
                    if TreatHD."Doctor's Name" = '' then begin
                        //"HMS Treatment Form Header".CALCFIELDS("HMS Treatment Form Header"."Doctor ID");
                        DocId.Get("HMS Treatment Form Header"."Doctor ID");
                        TreatHD."Doctor's Name" := DocId."Doctors Name";
                        TreatHD.Modify();
                    end;
                    HMSPat.SetRange(HMSPat."Patient No.", "HMS Treatment Form Header"."Patient No.");
                    if HMSPat.Find('-') then
                        strNm := HMSCU.GetPatientName(TreatHD."Patient No.");
                    strAddress := HMSCU.GetPatientAddress(TreatHD."Patient No.");
                    strResident := HMSCU.GetPatientResidence(TreatHD."Patient No.");
                    strDateofBirth := HMSCU.GetPatientDOB(TreatHD."Patient No.");
                    // strDOA:=FORMAT("HMS Treatment Admission"."Date Of Admission") ;
                    strSex := HMSCU.GetPatientGender(TreatHD."Patient No.");
                    strTel := HMSCU.GetPatientTel(TreatHD."Patient No.");
                    strAge := HMSCU.GetPatientAge(TreatHD."Patient No.");
                    PatNo := TreatHD."Patient No.";
                end;
                // ,DoctorsNotes,MedicalReport,history,Treatment Plan,Chief Complaints,Past Medical History,Past Surgical History,Social History,Investigations,Assessment and plan,Reviews of Systems,Impression,Visual Acuity,Past Ocular History
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Patient History");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            HPI := 'History Of Present Illness';
                            // Nt[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                ObjPhyEx.Reset();
                ObjPhyEx.SetRange(ObjPhyEx."Treatment No.", "HMS Treatment Form Header"."Treatment No.");
                if ObjPhyEx.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            PhysicalExam := 'Physical Exam';
                            PhysicalExamUser := "HMS Treatment Form Header"."Doctor's Name";
                            PhyEx[i] := ObjPhyEx."Sign Code" + ' ' + ObjPhyEx.System + ' ' + ObjPhyEx."Sign Description" + '  ';
                        end;
                    until ObjPhyEx.Next() = 0;
                i := 0;
                ObjDiagnosis.Reset();
                ObjDiagnosis.SetRange(ObjDiagnosis."Treatment No.", "HMS Treatment Form Header"."Treatment No.");
                if ObjDiagnosis.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            Diagnosis := 'Diagnosis';
                            ObjDiagnosis.CalcFields(ObjDiagnosis."Diagnosis Name");
                            DiagnosisName[i] := ObjDiagnosis."Diagnosis No." + ' ' + ObjDiagnosis."Diagnosis Code" + ' ' + ObjDiagnosis."Diagnosis Name" + ' Differential Diagnosis ' +
                            ObjDiagnosis.Remarks;
                        end;
                    until ObjDiagnosis.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Assessment and plan");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            AssessmentPlan := 'Assessment and plan';
                            AssessmentPlanuser := HMSNotes."User ID";
                            // Asses[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::DoctorsNotes);
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            DocNotes := 'Doctors Notes';
                            DocNotesUser := HMSNotes."User ID";
                            // DocNot[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Chief Complaints");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            Chiefcomplaints := 'Chief Complaints';
                            ChiefcomplaintsUser := HMSNotes."User ID";
                            // CC[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Doctors Advice");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            DoctorsAdvice := 'Doctor''s Advice';
                            DoctorsAdviceUser := HMSNotes."User ID";
                            // DA[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::Impression);
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            Impression := 'Impression';
                            Impressionuser := HMSNotes."User ID";
                            // Impr[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::Investigations);
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            Investigations := 'Investigations';
                            InvestigationsUser := HMSNotes."User ID";
                            // Inves[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Treatment Done");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            TreatDone := 'Treatment Done';
                            TreatDoneUser := HMSNotes."User ID";
                            // TDone[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::MedicalReport);
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            MedicalReport := 'Medical Report';
                            MedicalReportUser := HMSNotes."User ID";
                            // MEDR[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Past Medical History");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            PastMed := 'Past Medical History';
                            PastMedUser := HMSNotes."User ID";
                            // PMH[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Past Ocular History");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            PastOcularHis := 'Past Ocular History';
                            PastOcularHisUser := HMSNotes."User ID";
                            // POCH[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Past Surgical History");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            PastSurgicalH := 'Past Surgical History';
                            PastSurgicalHUser := HMSNotes."User ID";
                            // PSH[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Reviews of Systems");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            ReviewsOfSytems := 'Reviews of Systems';
                            ReviewsOfSytemsUser := HMSNotes."User ID";
                            // RvwS[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Social History");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            PastSocialHist := 'Social History';
                            PastSocialHistUser := HMSNotes."User ID";
                            // PSCH[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Treatment Plan");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            TreatmentPlan := 'Treatment Plan';
                            TreatmentPlanUser := HMSNotes."User ID";
                            // TreatP[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Past Dental History");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            PastDental := 'Past Dental History';
                            PastDentalUser := HMSNotes."User ID";
                            // PDent[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Past Family History");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            PastFam := 'Past Family History';
                            PastFamUser := HMSNotes."User ID";
                            // PFam[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Visual Acuity");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            VisualAcuity := 'Visual Acuity';
                            VisualAcuityUser := HMSNotes."User ID";
                            // VA[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                i := 0;

                // TreatmentFormProcess.RESET;
                // TreatmentFormProcess.SETRANGE(TreatmentFormProcess."Treatment No.","HMS Treatment Form Header"."Treatment No.");
                // IF TreatmentFormProcess.FIND('-') THEN BEGIN
                // REPEAT
                //  IF TreatmentFormProcess."Patient No."='SYSTOLIC/DIASTOLIC' THEN
                //   PB:=TreatmentFormProcess.Temperature;
                //  IF TreatmentFormProcess."Patient No."='TEMP' THEN
                //   Temp:=TreatmentFormProcess.Temperature;
                //  IF TreatmentFormProcess."Patient No."='PULSE RATE' THEN
                //   Pulse:=TreatmentFormProcess.Temperature;
                //  IF TreatmentFormProcess."Patient No."='WEIGHT' THEN
                //   Wt:=TreatmentFormProcess.Temperature;
                //  IF TreatmentFormProcess."Patient No."='SP02' THEN
                //   O2:=TreatmentFormProcess.Temperature;
                // UNTIL TreatmentFormProcess.NEXT=0;
                // END;
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(Picture);
            end;
        }
    }

    var
        CompInf: Record "Company Information";
        LabH: Record "HMS Laboratory Form Header";
        HMSNotes: Record "hms Notes";
        ObjPhyEx: Record "HMS Observation Signs";
        HMSPat: Record "HMS Patient";
        DocId: Record "HMS Setup Doctor";
        DocsRec: Record "HMS Setup Doctor";
        LabTest: Record "HMS Setup Lab Test";
        ObjDiagnosis: Record "HMS Treatment Form Diagnosis";
        TreatHD: Record "HMS Treatment Form Header";
        HMSCU: Codeunit "HMS Patient-integration";
        O2: Code[20];
        PatNo: Code[20];
        PB: Code[20];
        Pulse: Code[20];
        Resp: Code[20];
        Temp: Code[20];
        Wt: Code[20];
        Counts: Integer;
        i: Integer;
        AssessmentPlan: Text;
        AssessmentPlanuser: Text;
        Chiefcomplaints: Text;
        ChiefcomplaintsUser: Text;
        Diagnosis: Text;
        DocNotes: Text;
        DocNotesUser: Text;
        DoctorsAdvice: Text;
        DoctorsAdviceUser: Text;
        HPI: Text;
        HPIuser: Text;
        Impression: Text;
        Impressionuser: Text;
        Investigations: Text;
        InvestigationsUser: Text;
        MedicalReport: Text;
        MedicalReportUser: Text;
        PastDental: Text;
        PastDentalUser: Text;
        PastFam: Text;
        PastFamUser: Text;
        PastMed: Text;
        PastMedUser: Text;
        PastOcularHis: Text;
        PastOcularHisUser: Text;
        PastSocialHist: Text;
        PastSocialHistUser: Text;
        PastSurgicalH: Text;
        PastSurgicalHUser: Text;
        PhysicalExam: Text;
        PhysicalExamUser: Text;
        ReviewsOfSytems: Text;
        ReviewsOfSytemsUser: Text;
        strAddress: Text;
        strAge: Text;
        strDateofBirth: Text;
        strDOA: Text;
        strNm: Text;
        strResident: Text;
        strSex: Text;
        strTel: Text;
        TestName: Text;
        TreatDone: Text;
        TreatDoneUser: Text;
        TreatmentPlan: Text;
        TreatmentPlanUser: Text;
        VisualAcuity: Text;
        VisualAcuityUser: Text;
        Matokeo: Text[250];
        Asses: array[10] of Text[500];
        CC: array[10] of Text[500];
        DA: array[10] of Text[500];
        DiagnosisName: array[10] of Text[500];
        DocNot: array[10] of Text[500];
        Impr: array[10] of Text[500];
        Inves: array[10] of Text[500];
        MEDR: array[10] of Text[500];
        Nt: array[10] of Text[500];
        PDent: array[10] of Text[500];
        PFam: array[10] of Text[500];
        PhyEx: array[10] of Text[500];
        PMH: array[10] of Text[500];
        POCH: array[10] of Text[500];
        PSCH: array[10] of Text[500];
        PSH: array[10] of Text[500];
        RvwS: array[10] of Text[500];
        TDone: array[10] of Text[500];
        TreatP: array[10] of Text[500];
        VA: array[10] of Text[500];
}
