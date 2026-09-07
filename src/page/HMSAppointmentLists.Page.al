
using System.Security.User;
page 85318 "HMS Appointment Lists"
{
    CardPageID = "HMS Appointment Form Header";
    DataCaptionFields = "Appointment No.", "Appointment Date";
    PageType = List;
    SourceTable = "HMS Appointment Form Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appointment No."; Rec."Appointment No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(SearchNames; Rec.SearchNames)
                {
                    Editable = false;
                }
                field(Branch; Rec.Branch)
                {
                    Editable = false;
                }
                field("Appointment Time"; Rec."Appointment Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ReAppointment No."; Rec."ReAppointment No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ReAppointment Date"; Rec."ReAppointment Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ReAppointment Time"; Rec."ReAppointment Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ReAppointment Type Code"; Rec."ReAppointment Type Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ReAppointment Doctor ID"; Rec."ReAppointment Doctor ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Treatment Status"; Rec."Treatment Status")
                {
                    ApplicationArea = Basic, Suite;
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
                action("Dispatch To Observation Room")
                {
                    Caption = 'Dispatch To Observation Room';

                    trigger OnAction()
                    begin
                        IF CONFIRM('Dispatch selected Appoiintment to Observation?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Rec."Dispatch To" := Rec."Dispatch To";
                        Rec."Dispatch Date" := TODAY;
                        Rec."Dispatch Time" := TIME;
                       Rec. MODIFY;
                        MESSAGE('Selected Appointment has been dispatched to the Observation Room.')
                    end;
                }
                action("Dispatch To Doctor")
                {
                    Caption = 'Dispatch To Doctor';

                    trigger OnAction()
                    begin
                        IF CONFIRM('Dispatch selected Appoiintment to Doctor?', FALSE) = FALSE THEN BEGIN EXIT END;
                       Rec."Dispatch To" := Rec."Dispatch To";
                        Rec."Dispatch Date" := TODAY;
                        Rec."Dispatch Time" := TIME;
                       Rec. MODIFY;
                        MESSAGE('Selected Appointment has been dispatched to the Doctor.')
                    end;
                }
                separator(Separator16)
                {
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        if UserRec.get(Database.UserId) then begin
            if userrec."Branch Code" <> '' then
               Rec.setfilter(Branch, UserRec."Branch Code");
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        objPAtient.RESET;
        objPAtient.SETRANGE(objPAtient."Patient No.", Rec."Patient No.");
        IF objPAtient.FIND('-') THEN BEGIN
            strNames := objPAtient.Surname + ' ' + objPAtient."Middle Name" + ' ' + objPAtient."Last Name";
        END;
    end;

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
        [InDataSet]
        "Employee No.Visible": Boolean;
        [InDataSet]
        "Relative No.Visible": Boolean;
        [InDataSet]
        "Student No.Enable": Boolean;
        [InDataSet]
        "Employee No.Enable": Boolean;
        [InDataSet]
        "Relative No.Enable": Boolean;
        objPAtient: Record "HMS Patient";
        strNames: Text;

    procedure CheckPatientType()
    begin
        IF Rec."Patient Type" = Rec."Patient Type"::Corporate THEN BEGIN
            "Student No.Enable" := FALSE;
            "Employee No.Enable" := FALSE;
            "Relative No.Enable" := FALSE;
            "Employee No.Visible" := FALSE;
            "Relative No.Visible" := FALSE;
        END
        ELSE BEGIN
            "Student No.Enable" := FALSE;
            "Employee No.Enable" := FALSE;
            "Relative No.Enable" := FALSE;
            "Employee No.Visible" := TRUE;
            "Relative No.Visible" := TRUE;

        END;
    end;

    procedure GetAppointmentTypeName(var AppointmentTypeName: Text[100]; var AppointmentTypeCode: Code[20])
    var
        AppType: Record "HMS Setup Appointment Type";
    begin
        AppType.RESET;
        IF AppType.GET(AppointmentTypeCode) THEN BEGIN AppointmentTypeName := AppType.Description END;
    end;

    procedure GetPatientNo(var PatientNo: Code[20]; var StudentNo: Code[20]; var EmployeeNo: Code[20]; var RelativeNo: Integer)
    var
        Patient: Record "HMS Patient";
    begin
    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    var
        Patient: Record "HMS Patient";
    begin
        Patient.RESET;
        IF Patient.GET(PatientNo) THEN BEGIN
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + Patient."Last Name";
        END;
    end;

    procedure GetPatientAge(var PatientNo: Code[20]; var Age: Text[100])
    var
        HRDates: Codeunit "HR Dates";
        Patient: Record "HMS Patient";
    begin
        Patient.RESET;
        IF Patient.GET(PatientNo) THEN BEGIN
            IF Patient."Date Of Birth" = 0D THEN BEGIN
                Age := '';
            END
            ELSE BEGIN
                Age := HRDates.DetermineAge(Patient."Date Of Birth", TODAY);
            END;
        END;
    end;

    procedure GetDoctorName(var DoctorCode: Code[20]; var DoctorName: Text[100])
    var
        Doctor: Record "HMS Setup Doctor";
    begin
        Doctor.RESET;
        IF Doctor.GET(DoctorCode) THEN BEGIN
            // Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DoctorName := Doctor."Doctors Name";
        END;
    end;

    procedure GetAppointmentStats(var PatientNo: Code[20])
    var
        Patient: Record "HMS Patient";
    begin
        Patient.RESET;
        IF Patient.GET(PatientNo) THEN BEGIN
            Patient.CALCFIELDS(Patient."Appointments Scheduled", Patient."Appointments Completed", Patient."Appointments Rescheduled");
            IntScheduled := Patient."Appointments Scheduled";
            IntCompleted := Patient."Appointments Completed";
            IntRescheduled := Patient."Appointments Rescheduled";
            Patient.CALCFIELDS(Patient."Appointments Cancelled");
            IntCancelled := Patient."Appointments Cancelled";
        END;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        GetAppointmentTypeName(AppointmentTypeName, xRec."Appointment Type");
        //GetDoctorName(Doctor,DoctorName);
        GetPatientNo(xRec."Patient No.", xRec."Student No.", xRec."Employee No.", xRec."Relative No.");
        //GetPatientName("Patient No.",PatientName);
        GetPatientAge(xRec."Patient No.", Age);
        GetAppointmentStats(xRec."Patient No.");
    end;
}

