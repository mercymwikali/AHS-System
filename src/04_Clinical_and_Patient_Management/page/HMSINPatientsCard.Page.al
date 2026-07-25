page 85360 "HMSINPatients Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Procedure Requests,Nursing Tool,Pharmacy Activities,Doctors Activities,Nurse Activities,Billing';
    SourceTable = "HMS Patient";

    layout
    {
        area(content)
        {
            group("Personal details")
            {
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ToolTip = 'Specifies the value of the Date Registered field.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the First/English Name field.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                    trigger OnValidate()
                    begin
                        if Rec."Date Of Birth" <> 0D then
                            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
                    end;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    Caption = 'Mode of Payment';
                    Editable = true;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the Mode of Payment field.';

                    trigger OnValidate()
                    begin
                        // CheckPatientType();
                    end;
                }
                field(Age; Age)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Next of kin Relationship"; Rec."Next of kin Relationship")
                {
                    Caption = 'Next of Kin Relationship';
                    ToolTip = 'Specifies the value of the Next of Kin Relationship field.';
                }
                field("Next Of kin Full Name"; Rec."Next Of kin Full Name")
                {
                    Caption = 'Next of Kin Full Name';
                    ToolTip = 'Specifies the value of the Next of Kin Full Name field.';
                }
                field("Next Of kin Address 1"; Rec."Next Of kin Address 1")
                {
                    Caption = 'Next of Kin Address 1';
                    ToolTip = 'Specifies the value of the Next of Kin Address 1 field.';
                }
                field("Next Of kin Address 2"; Rec."Next Of kin Address 2")
                {
                    Caption = 'Next of Kin Address 2';
                    ToolTip = 'Specifies the value of the Next of Kin Address 2 field.';
                }
                field("Next Of kin Address 3"; Rec."Next Of kin Address 3")
                {
                    Caption = 'Next of Kin Address 3';
                    ToolTip = 'Specifies the value of the Next of Kin Address 3 field.';
                }
                field("Next Of Kin ID Card No."; Rec."Next Of Kin ID Card No.")
                {
                    Caption = 'Next of Kin National ID Card No.';
                    ToolTip = 'Specifies the value of the Next of Kin National ID Card No. field.';
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ToolTip = 'Specifies the value of the Insurance No. field.';
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field("Mother Full Name"; Rec."Mother Full Name")
                {
                    Caption = 'Principal Member Name';
                    ToolTip = 'Specifies the value of the Principal Member Name field.';
                }
                field("Membership No"; Rec."Membership No")
                {
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
                field("File No"; Rec."File No")
                {
                    ToolTip = 'Specifies the value of the File No field.';
                }
            }
            group("Correspondence Address")
            {
                field("Current Adm No"; Rec."Current Adm No")
                {
                    ToolTip = 'Specifies the value of the Current Adm No field.';
                }
                field("Place of Birth Village"; Rec."Place of Birth Village")
                {
                    Caption = 'Residence';
                    ToolTip = 'Specifies the value of the Residence field.';
                }
                field("Name of Chief"; Rec."Name of Chief")
                {
                    Caption = 'Name of Chief/Asst. Chief';
                    ToolTip = 'Specifies the value of the Name of Chief/Asst. Chief field.';
                }
                field("Nearest Police Station"; Rec."Nearest Police Station")
                {
                    Caption = 'Nearest School/Church';
                    ToolTip = 'Specifies the value of the Nearest School/Church field.';
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 1 field.';
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    ToolTip = 'Specifies the value of the Telephone No. 2 field.';
                }
                field("Correspondence Address 1"; Rec."Correspondence Address 1")
                {
                    ToolTip = 'Specifies the value of the Correspondence Address 1 field.';
                }
                field("Correspondence Address 2"; Rec."Correspondence Address 2")
                {
                    ToolTip = 'Specifies the value of the Correspondence Address 2 field.';
                }
                field("Correspondence Address 3"; Rec."Correspondence Address 3")
                {
                    ToolTip = 'Specifies the value of the Correspondence Address 3 field.';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ToolTip = 'Specifies the value of the Fax No. field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

            group("Doctor Activities")
            {
                action("Doctor Notes")
                { // Notes are Taken during a doctors visit. i.e Doctors Notes are taken during a consultation (Treatment Form Header).
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "HMS Doctors Notes"; // TODO : Restrict Editing when coming from this page.
                    RunPageLink = "Patient No" = field("Patient No."), "Admission No." = field("Current Adm No");
                    RunPageView = sorting(TreatmentNo) order(descending);
                    ToolTip = 'Executes the Doctor Notes action.';
                }
                action("Add Doctor Notes")
                { // Notes are Taken during a doctors visit. i.e Doctors Notes are taken during a consultation (Treatment Form Header).
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "HMS Doctors Notes Card"; // TODO : Restrict Editing when coming from this page.
                    RunPageLink = TreatmentNo = field("Current Adm No");
                    // RunPageView = sorting(TreatmentNo) order(descending);
                    RunPageMode = Create;
                    ToolTip = 'Executes the Doctor Notes action.';
                }
                action(TherapySession)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Therapy Sessions';
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = ListPage;
                    ToolTip = 'Executes the Therapy Session Action';
                    RunObject = page "HMS Therapy List";
                    RunPageLink = "Treatment No." = field("Current Adm No");
                }

            }
            group("Nurse Activities")
            {
                action("Nurse Notes")
                {
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = Page "HMS Admission Nurse Notes";
                    RunPageLink = "Admission No." = field("Current Adm No");
                    ToolTip = 'Executes the Nurse Notes action.';
                }
                action("Daily Process/Procedures")
                {
                    Image = ProdBOMMatrixPerVersion;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = Page "HMS Admission Form Process";
                    RunPageLink = "Admission No." = field("Current Adm No");
                    ToolTip = 'Executes the Daily Process/Procedures action.';
                }
                action("Treatment Sheet")
                {
                    Image = Timesheet;
                    RunObject = Page "HMS Admission Drug Nurse";
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunPageLink = "Admission No." = field("Current Adm No");
                    ToolTip = 'Executes the Treatment Sheet action.';
                }
                action("Admission Details")
                {
                    Image = AddWatch;
                    RunObject = Page "HMS Admitted Form Header";
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunPageLink = "Admission No." = field("Current Adm No");
                    ToolTip = 'Executes the Admission Details action.';
                }
                action("Nurse Order Sheet")
                {
                    Image = AddWatch;
                    RunObject = Page "Nurse Order Sheet ";
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunPageLink = "Admission No" = field("Current Adm No");
                    ToolTip = 'Executes the Nursing Order sheet Details action.';
                }

            }
            group(pharmacy)
            {
                action(Prescriptions)
                {
                    Image = ProdBOMMatrixPerVersion;
                    Promoted = true;
                    RunObject = Page "HMS Admission Form Drug";
                    PromotedCategory = Category6;
                    RunPageLink = "Admission No." = field("Current Adm No");
                    ToolTip = 'Executes the Prescriptions action.';
                }
                action(PostedPrescriptions)
                {
                    Caption = 'Posted Prescriptions';
                    Image = PostedDeposit;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HMS Posted Admission Form Drug";
                    RunPageLink = "Admission No." = field("Current Adm No");
                    ToolTip = 'Executes the Posted Prescriptions action.';
                }
                action(PharmacyReturns)
                {
                    Caption = 'Pharmacy Returns';
                    Image = PostedDeposit;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HMS Pharmacy Line-returns";
                    RunPageLink = "Patient No" = field("Patient No.");
                    ToolTip = 'Executes the Posted Prescriptions action.';
                }
            }
            group(Forms)
            {
                Caption = 'Nursing Tool';
                action("VisitList")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "IP Visitors List";
                    RunPageLink = "Admission No." = field("Current Adm No");
                    ToolTip = 'Executes the Visit List action';
                }
                action(SuicidalForm)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Suicidal Precaution Form";
                    RunPageLink = "Admission No." = field("Current Adm No");
                    ToolTip = 'Executes the SuicidalForm action.';
                }
                action(MSE)
                {
                    ApplicationArea = All;
                    Caption = 'Mental Status Checklist';
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Mental Status Level Checklist";
                    RunPageLink = "Admission No." = field("Current Adm No");
                    ToolTip = 'Executes the MSE action.';
                }
                action("Brief MSE Form")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Brief MSE Form";
                    RunPageLink = "Encounter No" = field("Current Adm No");
                    ToolTip = 'Executes the Brief MSE Form List action.';
                }
                action("Nursing Care Plan")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Nursing Care Plan";
                    RunPageLink = "Patient No." = field("Patient No.");
                    RunPageView = sorting("Date Taken") order(descending);
                    ToolTip = 'Executes the Nursing Care Plan action.';
                }
                action("Dietary Intake")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Dietary Intake Form";
                    RunPageLink = "Admission No." = field("Current Adm No");
                    ToolTip = 'Executes the Dietary Intake action.';
                }
                action(JVForm)
                {
                    Caption = 'Jackson Visual Form';
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = page "Jackson Visual Form";
                    RunPageLink = "Admission No" = field("Current Adm No");
                    ToolTip = 'Executes the Jackson Visual Form action.';
                }
            }
            group(Procedures)
            {
                action(LabRequests)
                {
                    ApplicationArea = Basic, Suite;
                    Image = EditAdjustments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = page "Laboratory Requests";
                    RunPageLink = "Treatment No." = field("Current Adm No");
                    ToolTip = 'Executes the Lab Requests Actions';
                }
                action(RadiologyRequests)
                {
                    ApplicationArea = Basic, Suite;
                    Image = EditAdjustments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = page "HMS Treatment Form Radiology";
                    RunPageLink = "Treatment No." = field("Current Adm No");
                    ToolTip = 'Executes the Radiology Requests Actions';
                }
                action(ECTRequests)
                {
                    ApplicationArea = Basic, Suite;
                    Image = EditAdjustments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = page "HMS Procedure Request List";
                    RunPageLink = "Link No" = field("Current Adm No");
                    RunPageView = sorting("Request Date") order(ascending) where("Procedure Type" = filter(PatientProcedureTypesEnum::ECT));
                    ToolTip = 'Executes the ECT Requests Actions';
                }
                action(KetamineRequests)
                {
                    ApplicationArea = Basic, Suite;
                    Image = EditAdjustments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = page "HMS Procedure Request List";
                    RunPageLink = "Link No" = field("Current Adm No");
                    RunPageView = sorting("Request Date") order(ascending) where("Procedure Type" = filter(PatientProcedureTypesEnum::"Ketamine Infusion"));
                    ToolTip = 'Executes the Requests Actions';
                }
                action(ImplantsRequests)
                {
                    ApplicationArea = Basic, Suite;
                    Image = EditAdjustments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = page "HMS Procedure Request List";
                    RunPageLink = "Link No" = field("Current Adm No");
                    RunPageView = sorting("Request Date") order(ascending) where("Procedure Type" = filter(PatientProcedureTypesEnum::Implant));
                    ToolTip = 'Executes the Requests Actions';
                }
            }
            group(Notes)
            {
                action("39005887")
                {
                    Caption = 'Print Notes';
                    Image = MakeOrder;
                    ToolTip = 'Executes the Print Notes action.';
                    Promoted = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin
                        HMSAdmissionFormNurse.Reset();
                        HMSAdmissionFormNurse.SetRange(HMSAdmissionFormNurse."Admission No.", Rec."Current Adm No");
                        if HMSAdmissionFormNurse.Find('-') then
                            REPORT.Run(Report::"HMS Nurse Notes", true, true, HMSAdmissionFormNurse)
                        else
                            Message('No Notes Available for the patient');
                    end;
                }
            }
            group("Accounts Activities")
            {
                action(Charges)
                {
                    ApplicationArea = All;
                    Caption = 'Open Charges';
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Category9;
                    RunObject = Page "HMS Patient Charges List";
                    RunPageLink = "Patient No." = field("Patient No."),
                              "Visit No" = field("Current Adm No");
                    ToolTip = 'Executes the Charges action.';
                }
                action("Posted Patient Charges")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Charges';
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Category9;
                    RunObject = page "HMS Patient ClosedCharges List";
                    RunPageLink = "Visit No" = field("Current Adm No");
                    ToolTip = 'Executes the Posted Patient Charges action.';
                }
                action("&Print Interim Invoice")
                {
                    Caption = '&Print Interim Invoice';
                    Image = PrintDocument;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Executes the &Print Interim Invoice action.';

                    trigger OnAction()
                    begin
                        HMSPatientCharges.Reset();
                        HMSPatientCharges.SetFilter(HMSPatientCharges."Patient No.", Rec."Patient No.");
                        if HMSPatientCharges.Find('-') then
                            REPORT.Run(Report::"HMS Patient Invoice", true, true, HMSPatientCharges);
                    end;
                }
            }
            group(FormGenerator)
            {
                action("Generate MSE Form")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Generate MSE Form action.';
                    trigger OnAction()
                    var
                        PatientManagement: Codeunit "Patient Management";
                    begin
                        PatientManagement.GenerateBriefMSEForm(Rec."Current Adm No");
                    end;

                }
                action("Generate Consultation Notes")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Generate MSE Form action.';
                    trigger OnAction()
                    var
                        PatientManagement: Codeunit "Patient Management";                        
                    begin
                        if PatientManagement.FnGeneratePatientNotesForm(Rec."Current Adm No", true) then 
                            Message('done');                 
                    end;
                }
            }
        }
    }

    // trigger OnInit()
    // begin
    //     "Relative No.Enable" := true;
    //     "Employee No.Enable" := true;
    //     "Student No.Enable" := true;
    // end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Patient Type" := Rec."Patient Type"::Cash;
    end;

    var
        HMSAdmissionFormNurse: Record "HMS Admission Form Nurse";
        HMSPatientCharges: Record "HMS Patient Charges";
        HRDates: Codeunit "HR Dates";
        Age: Text[100];

    trigger OnAfterGetCurrRecord()
    begin
        // CheckPatientType();
        if Rec."Date Of Birth" <> 0D then
            Age := HRDates.DetermineAge(Rec."Date Of Birth", Today);
    end;

    /* local procedure isLastVisitDayWithin7days() lastVisitDay: Integer
    var
        appointments: Record "HMS Appointment Form Header";
    begin
        lastVisitDay := 999;

        appointments.Reset();
        appointments.SetRange(appointments."Patient No.", Rec."Patient No.");
        appointments.SetCurrentKey("Appointment No.");
        if appointments.FindLast() then
            lastVisitDay := Today - appointments."Appointment Date";
    end; */
}
