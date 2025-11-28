Page 52202736 "HMS ICU Role Centre"
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
                        RunObject = Report "HMS Laboratory Test Finding";
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
                        RunObject = Page "HMS Immunization Posted List";
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
                        Caption = 'Observation Signs';
                        Image = SetupList;
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "HMS Observation Signs";
                        ToolTip = 'Executes the Observation Signs action.';
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
        }
        area(sections)
        {
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
                action(DispenseDrugs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dispense Drugs';
                    Promoted = true;
                    RunObject = Page "HMS Pharmacy List";
                    ToolTip = 'Executes the Dispense Drugs action.';
                }
                action(ICUHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ICU History';
                    Promoted = true;
                    RunObject = Page "HMS ICU History";
                    ToolTip = 'Executes the ICU History action.';
                }
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
