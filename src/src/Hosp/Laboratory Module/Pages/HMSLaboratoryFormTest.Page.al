page 52202885 "HMS Laboratory Form Test"
{
    PageType = Document;
    SourceTable = "HMS Laboratory Form Header";

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("Laboratory No."; Rec."Laboratory No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Lab. Reference No."; Rec."Lab. Reference No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Lab. Reference No. field.';
                }
                field("Cash Sale"; Rec."Cash Sale")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cash Sale field.';
                }
                field("Laboratory Date"; Rec."Laboratory Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Laboratory Date';
                    ToolTip = 'Specifies the value of the Laboratory Date field.';
                }
                field("Laboratory Time"; Rec."Laboratory Time")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Laboratory Time';
                    ToolTip = 'Specifies the value of the Laboratory Time field.';
                }
                field("Request Area"; Rec."Request Area")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Request Area field.';
                }
                field("Link No."; Rec."Link No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Link No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Link No. field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field("ADM No."; Rec."ADM No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the ADM No. field.';
                }
                field("Memeber No"; Rec."Memeber No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Memeber No field.';
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Scheduled Date field.';
                }
                field("Scheduled Time"; Rec."Scheduled Time")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Scheduled Time field.';
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Supervisor ID field.';

                    trigger OnValidate()
                    begin
                        GetSupervisorName(Rec."Supervisor ID", SupervisorName);
                    end;
                }
                field(SupervisorName; SupervisorName)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field(PatientName; PatientName)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Patient Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Settlement Type field.';
                }
                field("Employee No.1"; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Relative No.1"; Rec."Relative No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Relative No. field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Samples Collected"; Rec."Samples Collected")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Samples Collected field.', Comment = '%';
                    Editable = false;
                }

            }
            group("Laboratory Test Findings")
            {
                Caption = 'Laboratory Test Findings';
                part(Control1000000000; "HMS Labaratory Test Line")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Laboratory No." = FIELD("Laboratory No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Register Item Usage")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Register Item Usage';
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "HMS Laboratory Item Header";
                RunPageLink = "Laboratory No." = FIELD("Laboratory No.");
                ToolTip = 'Executes the Register Item Usage action.';
            }
            action("&Mark as Completed")
            {
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                Caption = '&Mark as Completed';
                ToolTip = 'Executes the &Mark as Completed action.';
                trigger OnAction()
                begin
                    if Confirm('Mark the Laboratory Test as Completed?', false) = false then
                        exit;

                    HMSProcess.FnMarkLabRequestasCompleted(Rec);
                end;
            }
            action("Charges Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient Charges";
                RunPageLink = "Patient No." = FIELD("Patient No."),
                              "Link No" = FIELD("Laboratory No.");
                ToolTip = 'Executes the Charges Lines action.';
            }
            separator(Separator7)
            {
            }
            action("Dispatch To Doctor")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Dispatch To Doctor';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Dispatch To Doctor action.';
                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    if Confirm('Dispatch selected Appointment to Doctor?', false) = false then
                        exit;
                    CuHMSProcesses.FnLaboratoryDispatchToDoctor(Rec);
                end;
            }
            action(PreviewResults)
            {
                Image = ResetStatus;
                Promoted = true;
                ToolTip = 'Executes the Print Results action.';
                trigger OnAction()
                var
                    HMSLaboratoryResultsEntry: Record "HMS Laboratory Results Entry";
                    LabReport: Report "HMS Lab Results2";
                begin
                    HMSLaboratoryResultsEntry.SetFilter(HMSLaboratoryResultsEntry."Laboratory No.", Rec."Laboratory No.");
                    if HMSLaboratoryResultsEntry.Find('-') then
                        LabReport.SetTableView(HMSLaboratoryResultsEntry);
                    LabReport.Run();
                end;
            }
        }
    }

    var
        HSMApp: Record "HMS Appointment Form Header";
        LabLine: Record "HMS Laboratory Test Line";
        Patient: Record "HMS Patient";
        HMSSetup: Record "HMS Setup";
        docHeader: Record "HMS Treatment Form Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HMSProcess: Codeunit "HMS Processes";
        blnCompleted: Boolean;
        NewNo: Code[20];
        PatientName: Text[100];
        SupervisorName: Text[100];

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset();
        PatientName := '';
        if Patient.Get(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    procedure GetSupervisorName(var "User ID": Code[20]; var SupervisorName: Text[100])
    begin
        /*
        User.RESET;
        SupervisorName:='';
        IF User.GET("User ID") THEN
          BEGIN
            SupervisorName:=User."User Name";
          END;
         */
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
        GetSupervisorName(Rec."Supervisor ID", SupervisorName);
    end;
}
