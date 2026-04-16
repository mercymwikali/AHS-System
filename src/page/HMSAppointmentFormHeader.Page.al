#pragma implicitwith disable
page 85312 "HMS Appointment Form Header"
{
    PageType = Document;
    SourceTable = "HMS Appointment Form Header";
    Caption = 'Check In Card';
    // InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("Appointment No."; Rec."Appointment No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appointment No. field.';
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    Caption = 'Check-In Date';
                    ApplicationArea = Basic, Suite;
                    // Editable = false;
                    ToolTip = 'Specifies the value of the Check-In Date field.';
                }
                field("Appointment Time"; Rec."Appointment Time")
                {
                    Caption = 'Check-In Time';
                    ApplicationArea = Basic, Suite;
                    // Editable = false;
                    ToolTip = 'Specifies the value of the Check-In Time field.';
                }

                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient No. field.';

                    trigger OnValidate()
                    begin
                        Rec.GetPatientName(Rec."Patient No.");
                        //GetPatientNo("Patient No.","Student No.","Employee No.","Relative No.");
                        GetAppointmentStats(Rec."Patient No.");
                    end;
                }
                field(SearchNames; Rec.SearchNames)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the SearchNames field.';
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("Special Clinics"; Rec."Special Clinics")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Special Clinics field.';
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Settlement Type field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor field.';

                }
                field("Doctors Name"; Rec."Doctors Name")
                {
                    Caption = 'Doctor Name';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Doctor Name field.';
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Appointment Type field.';
                    // Editable = false;
                    trigger OnValidate()
                    begin
                        GetAppointmentTypeName(AppointmentTypeName, Rec."Appointment Type");
                    end;
                }
                field("Doctor Appointment Count"; Rec."Doctor Appointment Count")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Doctor Appointment count field.';
                }
                field("Doctor Last Appointment Date"; Rec."Doctor Last Appointment Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Doctor Last Appointment Date field.';
                }

                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Patient Type field.';
                    trigger OnValidate()
                    begin
                        CheckPatientType();
                    end;

                }
                field("Visit Balance"; Rec."Charges Count")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Visit Balance';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Visit Balance field.';
                }
                field("Insurance No"; Rec."Insurance No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance No field.';
                    trigger OnValidate()
                    var
                        cust: Record Customer;
                    begin
                        cust.Get(Rec."Insurance No");
                        if cust.Minet = true then
                            Message('Minet MVC No. is required');
                    end;
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Insurance Name field.';
                }
                field("Insurance Member No"; Rec."Insurance Member No")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Insurance Member No field.';
                }
                field("MCC No."; Rec."MVC No.")
                {
                    Caption = 'LOU No';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the LOU No field.';

                }
                field("NHIF LOU Amount"; Rec."Insurance LOU Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the NHIF LOU Amount field.';
                }
                field("NHIF Procedure Code"; Rec."NHIF Procedure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the NHIF Procedure Code field.';
                }
                field("Invoice No"; Rec."Invoice No")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Invoice No field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Status; Rec.Status)
                {
                    // Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Dispatch To"; Rec."Dispatch To")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Dispatch To field.';
                }
                  field("SystemId"; Rec.SystemId)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                group("Appointment Statistics")
                {
                    Caption = 'Appointment Statistics';
                    field(IntScheduled; IntScheduled)
                    {
                        Caption = 'No. of appointments scheduled';
                        Editable = false;
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the value of the No. of appointments scheduled field.';
                    }
                    field(IntCompleted; IntCompleted)
                    {
                        Caption = 'No. of appointments completed';
                        Editable = false;
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the value of the No. of appointments completed field.';
                    }
                    field(IntRescheduled; IntRescheduled)
                    {
                        Caption = 'No. of appointments rescheduled';
                        Editable = false;
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the value of the No. of appointments rescheduled field.';
                    }
                    field(IntCancelled; IntCancelled)
                    {
                        Caption = 'No. of appointments cancelled';
                        Editable = false;
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the value of the No. of appointments cancelled field.';
                    }
                }
            }
            part(Control1102760014; "HMS Appointment Form Line")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Patient No." = FIELD("Patient No.");
            }
        }
    }

    actions
    {
        area(processing)
        {


            action("Charges Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient Charges";
                RunPageLink = "Patient No." = FIELD("Patient No."),
                                  "Visit No" = FIELD("Appointment No.");
                ToolTip = 'Executes the Charges Lines action.';
            }
            action("Posted Charges")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Charges';
                Image = Invoice;
                Promoted = true;
                RunObject = Page "HMS Patient ClosedCharges List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ToolTip = 'Executes the Posted Charges action.';
            }
            action("Dispatch To Doctor")
            {
                Caption = 'Dispatch Patient';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Dispatch Patient action.';
                trigger OnAction()
                var
                    CuHMSProcesses: Codeunit "HMS Processes";
                begin
                    CuHMSProcesses.FnDispatchToTriage(Rec);
                end;
            }
            separator(Separator3)
            {
            }

            action("Dispatch To Lab")
            {
                Caption = 'Dispatch To Lab';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Dispatch To Lab action.';
                trigger OnAction()
                begin
                    /*DocLabRequestLines.RESET;
                    DocLabRequestLines.SETRANGE(DocLabRequestLines."Laboratory No.","Appointment No.");
                    IF DocLabRequestLines.FIND('-') THEN BEGIN
                      //Procees
                    END ELSE BEGIN
                      ERROR('Please enter the lab tests to be done so as to proceed');
                    END;
                    */
                    if ((Today - Rec."Appointment Date") > 2) then
                        Error('This is already an old appointment. Kindly queue the patient for today');

                    Rec.TestField("Settlement Type");
                    Rec.TestField("Patient Type");

                    if Confirm('Send Laboratory Test Request Now?', false) = true then begin
                        Rec.TestField("Settlement Type");
                        Rec.TestField("Appointment Date");
                        Rec.TestField("Appointment Time");
                        Rec.TestField("Patient Type");
                        Rec.TestField("Patient No.");
                        Rec.TestField("Appointment Type");

                        if Rec."Settlement Type" = Rec."Settlement Type"::Insurance then
                            Rec.TestField("Insurance Member No");
                        HMSSetup.Reset();
                        HMSSetup.Get();
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Lab Test Request Nos", 0D, true);
                        TreatmentHeader.Reset();
                        TreatmentHeader.Get(Rec."Appointment No.");
                        LabHeader.Reset();
                        LabHeader.Init();
                        LabHeader."Laboratory No." := NewNo;
                        LabHeader."Laboratory Date" := Today;
                        LabHeader."Laboratory Time" := DT2TIME(System.CurrentDateTime);
                        LabHeader."Patient No." := TreatmentHeader."Patient No.";
                        LabHeader."Request Area" := LabHeader."Request Area"::Doctor;
                        LabHeader."Link Type" := 'Appointment';
                        LabHeader."Link No." := TreatmentHeader."Appointment No.";
                        labheader2.Reset();
                        labheader2.SetRange(labheader2."Link No.", TreatmentHeader."Appointment No.");
                        if labheader2.Find('-') then begin
                            if Confirm('Record already exist,Confirm Continue?') then LabHeader.Insert();
                        end
                        else begin
                            LabHeader.Insert();
                        end;
                        DocLabRequestLines.Reset();
                        DocLabRequestLines.SetRange(DocLabRequestLines."Laboratory No.", Rec."Appointment No.");
                        //DocLabRequestLines.SETRANGE(DocLabRequestLines.Status,DocLabRequestLines.Status::New);
                        if DocLabRequestLines.Find('-') then begin
                            repeat

                                LabTestLines.Init();
                                LabTestLines."Laboratory No." := NewNo;
                                LabTestLines."Laboratory Test Code" := DocLabRequestLines."Laboratory Test Code";
                                LabTestLines."Specimen Code" := DocLabRequestLines."Specimen Code";
                                LabTestLines."Measuring Unit Code" := DocLabRequestLines."Measuring Unit Code";
                                LabTestLines."Laboratory Test Name" := DocLabRequestLines."Laboratory Test Name";
                                LabTestLines."Specimen Name" := DocLabRequestLines."Specimen Name";
                                LabTestLines.Insert();

                            until DocLabRequestLines.Next() = 0;
                        end;

                        Rec."Dispatch To" := Rec."Dispatch To";
                        Rec."Dispatch Date" := Today;
                        Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                        Rec.Status := Rec.Status::Dispatched;
                        Rec."Lab Time In" := CurrentDateTime;
                        Rec."Waiting At" := Rec."Waiting At";
                        Rec.Modify();
                    end;
                    //END;

                end;
            }

            action("Dispatch To Phamarcy")
            {
                Caption = 'Dispatch To Phamarcy';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                ToolTip = 'Executes the Dispatch To Phamarcy action.';
                trigger OnAction()
                var
                    HMSPatient: Record "HMS Patient";
                    PTLFactory: Codeunit "PTL Factory";
                    Dispatched: Boolean;
                begin
                    Rec.TestField("Settlement Type");
                    Rec.TestField("Patient Type");
                    rec.TestField("Patient No.");

                    if Confirm('Alert Pharmacy About Prescription?') = false then exit;

                    HMSPatient.Get(Rec."Patient No.");

                    Dispatched := PTLFactory.DispatchToPharmacy(HMSPatient);

                    if Dispatched then begin
                        Rec."Dispatch Date" := Today;
                        Rec."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                        Rec."Pharmacy Time In" := CurrentDateTime;
                        Rec."Waiting At" := Rec."Waiting At";
                        Rec.Status := Rec.Status::Dispatched;
                        Rec.Modify();
                    end;
                end;
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.GetDoctorName(Rec.Doctor);
        Rec.SetFilter("Date Filter", '%1..%2', 0D, (today - 1));
        if Rec."Patient Type" = Rec."Patient Type"::Corporate then Rec."Settlement Type" := Rec."Settlement Type"::Insurance;
    end;

    trigger OnInit()
    begin
        "Relative No.Enable" := true;
        "Employee No.Enable" := true;
        "Student No.Enable" := true;
        "Relative No.Visible" := true;
        "Employee No.Visible" := true;
        Rec."User ID" := UserId;
    end;

    procedure CreateReceipt(PatientNo: code[20]; VisitNo: code[20])
    var
        CashOfficeSetup: Record "Cash Office Setup";
        RecHeader: Record "Receipts Header";
        ReceiptNo: code[20];
        UserSetup: Record "User Setup";
    begin
        if Usersetup.get(Database.UserId) then;

        CashOfficeSetup.get;
        CashOfficeSetup.TestField("Receipts No");
        ReceiptNo := NoSeriesMgt.GetNextNo(CashOfficeSetup."Receipts No", 0D, true);
        RecHeader.init;
        RecHeader."No." := ReceiptNo;
        RecHeader.Date := today;
        RecHeader.Cashier := database."UserID";
        RecHeader."Global Dimension 1 Code" := userSetup."Branch Code";
        RecHeader."Patient No." := PatientNo;
        RecHeader."Patient Appointment No" := VisitNo;
        RecHeader.insert;
        if RecHeader.get(ReceiptNo) then begin
            RecHeader.validate("Patient Appointment No");
            page.run(Page::"Receipt Header UP", RecHeader);
        end;

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
        HMSSetup: Record "HMS Setup";
        NewNo: Code[20];
        NoSeriesMgt: Codeunit "No. Series";
        TreatmentHeader: Record "HMS Appointment Form Header";
        PharmHeader: Record "HMS Pharmacy Header";
        LabHeader: Record "HMS Laboratory Form Header";
        labheader2: Record "HMS Laboratory Form Header";
        ObservHeader: Record "HMS Observation Form Header";
        PhysioHeader: Record "HMS Physiotheraphy Form Header";
        docHeader: Record "HMS Treatment Form Header";
        DocLabRequestLines: Record "HMS Laboratory Test Line";
        AdmissionHeader: Record "HMS Admission Form Header";
        LabTestLines: Record "HMS Laboratory Test Line";
        HMSCharges: Record "HMS Charges";
        HMSPatientsCharges: Record "HMS Patient Charges";
        AppType: Record "HMS Setup Appointment Type";
        DoctorsRec: Record "HMS Setup Doctor";
        Patient: Record "HMS Patient";
        RadiologyHeader: Record "HMS Radiology Form Header";
        PatientCU: Codeunit "HMS Patient-integration";
        PatRec: Record "HMS Patient";
        recInsurance: Record Customer;
        DocNo: Text;
        TreatH: Record "HMS Treatment Form Header";
        DialHeader: Record "HMS Therapy Form Header";

    procedure CheckPatientType()
    begin
        if Rec."Patient Type" = Rec."Patient Type"::Corporate then begin
            "Student No.Enable" := false;
            "Employee No.Enable" := false;
            "Relative No.Enable" := false;
            "Employee No.Visible" := false;
            "Relative No.Visible" := false;
        end
        else begin
            "Student No.Enable" := false;
            "Employee No.Enable" := false;
            "Relative No.Enable" := false;
            "Employee No.Visible" := true;
            "Relative No.Visible" := true;

        end;
    end;

    procedure GetAppointmentTypeName(var AppointmentTypeName: Text[100]; var AppointmentTypeCode: Code[20])
    var
        AppType: Record "HMS Setup Appointment Type";
    begin
        AppType.Reset;
        if AppType.Get(AppointmentTypeCode) then begin AppointmentTypeName := AppType.Description end;
    end;

    procedure GetPatientNo(var PatientNo: Code[20]; var StudentNo: Code[20]; var EmployeeNo: Code[20]; var RelativeNo: Integer)
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset;
        if Patient.Get(PatientNo) then begin
        end;
    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset;
        if Patient.Get(PatientNo) then begin
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + Patient."Last Name";
            if Rec."Patient Type" = Rec."Patient Type"::Corporate then Rec."Settlement Type" := Rec."Settlement Type"::Insurance;
        end;
    end;

    procedure GetPatientAge(var PatientNo: Code[20]; var Age: Text[100])
    var
        HRDates: Codeunit "HR Dates";
        Patient: Record "HMS Patient";
    begin
        Patient.Reset;
        if Patient.Get(PatientNo) then begin
            if Patient."Date Of Birth" = 0D then begin
                Age := '';
            end
            else begin
                Age := HRDates.DetermineAge(Patient."Date Of Birth", Today);
            end;
        end;
    end;

    procedure GetDoctorName(var DoctorCode: Code[20]; var DoctorName: Text[100])
    var
        Doctor: Record "HMS Setup Doctor";
    begin
        Doctor.Reset;
        Doctor.SetRange(Doctor."Doctor ID", DoctorCode);
        if Doctor.Find('-') then begin
            // Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DoctorName := Doctor."Doctors Name";
        end;
    end;

    procedure GetAppointmentStats(var PatientNo: Code[20])
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset;
        if Patient.Get(PatientNo) then begin
            Patient.CalcFields(Patient."Appointments Scheduled", Patient."Appointments Completed", Patient."Appointments Rescheduled");
            IntScheduled := Patient."Appointments Scheduled";
            IntCompleted := Patient."Appointments Completed";
            IntRescheduled := Patient."Appointments Rescheduled";
            Patient.CalcFields(Patient."Appointments Cancelled");
            IntCancelled := Patient."Appointments Cancelled";
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        GetAppointmentTypeName(AppointmentTypeName, Rec."Appointment Type");
        Rec.GetDoctorName(Rec.Doctor);
        Rec.GetPatientName(Rec."Patient No.");
        Rec.GetPatientAge(Rec."Patient No.", Age);
        GetAppointmentStats(Rec."Patient No.");
    end;

    trigger OnOpenPage()
    begin
        HMSSetup.Get();
        if HMSSetup."View Therapy" = true then
            TherapyMode := false;
        if HMSSetup."View Therapy" = false then
            TherapyMode := true;
    end;

    var
        TherapyMode: Boolean;
        InsurancePackage: Record "HMS Insuarance Packages";
        ADmNo: Text;
        DialNo: Text;

}

#pragma implicitwith restore

