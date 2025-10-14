page 52202866 "HMS Admitted Form Header"
{
    PageType = Card;
    SourceTable = "HMS Admission Form Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("Admission No."; Rec."Admission No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission No. field.';
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Admission Date field.';
                }
                field("Admission Time"; Rec."Admission Time")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Admission Time field.';
                }
                field("Admission Area"; Rec."Admission Area")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Area field.';
                }
                field(Ward; Rec.Ward)
                {
                    ToolTip = 'Specifies the value of the Ward field.';
                }
                field(Bed; Rec.Bed)
                {
                    ToolTip = 'Specifies the value of the Bed field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ToolTip = 'Specifies the value of the Doctor field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(PatientName; PatientName)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field("Admission Reason"; Rec."Admission Reason")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Reason field.';
                }
                field("Admission Type"; Rec."Admission Type")
                {
                    ToolTip = 'Specifies the value of the Admission Type field.';
                }
                field("Admission Height"; Rec."Admission Height")
                {
                    ToolTip = 'Specifies the value of the Admission Height field.';
                }
                field("Admission Weight"; Rec."Admission Weight")
                {
                    ToolTip = 'Specifies the value of the Admission Weight field.';
                }
                field("Admission BMI"; Rec."Admission BMI")
                {
                    ToolTip = 'Specifies the value of the Admission BMI field.';
                }
                field(Control7; Rec."Nurse Notes")
                {
                    MultiLine = true;
                    ShowCaption = false;
                }
            }
            part(Control1102760002; "HMS Admission Lines")
            {
                Editable = false;
                SubPageLink = "Patient No." = FIELD("Patient No."),
                              Status = FILTER(Discharged);
            }
        }
    }

    actions
    {
        area(processing)
        {
            separator(Separator25)
            {
            }
            action("Treatment History")
            {
                Image = History;
                Promoted = true;
                RunObject = Page "HMS Treatment History List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Treatment History action.';
            }
            separator(Separator23)
            {
            }
            action(Charges)
            {
                Image = Accounts;
                Promoted = true;
                RunObject = Page "HMS Patient Charges List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Charges action.';
            }
            separator(Separator29)
            {
            }
            action("Bed Transfer")
            {
                Image = TransferToLines;
                RunObject = Page "HMS Beds Transfer";
                RunPageLink = "Admission No." = FIELD("Admission No.");
                ToolTip = 'Executes the Bed Transfer action.';
            }
            group("Nurse Activities")
            {
                separator(Separator28)
                {
                }
                action("Nurse Notes")
                {
                    Image = Comment;
                    Promoted = true;
                    ToolTip = 'Executes the Nurse Notes action.';

                    trigger OnAction()
                    begin
                        //HMS Admission Nurse Notes
                        AdmissionNurseNotes.Reset();
                        AdmissionNurseNotes.SetRange(AdmissionNurseNotes."Admission No.", Rec."Admission No.");
                        AdmissionNurseNotes.SetRange(AdmissionNurseNotes."Nurse ID", UserId);
                        if AdmissionNurseNotes.Find('-') then
                            PAGE.Run(70135179, AdmissionNurseNotes)
                        else begin
                            AdmissionNurseNotes.Init();
                            AdmissionNurseNotes."Admission No." := Rec."Admission No.";
                            AdmissionNurseNotes."Notes Date" := Today;
                            AdmissionNurseNotes."Notes Time" := Time;
                            AdmissionNurseNotes."Nurse ID" := UserId;
                            AdmissionNurseNotes.Insert();
                            PAGE.Run(70135179, AdmissionNurseNotes)
                        end;
                    end;
                }
                action("Daily Process/Procedures")
                {
                    Image = Comment;
                    RunObject = Page "HMS Admission Form Process";
                    RunPageLink = "Admission No." = FIELD("Admission No.");
                    ToolTip = 'Executes the Daily Process/Procedures action.';
                }
                action(Injections)
                {
                    Image = Comment;
                    RunObject = Page "HMS Admission Injection";
                    RunPageLink = "Admission No." = FIELD("Admission No.");
                    ToolTip = 'Executes the Injections action.';
                }
                action(Prescriptions)
                {
                    Image = Comment;
                    RunObject = Page "HMS Admission Form Drug";
                    RunPageLink = "Admission No." = FIELD("Admission No.");
                    ToolTip = 'Executes the Prescriptions action.';
                }
                action("Treatment Sheet")
                {
                    Image = Comment;
                    RunObject = Page "HMS Admission Drug Nurse";
                    RunPageLink = "Admission No." = FIELD("Admission No.");
                    ToolTip = 'Executes the Treatment Sheet action.';
                }
                action("General Observation")
                {
                    Image = Comment;
                    RunObject = Page "HMS General Observation";
                    RunPageLink = "Patient No" = FIELD("Patient No."),
                                  "Admission No" = FIELD("Admission No.");
                    ToolTip = 'Executes the General Observation action.';
                }
            }
            group(ICU)
            {
                separator(Separator36)
                {
                }
                action("Hourly Observation")
                {
                    Image = AddWatch;
                    RunObject = Page "HMS ICU Observations";
                    RunPageLink = "Admission No" = FIELD("Admission No.");
                    ToolTip = 'Executes the Hourly Observation action.';
                }
                action("Hourly Observation Chart")
                {
                    Image = ChartOfAccounts;
                    RunObject = Page "HMS ICU Observation Chart";
                    RunPageLink = "Admission No" = FIELD("Admission No.");
                    ToolTip = 'Executes the Hourly Observation Chart action.';
                }
                separator(Separator33)
                {
                }
                action("Print Observation Chart")
                {
                    Image = AnalysisView;
                    ToolTip = 'Executes the Print Observation Chart action.';

                    trigger OnAction()
                    begin
                        ICUOb.Reset();
                        ICUOb.SetRange(ICU, true);
                        ICUOb.SetFilter(ICUOb."Admission No", Rec."Admission No.");
                        ICUOb.SetFilter("ICU Category", '%1', 0);
                        if ICUOb.Find('-') then
                            REPORT.Run(70135151, true, true, ICUOb);
                    end;
                }
            }
            group(Reports)
            {
                action("General Observation Chart")
                {
                    Image = "Report";
                    ToolTip = 'Executes the General Observation Chart action.';

                    trigger OnAction()
                    begin
                        AdmRec.Reset();
                        AdmRec.SetFilter(AdmRec."Admission No.", Rec."Admission No.");
                        AdmRec.SetFilter(AdmRec."Patient No.", Rec."Patient No.");
                        if AdmRec.Find('-') then
                            REPORT.Run(70135142, true, true, AdmRec);
                    end;
                }
            }
        }
    }

    var
        AdmRec: Record "HMS Admission Form Header";
        AdmissionNurseNotes: Record "HMS Admission Form Nurse";
        ICUOb: Record "HMS General Observation";
        Patient: Record "HMS Patient";
        PatientName: Text[100];

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
    end;
}
