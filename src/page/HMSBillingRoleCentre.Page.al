Page 85346 "HMS Billing Role Centre"
{
    Caption = 'HMS Billing Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control60; "Headline RC General Mgt.")
            {
                ApplicationArea = RelationshipMgmt;
            }

            group(Control1900724808)
            {
                ShowCaption = false;

                part(Control8; "HMS Cue")
                {
                    Caption = 'HMS CUE';
                }
                part(Control16; "Team Member Activities")
                {
                    ApplicationArea = RelationshipMgmt;
                }
                // part(Control2; "Power BI Report Spinner Part")
                // {
                //     ApplicationArea = RelationshipMgmt;
                // }
            }
            group(Control1900724708)
            {
                ShowCaption = false;

                part("My Approval Entries"; "Requests to Approve")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approval Entries';
                }
                part(Control106; "My Job Queue")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(embedding)
        {
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Insurance/Customer';
                Image = Customer;
                RunObject = Page "Customer List2";
                ToolTip = 'Executes the Insurance/Customer action.';
            }
            action(CustomersBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
                ToolTip = 'Executes the Balance action.';
            }
            action(PatientBilling)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Active Patients';
                Image = Calculate;
                RunObject = Page "HMS Patient Billing";
                ToolTip = 'Executes the Active Patients action.';
            }
            action("Active InPatients")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Active Patient InPatients";
                ToolTip = 'Executes the Active InPatients action.';
            }
            action("Active OutPatients")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Active Patient OutPatients";
                ToolTip = 'Executes the Active OutPatients action.';
            }
            action("HMS Corporate pending Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Corporate Pending Invoicing';
                RunObject = Page "HMS Corporate pending Invoice";
                ToolTip = 'Executes the Corporate Pending Invoicing action.';
            }

            action("Discharge Request")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Admission Progress List";
                ToolTip = 'Executes the Discharge Request action.';
            }
            action("Discharge List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Admission Discharge List";
                ToolTip = 'Executes the Discharge List action.';
            }
            action("Sales Invoice")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Sales Invoice List.";
                ToolTip = 'Executes the Sales Invoice action.';
            }

            action("Invoice Dispatch")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Invoice Dispatch List";
                ToolTip = 'Executes the Invoice Dispatch action.';
            }
            action(Charges)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Charges';
                Image = Reminder;
                RunObject = Page "HMS Charges";
                ToolTip = 'Executes the Charges action.';
            }
            action(Reminders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reminders';
                Image = Reminder;
                RunObject = Page "Reminder List";
                ToolTip = 'Executes the Reminders action.';
            }
            action(FinanceChargeMemos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Finance Charge Memos';
                Image = FinChargeMemo;
                RunObject = Page "Finance Charge Memo List";
                ToolTip = 'Executes the Finance Charge Memos action.';
            }
            action(IncomingDocuments)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
                ToolTip = 'Executes the Incoming Documents action.';
            }
        }
        area(processing)
        {
            group(Admissions)
            {
                Caption = 'Admissions';
                Image = Payables;
                action(AdmReq)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admission Requests';
                    Image = FixedAssets;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Admission Form Header List";
                    ToolTip = 'Executes the Admission Requests action.';
                }
                action(AdmProg)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admission Process';
                    Image = FixedAssetLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Admission Progress";
                    ToolTip = 'Executes the Admission Process action.';
                }
            }
            group(Referrals)
            {
                Caption = 'Referrals';
                Image = Confirm;
                action(RefHosp)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referral Hospitals';
                    Image = SetupColumns;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Card";
                    ToolTip = 'Executes the Referral Hospitals action.';
                }
                action(ActiveRef)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Referrals';
                    Image = Setup;
                    Promoted = true;
                    RunObject = Page "HMS Referral Header Active";
                    ToolTip = 'Executes the Active Referrals action.';
                }
                action(hitRef)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Completed Referrals';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Referral Header Released";
                    ToolTip = 'Executes the Completed Referrals action.';
                }
            }
            group(Immunizations)
            {
                Caption = 'Immunizations';
                Image = SNInfo;
                action(Immunization)
                {
                    ApplicationArea = Basic, Suite;
                    Image = NewOrder;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Header";
                    ToolTip = 'Executes the Immunization action.';
                }
                action(ImmHist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Immunization History';
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Posted";
                    ToolTip = 'Executes the Immunization History action.';
                }
            }
            group(Reports)
            {
                Caption = 'HMS Reports';
                Image = SNInfo;
                group(HMSReports)
                {
                    Caption = 'HMS Reports';
                    action(App)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appointments';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Appointments Listing";
                        ToolTip = 'Executes the Appointments action.';
                    }
                    action(ICD10)
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Report "HMS Diagnosis List";
                        ToolTip = 'Executes the ICD10 action.';
                    }
                    action(incomePerCheaxe)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income per Patient Charges';
                        RunObject = Report "HMS Income per Patient Charges";
                        ToolTip = 'Executes the Income per Patient Charges action.';
                    }
                    action(Observ)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Observations';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Observation Listing Report";
                        ToolTip = 'Executes the Observations action.';
                    }
                    action("39005644")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of account';
                        RunObject = Report "HMs Invoice Statements";
                        ToolTip = 'Executes the Statement of account action.';
                    }
                    action(treatment)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Treatments';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Treatment Listing Report";
                        ToolTip = 'Executes the Treatments action.';
                    }
                    action(labtest1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lab Tests Summary';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Laboratory Test Summary";
                        ToolTip = 'Executes the Lab Tests Summary action.';
                    }
                    action(labtest2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lab Tests Detailed';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Laboratory Test Detailed";
                        ToolTip = 'Executes the Lab Tests Detailed action.';
                    }
                    action(labtest3)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lab tests Findings';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Laboratory Test Finding";
                        ToolTip = 'Executes the Lab tests Findings action.';
                    }
                    action(pham_Drug_1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Process Student Patients';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Pharmacy Issues Report";
                        ToolTip = 'Executes the Process Student Patients action.';
                    }
                    action(pham_Drug_3)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Process Student Patients';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Pharmacy Issues Report";
                        ToolTip = 'Executes the Process Student Patients action.';
                    }
                    action(PatList)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Patient listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Patient Listing Report";
                        ToolTip = 'Executes the Patient listing action.';
                    }
                    action(Admission_List)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Admission listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Admission Listing Summary";
                        ToolTip = 'Executes the Admission listing action.';
                    }
                    action(Ref_list)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Referrals Listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Referral Listing Report";
                        ToolTip = 'Executes the Referrals Listing action.';
                    }
                    action(Daily_Att_OutPat)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Daily Attendance (Outpatient)';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Daily Attendance Report";
                        ToolTip = 'Executes the Daily Attendance (Outpatient) action.';
                    }
                    action(Inj_Reg)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Injection Register';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Injection Register Report";
                        ToolTip = 'Executes the Injection Register action.';
                    }
                    action(Proc_Emp_and_Deps)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appointments';
                        Image = ExecuteAndPostBatch;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Process Employee & Deps";
                        ToolTip = 'Executes the Appointments action.';
                    }
                    action("Patients Visits Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = VATStatement;
                        RunObject = Report "HMS Visit Summary";
                        ToolTip = 'Executes the Patients Visits Summary action.';
                    }
                }
            }
            group(Setups)
            {
                Caption = 'Hospital Setups';
                Image = SNInfo;

                action("39006182")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction code';
                    RunObject = Page "HMS Transaction code List";
                    ToolTip = 'Executes the Transaction code action.';
                }
                action(ImmunHist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Immunization History';
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Posted";
                    ToolTip = 'Executes the Immunization History action.';
                }
                action(Setup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Card";
                    ToolTip = 'Executes the Setup Card action.';
                }
                action(Systems_Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Systems Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Systems List";
                    ToolTip = 'Executes the Systems Card action.';
                }
                action(Setup_Doctor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Doctor';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Hms Setup Doctors List";
                    ToolTip = 'Executes the Setup Doctor action.';
                }
                action(Setup_Blood_Group)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Blood Group';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Blood Group List";
                    ToolTip = 'Executes the Setup Blood Group action.';
                }
                action(Blood_Group_Donation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Blood Group Donation';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Blood Group Donation List";
                    ToolTip = 'Executes the Blood Group Donation action.';
                }
                action(Drug_Interaction)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Drug Interaction';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Drug Interaction Header";
                    ToolTip = 'Executes the Drug Interaction action.';
                }
                action(Observation_Signs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Observation Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS General Observation Setup";
                    ToolTip = 'Executes the General Observation Setup action.';
                }
                action(Appointment_Typ)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointment Type';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Appointment Type Lst";
                    ToolTip = 'Executes the Appointment Type action.';
                }
                action("Setup Process")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Process Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Process List";
                    ToolTip = 'Executes the Process Setup action.';
                }
                action(Injection)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Injection';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Injection List";
                    ToolTip = 'Executes the Injection action.';
                }
                action(Diagnosis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Diagnosis List";
                    ToolTip = 'Executes the Diagnosis action.';
                }
                action(SecondaryDiagnosis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Secondary Diagnosis Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Secondary Diagnosis Setup";
                    ToolTip = 'Executes the Secondary Diagnosis Setup action.';
                }
                action(Allergy)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Allergy';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Allergy List";
                    ToolTip = 'Executes the Allergy action.';
                }
                action(signs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Signs';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Signs";
                    ToolTip = 'Executes the Signs action.';
                }
                action(Symptoms)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Symptoms';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Syptoms";
                    ToolTip = 'Executes the Symptoms action.';
                }
                action(messuring_Uni)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Measuring Units';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Measuring Unit List";
                    ToolTip = 'Executes the Measuring Units action.';
                }
                action(specimen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Specimen Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Specimen List";
                    ToolTip = 'Executes the Specimen Card action.';
                }
                action(Lab_test)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Lab Test Setups';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Lab Test List";
                    ToolTip = 'Executes the Lab Test Setups action.';
                }
                action(Rad_Types)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Radiology Types';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Radiology Type List";
                    ToolTip = 'Executes the Radiology Types action.';
                }
                action(Theatre_Types)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Theatre Types';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS THeatre Type List";
                    ToolTip = 'Executes the Theatre Types action.';
                }
                action(Setup_Disctarge_Process)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Discharge Process';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Disctarge Process";
                    ToolTip = 'Executes the Setup Discharge Process action.';
                }
                action(wards)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ward Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Ward List";
                    ToolTip = 'Executes the Ward Setup action.';
                }
                action(Beds)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Beds';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Beds";
                    ToolTip = 'Executes the Beds action.';
                }
                action(Hos_Charges)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hospital Charges Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Charges";
                    ToolTip = 'Executes the Hospital Charges Setup action.';
                }
                action(Hos_Drugs_Prof)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hospital Drugs Profit';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Drugs Profit";
                    ToolTip = 'Executes the Hospital Drugs Profit action.';
                }
                action(URGENCYSETUP)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Urgency Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Urgency Color Coding Setup";
                    ToolTip = 'Executes the Urgency Setup action.';
                }

            }
        }
        area(sections)
        {
            group(Registration)
            {
                action("Patients List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List2";
                    ToolTip = 'Executes the Patients List action.';
                }
            }
            group(Appointments)
            {
                Caption = 'Appointments';
                Image = Statistics;
                action(Action19)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Appointment List";
                    ToolTip = 'Executes the Appointments action.';
                }
                action(AppointmentsControl)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments Control';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Appointment Form List";
                    ToolTip = 'Executes the Appointments Control action.';
                }
                action(AppointmentsHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Appointment Form History L";
                    ToolTip = 'Executes the Appointments History action.';
                }
            }
            group("Appointment Booking")
            {
                action("Appointment Booking List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Appointment Booking";
                    ToolTip = 'Executes the Appointment Booking List action.';
                }
            }
            group(ObsRoom)
            {
                Caption = 'Triage Room';
                Image = RegisteredDocs;
                action(Action48)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Triage';
                    RunObject = Page "HMS Observation List";
                    ToolTip = 'Executes the Triage action.';
                }
                action(TriageHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Triage History';
                    RunObject = Page "HMS Observation History List";
                    ToolTip = 'Executes the Triage History action.';
                }
            }
            group(DocVisit)
            {
                Caption = 'Consultation Room';
                Image = Journals;
                action(DocVisits)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visits';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Treatment List";
                    ToolTip = 'Executes the Doctor''s Visits action.';
                }
                action(DoctorsVisitHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visit History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Treatment History List";
                    ToolTip = 'Executes the Doctor''s Visit History action.';
                }
            }
            group(Theatre)
            {
                Caption = 'Theatre';
                Image = RegisteredDocs;
                action(TheatreList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Theatre List';
                    RunObject = Page "HMS Theatre List";
                    ToolTip = 'Executes the Theatre List action.';
                }
                action(TheatreHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Theatre History';
                    RunObject = Page "HMS Theatre History";
                    ToolTip = 'Executes the Theatre History action.';
                }
            }
            group(ICU)
            {
                Caption = 'ICU';
                Image = RegisteredDocs;
                action(ICUList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ICU List';
                    RunObject = Page "HMS ICU List";
                    ToolTip = 'Executes the ICU List action.';
                }
                action(ICUHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ICU History';
                    RunObject = Page "HMS ICU History";
                    ToolTip = 'Executes the ICU History action.';
                }
            }
            group(Physio)
            {
                Caption = 'Physiotherapy';
                Image = RegisteredDocs;
                action(PhysiotheraphyObservations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PhysiotheraphyObservations';
                    RunObject = Page "HMS Physiotheraphy List";
                    ToolTip = 'Executes the PhysiotheraphyObservations action.';
                }
                action("CLosed Physiotheraphy List")
                {
                    ApplicationArea = Basic, Suite;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page "HMS CLosed Physiotheraphy List";
                    ToolTip = 'Executes the CLosed Physiotheraphy List action.';
                }
            }
            group(Radiology)
            {
                Caption = 'Radiology';
                Image = RegisteredDocs;
                action(Action108)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Radiology';
                    RunObject = Page "HMS Radiology List";
                    ToolTip = 'Executes the Radiology action.';
                }
            }
            group(Lab)
            {
                Caption = 'Lab. Visits';
                Image = FiledPosted;
                action(Lab_List)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Requests';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Laboratory List";
                    ToolTip = 'Executes the Test Requests action.';
                }
                action(findings)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Findings';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Laboratory History List";
                    ToolTip = 'Executes the Test Findings action.';
                }
                action(Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visit History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Treatment History List";
                    ToolTip = 'Executes the Doctor''s Visit History action.';
                }
            }
            group(Pharmacy)
            {
                Caption = 'Pharmacy';
                Image = Departments;
                action(Pharm)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Pharmacy List";
                    ToolTip = 'Executes the Pharmacy List action.';
                }
                action(Pharm_Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Pharmacy History List";
                    ToolTip = 'Executes the Pharmacy History action.';
                }
                action("39003925")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List-Returns';
                    RunObject = Page "HMS Pharmacy Line-returns";
                    ToolTip = 'Executes the Pharmacy List-Returns action.';
                }
            }
            group(HMS_Admissions)
            {
                Caption = 'InPatients';
                Image = LotInfo;
                action(InPatients)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'InPatients';
                    RunObject = Page "HMS InPatient List";
                    ToolTip = 'Executes the InPatients action.';
                }
                action(DischargeRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Discharge Request';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Admission Progress List";
                    ToolTip = 'Executes the Discharge Request action.';
                }
                action(Discharge)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Discharge List';
                    Image = ReleaseShipment;
                    RunObject = Page "HMS Admission Discharge List";
                    ToolTip = 'Executes the Discharge List action.';
                }
            }
            group(Reports_Diagnosis)
            {
                Caption = 'Diagnosis Report';
                Image = ReferenceData;
                action("Dignosis Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis Over 5yrs';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Report "Diagnosis Over 5yrs";
                    ToolTip = 'Executes the Diagnosis Over 5yrs action.';
                }
                action(Under_5yrs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis Under 5yrs';
                    Image = History;
                    Promoted = true;
                    RunObject = Report "Diagnosis Under 5yrs";
                    ToolTip = 'Executes the Diagnosis Under 5yrs action.';
                }
                action("Hospital Diagnosis.")
                {
                    ApplicationArea = Basic, Suite;
                    Image = DataEntry;
                    RunObject = Report "Hospital Diagnosis<5years";
                    ToolTip = 'Executes the Hospital Diagnosis. action.';
                }
            }
            group(Refs)
            {
                Caption = 'Referrals';
                Image = RegisteredDocs;
                action(ref)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referrals';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Referral Header List";
                    ToolTip = 'Executes the Referrals action.';
                }
                action(ref_Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referrals History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Referral Header List2";
                    ToolTip = 'Executes the Referrals History action.';
                }
            }
            group(Immuns)
            {
                Caption = 'Immunizations';
                Image = ReferenceData;
                action(Immun)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Immunizations';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Immunization Header List";
                    ToolTip = 'Executes the Immunizations action.';
                }
                action(Immun_History)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Immunizations History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Immunization Posted List";
                    ToolTip = 'Executes the Immunizations History action.';
                }
            }
            group(Billing)
            {
                Caption = 'Hospital Billing';
                Image = Intrastat;
                action(Receipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Receipts';
                    Image = Insurance;
                    Promoted = true;
                    RunObject = Page "Receipts List";
                    ToolTip = 'Executes the Receipts action.';
                }
                action("Sales Invoice List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice List';
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Executes the Invoice List action.';
                }
            }
            group(Sales)
            {
                Caption = 'Sales';
                action(SalesOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    Image = "Order";
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Executes the Sales Orders action.';
                }
                action(SalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    Image = Invoice;
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Executes the Sales Invoices action.';
                }
                action(SalesReturnOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Order List";
                    ToolTip = 'Executes the Sales Return Orders action.';
                }
            }
            group(PostedDocuments)
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action(PostedSalesShipments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Executes the Posted Sales Shipments action.';
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Executes the Posted Sales Invoices action.';
                }
                action(PostedReturnReceipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Executes the Posted Return Receipts action.';
                }
                action(PostedSalesCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Executes the Posted Sales Credit Memos action.';
                }
                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Executes the Posted Purchase Invoices action.';
                }
                action(PostedPurchaseCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Executes the Posted Purchase Credit Memos action.';
                }
                action(PostedDispatchInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Invoice Dispatch';
                    RunObject = Page "Posted Invoice Dispatch List";
                    ToolTip = 'Executes the Posted Invoice Dispatch action.';
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Administration;
                action(PendingMyApproval)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending My Approval';
                    RunObject = Page "Approval Entries";
                    ToolTip = 'Executes the Pending My Approval action.';
                }
                action(MyApprovalrequests)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                    ToolTip = 'Executes the My Approval requests action.';
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action(StoresRequisitions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stores Requisitions';
                    RunObject = Page "Store Requisition";
                    ToolTip = 'Executes the Stores Requisitions action.';
                }
                action(StaffClaim)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff Claim';
                    RunObject = Page "Staff Claim List";
                    ToolTip = 'Executes the Staff Claim action.';
                }
                action(PurchaseRequisition)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Requisition';
                    RunObject = Page "Purchase Requisition";
                    ToolTip = 'Executes the Purchase Requisition action.';
                }
                action(ImprestSurrender)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Surrender';
                    RunObject = Page "Imprest Accounting";
                    ToolTip = 'Executes the Imprest Surrender action.';
                }
                action(ImprestRequisitions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "Imprest Lists";
                    ToolTip = 'Executes the Imprest Requisitions action.';
                }
                action(LeaveApplications)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Leave Applications';
                    RunObject = Page "HR Leave Requisition List";
                    ToolTip = 'Executes the Leave Applications action.';
                }
                action(MyApprovedLeaves)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "Hr My Approved Leaves List";
                    ToolTip = 'Executes the My Approved Leaves action.';
                }
                action("Broadcast SMS")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "SMS Broadcast List1";
                    ToolTip = 'Executes the Broadcast SMS action.';
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action("Request to Approve")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'Executes the Request to Approve action.';
                }
            }
        }
    }
}

profile "HMS Billing Role Center"
{
    ProfileDescription = 'Billing Role Center';
    Caption = 'New Billing Role Center';
    RoleCenter = "HMS Billing Role Centre";
}
 
