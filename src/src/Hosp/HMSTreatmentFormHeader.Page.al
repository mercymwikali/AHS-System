page 52202874 "HMS Treatment Form Header"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Consultation Notes,Procedures,Requests';
    SourceTable = "HMS Treatment Form Header";
    SourceTableView = where(Status = filter(TreatmentStatus::New | TreatmentStatus::Active));

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("Treatment No."; Rec."Treatment No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Treatment No.';
                    ToolTip = 'Specifies the value of the "Treatment No." field.';
                }
                field("Treatment Location"; Rec."Treatment Location")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Treatment Location field.';
                    Visible = false;
                }
                field("Treatment Type"; Rec."Treatment Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Treatment Type field.';
                }
                field(Direct; Rec.Direct)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Direct field.';
                }
                field("Link No."; Rec."Link No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Link No. field.';
                    trigger OnValidate()
                    begin
                        if (Rec."Treatment Type" = Rec."Treatment Type"::Outpatient) AND (Rec.Direct = false) then begin
                            Observation.RESET();
                            if Observation.GET(Rec."Link No.") then begin
                                Rec."Patient No." := Observation."Patient No.";
                                GetPatientNo(Observation."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                                Rec."Link Type" := 'Observation';
                            end;
                        end
                        else
                            if (Rec."Treatment Type" = Rec."Treatment Type"::Outpatient) AND (Rec.Direct = true) then begin
                                Appointment.RESET();
                                if Appointment.GET(Rec."Link No.") then begin
                                    Rec."Patient No." := Appointment."Patient No.";
                                    Rec."Student No." := Appointment."Student No.";
                                    Rec."Employee No." := Appointment."Employee No.";
                                    GetPatientNo(Appointment."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                                    Rec."Link Type" := 'Appointment';
                                end;
                            end
                            else
                                if Rec."Treatment Type" = Rec."Treatment Type"::Inpatient then begin
                                    Admission.RESET();
                                    if Admission.GET(Rec."Link No.") then begin
                                        Rec."Patient No." := Admission."Patient No.";
                                        GetPatientNo(Admission."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                                        Rec."Link Type" := 'Admission';
                                    end;
                                end;
                        GetPatientName(Rec."Patient No.", PatientName);
                    end;
                }
                field("Treatment Date"; Rec."Treatment Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Treatment Date field.';
                }
                field("Treatment Time"; Rec."Treatment Time")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Treatment Time field.';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor ID field.';

                    trigger OnValidate()
                    begin
                        GetDoctorName(Rec."Doctor ID", DoctorName);
                    end;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Student/Emp/Rel No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Student/Emp/Rel No. field.';
                    Visible = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PF No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the PF No. field.';
                    Visible = false;
                }
                field("Doctor Name"; Rec."Doctor's Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Doctor''s Name field.';
                }
                field("Employee No.2"; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    Visible = false;
                }
                field("Adm No."; Rec."Adm No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Adm No. field.';
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Settlement Type field.';
                }
                field("Membership No"; Rec."Membership No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Membership No field.';
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field("Relative No."; Rec."Relative No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Relative No. field.';
                }
                field(waiting; Rec."Waiting At")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the waiting at field.';
                }
                field("Next Appointment Date"; Rec."Next Appointment Date")
                {
                    ApplicationArea = Basic, Suite;
                    Tooltip = 'Specifies the value of the Next Appointment Date field.';
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic, Suite;
                    Tooltip = 'Specifies the value of the Branch field.';
                }
                field("Urgency Status"; Rec."Urgency Status")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Urgency Status field.';
                }
                field("Form Generated"; Rec."Form Generated")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'form Generated';
                }
            }
            group(Processes)
            {
                Caption = 'Processes';
                part(Control1102760003; "HMS Treatment Form Processes")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = field("Treatment No.");
                }
            }

            group("Process/Vitals Signs Results")
            {
                Caption = 'Process/Vitals Signs Results';
                part(Triage; "HMS Observation Form Proc")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Observation No." = field("Observation No");
                }
            }
            group(Laboratory)
            {
                Caption = 'Laboratory';
                part(Control1102760004; "HMS Treatment Form Laboratory")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                }
            }
            group(Radiology)
            {
                Caption = 'Radiology';
                part(Control1102760006; "HMS Treatment Form Radiology")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = field("Treatment No.");
                }
            }
            group(ECT)
            {
                Caption = 'ECT Request';
                part(ECTRequest; "HMS Procedure Request List")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Link No" = field("Treatment No.");
                    SubPageView = where("Procedure Type" = filter(ECT));
                }

            }
            group(Implants)
            {
                Caption = 'Implants Request';
                part(ImplantsRequest; "HMS Procedure Request List")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Link No" = field("Treatment No.");
                    SubPageView = where("Procedure Type" = filter(Implant));
                }

            }
            group(KetamineInfusion)
            {
                Caption = 'Ketamine Infusion Request';
                part(KetamineInfusionRequest; "HMS Procedure Request List")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Link No" = field("Treatment No.");
                    SubPageView = where("Procedure Type" = filter('Ketamine Infusion'));
                }

            }
            group(Diagnosis)
            {
                Caption = 'Diagnosis';
                part(Control1102760007; "HMS Treatment Form Diagnosis")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                }
            }
            
            group(Prescription)
            {
                Caption = 'Prescription';
                part(Control1102760005; "HMS Treatment Form Drug")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = field("Treatment No.");
                }
            }
            group(Admission)
            {
                Caption = 'Admission';
                part(Control1102760009; "HMS Treatment Form Admission")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                }
            }
            group(ReviewRequest)
            {
                Caption = 'Review Request';
                part(Control1102760010; "HMS Treatment Form Review")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = field("Treatment No.");
                }
            }
            group(Referrals)
            {
                Caption = 'Referrals';
                part(Control1102760038; "HMS Treatment Form Referral")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                }
            }
            group("Sick Off")
            {
                Caption = 'Sick Off';
                field("Off Duty"; Rec."Off Duty")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Off Duty field.';

                    trigger OnValidate()
                    begin
                        if Rec."Off Duty" = false then begin
                            "Off Duty DaysEnable" := false;
                            "Light Duty DaysEnable" := false;
                            "Off Duty CommentsEnable" := false;
                        end
                        else begin
                            "Off Duty DaysEnable" := true;
                            "Light Duty DaysEnable" := true;
                            "Off Duty CommentsEnable" := true;
                        end;
                    end;
                }
                field("Off Duty Days"; Rec."Off Duty Days")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Off Duty Days field.';
                }
                field("Light Duty Days"; Rec."Light Duty Days")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Light Duty Days field.';
                }
                field("Off Duty Comments"; Rec."Off Duty Comments")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Off Duty Comments field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Checkin)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Checkin Patient';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Checkin action.';
                trigger OnAction()
                var
                    HMSProcesses: Codeunit "HMS Processes";
                begin
                    HMSProcesses.FnConsultationRoomCheckin(Rec);
                end;
            }
            group("Doctor Activities")
            {
                action(ConsultationNotes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Generate Consultation Notes Form';
                    Image = Notes;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the Consultation Notes action.';

                    trigger OnAction()
                    var
                        PatientManagement: Codeunit "Patient Management";
                    begin
                        if PatientManagement.FnGeneratePatientNotesForm(Rec."Treatment No.", false) then begin
                            Rec."Form Generated" := true;
                            Rec.Modify();
                            Message('done');
                        end;
                    end;
                }
                action(NotesEntry)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consultation Notes Form Entry';
                    Image = Notes;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Consultation Notes Form";
                    RunPageLink = "Encounter No" = field("Treatment No.");
                    ToolTip = 'Executes the Consultation Notes action.';
                }
                action(DocNotes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctors Notes';
                    Image = Notes;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HMS Doctors Notes";
                    RunPageLink = TreatmentNo = field("Treatment No.");
                    ToolTip = 'Executes the Doc Notes action.';
                }
                action("&Mark as Completed")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Mark as Completed';
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the &Mark as Completed action.';
                    trigger OnAction()
                    var
                        HMSProcesses: Codeunit "HMS Processes";
                    begin
                        if Confirm('Mark this treatment as completed?', true) then
                            HMSProcesses.FnConsultationMarkAsCompleted(Rec);
                    end;
                }
                action("Send to Observation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send to Observation';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Send to Observation action.';
                    trigger OnAction()
                    var
                        HMSProcesses: Codeunit "HMS Processes";
                    begin
                        HMSProcesses.FnConsultationRoomSendToTriage(Rec);
                    end;
                }
            }
            action("Referral Progress")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Referral Progress';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "HMS Referral Header Active";
                RunPageLink = "Treatment No." = field("Treatment No.");
                ToolTip = 'Executes the Referral Progress action.';
            }
            action("Admission Details")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Admission Details';
                Image = RegisteredDocs;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HMS Appointment Form Header";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Admission Details action.';
            }
            action("Radiology Results")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Radiology Results';
                Image = ResourceJournal;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "HMS Radiology View Test Header";
                RunPageLink = "Link Type" = CONST('DOCTOR'), "Link No." = FIELD("Treatment No.");
                ToolTip = 'Executes the Radiology Results action.';
            }
            action("Laboratory Results")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Laboratory Results';
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Category5;
                RunObject = Page "HMS Labo Form History Li";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Laboratory Results action.';
                trigger OnAction()
                begin
                    /*
                    Labrecords.RESET;
                    Labrecords.SETRANGE(Labrecords."Patient No.","Patient No.");
                    Labrecords.SETRANGE(Labrecords.Status, Labrecords.Status::Completed);
                    if Labrecords.FIND('-') then begin
                    LabResults.SETTABLEVIEW(Labrecords);
                    LabResults.RUN;
                    end;
                    */
                end;
            }
            separator(Separator25)
            {
            }

            action("Observation Room")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Observation Room';
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Executes the Observation Room action.';

                trigger OnAction()
                var
                    ObservationForm: Page "HMS Observation Form Header";
                begin

                    ObservationRec.Reset();
                    ObservationRec.SETRANGE(ObservationRec."Patient No.", Rec."Patient No.");
                    ObservationRec.SETRANGE(ObservationRec."Observation No.", Rec."Observation No");
                    if ObservationRec.FIND('-') then begin
                        ObservationForm.SETTABLEVIEW(ObservationRec);
                        ObservationForm.Run();
                    end
                    else
                        MESSAGE('No Observation details available for this patient!');

                end;
            }
            action("Charges Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Category6;
                RunObject = Page "HMS Patient Charges";
                RunPageLink = "Patient No." = FIELD("Patient No."), "Link No" = FIELD("Treatment No.");
                ToolTip = 'Executes the Charges Lines action.';
            }
            separator(Separator24)
            {
            }
            action("Print Referal")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Executes the Print Referal action.';

                trigger OnAction()
                begin
                    // TreatmentHeader.RESET();
                    // TreatmentHeader.SETFILTER(TreatmentHeader."Treatment No.", Rec."Treatment No.");
                    // if TreatmentHeader.FindFirst() then
                    REPORT.RUN(Report::"HMS Refferal Form", true, true, Rec);
                end;
            }
            action(PrintSickSHeet)
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Executes the PrintSickSHeet action.';

                trigger OnAction()
                var
                    HMSSickoffOP: Report "HMS Sickoff OP";
                begin
                    HMSSickoffOP.SetTableView(Rec);
                    HMSSickoffOP.RunModal();
                end;
            }

            action("Dispatch To Phamarcy")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Dispatch To Phamarcy';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Executes the Dispatch To Phamarcy action.';
                Visible = false;
                trigger OnAction()
                var
                    PharmHeader: Record "HMS Pharmacy Header";
                    
                begin
                    if ((Today - Rec."Treatment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    Rec.TestField("Settlement Type");
                    Rec.TestField("Patient Type");

                    if Confirm('Alert Pharmacy About Prescription?') = false then begin exit end;
                    /*
                    TESTFIELD("Settlement Type");
                    TESTFIELD("Appointment Date");
                    TESTFIELD("Appointment Time");
                    TESTFIELD("Patient Type");
                    TESTFIELD("Patient No.");
                    TESTFIELD("Appointment Type");
                    */
                    HMSSetup.Reset();
                    HMSSetup.Get();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);

                    /*Get the treatment from the database*/
                    /* TreatmentHeader.Reset();
                    if TreatmentHeader.Get(Rec."Appointment No.") then begin */
                    PharmHeader.Reset();
                    PharmHeader.Init();
                    PharmHeader."Pharmacy No." := NewNo;
                    PharmHeader."Pharmacy Date" := Today;
                    PharmHeader."Pharmacy Time" := DT2TIME(System.CurrentDateTime);
                    PharmHeader."Request Area" := PharmHeader."Request Area"::Walkin;
                    PharmHeader."Patient No." := Rec."Patient No.";
                    PharmHeader."Link Type" := 'Appointment';
                    PharmHeader."Link No." := Rec."Appointment No";
                    PharmHeader.Insert();

                    //"Dispatch To":="Dispatch To";

                    Rec."Waiting At" := Rec."Waiting At";
                    Rec.Modify();
                    if Confirm('The Prescription has been sent to pharmacy,Do you want to open the issue form?', true) then
                        page.Run(Page::"HMS Pharmacy Header", PharmHeader);
                    //Message('The Prescription has been sent to the Pharmacy for Issuance');
                    // end;

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PatientName := '';
        if Patient.GET(Rec."Patient No.") then
            PatientName := Patient.Surname + ' ' + Patient."Last Name";
    end;

    trigger OnInit()
    begin
        /*
        "Off Duty CommentsEnable" := true;
        "Light Duty DaysEnable" := true;
        "Off Duty DaysEnable" := true;
        */
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Direct := true;
        Rec."Treatment Type" := Rec."Treatment Type"::Outpatient;
        // "Doctor ID":=USERID;
    end;

    var
        Admission: Record "HMS Admission Form Header";
        Appointment: Record "HMS Appointment Form Header";
        Observation: Record "HMS Observation Form Header";
        ObservationRec: Record "HMS Observation Form Header";
        Patient: Record "HMS Patient";
        PhysioHeader: Record "HMS Physiotherapy Form Header";
        HMSSetup: Record "HMS Setup";
        Doctor: Record "HMS Setup Doctor";
        TreatmentHeader: Record "HMS Treatment Form Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        [InDataSet]
        "Light Duty DaysEnable": Boolean;
        [InDataSet]
        "Off Duty CommentsEnable": Boolean;
        [InDataSet]
        "Off Duty DaysEnable": Boolean;
        NewNo: Code[20];
        DoctorName: Text[30];
        PatientName: Text[100];

    procedure GetPatientNo(var PatientNo: Code[20]; var "Student No.": Code[20]; var "Employee No.": Code[20]; var "Relative No.": Integer)
    begin
        Patient.RESET();
        if Patient.GET(PatientNo) then begin
            "Student No." := Patient."Student No.";
            "Employee No." := Patient."Employee No.";
            //  "Relative No.":=Patient."Relative No.";
        end;
    end;

    procedure GetDoctorName(var DoctorID: Code[20]; var DoctorName: Text[30])
    begin
        Doctor.RESET();
        DoctorName := '';
        if Doctor.GET(DoctorID) then
            //Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DoctorName := Doctor."Doctors Name";
    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin

        Patient.RESET();
        PatientName := '';
        if Patient.GET(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
        GetDoctorName(Rec."Doctor ID", DoctorName);
    end;
}
