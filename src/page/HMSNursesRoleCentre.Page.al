page 85550 "HMS Nurses Role Centre"
{
    Caption = 'Nurse Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group(Hospital)
            {
                part("HMS CUE"; "HMS Cue")
                {
                    Caption = 'HMS CUE';
                }
                systempart(Links; Links)
                {
                }
                systempart(MyNotes; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Admissions)
            {
                Caption = 'Admissions';
                Image = Payables;
                action(AdmReq)
                {
                    Caption = 'Admission Requests';
                    Image = FixedAssets;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Admission Form Header";
                    ToolTip = 'Executes the Admission Requests action.';
                }
                action(AdmProg)
                {
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
                    Caption = 'Referral Hospitals';
                    Image = SetupColumns;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 26;
                    ToolTip = 'Executes the Referral Hospitals action.';
                }
                action(ActiveRef)
                {
                    Caption = 'Active Referrals';
                    Image = Setup;
                    Promoted = true;
                    RunObject = Page "HMS Referral Header List";
                    ToolTip = 'Executes the Active Referrals action.';
                }
                action(hitRef)
                {
                    Caption = 'Completed Referrals';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Referral Header List";
                    ToolTip = 'Executes the Completed Referrals action.';
                }
            }
            group(Immunizations)
            {
                Caption = 'Immunizations';
                Image = SNInfo;
                action(Immunization)
                {
                    Image = NewOrder;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Header List";
                    ToolTip = 'Executes the Immunization action.';
                }
                action(ImmHist)
                {
                    Caption = 'Immunization History';
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Header List";
                    ToolTip = 'Executes the Immunization History action.';
                }
            }
            group(Reports)
            {
                Caption = 'HMS Reports';
                Image = SNInfo;
                group("HMS Reports")
                {
                    Caption = 'HMS Reports';
                    action(App)
                    {
                        Caption = 'Appointments';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Appointments Listing";
                        ToolTip = 'Executes the Appointments action.';
                    }
                    action(Observ)
                    {
                        Caption = 'Observations';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Observation Listing Report";
                        ToolTip = 'Executes the Observations action.';
                    }
                    action(treatment)
                    {
                        Caption = 'Treatments';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Treatment Listing Report";
                        ToolTip = 'Executes the Treatments action.';
                    }
                    action(labtest1)
                    {
                        Caption = 'Lab Tests Summary';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Lab Tests Summary";
                        ToolTip = 'Executes the Lab Tests Summary action.';
                    }
                    action(labtest2)
                    {
                        Caption = 'Lab Tests Detailed';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Laboratory Detailed Report2";
                        ToolTip = 'Executes the Lab Tests Detailed action.';
                    }
                    action(labtest3)
                    {
                        Caption = 'Lab tests Findings';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Laboratory Test Finding";
                        ToolTip = 'Executes the Lab tests Findings action.';
                    }
                    action(PatList)
                    {
                        Caption = 'Patient listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Patient Listing Report";
                        ToolTip = 'Executes the Patient listing action.';
                    }
                    action(Admission_List)
                    {
                        Caption = 'Admission listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Admission Listing Summary";
                        ToolTip = 'Executes the Admission listing action.';
                    }
                    action(Ref_list)
                    {
                        Caption = 'Referrals Listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Referral Listing Report";
                        ToolTip = 'Executes the Referrals Listing action.';
                    }
                    action(Daily_Att_OutPat)
                    {
                        Caption = 'Daily Attendance (Outpatient)';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Daily Attendance Report";
                        ToolTip = 'Executes the Daily Attendance (Outpatient) action.';
                    }
                    action(Inj_Reg)
                    {
                        Caption = 'Injection Register';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Injection Register Report";
                        ToolTip = 'Executes the Injection Register action.';
                    }
                    action(Proc_Emp_and_Deps)
                    {
                        Caption = 'Appointments';
                        Image = ExecuteAndPostBatch;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Appointments Listing";
                        ToolTip = 'Executes the Appointments action.';
                    }
                    action("Patients Visits Summary")
                    {
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
                group(Setup)
                {
                    Caption = 'Setup';

                    action(Ob_signs)
                    {
                        Caption = 'Observation Signs';
                        Image = Opportunity;
                        Promoted = true;
                        PromotedIsBig = false;
                        RunObject = Page "HMS General Observation Setup";
                        ToolTip = 'Executes the Observation Signs action.';
                    }
                    action(ImmunHist)
                    {
                        Caption = 'Immunization History';
                        Image = History;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Page "HMS Setup Process List";
                        ToolTip = 'Executes the Immunization History action.';
                    }
                    action(SetupCard)
                    {
                        Caption = 'Setup Card';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Card";
                        ToolTip = 'Executes the Setup Card action.';
                    }
                    action(Systems_Card)
                    {
                        Caption = 'Systems Card';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Systems List";
                        ToolTip = 'Executes the Systems Card action.';
                    }
                    action(Setup_Doctor)
                    {
                        Caption = 'Setup Doctor';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Hms Setup Doctors List";
                        ToolTip = 'Executes the Setup Doctor action.';
                    }
                    action(Setup_Blood_Group)
                    {
                        Caption = 'Setup Blood Group';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Blood Group List";
                        ToolTip = 'Executes the Setup Blood Group action.';
                    }
                    action(Blood_Group_Donation)
                    {
                        Caption = 'Blood Group Donation';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Blood Group Donation List";
                        ToolTip = 'Executes the Blood Group Donation action.';
                    }
                    action(Drug_Interaction)
                    {
                        Caption = 'Drug Interaction';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Drug Interaction Header";
                        ToolTip = 'Executes the Drug Interaction action.';
                    }
                    action(Observation_Signs)
                    {
                        Caption = 'Observation Signs';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Observation Signs";
                        ToolTip = 'Executes the Observation Signs action.';
                    }
                    action(Appointment_Typ)
                    {
                        Caption = 'Appointment Type';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Appointment Type Lst";
                        ToolTip = 'Executes the Appointment Type action.';
                    }
                    action(TriageSetUp)
                    {
                        Caption = 'Triage Tests Setup';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Triage Waiting List";
                        ToolTip = 'Executes the Triage Tests Setup action.';
                    }
                    action("Setup Process")
                    {
                        Caption = 'Process Setup';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Process List";
                        ToolTip = 'Executes the Process Setup action.';
                    }
                    action(Injection)
                    {
                        Caption = 'Injection';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Injection List";
                        ToolTip = 'Executes the Injection action.';
                    }
                    action(Diagnosis)
                    {
                        Caption = 'Diagnosis';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Diagnosis Card";
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
                        Caption = 'Allergy';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Allergy Card";
                        ToolTip = 'Executes the Allergy action.';
                    }
                    action(signs)
                    {
                        Caption = 'Signs';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Signs";
                        ToolTip = 'Executes the Signs action.';
                    }
                    action(Symptoms)
                    {
                        Caption = 'Symptoms';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Syptoms";
                        ToolTip = 'Executes the Symptoms action.';
                    }
                    action(messuring_Uni)
                    {
                        Caption = 'Measuring Units';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Measuring Unit List";
                        ToolTip = 'Executes the Measuring Units action.';
                    }
                    action(specimen)
                    {
                        Caption = 'Specimen Card';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Specimen Card";
                        ToolTip = 'Executes the Specimen Card action.';
                    }
                    action(Lab_test)
                    {
                        Caption = 'Lab Test Setups';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Lab Test List";
                        ToolTip = 'Executes the Lab Test Setups action.';
                    }
                    action(Rad_Types)
                    {
                        Caption = 'Radiology Types';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Radiology Type List";
                        ToolTip = 'Executes the Radiology Types action.';
                    }
                    action(Setup_Disctarge_Process)
                    {
                        Caption = 'Setup Disctarge Process';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Setup Disctarge Process";
                        ToolTip = 'Executes the Setup Disctarge Process action.';
                    }
                    action(wards)
                    {
                        Caption = 'Ward Setup';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Ward List";
                        ToolTip = 'Executes the Ward Setup action.';
                    }
                    action(Beds)
                    {
                        Caption = 'Beds';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Beds";
                        ToolTip = 'Executes the Beds action.';
                    }
                    action(Hos_Charges)
                    {
                        Caption = 'Hospital Charges Setup';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Charges";
                        ToolTip = 'Executes the Hospital Charges Setup action.';
                    }
                    action(Hos_Drugs_Prof)
                    {
                        Caption = 'Hospital Drugs Profit';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Drugs Profit";
                        ToolTip = 'Executes the Hospital Drugs Profit action.';
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
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List";
                    ToolTip = 'Executes the Patients List action.';
                }
            }
            group(Appointment)
            {
                Caption = 'Appointments';
                Image = Statistics;
                action(Appointments)
                {
                    Caption = 'Appointments';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Appointment List";
                    ToolTip = 'Executes the Appointments action.';
                }
            }
            group(ObsRoom)
            {
                Caption = 'Triage Room';
                Image = RegisteredDocs;
                action(Triage)
                {
                    Caption = 'Triage';
                    RunObject = Page "HMS Observation List";
                    ToolTip = 'Executes the Triage action.';
                }
                action("Triage History")
                {
                    Caption = 'Triage History';
                    RunObject = Page "HMS Observation History List";
                    ToolTip = 'Executes the Triage History action.';
                }
            }
            group(HMS_Admissions)
            {
                Caption = 'InPatients';
                Image = LotInfo;
                action(Pat_Admissions)
                {
                    Caption = 'Patient Admissions';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Admission Form Header List";
                    ToolTip = 'Executes the Patient Admissions action.';
                }
                action(InPatients)
                {
                    Caption = 'InPatients';
                    RunObject = Page "HMS InPatient List";
                    ToolTip = 'Executes the InPatients action.';
                }
                action("Pharmacy List")
                {
                    Caption = 'Pharmacy List';
                    RunObject = Page "HMS Pharmacy List Inpatient";
                    ToolTip = 'Executes the Pharmacy List action.';
                }
                action(InPatients_Livr)
                {
                    Caption = 'Admission Admitted Patient';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Admission Admitted List";
                    ToolTip = 'Executes the Admission Admitted Patient action.';
                }
                action(InPatients_Liverr)
                {
                    Caption = 'Inpatients Verified Patient';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Admission Verified List";
                    ToolTip = 'Executes the Inpatients Patient action.';
                }
                action("Discharge Request")
                {
                    Caption = 'Discharge Request';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Admission Discharge List";
                    ToolTip = 'Executes the Discharge Request action.';
                }
                action(Discharge)
                {
                    Caption = 'Discharge List';
                    Image = ReleaseShipment;
                    RunObject = Page "HMS Admission Discharge List";
                    ToolTip = 'Executes the Discharge List action.';
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Administration;
                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page 658;
                    ToolTip = 'Executes the Pending My Approval action.';
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page 662;
                    ToolTip = 'Executes the My Approval requests action.';
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    Caption = 'Stores Requisitions';
                    RunObject = Page "Store Requisition";
                    ToolTip = 'Executes the Stores Requisitions action.';
                }
                action("Staff Claim")
                {
                    Caption = 'Staff Claim';
                    RunObject = Page "Staff Claim List";
                    ToolTip = 'Executes the Staff Claim action.';
                }
                action("Purchase Requisition")
                {
                    Caption = 'Purchase Requisition';
                    RunObject = Page "Purchase Requisition";
                    ToolTip = 'Executes the Purchase Requisition action.';
                }
                action("Imprest Surrender")
                {
                    Caption = 'Imprest Surrender';
                    RunObject = Page "Imprest Accounting";
                    ToolTip = 'Executes the Imprest Surrender action.';
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "Imprest Lists";
                    ToolTip = 'Executes the Imprest Requisitions action.';
                }
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page "HR Leave Application List";
                    ToolTip = 'Executes the Leave Applications action.';
                }
                action("My Approved Leaves")
                {
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "Hr My Approved Leaves List";
                    ToolTip = 'Executes the My Approved Leaves action.';
                }
                action("Transfer Order")
                {
                    Caption = 'Transfer Order';
                    RunObject = Page 5742;
                    ToolTip = 'Executes the Transfer Order action.';
                }
            }
        }
    }
}
