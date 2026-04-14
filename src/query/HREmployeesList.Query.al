namespace HMISBC.HMISBC;

using Microsoft.HumanResources.Employee;

query 85016 HREmployeesList
{
    Caption = 'HREmployees';
    QueryType = Normal;

    elements
    {
        dataitem(HR_Employee; "HR-Employee")
        {
            column(No; "No.")
            {
            }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {
            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {
            }
            column(AdditionalLanguage; "Additional Language")
            {
            }
            column(Age; Age)
            {
            }
            column(AllowOvertime; "Allow Overtime")
            {
            }
            column(AllowReEmploymentInFuture; "Allow Re-Employment In Future")
            {
            }
            column(AmountPaidByCompany; "Amount Paid By Company")
            {
            }
            column(AmountPaidByEmployee; "Amount Paid By Employee")
            {
            }
            column(AmountReimbursed; "Amount Reimbursed")
            {
            }
            column(Appointment; Appointment)
            {
            }
            column(AppointmentDescription; "Appointment Description")
            {
            }
            column(AppointmentDuration; "Appointment Duration")
            {
            }
            column(AppointmentEndDate; "Appointment End Date")
            {
            }
            column(AppointmentStartDate; "Appointment Start Date")
            {
            }
            column(BankAccountNumber; "Bank Account Number")
            {
            }
            column(BarcodePicture; "Barcode Picture")
            {
            }
            column(Bonded; Bonded)
            {
            }
            column(BondingEndDate; "Bonding End Date")
            {
            }
            column(BranchBank; "Branch Bank")
            {
            }
            column(BranchBankName; "Branch Bank Name")
            {
            }
            column(CampusCode; "Campus Code")
            {
            }
            column(Category; Category)
            {
            }
            column(CauseofInactivityCode; "Cause of Inactivity Code")
            {
            }
            column(CellPhoneReimbursement; "Cell Phone Reimbursement?")
            {
            }
            column(CellularPhoneNumber; "Cellular Phone Number")
            {
            }
            column(ChangedPassword; "Changed Password")
            {
            }
            column(Citizenship; Citizenship)
            {
            }
            column(City; City)
            {
            }
            column(CoOperativeNo; "Co-Operative No")
            {
            }
            column(Comment; Comment)
            {
            }
            column(CompanyEMail; "Company E-Mail")
            {
            }
            column(CompanyType; "Company Type")
            {
            }
            column(ContractDuration; "Contract Duration")
            {
            }
            column(ContractEndDate; "Contract End Date")
            {
            }
            column(ContractLocation; "Contract Location")
            {
            }
            column(ContractStartDate; "Contract Start Date")
            {
            }
            column(ContractType; "Contract Type")
            {
            }
            column(ContractedHours; "Contracted Hours")
            {
            }
            column(CostCenterCode; "Cost Center Code")
            {
            }
            column(CostCode; "Cost Code")
            {
            }
            column(CountryCode; "Country Code")
            {
            }
            column(County; County)
            {
            }
            column(CountyCode; "County Code")
            {
            }
            column(CurrentLeaveNo; "Current Leave No")
            {
            }
            column(DailyRate; "Daily Rate")
            {
            }
            column(DateOfJoin; "Date Of Join")
            {
            }
            column(DateOfLeaving; "Date Of Leaving")
            {
            }
            column(DateEngaged; DateEngaged)
            {
            }
            column(DateLeaving; DateLeaving)
            {
            }
            column(DateOfBirth; DateOfBirth)
            {
            }
            column(Dean; Dean)
            {
            }
            column(DemisedDate; "Demised Date")
            {
            }
            column(DepartmentName; "Department Name")
            {
            }
            column(deptStatus; "dept Status")
            {
            }
            column(DirectIndirect; "Direct/Indirect")
            {
            }
            column(DisabilityGrade; "Disability Grade")
            {
            }
            column(Disabled; Disabled)
            {
            }
            column(DisablingDetails; "Disabling Details")
            {
            }
            column(Divisions; Divisions)
            {
            }
            column(DrivingLicence; "Driving Licence")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(EmployeeClassification; "Employee Classification")
            {
            }
            column(EmployeeType; "Employee Type")
            {
            }
            column(EndOfProbationDate; "End Of Probation Date")
            {
            }
            column(EthnicOrigin; "Ethnic Origin")
            {
            }
            column(ExitDate; "Exit Date")
            {
            }
            column(ExitInterviewDate; "Exit Interview Date")
            {
            }
            column(ExitInterviewDoneby; "Exit Interview Done by")
            {
            }
            column(Ext; "Ext.")
            {
            }
            column(FaxNumber; "Fax Number")
            {
            }
            column(FirstLanguageRWS; "First Language (R/W/S)")
            {
            }
            column(FirstLanguageRead; "First Language Read")
            {
            }
            column(FirstLanguageSpeak; "First Language Speak")
            {
            }
            column(FirstLanguageWrite; "First Language Write")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(FullPartTime; "Full / Part Time")
            {
            }
            column(Gender; Gender)
            {
            }
            column(Grade; Grade)
            {
            }
            column(GradeLevel; "Grade Level")
            {
            }
            column(GrossIncomeVariation; "Gross Income Variation")
            {
            }
            column(GrossNetPayVariation; "Gross Net Pay Variation")
            {
            }
            column(GrossNetVariation; "Gross Net Variation")
            {
            }
            column(GroundsforTermCode; "Grounds for Term. Code")
            {
            }
            column(HeadofDepartment; "Head of Department")
            {
            }
            column(HealthAssesmentDate; "Health Assesment Date")
            {
            }
            column(HealthAssesment; "Health Assesment?")
            {
            }
            column(HELBNo; "HELB No")
            {
            }
            column(HMIS; HMIS)
            {
            }
            column(HOD; HOD)
            {
            }
            column(HolidayDaysEntitlement; "Holiday Days Entitlement")
            {
            }
            column(HolidayDaysUsed; "Holiday Days Used")
            {
            }
            column(HomePhoneNumber; "Home Phone Number")
            {
            }
            column(HourlyRate; "Hourly Rate")
            {
            }
            column(IDNumber; "ID Number")
            {
            }
            column(Image; Image)
            {
            }
            column(Initials; Initials)
            {
            }
            column(JobApplicationNo; "Job Application No...")
            {
            }
            column(JobSpecification; "Job Specification")
            {
            }
            column(JobTitle; "Job Title")
            {
            }
            column(KnownAs; "Known As")
            {
            }
            column(LastDateModified; "Last Date Modified")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(Lecturer; Lecturer)
            {
            }
            column(LecturerCategory; "Lecturer Category")
            {
            }
            column(LengthOfService; "Length Of Service")
            {
            }
            column(Level; Level)
            {
            }
            column(LibraryBorrowerType; "Library Borrower Type")
            {
            }
            column(LibraryCode; "Library Code")
            {
            }
            column(LockBankDetails; "Lock Bank Details")
            {
            }
            column(MainBank; "Main Bank")
            {
            }
            column(MainBankName; "Main Bank Name")
            {
            }
            column(Manager; Manager)
            {
            }
            column(ManagerEmpNo; "Manager Emp No")
            {
            }
            column(MaritalStatus; "Marital Status")
            {
            }
            column(MaximunHours; "Maximun Hours")
            {
            }
            column(MedicalSchemeHeadMember; "Medical Scheme Head Member")
            {
            }
            column(MedicalSchemeJoin; "Medical Scheme Join")
            {
            }
            column(MedicalSchemeJoinDate; "Medical Scheme Join Date")
            {
            }
            column(MedicalSchemeName; "Medical Scheme Name")
            {
            }
            column(MedicalSchemeName2; "Medical Scheme Name #2")
            {
            }
            column(MedicalSchemeNo; "Medical Scheme No.")
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(NameOfManager; "Name Of Manager")
            {
            }
            column(NHIFNo; "NHIF No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(NoticePeriod; "Notice Period")
            {
            }
            column(NotifyHRReminders; "Notify HR Reminders")
            {
            }
            column(NSSFNo; "NSSF No.")
            {
            }
            column(NumberOfDependants; "Number Of Dependants")
            {
            }
            column(Office; Office)
            {
            }
            column(OnLeave; "On Leave")
            {
            }
            column(OtherNames; "Other Names")
            {
            }
            column(OTPCodeUsedToday; "OTP Code Used Today")
            {
            }
            column(P9Year; P9Year)
            {
            }
            column(PartTime; "Part Time")
            {
            }
            column(PassportNumber; "Passport Number")
            {
            }
            column(Password; Password)
            {
            }
            column(PayPerPeriod; "Pay Per Period")
            {
            }
            column(PayPeriod; "Pay Period")
            {
            }
            column(PAYENumber; "PAYE Number")
            {
            }
            column(PaymentMode; "Payment Mode")
            {
            }
            column(PayrollCode; "Payroll Code")
            {
            }
            column(PayrollPostingGroup; "Payroll Posting Group")
            {
            }
            column(PayrollType; "Payroll Type")
            {
            }
            column(PensionSchemeJoin; "Pension Scheme Join")
            {
            }
            column(PensionJoin; PensionJoin)
            {
            }
            column(PerAnnum; "Per Annum")
            {
            }
            column(PeriodFilter; "Period Filter")
            {
            }
            column(Permanent; Permanent)
            {
            }
            column(PhysicalDisability; "Physical Disability")
            {
            }
            column(Picture; Picture)
            {
            }
            column(PINNumber; "PIN Number")
            {
            }
            column(PortalOTPCode; "Portal OTP Code")
            {
            }
            column(PortalOTPDate; "Portal OTP Date")
            {
            }
            column(PortalOTPDevice; "Portal OTP Device")
            {
            }
            column(PortalPassword; "Portal Password")
            {
            }
            column(PortalResetToken; "Portal Reset Token")
            {
            }
            column(PortalResetTokenExpired; "Portal Reset Token Expired")
            {
            }
            column(PortalSessionToken; "Portal Session Token")
            {
            }
            column(Position; Position)
            {
            }
            column(PositionToSucceed; "Position To Succeed")
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(PostCode2; "Post Code2")
            {
            }
            column(PostOfficeNo; "Post Office No")
            {
            }
            column(PostalAddress; "Postal Address")
            {
            }
            column(PostalAddress2; "Postal Address2")
            {
            }
            column(PostalAddress3; "Postal Address3")
            {
            }
            column(PostingGroup; "Posting Group")
            {
            }
            column(PrimarySkillsCategory; "Primary Skills Category")
            {
            }
            column(ProbationStartDate; "Probation Start Date")
            {
            }
            column(ReceivingCarAllowance; "Receiving Car Allowance ?")
            {
            }
            column(Region; Region)
            {
            }
            column(Registrar; Registrar)
            {
            }
            column(Religion; Religion)
            {
            }
            column(ResidentialAddress; "Residential Address")
            {
            }
            column(ResidentialAddress2; "Residential Address2")
            {
            }
            column(ResidentialAddress3; "Residential Address3")
            {
            }
            column(ResidentialStatus; "Residential Status")
            {
            }
            column(ResignationDate; "Resignation Date")
            {
            }
            column(ResourceNo; "Resource No.")
            {
            }
            column(Retirementdate; "Retirement date")
            {
            }
            column(Retrenchmentdate; "Retrenchment date")
            {
            }
            column(ReturningOfficer; "Returning Officer")
            {
            }
            column(SaccoStaffNo; "Sacco Staff No")
            {
            }
            column(SalaryCategory; "Salary Category")
            {
            }
            column(SalaryGrade; "Salary Grade")
            {
            }
            column(SalaryNotchStep; "Salary Notch/Step")
            {
            }
            column(SalarySegment; "Salary Segment")
            {
            }
            column(SalespersPurchCode; "Salespers./Purch. Code")
            {
            }
            column(Schools; Schools)
            {
            }
            column(SearchName; "Search Name")
            {
            }
            column(SecondLanguageRWS; "Second Language (R/W/S)")
            {
            }
            column(SecondLanguageRead; "Second Language Read")
            {
            }
            column(SecondLanguageSpeak; "Second Language Speak")
            {
            }
            column(SecondLanguageWrite; "Second Language Write")
            {
            }
            column(Seconded; Seconded)
            {
            }
            column(Section; Section)
            {
            }
            column(SectionName; "Section Name")
            {
            }
            column(SelectedPeriod; "Selected Period")
            {
            }
            column(SendAlertto; "Send Alert to")
            {
            }
            column(ServedNoticePeriod; "Served Notice Period")
            {
            }
            column(ShiftWorker; "Shift Worker?")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Signature; Signature)
            {
            }
            column(SortNo; "Sort No")
            {
            }
            column(StatisticsGroupCode; "Statistics Group Code")
            {
            }
            column(Status; Status)
            {
            }
            column(Status1; "Status 1")
            {
            }
            column(StatusChangeDate; "Status Change Date")
            {
            }
            column(StudyLeaveEndDate; "Study Leave End Date")
            {
            }
            column(StudyLeaveStartDate; "Study Leave Start Date")
            {
            }
            column(SubTribe; "Sub Tribe")
            {
            }
            column(SuccesionDate; "Succesion Date")
            {
            }
            column(SuspensionDate; "Suspension Date")
            {
            }
            column(Temp; Temp)
            {
            }
            column(TerminationCategory; "Termination Category")
            {
            }
            column(TimeMedicalScheme; "Time Medical Scheme")
            {
            }
            column(TimePensionScheme; "Time Pension Scheme")
            {
            }
            column(Title; Title)
            {
            }
            column(Tribe; Tribe)
            {
            }
            column(TypeofContract; "Type of Contract")
            {
            }
            column(TypeofEmployee; "Type of Employee")
            {
            }
            column(UIFContributor; "UIF Contributor?")
            {
            }
            column(UIFNumber; "UIF Number")
            {
            }
            column(UnionMember; "Union Member?")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(VehicleRegistrationNumber; "Vehicle Registration Number")
            {
            }
            column(WeddingAnniversary; "Wedding Anniversary")
            {
            }
            column(WorkPhoneNumber; "Work Phone Number")
            {
            }
            column(Status_1; "Status 1")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(DoctorID; "Doctor ID")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
