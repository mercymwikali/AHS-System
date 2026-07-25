Page 85430 "HMS Registration Role Centre"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control10)
            {
                part(Control8; "HMS Cue")
                {
                    Caption = 'HMS CUE';
                }
                systempart(Control105; Links)
                {
                }
                systempart(Control106; MyNotes)
                {
                }
                // chartpart("T38-08"; "T38-08")
                // {
                // }
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
            action("Invoice Dispatch")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Invoice Dispatch List";
                ToolTip = 'Executes the Invoice Dispatch action.';
            }
            action("UnDispatched Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Invoices Pending Dispatch';
                RunObject = Page "UnDispatched Invoices";
                ToolTip = 'Executes the Invoices Pending Dispatch action.';
            }

            action(Charges)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Charges';
                Image = Reminder;
                RunObject = Page "HMS Charges";
                ToolTip = 'Executes the Charges action.';
            }
            action(Receipt)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Receipts';
                Image = Reminder;
                RunObject = Page "Receipts List";
                ToolTip = 'Executes the Receipts action.';
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
                action(AdmReq1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Verified Admission Requests';
                    Image = FixedAssets;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Admission Verified List";
                    ToolTip = 'Executes the Verified Admission Requests action.';
                }
                action(AdmAdmitted)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admitted Admission Requests';
                    Image = FixedAssets;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Admission Header Admitted";
                    ToolTip = 'Executes the Verified Admission Requests action.';
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
            group(PatientQueue)
            {
                Caption = 'Patient Queue';
                action(WDoctor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctors Queue';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Doctor Waiting List";
                    ToolTip = 'Executes the Doctors Queue action.';
                }
                action(WTriage)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Triage Queue';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Triage Waiting List";
                    ToolTip = 'Executes the Triage Queue action.';
                }
                action(WLab)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Laboratory Queue';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Lab Waiting List";
                    ToolTip = 'Executes the Laboratory Queue action.';
                }
                action(WPharm)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy Queue';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Pharmacy Waiting List";
                    ToolTip = 'Executes the Pharmacy Queue action.';
                }
                action(WRadiology)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Radiology Queue';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Radiology Waiting List";
                    ToolTip = 'Executes the Radiology Queue action.';
                }
            }
            group(Setups1)
            {
                Caption = 'Hospital Setups.';
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
                action("Setup Dosage")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dosage Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Dosage Setup";
                    ToolTip = 'Executes the Dosage Setup action.';
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
                action(DosageSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dosage Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Dosage Setup";
                    ToolTip = 'Executes the Dosage Setup action.';
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
                    RunObject = Page "HMS ward List";
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
            }

            group(Reports)
            {
                Caption = 'Reports';
                Image = SNInfo;
                group(ReceiptsReports)
                {
                    caption = 'Receipts Reports';
                    action("Receiptsshiftsplitreport")
                    {
                        ApplicationArea = all;
                        Caption = 'Receipts shift report-split';
                        Image = "Report";
                        RunObject = Report "HMS Shift Report";
                        ToolTip = 'Executes the Receipts shift report-split action.';
                    }
                    action("Receiptsshiftreport")
                    {
                        ApplicationArea = all;
                        Caption = 'Receipts shift report';
                        Image = "Report";
                        RunObject = Report "Receipts Per Transaction Type";
                        ToolTip = 'Executes the Receipts shift report action.';
                    }
                    action("ReceiptsSummary")
                    {
                        ApplicationArea = all;
                        Caption = 'Receipts Summary';
                        Image = "Report";
                        RunObject = Report "Receipts Summary";
                        ToolTip = 'Executes the Receipts Summary action.';
                    }
                    action("RevenueSummary")
                    {
                        ApplicationArea = all;
                        Caption = 'Revenue Summary';
                        Image = "Report";
                        RunObject = Report "Receipts Per Transaction Type2";
                        ToolTip = 'Executes the Revenue Summary action.';
                    }
                    action("ReceiptsReportCombined")
                    {
                        ApplicationArea = all;
                        Caption = 'Receipts Report Combined';
                        Image = "Report";
                        RunObject = Report "Receipts Unscattered";
                        ToolTip = 'Executes the Receipts Report Combined action.';
                    }
                }
                group(BillingReport)
                {
                    Caption = 'Billing Reports';
                    action("Patients Visits Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = VATStatement;
                        RunObject = Report "HMS Visit Summary";
                        ToolTip = 'Executes the Patients Visits Summary action.';
                    }
                    action("HMS Insurance Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insurance Summary';
                        Image = Receipt;
                        RunObject = Report "Posted Sales Invoice Summary";
                        ToolTip = 'Executes the Insurance Summary action.';
                    }
                    action("HMSBedOccupancy")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bed Occupancy';
                        Image = Receipt;
                        RunObject = Report "HMS Bed Occupancy";
                        ToolTip = 'Executes the Bed Occupancy action.';
                    }
                    action("Insurance Summary2")
                    {
                        ApplicationArea = all;
                        Caption = 'Customer Credit Sales';
                        Image = "Report";
                        RunObject = Report "HMS Customer Credit Sales";
                        ToolTip = 'Executes the Customer Credit Sales action.';
                    }
                    action("Receipt Summary2")
                    {
                        ApplicationArea = all;
                        Caption = 'Flash Revenue';
                        Image = "Report";
                        RunObject = Report "Flash Revenue";
                        ToolTip = 'Executes the Flash Revenue action.';
                    }
                    action("HMS Charges Prices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Charges Prices';
                        Image = Receipt;
                        RunObject = Report "HMS Charges Prices";
                        ToolTip = 'Executes the Charges Prices action.';
                    }
                    action("HMS Insurance Rates")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insurance Consultation Rates';
                        Image = Receipt;
                        RunObject = Report "HMS Insurance Rates";
                        ToolTip = 'Executes the Insurance Consultation Rates action.';
                    }
                }
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
                    action(App1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Operational Monthly Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Operational Monthly Totals";
                        ToolTip = 'Executes the Operational Monthly Totals action.';
                    }
                    action(App2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Operational Daily Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Operational Daily Totals";
                        ToolTip = 'Executes the Operational Daily Totals action.';
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
                    action(Pharmt1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Prescriptions Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS IP/OP Prescription";
                        ToolTip = 'Executes the Prescriptions Report action.';
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
                    RunPageView = where("Patient Status" = filter(Alive));
                    ToolTip = 'Executes the Patients List action.';
                }
                action("Walk-In Patients List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Walkin Patient List";
                    RunPageView = where("Patient Status" = filter(Alive), "Walk-in" = filter(true));
                    ToolTip = 'Executes the Walk-In Patients List action.';
                }
                action("Patients List2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'RIP Patients List';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List2";
                    RunPageView = where("Patient Status" = const(Dead));
                    ToolTip = 'Executes the RIP Patients List action.';
                }
                action("Transferred Patients List2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transferred Patients List';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List2";
                    RunPageView = where("Patient Status" = const(Transfer));
                    ToolTip = 'Executes the Transferred Patients List action.';
                }
            }

            group(Appointments)
            {
                Caption = 'Checked-In List';
                Image = Statistics;
                action(Action19)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active List';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Appointment List";
                    ToolTip = 'Executes the Active List action.';
                }
                action(AppointmentsHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Appointment Form History L";
                    ToolTip = 'Executes the History action.';
                }
            }
            group("Appointment Booking")
            {
                action("Appointment Booking List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointment Booking List';
                    RunObject = Page "HMS Appointment Booking";
                    RunPageView = where(Status = filter(""));
                    ToolTip = 'Executes the Appointment Booking List action.';
                }
                action("Therapy Booking List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Therapy Booking List';
                    RunObject = Page "HMS Appointment Booking";
                    RunPageView = where(Section = filter(Therapy), Status = filter(Booked));
                    ToolTip = 'Executes the Therapy Booking List action.';
                }
                action("Consultation Booking List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consultation Booking List';
                    RunObject = Page "HMS Appointment Booking";
                    RunPageView = where(Section = filter(Consultation), Status = filter(Booked));
                    ToolTip = 'Executes the Consultation Booking List action.';
                }
                action("Procedure Booking List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Procedure Booking List';
                    RunObject = Page "HMS Appointment Booking";
                    RunPageView = where(Section = filter("Procedure"), Status = filter(Booked));
                    ToolTip = 'Executes the Procedure Booking List action.';
                }
                action("Appointment Booking History")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointment Booking History';
                    RunObject = Page "HMS Appointment Booking";
                    RunPageView = where(Status = filter(<> ""));
                    ToolTip = 'Executes the Appointment Booking History action.';
                }
                action("Cancelled Booking History")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancelled Booking';
                    RunObject = Page "HMS Appointment Booking";
                    RunPageView = where(Status = filter(Cancelled));
                    ToolTip = 'Executes the Cancelled Booking action.';
                }
                action("Forfeited Booking History")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Forfeited Booking';
                    RunObject = Page "HMS Appointment Booking";
                    RunPageView = where(Status = filter("Failed To Attend"));
                    ToolTip = 'Executes the Forfeited Booking action.';
                }
            }
            group(Theatre)
            {
                Caption = 'Therapy';
                Image = RegisteredDocs;
                action(TheatreList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Therapy List';
                    RunObject = Page "HMS Therapy List";
                    RunPageView = where(Status = filter(<> Closed));
                    ToolTip = 'Executes the Therapy List action.';
                }
                action(TheatreHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Therapy History';
                    RunObject = Page "HMS Therapy List";
                    RunPageView = where(Status = filter(Closed));
                    ToolTip = 'Executes the Therapy History action.';
                }
            }
            group(Pharmacy)
            {
                Caption = 'Pharmacy';

                action("Pharmacy Patients Walkin")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Walkin Patient List";
                    ToolTip = 'Executes the Pharmacy Patients Walkin action.';
                }
                action("39006002")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointment List';
                    RunObject = Page "HMS Appointment Form History L";
                    ToolTip = 'Executes the Appointment List action.';
                }
                action(InPatientList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'InPatient List';
                    RunObject = Page "HMS Current InPatients List";
                    ToolTip = 'Executes the InPatient List action.';
                }
                action(Pharm)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List Outpatient';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Pharmacy List";
                    RunPageView = where(Status = filter('New'),
                                        Inpatient = filter(False));
                    ToolTip = 'Executes the Pharmacy List Outpatient action.';
                }
                action("Pharmacy List Inpatient")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Pharmacy List Inpatient";
                    Visible = false;
                    ToolTip = 'Executes the Pharmacy List Inpatient action.';
                }
                action("Pharmacy List Discharge")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Pharmacy List Discharge";
                    ToolTip = 'Executes the Pharmacy List Discharge action.';
                }
                action(Pharm_Paid)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Paid Pharmacy List';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Pharmacy List Paid";
                    ToolTip = 'Executes the Paid Pharmacy List action.';
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
                action(Pharm_Cancel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancelled Pharmacy List';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Pharmacy Cancelled List";
                    ToolTip = 'Executes the Cancelled Pharmacy List action.';
                }
                action("39003925")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List-Returns';
                    RunObject = Page "HMS Pharmacy Line-returns";
                    ToolTip = 'Executes the Pharmacy List-Returns action.';
                }
                action("Treatment Sheet")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Treatment History List";
                    ToolTip = 'Executes the Treatment Sheet action.';
                }
            }

            group(Billing)
            {
                Caption = 'Hospital Billing';
                Image = Intrastat;
                action("Active OutPatient")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Active Patient OutPatients";
                    ToolTip = 'Executes the Active OutPatient action.';
                }
                action(PendingCashPat)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Patients Pending Receipts';
                    Image = Insurance;
                    Promoted = true;
                    RunObject = Page "HMS Cash Active Patients";
                    ToolTip = 'Executes the Cash Patients Pending Receipts action.';
                }
                action("HMS Corporate pending Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Corporate Pending Invoicing';
                    Image = Insurance;
                    Promoted = true;
                    RunObject = Page "HMS Corporate pending Invoice";
                    ToolTip = 'Executes the Corporate Pending Invoicing action.';
                }
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
                    RunObject = Page "Sales Invoice List.";
                    ToolTip = 'Executes the Invoice List action.';
                }
                action("Invoice Dispatchs")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice Dispatch';
                    RunObject = Page "Invoice Dispatch List";
                    ToolTip = 'Executes the Invoice Dispatch action.';
                }
                action("UnDispatched Invoicess")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoices Pending Dispatch';
                    RunObject = Page "UnDispatched Invoices";
                    ToolTip = 'Executes the Invoices Pending Dispatch action.';
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
                    RunObject = Page "Sales Invoice List.";
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
                action(PostedReceipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Receipts';
                    Image = PostedShipment;
                    RunObject = Page "Posted Receipts";
                    ToolTip = 'Executes the Posted Receipts action.';
                }
                action(PostedInvoiceDispatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Invoice Dispatch';
                    Image = PostedShipment;
                    RunObject = Page "Posted Invoice Dispatch List";
                    ToolTip = 'Executes the Posted Invoice Dispatch action.';
                }
                action(PostedDischarge)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Discharge';
                    Image = PostedShipment;
                    RunObject = Page "HMS Posted Discharge List";
                    ToolTip = 'Executes the Posted Discharge action.';
                }
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
                    RunObject = Page "Posted Sales Invoices.";
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
            }
            group(Periodic)
            {
                action(PostRecurring)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Recurring Charges';
                    RunObject = report "HMS Reccuring Charges";
                    ToolTip = 'Executes the Post Recurring Charges action.';
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
profile "HMS Registration Role Center"
{
    ProfileDescription = 'HMSRegistration Role Center';
    Caption = 'New Hms Registration Role Center';
    RoleCenter = "HMS Registration Role Centre";
}
 