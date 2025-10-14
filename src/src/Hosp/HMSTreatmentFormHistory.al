page 52202914 "HMS Treatment Form History"
{
    Editable = false;
    PageType = Document;
    SourceTable = "HMS Treatment Form Header";
    SourceTableView = WHERE(Status = filter(<> TreatmentStatus::New));

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
                    ToolTip = 'Specifies the value of the Treatment No. field.';
                }
                field("Treatment Type"; Rec."Treatment Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Treatment Type field.';
                }
                field("Link No."; Rec."Link No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Link No. field.';
                    trigger OnValidate()
                    begin
                        if Rec."Treatment Type" = Rec."Treatment Type"::Inpatient then begin
                            Observation.Reset();
                            if Observation.Get(Rec."Link No.") then begin
                                Rec."Patient No." := Observation."Patient No.";
                                GetPatientNo(Observation."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                                Rec."Link Type" := 'Observation';
                            end;
                        end
                        else begin
                            Admission.Reset();
                            if Admission.Get(Rec."Link No.") then begin
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
                field(DoctorName; DoctorName)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(PatientName; PatientName)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(Control1102760002)
            {
                Caption = 'Processes';
                part(Control1102760003; "HMS Treatment Form Processes")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
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
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
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
            group(Control1904500401)
            {
                Caption = 'Injections';
                part(Control1102760008; "HMS Treatment Form Injection")
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
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
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
            group(Control1906819501)
            {
                Caption = 'Referrals';
                part(Control1102760016; "HMS Treatment Form Referral")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("&Treatment Details")
            {
                Caption = '&Treatment Details';
                Image = Ledger;
                action(Processes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Processes';
                    Image = Production;
                    Promoted = true;
                    RunObject = Page "HMS Treatment Form Processes";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Processes action.';
                }
                action(Signs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Signs';
                    Image = RegisteredDocs;
                    Promoted = true;
                    RunObject = Page "HMS Observation Signs";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Signs action.';
                }
                action(Symptoms)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Symptoms';
                    Image = RegisterPick;
                    Promoted = true;
                    RunObject = Page "HMS Observation Symptoms";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Symptoms action.';
                }
                action("Laboratory Needs")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Laboratory Needs';
                    Image = TestFile;
                    Promoted = true;
                    RunObject = Page "HMS Treatment Form Laboratory";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Laboratory Needs action.';
                }
                action("Radiology Needs")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Radiology Needs';
                    Image = ReleaseShipment;
                    Promoted = true;
                    RunObject = Page "HMS Treatment Form Radiology";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Radiology Needs action.';
                }
                action(Diagmnosis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagmnosis';
                    Image = AnalysisView;
                    Promoted = true;
                    RunObject = Page "HMS Treatment Form Diagnosis";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Diagmnosis action.';
                }
                action(Injections)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Injections';
                    Image = Reconcile;
                    Promoted = true;
                    RunObject = Page "HMS Treatment Form Injection";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Injections action.';
                }
                action(Prescriptions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Prescriptions';
                    Image = ItemAvailability;
                    Promoted = true;
                    RunObject = Page "HMS Treatment Form Drug";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Prescriptions action.';
                }
                action(Referrals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referrals';
                    Image = Reconcile;
                    Promoted = true;
                    RunObject = Page "HMS Treatment Form Referral";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Referrals action.';
                }
                action(Admissions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admissions';
                    Image = Account;
                    Promoted = true;
                    RunObject = Page "HMS Treatment Form Admission";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Admissions action.';
                }
                action("Referral Progress")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referral Progress';
                    Image = RefreshLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Referral Header Active";
                    RunPageLink = "Treatment no." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Referral Progress action.';
                }
                action("Admission Details")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admission Details';
                    Image = RegisteredDocs;
                    Promoted = true;
                    PromotedCategory = Process;
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
                    PromotedCategory = Process;
                    RunObject = Page "HMS Radiology View Test Header";
                    RunPageLink = "Link Type" = CONST('DOCTOR'),
                                  "Link No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Radiology Results action.';
                }
                action("Laboratory Results")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Laboratory Results';
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Laboratory Form History";
                    RunPageLink = "Link No." = FIELD("Link No.");
                    ToolTip = 'Executes the Laboratory Results action.';

                    trigger OnAction()
                    begin

                        Labrecords.Reset();
                        Labrecords.SetRange(Labrecords."Patient No.", Rec."Patient No.");
                        Labrecords.SetRange(Labrecords.Status, Labrecords.Status::Completed);
                        if Labrecords.Find('-') then begin
                            LabResults.SetTableView(Labrecords);
                            LabResults.Run();
                        end;
                    end;
                }
                action("Observation Room")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Observation Room';
                    Image = Allocations;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Observation Room action.';
                    trigger OnAction()
                    begin
                        ObservationRec.Reset();
                        ObservationRec.SetRange(ObservationRec."Patient No.", Rec."Patient No.");
                        ObservationRec.SetRange(ObservationRec."Observation No.", Rec."Link No.");
                        if ObservationRec.Find('-') then begin
                            ObservationForm.SetTableView(ObservationRec);
                            ObservationForm.Run();
                        end
                        else
                            Message('No Observation details available for this patient!');
                    end;
                }
            }
            group(res)
            {
                Caption = 'Results';
                Image = ReferenceData;
                action(Action29)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referral Progress';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Referral Header Active";
                    RunPageLink = "Treatment no." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Referral Progress action.';
                }
                action(Action28)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admission Details';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Admission Progress";
                    RunPageLink = "Link Type" = CONST('DOCTOR'),
                                  "Link No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Admission Details action.';
                }
                action(Action27)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Radiology Results';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Radiology View Test Header";
                    RunPageLink = "Link Type" = CONST('DOCTOR'),
                                  "Link No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Radiology Results action.';
                }
                action(Action26)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Laboratory Results';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Laboratory View Test";
                    RunPageLink = "Request Area" = CONST(Doctor),
                                  "Link No." = FIELD("Treatment No.");
                    ToolTip = 'Executes the Laboratory Results action.';
                }
                action(Action25)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Observation Room';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Observation Form Header";
                    RunPageLink = "Observation No." = FIELD("Link No.");
                    ToolTip = 'Executes the Observation Room action.';
                }
            }
        }
        area(processing)
        {
            action("Re open")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Re open';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Re open action.';
                trigger OnAction()
                begin
                    /*Ask for confirmation*/
                    if Confirm('Mark the Treatment as open?', false) = false then
                        exit;
                    Rec.TestField("Treatment Date");
                    Rec.Status := Rec.Status::Active;
                    Rec.Modify();

                    ObservationRec.Reset();
                    ObservationRec.SetRange(ObservationRec."Patient No.", Rec."Patient No.");
                    ObservationRec.SetRange(ObservationRec."Observation No.", Rec."Link No.");
                    if ObservationRec.Find('-') then begin
                        ObservationRec.Status := ObservationRec.Status::New;
                        ObservationRec.Modify();
                    end;

                    Message('Treatment Marked as Open');
                end;
            }
            action(Action40)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Referral Progress';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS Referral Header Active";
                RunPageLink = "Treatment no." = FIELD("Treatment No.");
                ToolTip = 'Executes the Referral Progress action.';
            }
            action(Action39)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Admission Details';
                Image = RegisteredDocs;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS Appointment Form Header";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Admission Details action.';
            }
            action(Action38)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Radiology Results';
                Image = ResourceJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS Radiology View Test Header";
                RunPageLink = "Link Type" = CONST('DOCTOR'),
                              "Link No." = FIELD("Treatment No.");
                ToolTip = 'Executes the Radiology Results action.';
            }
            action(Action37)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Laboratory Results';
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS Laboratory Form History";
                RunPageLink = "Link No." = FIELD("Link No.");
                ToolTip = 'Executes the Laboratory Results action.';

                trigger OnAction()
                begin

                    Labrecords.Reset();
                    Labrecords.SetRange(Labrecords."Patient No.", Rec."Patient No.");
                    Labrecords.SetRange(Labrecords.Status, Labrecords.Status::Completed);
                    if Labrecords.Find('-') then begin
                        LabResults.SetTableView(Labrecords);
                        LabResults.Run();
                    end;
                end;
            }
            action(Action36)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Observation Room';
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Observation Room action.';
                trigger OnAction()
                begin
                    ObservationRec.Reset();
                    ObservationRec.SetRange(ObservationRec."Patient No.", Rec."Patient No.");
                    ObservationRec.SetRange(ObservationRec."Observation No.", Rec."Link No.");
                    if ObservationRec.Find('-') then begin
                        ObservationForm.SetTableView(ObservationRec);
                        ObservationForm.Run();
                    end
                    else
                        Message('No Observation details available for this patient!');
                end;
            }
            action("Charges Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient Charges";
                RunPageLink = "Patient No." = FIELD("Patient No."),
                              "Treatment No." = FIELD("Treatment No.");
                ToolTip = 'Executes the Charges Lines action.';
            }
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
               
        }
    }

    var
        Admission: Record "HMS Admission Form Header";
        Labrecords: Record "HMS Laboratory Form Header";
        Observation: Record "HMS Observation Form Header";
        ObservationRec: Record "HMS Observation Form Header";
        Patient: Record "HMS Patient";
        Doctor: Record "HMS Setup Doctor";
        LabResults: Page "HMS Laboratory Form History";
        ObservationForm: Page "HMS Observation Form Header";
        DoctorName: Text[30];
        PatientName: Text[100];

    procedure GetPatientNo(var PatientNo: Code[20]; var "Student No.": Code[20]; var "Employee No.": Code[20]; var "Relative No.": Integer)
    begin
        Patient.Reset();
        if Patient.Get(PatientNo) then begin
            "Student No." := Patient."Student No.";
            "Employee No." := Patient."Employee No.";
            //  "Relative No.":=Patient."Relative No.";
        end;
    end;

    procedure GetDoctorName(var DoctorID: Code[20]; var DoctorName: Text[30])
    begin
        Doctor.Reset();
        DoctorName := '';
        if Doctor.Get(DoctorID) then
            //Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DoctorName := Doctor."Doctors Name";
    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset();
        PatientName := '';
        if Patient.Get(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
        GetDoctorName(Rec."Doctor ID", DoctorName);
    end;
}
