namespace PTL.HMISBC;

xmlport 52202431 HMSPatients
{
    Caption = 'HMSPatients';
    UseRequestPage = true;
    Format = VariableText;
    Direction = Both;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(HMSPatient; "HMS Patient")
            {
                fieldelement(PatientNo; HMSPatient."Patient No.")
                {
                }
                fieldelement(DateRegistered; HMSPatient."Date Registered")
                {
                }
                fieldelement(PatientType; HMSPatient."Patient Type")
                {
                }
                fieldelement(Test; HMSPatient.Test)
                {
                }
                fieldelement(Title; HMSPatient.Title)
                {
                }
                fieldelement(Surname; HMSPatient.Surname)
                {
                }
                fieldelement(MiddleName; HMSPatient."Middle Name")
                {
                }
                fieldelement(LastName; HMSPatient."Last Name")
                {
                }
                fieldelement(Gender; HMSPatient.Gender)
                {
                }
                fieldelement(DateOfBirth; HMSPatient."Date Of Birth")
                {
                }
                fieldelement(MaritalStatus; HMSPatient."Marital Status")
                {
                }
                fieldelement(IDNumber; HMSPatient."ID Number")
                {
                }
                fieldelement(Photo; HMSPatient.Photo)
                {
                }
                fieldelement(CorrespondenceAddress1; HMSPatient."Correspondence Address 1")
                {
                }
                fieldelement(CorrespondenceAddress2; HMSPatient."Correspondence Address 2")
                {
                }
                fieldelement(CorrespondenceAddress3; HMSPatient."Correspondence Address 3")
                {
                }
                fieldelement(TelephoneNo1; HMSPatient."Telephone No. 1")
                {
                }
                fieldelement(TelephoneNo2; HMSPatient."Telephone No. 2")
                {
                }
                fieldelement(Email; HMSPatient.Email)
                {
                }
                fieldelement(FaxNo; HMSPatient."Fax No.")
                {
                }
                fieldelement(SpouseName; HMSPatient."Spouse Name")
                {
                }
                fieldelement(SpouseAddress1; HMSPatient."Spouse Address 1")
                {
                }
                fieldelement(SpouseAddress2; HMSPatient."Spouse Address 2")
                {
                }
                fieldelement(SpouseAddress3; HMSPatient."Spouse Address 3")
                {
                }
                fieldelement(SpouseTelephoneNo1; HMSPatient."Spouse Telephone No. 1")
                {
                }
                fieldelement(SpouseTelephoneNo2; HMSPatient."Spouse Telephone No. 2")
                {
                }
                fieldelement(SpouseEmail; HMSPatient."Spouse Email")
                {
                }
                fieldelement(SpouseFax; HMSPatient."Spouse Fax")
                {
                }
                fieldelement(PlaceofBirthVillage; HMSPatient."Place of Birth Village")
                {
                }
                fieldelement(PlaceofBirthLocation; HMSPatient."Place of Birth Location")
                {
                }
                fieldelement(PlaceofBirthDistrict; HMSPatient."Place of Birth District")
                {
                }
                fieldelement(NameofChief; HMSPatient."Name of Chief")
                {
                }
                fieldelement(NearestPoliceStation; HMSPatient."Nearest Police Station")
                {
                }
                fieldelement(Nationality; HMSPatient.Nationality)
                {
                }
                fieldelement(Religion; HMSPatient.Religion)
                {
                }
                fieldelement(MotherAliveorDead; HMSPatient."Mother Alive or Dead")
                {
                }
                fieldelement(MotherFullName; HMSPatient."Mother Full Name")
                {
                }
                fieldelement(MotherOccupation; HMSPatient."Mother Occupation")
                {
                }
                fieldelement(FatherAliveorDead; HMSPatient."Father Alive or Dead")
                {
                }
                fieldelement(FatherFullName; HMSPatient."Father Full Name")
                {
                }
                fieldelement(FatherOccupation; HMSPatient."Father Occupation")
                {
                }
                fieldelement(GuardianName; HMSPatient."Guardian Name")
                {
                }
                fieldelement(GuardianOccupation; HMSPatient."Guardian Occupation")
                {
                }
                fieldelement(PhysicalImpairmentDetails; HMSPatient."Physical Impairment Details")
                {
                }
                fieldelement(BloodGroup; HMSPatient."Blood Group")
                {
                }
                fieldelement(WithoutGlassesR6; HMSPatient."Without Glasses R.6")
                {
                }
                fieldelement(WithoutGlassesL6; HMSPatient."Without Glasses L.6")
                {
                }
                fieldelement(WithGlassesR6; HMSPatient."With Glasses R.6")
                {
                }
                fieldelement(WithGlassesL6; HMSPatient."With Glasses L.6")
                {
                }
                fieldelement(HearingRightEar; HMSPatient."Hearing Right Ear")
                {
                }
                fieldelement(HearingLeftEar; HMSPatient."Hearing Left Ear")
                {
                }
                fieldelement(ConditionOfTeeth; HMSPatient."Condition Of Teeth")
                {
                }
                fieldelement(ConditionOfThroat; HMSPatient."Condition Of Throat")
                {
                }
                fieldelement(ConditionOfEars; HMSPatient."Condition Of Ears")
                {
                }
                fieldelement(ConditionOfLymphaticGlands; HMSPatient."Condition Of Lymphatic Glands")
                {
                }
                fieldelement(ConditionOfNose; HMSPatient."Condition Of Nose")
                {
                }
                fieldelement(CirculatorySystemPulse; HMSPatient."Circulatory System Pulse")
                {
                }
                fieldelement(ExaminingOfficer; HMSPatient."Examining Officer")
                {
                }
                fieldelement(MedicalExamDate; HMSPatient."Medical Exam Date")
                {
                }
                fieldelement(MedicalDetailsNotCovered; HMSPatient."Medical Details Not Covered")
                {
                }
                fieldelement(NextofkinRelationship; HMSPatient."Next of kin Relationship")
                {
                }
                fieldelement(NextOfkinFullName; HMSPatient."Next Of kin Full Name")
                {
                }
                fieldelement(NextOfkinAddress1; HMSPatient."Next Of kin Address 1")
                {
                }
                fieldelement(NextOfkinAddress2; HMSPatient."Next Of kin Address 2")
                {
                }
                fieldelement(NextOfkinAddress3; HMSPatient."Next Of kin Address 3")
                {
                }
                fieldelement(NextOfkinDateofConsent; HMSPatient."Next Of kin Date of Consent")
                {
                }
                fieldelement(NextOfKinIDCardNo; HMSPatient."Next Of Kin ID Card No.")
                {
                }
                fieldelement(NoSeries; HMSPatient."No. Series")
                {
                }
                fieldelement(AppointmentsScheduled; HMSPatient."Appointments Scheduled")
                {
                }
                fieldelement(AppointmentsCompleted; HMSPatient."Appointments Completed")
                {
                }
                fieldelement(AppointmentsRescheduled; HMSPatient."Appointments Rescheduled")
                {
                }
                fieldelement(AppointmentsCancelled; HMSPatient."Appointments Cancelled")
                {
                }
                fieldelement(Height; HMSPatient.Height)
                {
                }
                fieldelement(Weight; HMSPatient.Weight)
                {
                }
                fieldelement(DrugReaction; HMSPatient."Drug Reaction")
                {
                }
                fieldelement(InsuranceNo; HMSPatient."Insurance No.")
                {
                }
                fieldelement(CustomerCreated; HMSPatient."Customer Created")
                {
                }
                fieldelement(GlobalDimension1Code; HMSPatient."Global Dimension 1 Code")
                {
                }
                fieldelement(GlobalDimension2Code; HMSPatient."Global Dimension 2 Code")
                {
                }
                fieldelement(ImmunizationNumber; HMSPatient."Immunization Number")
                {
                }
                fieldelement(Blocked; HMSPatient.Blocked)
                {
                }
                fieldelement(RequestRegistration; HMSPatient."Request Registration")
                {
                }
                fieldelement(Registered; HMSPatient.Registered)
                {
                }
                fieldelement(Status; HMSPatient.Status)
                {
                }
                fieldelement(Select; HMSPatient.Select)
                {
                }
                fieldelement(PatientRefNo; HMSPatient."Patient Ref. No.")
                {
                }
                fieldelement(DepandantPrincipleMember; HMSPatient."Depandant Principle Member")
                {
                }
                fieldelement(UserID; HMSPatient."User ID")
                {
                }
                fieldelement(PatientCurrentLocation; HMSPatient."Patient Current Location")
                {
                }
                fieldelement(TotalBilled; HMSPatient."Total Billed")
                {
                }
                fieldelement(RegistrationStatus; HMSPatient."Registration Status")
                {
                }
                fieldelement(TriageStatus; HMSPatient."Triage Status")
                {
                }
                fieldelement(AppointmentStatus; HMSPatient."Appointment Status")
                {
                }
                fieldelement(ObservationStatus; HMSPatient."Observation Status")
                {
                }
                fieldelement(DoctorVisitStatus; HMSPatient."Doctor Visit Status")
                {
                }
                fieldelement(LaboratoryStatus; HMSPatient."Laboratory Status")
                {
                }
                fieldelement(RadiologyStatus; HMSPatient."Radiology Status")
                {
                }
                fieldelement(PharmacyStatus; HMSPatient."Pharmacy Status")
                {
                }
                fieldelement(HospitalBillingStatus; HMSPatient."Hospital Billing Status")
                {
                }
                fieldelement(InsuranceName; HMSPatient."Insurance Name")
                {
                }
                fieldelement(MembershipNo; HMSPatient."Membership No")
                {
                }
                fieldelement(NextAppointment; HMSPatient."Next Appointment")
                {
                }
                fieldelement(StaffNo; HMSPatient."Staff No")
                {
                }
                fieldelement(AdmNo; HMSPatient."Adm No.")
                {
                }
                fieldelement(Inpatient; HMSPatient.Inpatient)
                {
                }
                fieldelement(AdmissionsDate; HMSPatient."Admissions Date")
                {
                }
                fieldelement(DischargeDate; HMSPatient."Discharge Date")
                {
                }
                fieldelement(Walkin; HMSPatient."Walk-in")
                {
                }
                fieldelement(SearchName; HMSPatient."Search Name")
                {
                }
                fieldelement(EmployeeNo; HMSPatient."Employee No.")
                {
                }
                fieldelement(Activated; HMSPatient.Activated)
                {
                }
                fieldelement(BillBalance; HMSPatient."Bill Balance")
                {
                }
                fieldelement(InvoiceAmount; HMSPatient."Invoice Amount")
                {
                }
                fieldelement(ReceiptAmount; HMSPatient."Receipt Amount")
                {
                }
                fieldelement(DoctorAmount; HMSPatient."Doctor Amount")
                {
                }
                fieldelement(AgeinYears; HMSPatient."Age in Years")
                {
                }
                fieldelement(DischargedType; HMSPatient."Discharged Type")
                {
                }
                fieldelement(Names; HMSPatient.Names)
                {
                }
                fieldelement(SpecialClinics; HMSPatient."Special Clinics")
                {
                }
                fieldelement(OpenChargesCount; HMSPatient."Open Charges Count")
                {
                }
                fieldelement(FileNo; HMSPatient."File No")
                {
                }
                fieldelement(OpenInsuranceAmount; HMSPatient."Open Insurance Amount")
                {
                }
                fieldelement(CurrentAdmNo; HMSPatient."Current Adm No")
                {
                }
                fieldelement(PostedInvoiceAmount; HMSPatient."Posted Invoice Amount")
                {
                }
                fieldelement(ActiveVisitNo; HMSPatient."Active Visit No")
                {
                }
                fieldelement(InvoiceAmount1; HMSPatient."Invoice Amount1")
                {
                }
                fieldelement(ReceiptAmount1; HMSPatient."Receipt Amount1")
                {
                }
                fieldelement(UnClaimedAmount; HMSPatient."UnClaimed Amount")
                {
                }
                fieldelement(PatientOccupation; HMSPatient."Patient Occupation")
                {
                }
                fieldelement(ExistinAdmission; HMSPatient."Exist in Admission")
                {
                }
                fieldelement(ExistinDischarge; HMSPatient."Exist in Discharge")
                {
                }
                fieldelement(AdmissionDate; HMSPatient."Admission Date")
                {
                }
                fieldelement(AdmittingDoctor; HMSPatient."Admitting Doctor")
                {
                }
                fieldelement(CurrentWard; HMSPatient."Current Ward")
                {
                }
                fieldelement(LastAppointmentDate; HMSPatient."Last Appointment Date")
                {
                }
                fieldelement(OldFileNo; HMSPatient."Old File No")
                {
                }
                fieldelement(Balance; HMSPatient.Balance)
                {
                }
                fieldelement(DentalCharges; HMSPatient."Dental Charges")
                {
                }
                fieldelement(DOCTORSCharges; HMSPatient."DOCTORS  Charges")
                {
                }
                fieldelement(ICUCharges; HMSPatient."ICU Charges")
                {
                }
                fieldelement(INPATIENTSTORECharges; HMSPatient."INPATIENT STORE Charges")
                {
                }
                fieldelement(IPPHARMACYCharges; HMSPatient."IP PHARMACY Charges")
                {
                }
                fieldelement(LABORATORYCharges; HMSPatient."LABORATORY Charges")
                {
                }
                fieldelement(MATERNITYCharges; HMSPatient."MATERNITY Charges")
                {
                }
                fieldelement(NUTRITIONCharges; HMSPatient."NUTRITION Charges")
                {
                }
                fieldelement(OPCONSULTATIONCharges; HMSPatient."OP CONSULTATION Charges")
                {
                }
                fieldelement(OPTICALCharges; HMSPatient."OPTICAL Charges")
                {
                }
                fieldelement(ORTHOPAEDICCharges; HMSPatient."ORTHOPAEDIC Charges")
                {
                }
                fieldelement(OUTPATIENTSTORECharges; HMSPatient."OUTPATIENT STORE Charges")
                {
                }
                fieldelement(PHYSIOTHERAPYCharges; HMSPatient."PHYSIOTHERAPY Charges")
                {
                }
                fieldelement(THEATRECharges; HMSPatient."THEATRE Charges")
                {
                }
                fieldelement(WARDPROCEDURESCharges; HMSPatient."WARD PROCEDURES Charges")
                {
                }
                fieldelement(AdmissionsCharges; HMSPatient."Admissions Charges")
                {
                }
                fieldelement(AmbulanceCharges; HMSPatient."Ambulance Charges")
                {
                }
                fieldelement(BedCharges; HMSPatient."Bed Charges")
                {
                }
                fieldelement(VisitInvoiceNo; HMSPatient."Visit Invoice No")
                {
                }
                fieldelement(PhysioNo; HMSPatient."Physio No.")
                {
                }
                fieldelement(AdmissionType; HMSPatient."Admission Type")
                {
                }
                fieldelement(InDischargeList; HMSPatient."In Discharge List")
                {
                }
                fieldelement(SunflashCounter; HMSPatient."Sunflash Counter")
                {
                }
                fieldelement(MedicenterCounter; HMSPatient."Medicenter Counter")
                {
                }
                fieldelement(SunflashBalance; HMSPatient."Sunflash Balance")
                {
                }
                fieldelement(MediCenterBalance; HMSPatient."MediCenter Balance")
                {
                }
                fieldelement(ChargesDate; HMSPatient."Charges Date")
                {
                }
                fieldelement(UnPostedBalance; HMSPatient."Un Posted Balance")
                {
                }
                fieldelement(TransBalance; HMSPatient."Trans Balance")
                {
                }
                fieldelement(SchemeName; HMSPatient."Scheme Name")
                {
                }
                fieldelement(PeriodAppointmentCount; HMSPatient."Period Appointment Count")
                {
                }
                fieldelement(CurrentBenefitNumber; HMSPatient.CurrentBenefitNumber)
                {
                }
                fieldelement(BillBalanceSMS; HMSPatient."Bill Balance SMS")
                {
                }
                fieldelement(Dependant; HMSPatient.Dependant)
                {
                }
                fieldelement(PatientType2; HMSPatient."Patient Type2")
                {
                }
                fieldelement(StudentNo; HMSPatient."Student No.")
                {
                }
                fieldelement(RelativeNo; HMSPatient."Relative No.")
                {
                }
                fieldelement(ActiveAppointmentdate; HMSPatient."Active Appointment date")
                {
                }
                fieldelement(PendingAdmissionCount; HMSPatient."Pending Admission Count")
                {
                }
                fieldelement(HowyouKnewAboutUs; HMSPatient."How you Knew About Us")
                {
                }
                fieldelement(CurrentAppointmentdate; HMSPatient."Current Appointment date")
                {
                }
                fieldelement(CurrentSpecialClinics; HMSPatient."Current Special Clinics")
                {
                }
                fieldelement(LastBillingDate; HMSPatient."Last Billing Date")
                {
                }
                fieldelement(CurrentLOUAmount; HMSPatient."Current LOU Amount")
                {
                }
                fieldelement(Principal; HMSPatient.Principal)
                {
                }
                fieldelement(PatientStatus; HMSPatient."Patient Status")
                {
                }
                fieldelement(DebtorAccount; HMSPatient."Debtor Account")
                {
                }
                fieldelement(SubCountycode; HMSPatient."Sub-County code")
                {
                }
                fieldelement(SubCountyName; HMSPatient."Sub-County Name")
                {
                }
                fieldelement(CountyWard; HMSPatient."County Ward")
                {
                }
                fieldelement(CountyWardName; HMSPatient."County Ward Name")
                {
                }
                fieldelement(PrincipalMemberName; HMSPatient."Principal Member Name")
                {
                }
                fieldelement(NoofInsuranceList; HMSPatient."No. of Insurance List")
                {
                }
                fieldelement(ActiveCashier; HMSPatient."Active Cashier")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
