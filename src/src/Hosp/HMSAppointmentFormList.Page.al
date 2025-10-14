page 52203050 "HMS Appointment Form List"
{
    CardPageID = "HMS Appointment Form Header";
    PageType = List;
    SourceTable = "HMS Appointment Form Header";
    // SourceTableView = where(Status = const(New));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Appointment No."; Rec."Appointment No.")
                {
                    ToolTip = 'Specifies the value of the Appointment No. field.';
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Appointment Date field.';
                }
                field("Appointment Time"; Rec."Appointment Time")
                {
                    ToolTip = 'Specifies the value of the Appointment Time field.';
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                    ToolTip = 'Specifies the value of the Appointment Type field.';

                    /* trigger OnValidate()
                    begin
                        GetAppointmentTypeName(AppointmentTypeName, Rec."Appointment Type");
                    end; */
                }
                field(AppointmentTypeName; AppointmentTypeName)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ToolTip = 'Specifies the value of the Patient Type field.';

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';

                    /* trigger OnValidate()
                    begin
                        Rec.GetPatientName(Rec."Patient No.");
                        Rec.GetPatientNo(Rec."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                        GetAppointmentStats(Rec."Patient No.");
                    end; */
                }
                field(PatientName; PatientName)
                {
                    Caption = 'Patient';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ToolTip = 'Specifies the value of the Doctor field.';

                    trigger OnValidate()
                    begin
                        Rec.GetDoctorName(Rec.Doctor);
                    end;
                }
                field(DoctorName; DoctorName)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(IntScheduled; IntScheduled)
                {
                    Caption = 'No. of appointments scheduled';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. of appointments scheduled field.';
                }
                field(IntCompleted; IntCompleted)
                {
                    Caption = 'No. of appointments completed';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. of appointments completed field.';
                }
                field(IntRescheduled; IntRescheduled)
                {
                    Caption = 'No. of appointments rescheduled';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. of appointments rescheduled field.';
                }
                field(IntCancelled; IntCancelled)
                {
                    Caption = 'No. of appointments cancelled';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. of appointments cancelled field.';
                }
            }
        }
    }

    /* actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Dispatch To Observation Room")
                {
                    Caption = 'Dispatch To Triage Room';
                    Image = ExecuteAndPostBatch;
                    Promoted = true;
                    ToolTip = 'Executes the Dispatch To Triage Room action.';

                    trigger OnAction()
                    var
                        HMSProcesses: Codeunit "HMS Processes";
                    begin
                        if CONFIRM('Dispatch selected Appointment to Triage?', false) then begin

                            HMSProcesses.FnDispatchToTriage(Rec);

                            MESSAGE('Selected Appointment has been dispatched to Triage')
                        end;
                    end;
                }
            }
        }
    } */

    var
        AppointmentTypeName: Text[100];
        PatientName: Text[100];
        DoctorName: Text[100];
        IntScheduled: Integer;
        IntCompleted: Integer;
        IntRescheduled: Integer;
        IntCancelled: Integer;
        LastDate: Date;
        LastTime: Time;
        LastAppointmentType: Code[20];
        LastAppointmentDoctor: Code[20];
        Age: Text[100];
        HMSProcesses: Codeunit "HMS Processes";


/* 
    procedure GetAppointmentTypeName(var AppointmentTypeName: Text[100]; var AppointmentTypeCode: Code[20])
    var
        AppType: Record "HMS Setup Appointment Type";
    begin
        AppType.reset();
        if AppType.GET(AppointmentTypeCode) then begin AppointmentTypeName := AppType.Description end;
    end;

    procedure GetPatientNo(var PatientNo: Code[20]; var StudentNo: Code[20]; var EmployeeNo: Code[20]; var RelativeNo: Integer)
    var
        Patient: Record "HMS Patient";
    begin
        Patient.reset();
        if Patient.GET(PatientNo) then begin
            StudentNo := Patient.Test;
            EmployeeNo := Patient."Employee No.";
            //    RelativeNo:=Patient."Relative No.";
        end;
    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    var
        Patient: Record "HMS Patient";
    begin
        Patient.reset();
        if Patient.GET(PatientNo) then begin
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + Patient."Last Name";
        end;
    end;

    procedure GetPatientAge(var PatientNo: Code[20]; var Age: Text[100])
    var
        HRDates: Codeunit "HR Dates";
        Patient: Record "HMS Patient";
    begin
        Patient.reset();
        if Patient.GET(PatientNo) then begin
            if Patient."Date Of Birth" = 0D then begin
                Age := '';
            end
            ELSE begin
                Age := HRDates.DetermineAge(Patient."Date Of Birth", TODAY);
            end;
        end;
    end;

    procedure GetDoctorName(var DoctorCode: Code[20]; var DoctorName: Text[100])
    var
        Doctor: Record "HMS Setup Doctor";
    begin
        Doctor.reset();
        if Doctor.GET(DoctorCode) then begin
            // Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DoctorName := Doctor."Doctors Name";
        end;
    end;

    procedure GetAppointmentStats(var PatientNo: Code[20])
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset();
        if Patient.GET(PatientNo) then begin
            Patient.CALCFIELDS(Patient."Appointments Scheduled", Patient."Appointments Completed", Patient."Appointments Rescheduled");
            IntScheduled := Patient."Appointments Scheduled";
            IntCompleted := Patient."Appointments Completed";
            IntRescheduled := Patient."Appointments Rescheduled";
            Patient.CALCFIELDS(Patient."Appointments Cancelled");
            IntCancelled := Patient."Appointments Cancelled";
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetAppointmentTypeName(AppointmentTypeName, Rec."Appointment Type");
        Rec.GetDoctorName(Rec.Doctor);
        Rec.GetPatientNo(Rec."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
        Rec.GetPatientName(Rec."Patient No.");
        Rec.GetPatientAge(Rec."Patient No.", Age);
        GetAppointmentStats(Rec."Patient No.");
    end; */
}

