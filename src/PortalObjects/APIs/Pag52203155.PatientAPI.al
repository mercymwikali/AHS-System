namespace HMISBC.HMISBC;

page 52203155 PatientAPI
{
    APIGroup = 'HMIS';
    APIPublisher = 'PTL';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'patientRegistration';
    DelayedInsert = true;
    EntityName = 'Patient';
    EntitySetName = 'Patients';
    PageType = API;
    SourceTable = "HMS Patient";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(activated; Rec.Activated)
                {
                    Caption = 'Activated';
                }
                field(activeAppointmentDate; Rec."Active Appointment date")
                {
                    Caption = 'Active Appointment date';
                }
                field(activeVisitNo; Rec."Active Visit No")
                {
                    Caption = 'Active Visit No';
                }
                field(admNo; Rec."Adm No.")
                {
                    Caption = 'Adm No.';
                }
                field(admissionDate; Rec."Admission Date")
                {
                    Caption = 'Admission Date';
                }
                field(admissionType; Rec."Admission Type")
                {
                    Caption = 'Admission Type';
                }
                field(admissionsCharges; Rec."Admissions Charges")
                {
                    Caption = 'Admissions Charges';
                }
                field(admissionsDate; Rec."Admissions Date")
                {
                    Caption = 'Admissions Date';
                }
                field(admittingDoctor; Rec."Admitting Doctor")
                {
                    Caption = 'Admitting Doctor';
                }
                field(ageInYears; Rec."Age in Years")
                {
                    Caption = 'Age in Years';
                }
                field(ambulanceCharges; Rec."Ambulance Charges")
                {
                    Caption = 'Ambulance Charges';
                }
                field(appointmentStatus; Rec."Appointment Status")
                {
                    Caption = 'Appointment Status';
                }
                field(appointmentsCancelled; Rec."Appointments Cancelled")
                {
                    Caption = 'Appointments Cancelled';
                }
                field(appointmentsCompleted; Rec."Appointments Completed")
                {
                    Caption = 'Appointments Completed';
                }
                field(appointmentsRescheduled; Rec."Appointments Rescheduled")
                {
                    Caption = 'Appointments Rescheduled';
                }
                field(appointmentsScheduled; Rec."Appointments Scheduled")
                {
                    Caption = 'Appointments Scheduled';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(bedCharges; Rec."Bed Charges")
                {
                    Caption = 'Bed Charges';
                }
                field(billBalance; Rec."Bill Balance")
                {
                    Caption = 'Bill Balance';
                }
                field(billBalanceSMS; Rec."Bill Balance SMS")
                {
                    Caption = 'Bill Balance SMS';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(bloodGroup; Rec."Blood Group")
                {
                    Caption = 'Blood Group';
                }
                field(chargesDate; Rec."Charges Date")
                {
                    Caption = 'Charges Date';
                }
                field(circulatorySystemPulse; Rec."Circulatory System Pulse")
                {
                    Caption = 'Circulatory System Pulse';
                }
                field(conditionOfEars; Rec."Condition Of Ears")
                {
                    Caption = 'Condition Of Ears';
                }
                field(conditionOfLymphaticGlands; Rec."Condition Of Lymphatic Glands")
                {
                    Caption = 'Condition Of Lymphatic Glands';
                }
                field(conditionOfNose; Rec."Condition Of Nose")
                {
                    Caption = 'Condition Of Nose';
                }
                field(conditionOfTeeth; Rec."Condition Of Teeth")
                {
                    Caption = 'Condition Of Teeth';
                }
                field(conditionOfThroat; Rec."Condition Of Throat")
                {
                    Caption = 'Condition Of Throat';
                }
                field(correspondenceAddress1; Rec."Correspondence Address 1")
                {
                    Caption = 'Correspondence Address 1';
                }
                field(correspondenceAddress2; Rec."Correspondence Address 2")
                {
                    Caption = 'Correspondence Address 2';
                }
                field(correspondenceAddress3; Rec."Correspondence Address 3")
                {
                    Caption = 'Correspondence Address 3';
                }
                field(currentAdmNo; Rec."Current Adm No")
                {
                    Caption = 'Current Adm No';
                }
                field(currentAppointmentDate; Rec."Current Appointment date")
                {
                    Caption = 'Current Appointment date';
                }
                field(currentNHIFLOUAmount; Rec."Current LOU Amount")
                {
                    Caption = 'Current NHIF LOU Amount';
                }
                field(currentSpecialClinics; Rec."Current Special Clinics")
                {
                    Caption = 'Current Special Clinics';
                }
                field(currentWard; Rec."Current Ward")
                {
                    Caption = 'Current Ward';
                }
                field(currentBenefitNumber; Rec.CurrentBenefitNumber)
                {
                    Caption = 'CurrentBenefitNumber';
                }
                field(customerCreated; Rec."Customer Created")
                {
                    Caption = 'Customer Created';
                }
                field(doctorsCharges; Rec."DOCTORS  Charges")
                {
                    Caption = 'DOCTORS  Charges';
                }
                field(dateOfBirth; Rec."Date Of Birth")
                {
                    Caption = 'Date Of Birth';
                }
                field(dateRegistered; Rec."Date Registered")
                {
                    Caption = 'Date Registered';
                }
                field(debtorAccount; Rec."Debtor Account")
                {
                    Caption = 'Debtor Account';
                }
                field(dentalCharges; Rec."Dental Charges")
                {
                    Caption = 'Dental Charges';
                }
                field(depandantPrincipleMember; Rec."Depandant Principle Member")
                {
                    Caption = 'Depandant Principle Member';
                }
                field(dependant; Rec.Dependant)
                {
                    Caption = 'Dependant';
                }
                field(dischargeDate; Rec."Discharge Date")
                {
                    Caption = 'Discharge Date';
                }
                field(dischargedType; Rec."Discharged Type")
                {
                    Caption = 'Discharged Type';
                }
                field(doctorAmount; Rec."Doctor Amount")
                {
                    Caption = 'Doctor Amount';
                }
                field(doctorVisitStatus; Rec."Doctor Visit Status")
                {
                    Caption = 'Doctor Visit Status';
                }
                field(drugReaction; Rec."Drug Reaction")
                {
                    Caption = 'Drug Reaction';
                }
                field(email; Rec.Email)
                {
                    Caption = 'Email';
                }
                field(employeeNo; Rec."Employee No.")
                {
                    Caption = 'Employee No.';
                }
                field(examiningOfficer; Rec."Examining Officer")
                {
                    Caption = 'Examining Officer';
                }
                field(existInAdmission; Rec."Exist in Admission")
                {
                    Caption = 'Exist in Admission';
                }
                field(existInDischarge; Rec."Exist in Discharge")
                {
                    Caption = 'Exist in Discharge';
                }
                field(fatherAliveOrDead; Rec."Father Alive or Dead")
                {
                    Caption = 'Father Alive or Dead';
                }
                field(fatherFullName; Rec."Father Full Name")
                {
                    Caption = 'Father Full Name';
                }
                field(fatherOccupation; Rec."Father Occupation")
                {
                    Caption = 'Father Occupation';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(fileNo; Rec."File No")
                {
                    Caption = 'File No';
                }
                field(gender; Rec.Gender)
                {
                    Caption = 'Gender';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                field(guardianName; Rec."Guardian Name")
                {
                    Caption = 'Guardian Name';
                }
                field(guardianOccupation; Rec."Guardian Occupation")
                {
                    Caption = 'Guardian Occupation';
                }
                field(hearingLeftEar; Rec."Hearing Left Ear")
                {
                    Caption = 'Hearing Left Ear';
                }
                field(hearingRightEar; Rec."Hearing Right Ear")
                {
                    Caption = 'Hearing Right Ear';
                }
                field(height; Rec.Height)
                {
                    Caption = 'Height';
                }
                field(hospitalBillingStatus; Rec."Hospital Billing Status")
                {
                    Caption = 'Hospital Billing Status';
                }
                field(howYouKnewAboutUs; Rec."How you Knew About Us")
                {
                    Caption = 'How you Knew About Us';
                }
                field(icuCharges; Rec."ICU Charges")
                {
                    Caption = 'ICU Charges';
                }
                field(idNumber; Rec."ID Number")
                {
                    Caption = 'ID Number';
                }
                field(inpatientSTORECharges; Rec."INPATIENT STORE Charges")
                {
                    Caption = 'INPATIENT STORE Charges';
                }
                field(ipPHARMACYCharges; Rec."IP PHARMACY Charges")
                {
                    Caption = 'IP PHARMACY Charges';
                }
                field(immunizationNumber; Rec."Immunization Number")
                {
                    Caption = 'Immunization Number';
                }
                field(inDischargeList; Rec."In Discharge List")
                {
                    Caption = 'In Discharge List';
                }
                field(inpatient; Rec.Inpatient)
                {
                    Caption = 'Inpatient';
                }
                field(insuranceName; Rec."Insurance Name")
                {
                    Caption = 'Insurance Name';
                }
                field(insuranceNo; Rec."Insurance No.")
                {
                    Caption = 'Insurance No.';
                }
                field(invoiceAmount; Rec."Invoice Amount")
                {
                    Caption = 'Invoice Amount';
                }
                field(invoiceAmount1; Rec."Invoice Amount1")
                {
                    Caption = 'Invoice Amount1';
                }
                field(laboratoryCharges; Rec."LABORATORY Charges")
                {
                    Caption = 'LABORATORY Charges';
                }
                field(laboratoryStatus; Rec."Laboratory Status")
                {
                    Caption = 'Laboratory Status';
                }
                field(lastAppointmentDate; Rec."Last Appointment Date")
                {
                    Caption = 'Last Appointment Date';
                }
                field(lastBillingDate; Rec."Last Billing Date")
                {
                    Caption = 'Last Billing Date';
                }
                field(lastName; Rec."Last Name")
                {
                    Caption = 'Last Name';
                }
                field(maternityCharges; Rec."MATERNITY Charges")
                {
                    Caption = 'MATERNITY Charges';
                }
                field(maritalStatus; Rec."Marital Status")
                {
                    Caption = 'Marital Status';
                }
                field(mediCenterBalance; Rec."MediCenter Balance")
                {
                    Caption = 'MediCenter Balance';
                }
                field(medicalDetailsNotCovered; Rec."Medical Details Not Covered")
                {
                    Caption = 'Medical Details Not Covered';
                }
                field(medicalExamDate; Rec."Medical Exam Date")
                {
                    Caption = 'Medical Exam Date';
                }
                field(medicenterCounter; Rec."Medicenter Counter")
                {
                    Caption = 'Medicenter Counter';
                }
                field(membershipNo; Rec."Membership No")
                {
                    Caption = 'Membership No';
                }
                field(middleName; Rec."Middle Name")
                {
                    Caption = 'Middle Name';
                }
                field(motherAliveOrDead; Rec."Mother Alive or Dead")
                {
                    Caption = 'Mother Alive or Dead';
                }
                field(motherFullName; Rec."Mother Full Name")
                {
                    Caption = 'Mother Full Name';
                }
                field(motherOccupation; Rec."Mother Occupation")
                {
                    Caption = 'Mother Occupation';
                }
                field(nutritionCharges; Rec."NUTRITION Charges")
                {
                    Caption = 'NUTRITION Charges';
                }
                field(nameOfChief; Rec."Name of Chief")
                {
                    Caption = 'Name of Chief';
                }
                field(names; Rec.Names)
                {
                    Caption = 'Names';
                }
                field(nationality; Rec.Nationality)
                {
                    Caption = 'Nationality';
                }
                field(nearestPoliceStation; Rec."Nearest Police Station")
                {
                    Caption = 'Nearest Police Station';
                }
                field(nextAppointment; Rec."Next Appointment")
                {
                    Caption = 'Next Appointment';
                }
                field(nextOfKinIDCardNo; Rec."Next Of Kin ID Card No.")
                {
                    Caption = 'Next Of Kin ID Card No.';
                }
                field(nextOfKinAddress1; Rec."Next Of kin Address 1")
                {
                    Caption = 'Next Of kin Address 1';
                }
                field(nextOfKinAddress2; Rec."Next Of kin Address 2")
                {
                    Caption = 'Next Of kin Address 2';
                }
                field(nextOfKinAddress3; Rec."Next Of kin Address 3")
                {
                    Caption = 'Next Of kin Address 3';
                }
                field(nextOfKinDateOfConsent; Rec."Next Of kin Date of Consent")
                {
                    Caption = 'Next Of kin Date of Consent';
                }
                field(nextOfKinFullName; Rec."Next Of kin Full Name")
                {
                    Caption = 'Next Of kin Full Name';
                }
                field(nextOfKinRelationship; Rec."Next of kin Relationship")
                {
                    Caption = 'Next of kin Relationship';
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                }
                field(opCONSULTATIONCharges; Rec."OP CONSULTATION Charges")
                {
                    Caption = 'OP CONSULTATION Charges';
                }
                field(opticalCharges; Rec."OPTICAL Charges")
                {
                    Caption = 'OPTICAL Charges';
                }
                field(orthopaedicCharges; Rec."ORTHOPAEDIC Charges")
                {
                    Caption = 'ORTHOPAEDIC Charges';
                }
                field(outpatientSTORECharges; Rec."OUTPATIENT STORE Charges")
                {
                    Caption = 'OUTPATIENT STORE Charges';
                }
                field(observationStatus; Rec."Observation Status")
                {
                    Caption = 'Observation Status';
                }
                field(oldFileNo; Rec."Old File No")
                {
                    Caption = 'Old File No';
                }
                field(openChargesCount; Rec."Open Charges Count")
                {
                    Caption = 'Open Charges Count';
                }
                field(openInsuranceAmount; Rec."Open Insurance Amount")
                {
                    Caption = 'Open Insurance Amount';
                }
                field(physiotherapyCharges; Rec."PHYSIOTHERAPY Charges")
                {
                    Caption = 'PHYSIOTHERAPY Charges';
                }
                field(patientCurrentLocation; Rec."Patient Current Location")
                {
                    Caption = 'Patient Current Location';
                }
                field(patientNo; Rec."Patient No.")
                {
                    Caption = 'Patient No.';
                }
                field(patientOccupation; Rec."Patient Occupation")
                {
                    Caption = 'Patient Occupation';
                }
                field(patientRefNo; Rec."Patient Ref. No.")
                {
                    Caption = 'Patient Ref. No.';
                }
                field(patientStatus; Rec."Patient Status")
                {
                    Caption = 'Patient Status';
                }
                field(patientType; Rec."Patient Type")
                {
                    Caption = 'Patient Type';
                }
                field(patientType2; Rec."Patient Type2")
                {
                    Caption = 'Patient Type2';
                }
                field(pendingAdmissionCount; Rec."Pending Admission Count")
                {
                    Caption = 'Pending Admission Count';
                }
                field(periodAppointmentCount; Rec."Period Appointment Count")
                {
                    Caption = 'Period Appointment Count';
                }
                field(pharmacyStatus; Rec."Pharmacy Status")
                {
                    Caption = 'Pharmacy Status';
                }
                field(photo; Rec.Photo)
                {
                    Caption = 'Photo';
                }
                field(physicalImpairmentDetails; Rec."Physical Impairment Details")
                {
                    Caption = 'Physical Impairment Details';
                }
                field(physioNo; Rec."Physio No.")
                {
                    Caption = 'Physio No.';
                }
                field(placeOfBirthDistrict; Rec."Place of Birth District")
                {
                    Caption = 'Place of Birth District';
                }
                field(placeOfBirthLocation; Rec."Place of Birth Location")
                {
                    Caption = 'Place of Birth Location';
                }
                field(placeOfBirthVillage; Rec."Place of Birth Village")
                {
                    Caption = 'Place of Birth Village';
                }
                field(postedInvoiceAmount; Rec."Posted Invoice Amount")
                {
                    Caption = 'Posted Invoice Amount';
                }
                field(principal; Rec.Principal)
                {
                    Caption = 'Principal';
                }
                field(radiologyStatus; Rec."Radiology Status")
                {
                    Caption = 'Radiology Status';
                }
                field(receiptAmount; Rec."Receipt Amount")
                {
                    Caption = 'Receipt Amount';
                }
                field(receiptAmount1; Rec."Receipt Amount1")
                {
                    Caption = 'Receipt Amount1';
                }
                field(registered; Rec.Registered)
                {
                    Caption = 'Registered';
                }
                field(registrationStatus; Rec."Registration Status")
                {
                    Caption = 'Registration Status';
                }
                field(relativeNo; Rec."Relative No.")
                {
                    Caption = 'Relative No.';
                }
                field(religion; Rec.Religion)
                {
                    Caption = 'Religion';
                }
                field(requestRegistration; Rec."Request Registration")
                {
                    Caption = 'Request Registration';
                }
                field(schemeName; Rec."Scheme Name")
                {
                    Caption = 'Scheme Name';
                }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(select; Rec.Select)
                {
                    Caption = 'Select';
                }
                field(specialClinics; Rec."Special Clinics")
                {
                    Caption = 'Special Clinics';
                }
                field(spouseAddress1; Rec."Spouse Address 1")
                {
                    Caption = 'Spouse Address 1';
                }
                field(spouseAddress2; Rec."Spouse Address 2")
                {
                    Caption = 'Spouse Address 2';
                }
                field(spouseAddress3; Rec."Spouse Address 3")
                {
                    Caption = 'Spouse Address 3';
                }
                field(spouseEmail; Rec."Spouse Email")
                {
                    Caption = 'Spouse Email';
                }
                field(spouseFax; Rec."Spouse Fax")
                {
                    Caption = 'Spouse Fax';
                }
                field(spouseName; Rec."Spouse Name")
                {
                    Caption = 'Spouse Name';
                }
                field(spouseTelephoneNo1; Rec."Spouse Telephone No. 1")
                {
                    Caption = 'Spouse Telephone No. 1';
                }
                field(spouseTelephoneNo2; Rec."Spouse Telephone No. 2")
                {
                    Caption = 'Spouse Telephone No. 2';
                }
                field(staffNo; Rec."Staff No")
                {
                    Caption = 'Staff No';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(studentNo; Rec."Student No.")
                {
                    Caption = 'Student No.';
                }
                field(sunflashBalance; Rec."Sunflash Balance")
                {
                    Caption = 'Sunflash Balance';
                }
                field(sunflashCounter; Rec."Sunflash Counter")
                {
                    Caption = 'Sunflash Counter';
                }
                field(surname; Rec.Surname)
                {
                    Caption = 'First/English Name';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(theatreCharges; Rec."THEATRE Charges")
                {
                    Caption = 'THEATRE Charges';
                }
                field(telephoneNo1; Rec."Telephone No. 1")
                {
                    Caption = 'Telephone No. 1';
                }
                field(telephoneNo2; Rec."Telephone No. 2")
                {
                    Caption = 'Telephone No. 2';
                }
                field(test; Rec.Test)
                {
                    Caption = 'Test';
                }
                field(title; Rec.Title)
                {
                    Caption = 'Title';
                }
                field(totalBilled; Rec."Total Billed")
                {
                    Caption = 'Total Billed';
                }
                field(transBalance; Rec."Trans Balance")
                {
                    Caption = 'Trans Balance';
                }
                field(triageStatus; Rec."Triage Status")
                {
                    Caption = 'Triage Status';
                }
                field(unPostedBalance; Rec."Un Posted Balance")
                {
                    Caption = 'Un Posted Balance';
                }
                field(unClaimedAmount; Rec."UnClaimed Amount")
                {
                    Caption = 'UnClaimed Amount';
                }
                field(userID; Rec."User ID")
                {
                    Caption = 'User ID';
                }
                field(visitInvoiceNo; Rec."Visit Invoice No")
                {
                    Caption = 'Visit Invoice No';
                }
                field(wardPROCEDURESCharges; Rec."WARD PROCEDURES Charges")
                {
                    Caption = 'WARD PROCEDURES Charges';
                }
                field(walkIn; Rec."Walk-in")
                {
                    Caption = 'Walk-in';
                }
                field(weight; Rec.Weight)
                {
                    Caption = 'Weight';
                }
                field(withGlassesL6; Rec."With Glasses L.6")
                {
                    Caption = 'With Glasses L.6';
                }
                field(withGlassesR6; Rec."With Glasses R.6")
                {
                    Caption = 'With Glasses R.6';
                }
                field(withoutGlassesL6; Rec."Without Glasses L.6")
                {
                    Caption = 'Without Glasses L.6';
                }
                field(withoutGlassesR6; Rec."Without Glasses R.6")
                {
                    Caption = 'Without Glasses R.6';
                }
            }
        }
    }
}
