
#pragma warning disable AA0150
table 52202440 "HMS Appointment Form Header"
{
    DataCaptionFields = "Appointment No.", "Appointment Date";
    DrillDownPageID = "HMS Appointment Lists";
    LookupPageID = "HMS Appointment Lists";

    fields
    {
        field(1; "Appointment No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                // if "Appointment No." <> xRec."Appointment No." then begin
                //     HMSSetup.Get();
                //     NoSeriesMgt.TestManual(HMSSetup."Appointment Nos");
                //     "No. Series" := '';
                // end;
            end;
        }
        field(2; "Appointment Date"; Date)
        {
        }
        field(3; "Appointment Time"; Time)
        {
        }
        field(4; "Appointment Type"; Code[20])
        {
            TableRelation = "HMS Setup Appointment Type".Code;
        }
        field(5; "Patient Type"; Option)
        {
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;

            trigger OnValidate()
            begin

            end;
        }
        field(6; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";

            trigger OnValidate()
            var
                hmsPatInt: Codeunit "HMS Patient-integration";
            begin
                HMSPat.SetRange(HMSPat."Patient No.", "Patient No.");
                if HMSPat.Find('-') then begin
                    Names := HMSPat."Search Name";//HMSPat.Surname+' '+HMSPat."Middle Name"+' '+HMSPat."Last Name";
                    SearchNames := HMSPat."Search Name";//HMSPat.Surname+' '+HMSPat."Middle Name"+' '+HMSPat."Last Name";

                    "Patient Names" := HMSPat."Search Name";// HMSPat.Surname+' '+HMSPat."Middle Name"+' '+HMSPat."Last Name";
                end;
                if "Invoice No" = '' then
                    "Invoice No" := hmsPatInt.GetNewInvoiceNumber("Global Dimension 1", 'OP'); // This assigns an invoice numver fot the visit if the patient is corporate.

            end;
        }
        field(7; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(8; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(9; "Relative No."; Integer)
        {
            TableRelation = "Employee Relative"."Line No." where("Employee No." = field("Employee No."));
        }
        field(10; Doctor; Code[20])
        {
            TableRelation = "HMS Setup Doctor"."Doctor ID" where(Specialization = field("Special Clinics"));

            trigger OnValidate()
            var
                DaysBtwnTodayAndLastVisit: Integer;
            begin
                "Doctors Name" := GetDoctorName(Doctor);
                SetFilter("Date Filter", '%1..%2', 0D, (today - 1));
                calcfields("Doctor Appointment count");
                calcfields("Doctor Last Appointment Date");
                if IfResidentDoctor(Doctor) then begin
                    "Appointment Type" := 'REVISIT';
                    DaysBtwnTodayAndLastVisit := isLastVisitDayWithin7days();
                    if DaysBtwnTodayAndLastVisit <= 7 then
                        "Appointment Type" := 'REVIEW';
                    if DaysBtwnTodayAndLastVisit = 999 then
                        "Appointment Type" := 'NORMAL';
                    if DaysBtwnTodayAndLastVisit = 0 then
                        "Appointment Type" := 'NORMAL';

                end else
                    if "Doctor Appointment count" > 0 then begin
                        "Appointment Type" := 'REVISIT';
                        if "Doctor Last Appointment Date" <> 0D then
                            if (today - "Doctor Last Appointment Date") < 8 then
                                "Appointment Type" := 'REVIEW'
                            else
                                "Appointment Type" := 'NORMAL';
                    end;


                if "Settlement Type" <> "Settlement Type"::Cash then
                    "Appointment Type" := 'NORMAL';
            end;
        }
        field(111; "Doctor Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field(Doctor)));
        }
        field(11; Remarks; Text[100])
        {
        }
        field(12; Status; Enum AppointmentStatusEnum)
        {
        }
        field(13; "ReAppointment No."; Code[20])
        {
        }
        field(14; "ReAppointment Date"; Date)
        {
        }
        field(15; "ReAppointment Time"; Time)
        {
        }
        field(16; "ReAppointment Type Code"; Code[20])
        {
            TableRelation = "HMS Setup Appointment Type".Code;
        }
        field(17; "ReAppointment Doctor ID"; Code[20])
        {
            TableRelation = "HMS Setup Doctor"."Doctor ID";
        }
        field(18; "No. Series"; Code[20])
        {
        }
        field(19; "Dispatch To"; Enum "Dispatch Areas")
        {
            // OptionCaption = 'Observation,Doctor,Physiotheraphy,Laboratory,Phamarcy,Inpatient,Radiology,Dialysis';
            // OptionMembers = Observation,Doctor,Physiotheraphy,Laboratory,Phamarcy,Inpatient,Radiology,Dialysis;
        }
        field(20; "Dispatch Date"; Date)
        {
        }
        field(21; "Dispatch Time"; Time)
        {
        }
        field(22; "User ID"; Code[20])
        {
            TableRelation = User."User Name";
        }
        field(23; "Treatment Status"; Option)
        {
            CalcFormula = lookup("HMS Treatment Form Header".Status where("Link No." = field("Appointment No.")));
            FieldClass = FlowField;
            OptionMembers = ,New,Active,Completed,Referred,Cancelled;
        }
        field(24; "Settlement Type"; Option)
        {
            OptionCaption = ' ,Cash,Insurance,Credit';
            OptionMembers = " ",Cash,Insurance,Credit;
            trigger OnValidate()
            begin
                if "Settlement Type" <> "Settlement Type"::Cash then
                    "Appointment Type" := 'NORMAL';

                case "Settlement Type" of
                    "Settlement Type"::Insurance:
                        begin
                            "Patient Type" := "Patient Type"::Corporate;
                            // "Insurance No" := '';
                            // "Membership No" := '';
                            // "Insurance Member No" := '';
                        end;
                    "Settlement Type"::Cash:
                        begin
                            "Patient Type" := "Patient Type"::Cash;
                            "Insurance No" := '';
                            "Membership No" := '';
                            "Insurance Member No" := '';
                        end;
                /* "Settlement Type"::Credit:
                    begin
                        "Patient Type" := "Patient Type"::Corporate;
                        "Insurance No" := '';
                        "Membership No" := '';
                        "Insurance Member No" := '';
                    end; */
                end;
            end;
        }
        field(25; "Membership No"; Code[50])
        {
            CalcFormula = lookup("HMS Patient"."Membership No" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(26; "Insurance Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Insurance Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(27; "Pharmacy count"; Integer)
        {
            CalcFormula = count("HMS Pharmacy Line" where("Link Code" = field("Appointment No.")));
            FieldClass = FlowField;
        }
        field(28; "Physio Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Appointment No." = field("Appointment No."),
                                                                  "Applicable Section" = CONST(Physiotheraphy)));
            FieldClass = FlowField;
        }
        field(29; "Observation Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Appointment No." = field("Appointment No."),
                                                                  "Applicable Section" = CONST("Observation Room")));
            FieldClass = FlowField;
        }
        field(30; "Laboratory Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Appointment No." = field("Appointment No."),
                                                                  "Applicable Section" = CONST(Laboratory)));
            FieldClass = FlowField;
        }
        field(31; "Consultation Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Appointment No." = field("Appointment No."),
                                                                  "Applicable Section" = CONST("Consultation Fee")));
            FieldClass = FlowField;
        }
        field(32; "Pharmacy Amount"; Decimal)
        {
            CalcFormula = sum("HMS Pharmacy Line"."Issued Price" where("Link Code" = field("Appointment No.")));
            FieldClass = FlowField;
        }
        field(33; "Charges count"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Appointment No.")));
            FieldClass = FlowField;
        }
        field(34; "Patient Type Lk"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(35; "Invoice count"; Integer)
        {
            CalcFormula = count("Sales Header" where("Appointment No" = field("Appointment No.")));
            FieldClass = FlowField;
        }
        field(36; "Adm No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Adm No." where("Patient No." = field("Patient No."), Status = filter(AdmissionStatusEnum::Admitted)));
            FieldClass = FlowField;
        }
        field(37; "Invoice Posted"; Boolean)
        {
        }
        field(38; "Invoice Posted By"; Code[50])
        {
        }
        field(39; "Invoice Posted On"; Date)
        {
        }
        field(40; "Pending Invoice"; Boolean)
        {
        }
        field(41; "Appointment count"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where("Appointment Date" = field("Appointment Date"),
                                                                     "Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(42; "App Temp"; Boolean)
        {
        }
        field(43; "Insurance No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                HMSPat.Get("Patient No.");
                if HMSPat."Insurance No." <> "Insurance No" then begin
                    PatInsurance.Init();
                    PatInsurance."Patient No" := "Patient No.";
                    PatInsurance."Insurance No" := "Insurance No";
                    PatInsurance.Validate("Insurance No");
                    PatInsurance."Member No" := "Membership No";
                    PatInsurance."Vist No" := "Appointment No.";
                    PatInsurance.Insert();
                end;
            end;
        }
        field(44; "Insurance Member No"; Code[50])
        {
        }
        field(45; "Link No"; Code[20])
        {
        }
        field(46; "Doctors Name"; Text[250])
        {
        }
        field(47; "Patient Names"; Text[250])
        {
        }
        field(48; "Age in Years"; Integer)
        {
        }
        field(49; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50; visitType; Option)
        {
            OptionCaption = 'New,Revisit';
            OptionMembers = New,Revisit;
        }
        field(51; Emergency; Boolean)
        {
        }
        field(52; Names; Text[250])
        {
            FieldClass = Normal;
        }
        field(53; SearchNames; Text[250])
        {
        }
        field(54; imported; Boolean)
        {
        }
        field(55; Minor; Boolean)
        {
        }
        field(56; Physio; Boolean)
        {
        }
        field(57; "SmarkLink Balance"; Decimal)
        {
        }
        field(58; "MVC No."; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Invoice No" = '' then
                    "Invoice No" := hmsPatInt.GetNewInvoiceNumber("Global Dimension 1", 'OP');
            end;
        }
        field(59; "Patient Category"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(3));
        }
        field(60; "Phone No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Waiting At"; Enum "Dispatch Areas")
        {
            DataClassification = ToBeClassified;
            // OptionCaption = ',Registration,Triage,Doctor,Lab,Pharmacy,Imaging,Lab Results,Dialysis';
            // OptionMembers = ,Registration,Triage,Doctor,Lab,Pharmacy,Imaging,"Lab Results",Dialysis;
        }
        field(62; "Triage Time In"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Triage Time out"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Doctor Time In"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Doctor Time Out"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Lab Time In"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Lab Time Out"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Pharmacy Time In"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Pharmacy Time Out"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Imaging Time In"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Imaging Time Out"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Posted Invoice No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient Charges"."Invoice Number" where("Patient No." = field("Patient No."),
                                                                               "Visit No" = field("Appointment No.")));
            FieldClass = FlowField;
        }
        field(73; "Total Billed"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Visit No" = field("Appointment No."),
                                                                          "Transaction Type" = filter(<> 'ZRECEIPT')));
            FieldClass = FlowField;
        }
        field(74; "Total Receipts"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  "Visit No" = field("Appointment No."),
                                                                  "Transaction Type" = CONST('ZRECEIPT')));
            FieldClass = FlowField;
        }
        field(75; Branch; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
            trigger OnValidate()
            var
                LabHeader: Record "HMS Laboratory Form Header";
                ObservationHeader: Record "HMS Observation Form Header";
                PatRec: Record "HMS Patient";
                RadHeader: Record "HMS Radiology Form Header";
                TreatHeader: Record "HMS Treatment Form Header";
            begin
                TestField(Branch);
                if PatRec.get("Patient No.") then begin
                    PatRec."Global Dimension 1 Code" := Branch;
                    PatRec.modify();
                end;
                LabHeader.reset();
                LabHeader.setrange("Patient No.", "Patient No.");
                LabHeader.setrange("Link No.", "Appointment No.");
                if LabHeader.Find('-') then begin
                    LabHeader.Branch := Branch;
                    LabHeader.modify();
                end;

                RadHeader.reset();
                RadHeader.setrange("Patient No.", "Patient No.");
                RadHeader.setrange("Link No.", "Appointment No.");
                if RadHeader.Find('-') then begin
                    RadHeader.Branch := Branch;
                    RadHeader.modify();
                end;

                ObservationHeader.reset();
                ObservationHeader.setrange("Patient No.", "Patient No.");
                ObservationHeader.setrange("Link No.", "Appointment No.");
                if ObservationHeader.Find('-') then begin
                    ObservationHeader.Branch := Branch;
                    ObservationHeader.modify();
                end;

                TreatHeader.reset();
                TreatHeader.setrange("Patient No.", "Patient No.");
                TreatHeader.setrange("Link No.", "Appointment No.");
                if TreatHeader.Find('-') then begin
                    TreatHeader.Branch := Branch;
                    TreatHeader.modify();
                end;
            end;
        }
        field(76; "Global Dimension 1"; Code[30])
        {
            CalcFormula = lookup("HMS Patient"."Global Dimension 1 Code" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(77; "Invoince No"; Code[20])
        {
            CalcFormula = lookup("Sales Invoice Header"."No." where("Appointment No" = field("Appointment No.")));
            FieldClass = FlowField;
        }
        field(78; "Booked By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(79; Time; time)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Therapy Time In"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Special Clinics"; Code[30])
        {
            TableRelation = "HMS Clinics Setup".No;

            trigger OnValidate()
            var
                HMSSetupClinic: Record "HMS Clinics Setup";
            begin
                isTherapy := false;

                if HMSSetupClinic.Get("Special Clinics") then begin
                    if HMSSetupClinic."Clinic Type" = HMSSetupClinic."Clinic Type"::Psychology then
                        isTherapy := true
                    else
                        isTherapy := false;

                    "Dispatch To" := HMSSetupClinic."Dispatch Area";
                end;
            end;

        }
        field(82; "Insurance LOU Amount"; decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                TestField("Patient No.");
                HMSPat.Get("Patient No.");

                if HMSPat."Current LOU Amount" <> "Insurance LOU Amount" then begin
                    HMSPat."Current LOU Amount" := "Insurance LOU Amount";
                    HMSPat.Modify();
                end;

            end;
        }
        field(83; "NHIF Procedure Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Re-Opened"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Re-Opened Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Re-Opened UserID"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Doctor Appointment count"; Integer)
        {
            CalcFormula = count("HMS Appointment Form Header" where(Doctor = field("Doctor"),
                                                                     "Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(88; "Doctor Last Appointment Date"; date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Appointment Form Header"."Appointment Date" where(Doctor = field("Doctor"),
                                                                     "Patient No." = field("Patient No."), "Appointment Date" = field("Date Filter")));

        }
        field(89; "Date Filter"; date)
        {
            FieldClass = FlowFilter;

        }
        field(90; "Telephone No."; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(91; "Visit Type"; Code[20])
        {
            TableRelation = "HMS Setup Appointment Type".Code;
        }
        field(92; "Invoice No"; Code[20])
        {

        }
        field(93; isTherapy; Boolean)
        {

        }
        field(94; "Treatment No"; Code[20])
        {

        }
        field(95; isTranscription; Boolean)
        {

        }
        field(96; "Transcribed By"; Code[30])
        {

        }
        field(97; "Transcribed Date"; Date)
        {

        }

    }

    keys
    {
        key(Key1; "Appointment No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Appointment No.", "Appointment Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Appointment No." = '' then begin
            HMSSetup.Get();
            HMSSetup.TestField("Appointment Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Appointment Nos", xRec."No. Series", 0D, "Appointment No.", "No. Series");
        end;

        if "Patient Type" = "Patient Type"::Corporate then "Settlement Type" := "Settlement Type"::Insurance;
        if not isTranscription then
            if HMSPat.Get("Patient No.") then begin
                HMSPat."Active Visit No" := "Appointment No.";
                HMSPat.Modify();
                if "Invoice No" = '' then
                    "Invoice No" := hmsPatInt.GetNewInvoiceNumber(HMSPat."Global Dimension 1 Code", 'OP');
            end;

    end;

    trigger OnModify()
    begin
        if "Patient Type" = "Patient Type"::Corporate then "Settlement Type" := "Settlement Type"::Insurance;
    end;

    var
        // Cust: Record Customer;
        HMSPat: Record "HMS Patient";
        HMSSetup: Record "HMS Setup";
        PatInsurance: Record "HMS Patient Insuarance";
        hmsPatInt: Codeunit "HMS Patient-integration";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure GetPatientNo(var PatientNo: Code[20]; var StudentNo: Code[20]; var EmployeeNo: Code[20]; var RelativeNo: Integer)
    var
        Patient: Record "HMS Patient";
    begin
    end;

    procedure GetPatientName(var PatientNo: Code[20]) PatientName: Text
    var
        Patient: Record "HMS Patient";
    begin
        PatientName := '';
        Patient.Reset();
        if Patient.Get(PatientNo) then begin
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + Patient."Last Name";
            "Phone No" := Patient."Telephone No. 1";
            if "Patient Type" = "Patient Type"::Corporate then "Settlement Type" := "Settlement Type"::Insurance;
        end;
    end;

    procedure GetPatientAge(var PatientNo: Code[20]; var Age: Text[100])
    var
        Patient: Record "HMS Patient";
        HRDates: Codeunit "HR Dates";
    begin
        Patient.Reset();
        if Patient.Get(PatientNo) then
            if Patient."Date Of Birth" = 0D then
                Age := ''
            else
                Age := HRDates.DetermineAge(Patient."Date Of Birth", Today);
    end;

    procedure GetDoctorName(var DoctorCode: Code[20]) DocName: Text[200]
    var
        HMSSetupDoctor: Record "HMS Setup Doctor";
    begin
        DocName := '';
        HMSSetupDoctor.Reset();
        HMSSetupDoctor.SetRange(HMSSetupDoctor."Doctor ID", DoctorCode);
        if HMSSetupDoctor.Find('-') then begin
            // Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DocName := HMSSetupDoctor."Doctors Name";
        end;
    end;

    procedure IfResidentDoctor(var DoctorCode: Code[20]) Resident: Boolean
    var
        HMSSetupDoctor: Record "HMS Setup Doctor";
    begin
        Resident := false;
        HMSSetupDoctor.Reset();
        HMSSetupDoctor.SetRange(HMSSetupDoctor."Doctor ID", DoctorCode);
        if HMSSetupDoctor.FindFirst() then
            // Doctor.CALCFIELDS(Doctor."Doctor's Name");
            Resident := HMSSetupDoctor.Resident;
    end;

    local procedure isLastVisitDayWithin7days() lastVisitDay: Integer
    var
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
    begin
        lastVisitDay := 999;

        HMSAppointmentFormHeader.RESET();
        HMSAppointmentFormHeader.SETRANGE(HMSAppointmentFormHeader."Patient No.", "Patient No.");
        HMSAppointmentFormHeader.SETCURRENTKEY("Appointment No.");
        if HMSAppointmentFormHeader.FindLast() then
            lastVisitDay := TODAY - HMSAppointmentFormHeader."Appointment Date";
    end;
}

#pragma warning restore AA0150
