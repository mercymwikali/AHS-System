Page 85462 "HMS Theatre Role Centre"
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
                    RunObject = Page "HMS Appointment Form List";
                    ToolTip = 'Executes the Appointments action.';
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
                action(InPatients)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'InPatients';
                    RunObject = Page "HMS InPatient List";
                    ToolTip = 'Executes the InPatients action.';
                }
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
                action(PharmacyListReturns)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List-Returns';
                    RunObject = Page "HMS Pharmacy Line-returns";
                    ToolTip = 'Executes the Pharmacy List-Returns action.';
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
