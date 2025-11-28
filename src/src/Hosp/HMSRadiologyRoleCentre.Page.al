Page 52202737 "HMS Radiology Role Centre"
{
    Caption = 'Role Center';
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
                    RunObject = Page "HMS Admission Form Header";
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
                    RunObject = Page "Vendor List";
                    ToolTip = 'Executes the Referral Hospitals action.';
                }
                action(ActiveRef)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Referrals';
                    Image = Setup;
                    Promoted = true;
                    RunObject = Page "HMS Referral Header List";
                    ToolTip = 'Executes the Active Referrals action.';
                }
                action(hitRef)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Completed Referrals';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Referral Header List2";
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
                    RunObject = Page "HMS Immunization Header List";
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
                        Caption = 'Lab Tests Findings';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Laboratory Test Finding";
                        ToolTip = 'Executes the Lab Tests Findings action.';
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
                        RunObject = Report "HMS Appointments Listing";
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
                group(ActionGroup103)
                {
                    Caption = 'Setup';
                    action(Ob_signs)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Observation Signs';
                        Image = Opportunity;
                        Promoted = true;
                        PromotedIsBig = false;
                        RunObject = Page "HMS Observation Signs";
                        ToolTip = 'Executes the Observation Signs action.';
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
                        RunObject = Page "HMS Lab Parameters Setup List";
                        ToolTip = 'Executes the Lab Test Setups action.';
                    }
                    action(Rad_Types)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Radiology Types';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Radiology List";
                        ToolTip = 'Executes the Radiology Types action.';
                    }
                    action(Setup_Disctarge_Process)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Setup Disctarge Process';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Admission Discharge List";
                        ToolTip = 'Executes the Setup Disctarge Process action.';
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
                        Caption = 'Drugs Profit';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Drugs Profit";
                        ToolTip = 'Executes the Drugs Profit action.';
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
                    RunObject = Page "HMS Patient List";
                    ToolTip = 'Executes the Patients List action.';
                }
                action(Walkin)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Walkin Patient List";
                    ToolTip = 'Executes the Walkin action.';
                }
                action("Gym Customers")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Customer List2";
                    ToolTip = 'Executes the Gym Customers action.';
                }
            }
            group(Appointments)
            {
                Caption = 'Appointments';
                Image = Statistics;
                action(TherapyAppointments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Therapy Appointments';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Appointment List-Therapy";
                    ToolTip = 'Executes the Therapy Appointments action.';
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
                    RunObject = Page "HMS Appointment Form Header";
                    ToolTip = 'Executes the Appointments History action.';
                }
            }
            group(Radiotherapy)
            {
                Caption = 'Radiology';
                Image = RegisteredDocs;
                action(Radiology)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Radiology';
                    RunObject = Page "HMS Radiology List";
                    ToolTip = 'Executes the Radiology action.';
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
                    RunObject = Page "Imprest List UP";
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
            }
        }
    }
}
