page 52202689 "HMS Physio Form Header-Closed"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "HMS Physiotheraphy Form Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Link No."; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';
                    trigger OnValidate()
                    begin
                        if Rec.Type = Rec.Type::Appointment then
                            GetAppointmentDetails();
                    end;
                }
                field("Physio Date"; Rec."Physio Date")
                {
                    ToolTip = 'Specifies the value of the Physio Date field.';
                }
                field("Physio Time"; Rec."Physio Time")
                {
                    ToolTip = 'Specifies the value of the Physio Time field.';
                }
                field("Physio User ID"; Rec."Physio User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Physio User ID field.';
                }
                field("Physio Remarks"; Rec."Physio Remarks")
                {
                    ToolTip = 'Specifies the value of the Physio Remarks field.';
                }
                field(InPatient; Rec.InPatient)
                {
                    ToolTip = 'Specifies the value of the InPatient field.';
                }
                field(Closed; Rec.Closed)
                {
                    Caption = 'Released';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Released field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("ADM No"; Rec."ADM No")
                {
                    ToolTip = 'Specifies the value of the ADM No field.';
                }
                field("""Surname Name""+' '+""Last Name"""; Rec."Surname Name" + ' ' + Rec."Last Name")
                {
                    Caption = 'Names';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field("Next Appointment Date"; Rec."Next Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Next Appointment Date field.';
                }
                field("Daily Activities"; Rec."Daily Activities")
                {
                    ToolTip = 'Specifies the value of the Daily Activities field.';
                }
                field(Examination; Rec.Examination)
                {
                    ToolTip = 'Specifies the value of the Examination field.';
                }
                field("Assesment/Findings"; Rec."Assesment/Findings")
                {
                    ToolTip = 'Specifies the value of the Assesment/Findings field.';
                }
                field("Physio DX"; Rec."Physio DX")
                {
                    ToolTip = 'Specifies the value of the Physio DX field.';
                }
                field("Goals/Aim"; Rec."Goals/Aim")
                {
                    ToolTip = 'Specifies the value of the Goals/Aim field.';
                }
                field("Means of RX"; Rec."Means of RX")
                {
                    ToolTip = 'Specifies the value of the Means of RX field.';
                }
                field("Frequency/Duration"; Rec."Frequency/Duration")
                {
                    ToolTip = 'Specifies the value of the Frequency/Duration field.';
                }
            }
            group("Vital Signs")
            {
                Caption = 'Vital Signs';
                part(Control20; "HMS Observation Form Proc")
                {
                    SubPageLink = "Observation No." = FIELD("No.");
                }
            }
            group(History)
            {
                Caption = 'History';
                part(Control21; "HMS Treatment History")
                {
                    SubPageLink = "Treatment No." = FIELD("No.");
                }
            }
            group(Diagnosis)
            {
                Caption = 'Diagnosis';
                part(Control1102760004; "HMS Physio Form Process")
                {
                    SubPageLink = "No." = FIELD("No.");
                }
            }
            group(Treatment)
            {
                Caption = 'Treatment';
                part(Control5; "HMS Treatment Form Drug")
                {
                    SubPageLink = "Treatment No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Dispatch To Doctor")
                {
                    Caption = 'Dispatch To Doctor';
                    Image = ReleaseDoc;
                    Promoted = true;
                    ToolTip = 'Executes the Dispatch To Doctor action.';

                    trigger OnAction()
                    begin
                        if Confirm('Dispatch selected Appointment to Doctor?', false) = false then
                            exit;
                        if Confirm('Dispatch selected Appointment to Doctor?') then begin
                            HMSSetup.Reset();
                            HMSSetup.Get();
                            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
                            docHeader.Init();
                            docHeader."Treatment No." := NewNo;
                            docHeader."Treatment Date" := Today;
                            docHeader."Treatment Time" := Time;
                            // docHeader."Doctor ID":=Doctor;
                            docHeader."Patient No." := Rec."Patient No.";
                            docHeader."Student No." := Rec."Student No.";
                            docHeader."Employee No." := Rec."Employee No.";
                            docHeader."Relative No." := Rec."Relative No.";
                            docHeader.Direct := true;
                            docHeader."Link No." := Rec."Link No.";
                            //:=LabHeader."Request Area"::Doctor;
                            docHeader."Link Type" := 'Outpatient';
                            //      docHeader."Link No.":=TreatmentHeader."Appointment No.";
                            docHeader.Insert();

                            Rec.Completed := true;
                            Rec.Status := Rec.Status::Closed;
                            Rec.Closed := true;

                            Rec.Modify();
                            Message('Selected Appointment has been dispatched to the Doctor.')
                        end;
                    end;
                }
                action("Dispatch To Observation")
                {
                    Caption = 'Dispatch To Observation';
                    Image = ReleaseDoc;
                    ToolTip = 'Executes the Dispatch To Observation action.';

                    trigger OnAction()
                    begin
                        if Confirm('Dispatch selected Appointment to Physiotheraphy?', false) = false then
                            exit;

                        HMSSetup.Reset();
                        HMSSetup.Get();
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);
                        PhysioHeader."Observation No." := NewNo;
                        PhysioHeader."Observation Date" := Today;
                        PhysioHeader."Observation Time" := Time;
                        PhysioHeader."Patient No." := Rec."Patient No.";
                        PhysioHeader."Student No." := Rec."Student No.";
                        PhysioHeader."Employee No." := Rec."Employee No.";
                        PhysioHeader."Relative No." := Rec."Relative No.";
                        //:=LabHeader."Request Area"::Doctor;
                        PhysioHeader."Link Type" := 'Observation';
                        PhysioHeader."Link No." := Rec."Link No.";
                        PhysioHeader.Insert();

                        Rec.Completed := true;
                        Rec.Status := Rec.Status::Closed;
                        Rec.Closed := true;

                        Rec.Modify();
                        Message('Selected Appointment has been dispatched to the Physiotheraphy Room.')
                    end;
                }
                action("Dispatch To Lab")
                {
                    Caption = 'Dispatch To Lab';
                    Image = ReleaseDoc;
                    ToolTip = 'Executes the Dispatch To Lab action.';

                    trigger OnAction()
                    begin
                        if Confirm('Send Laboratory Test Request Now?', false) = true then begin
                            HMSSetup.Reset();
                            HMSSetup.Get();
                            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Lab Test Request Nos", 0D, true);
                            LabHeader.Reset();
                            LabHeader.Init();
                            LabHeader."Laboratory No." := NewNo;
                            LabHeader."Laboratory Date" := Today;
                            LabHeader."Laboratory Time" := Time;
                            LabHeader."Patient No." := Rec."Patient No.";
                            LabHeader."Student No." := Rec."Student No.";
                            LabHeader."Employee No." := Rec."Employee No.";
                            LabHeader."Relative No." := Rec."Relative No.";
                            LabHeader."Request Area" := LabHeader."Request Area"::Doctor;
                            LabHeader."Link Type" := 'Appointment';
                            LabHeader."Link No." := Rec."Link No.";
                            LabHeader.Insert();

                            Rec.Completed := true;
                            Rec.Status := Rec.Status::Closed;
                            Rec.Closed := true;

                            Rec.Modify();
                        end;
                    end;
                }
                action("&Release Observation")
                {
                    Caption = '&Release Observation';
                    ToolTip = 'Executes the &Release Observation action.';

                    trigger OnAction()
                    begin
                        /*Allow the user to release the document*/
                        Rec.Closed := true;
                        Rec.Status := Rec.Status::Pending;
                        Rec.Modify();
                        Message('Observation Record Released');
                    end;
                }
                action("&Reopen Observation")
                {
                    Caption = '&Reopen Observation';
                    ToolTip = 'Executes the &Reopen Observation action.';

                    trigger OnAction()
                    begin
                        /*Allow the user to reopen the record*/
                        if (Rec.Closed = true) then begin
                            Rec.Closed := false;
                            Rec.Modify();
                            Message('Observation Record Reopened');
                        end;
                    end;
                }
                separator(Separator1102760013)
                {
                }
                action("Mark as Completed")
                {
                    Caption = 'Mark as Completed';
                    ToolTip = 'Executes the Mark as Completed action.';

                    trigger OnAction()
                    begin
                        if Confirm('Mark the Observation as Completed?', false) = false then
                            exit;
                        Rec.Completed := true;
                        Rec.Status := Rec.Status::Closed;
                        Rec.Closed := true;
                        Rec.Modify();
                        Message('The Observation record has been marked as completed');
                    end;
                }
                action("Charges Lines")
                {
                    Image = Invoice;
                    Promoted = true;
                    RunObject = Page "HMS Patient Charges";
                    RunPageLink = "Patient No." = FIELD("Patient No."),
                                  "Link No" = FIELD("No.");
                    ToolTip = 'Executes the Charges Lines action.';
                }
            }
            action(Prescriptions)
            {
                Image = ProdBOMMatrixPerVersion;
                RunObject = Page "HMS Admission Form Drug";
                RunPageLink = "Admission No." = FIELD("No.");
                ToolTip = 'Executes the Prescriptions action.';
            }
            action(PostedPrescriptions)
            {
                Caption = 'Posted Prescriptions';
                Image = PostedDeposit;
                RunObject = Page "HMS Posted Admission Form Drug";
                RunPageLink = "Admission No." = FIELD("No.");
                ToolTip = 'Executes the Posted Prescriptions action.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
        Rec.CalcFields("Surname Name");
        Rec.CalcFields("Last Name");
        Rec."Physio User ID" := UserId;
    end;

    var
        Appointment: Record "HMS Appointment Form Header";
        LabHeader: Record "HMS Laboratory Form Header";
        PhysioHeader: Record "HMS Observation Form Header";
        Patient: Record "HMS Patient";
        HMSSetup: Record "HMS Setup";
        docHeader: Record "HMS Treatment Form Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        PatientName: Text[100];

    procedure GetAppointmentDetails()
    begin
        /*Get the appointment details from the database*/
        Appointment.Reset();
        if Appointment.Get(Rec."Link No.") then begin
            Rec."Patient No." := Appointment."Patient No.";
            Rec."Student No." := Appointment."Student No.";
            Rec."Employee No." := Appointment."Employee No.";
            Rec."Relative No." := Appointment."Relative No.";
            Rec."Link Type" := 'Appointment';
            GetPatientName(Rec."Patient No.", PatientName);
        end;
    end;

    procedure GetVisitDetails()
    begin
    end;

    procedure GetAdmissionDetails()
    begin
    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset();
        PatientName := '';
        if Patient.Get(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    procedure GetUserName()
    begin
        /*
        User.RESET;
        IF User.GET("Observation User ID") THEN
          BEGIN
          //  ObservationUserIDName:=User."User Name";
          END;
         */
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        //VALIDATE("Patient No.");
        GetPatientName(Rec."Patient No.", PatientName);
        GetUserName();
    end;
}
