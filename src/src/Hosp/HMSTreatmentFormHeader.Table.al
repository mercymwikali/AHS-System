table 52202646 "HMS Treatment Form Header"
{
    DrillDownPageID = "HMS Treatment List";
    LookupPageID = "HMS Treatment List";

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            trigger OnValidate()
            begin

            end;
        }
        field(2; "Treatment Type"; Option)
        {
            OptionMembers = Outpatient,Inpatient;
        }
        field(3; "Treatment Date"; Date)
        {
        }
        field(4; "Treatment Time"; Time)
        {
        }
        field(5; "Doctor ID"; Code[20])
        {
            TableRelation = "HMS Setup Doctor"."Doctor ID";

            trigger OnValidate()
            begin
                Doc.Reset();
                Doc.SetRange("Doctor ID", "Doctor ID");
                if Doc.FindFirst() then begin
                    "Doctor's Name" := Doc."Doctors Name";
                    "Resident Doctor" := Doc.Resident;
                end;
            end;
        }
        field(6; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
            trigger OnValidate()
            var
                Patient: Record "HMS Patient";
            begin
                Patient.Reset();
                Patient.SetRange("Patient No.", "Patient No.");
                if Patient.FindFirst() then
                    "Patient Name" := Patient."Search Name";

            end;
        }
        field(7; "Student No."; Code[20])
        {
        }
        field(8; "Employee No."; Code[20])
        {
        }
        field(9; "Relative No."; Integer)
        {
        }
        field(10; "Doctor Notes"; Text[200])
        {
        }
        field(11; Status; Enum TreatmentStatus)
        {
        }
        field(12; "Link No."; Code[20])
        {
            TableRelation = if ("Treatment Type" = const(Outpatient),
                                Direct = const(false)) "HMS Observation Form Header"."Observation No." where(Closed = const(true),
                                                                                                            Status = const(Pending),
                                                                                                            Completed = const(false))
            else
            if ("Treatment Type" = const(Inpatient)) "HMS Admission Form Header"."Admission No." where(Status = const(Admitted))
            else
            if ("Treatment Type" = const(Outpatient),
                    Direct = const(true)) "HMS Appointment Form Header"."Appointment No." where(Status = const(Dispatched),
                    "Dispatch To" = filter('Doctor'));
        }
        field(13; "Link Type"; Code[20])
        {
        }
        field(14; "No. Series"; Code[20])
        {
        }
        field(15; "Off Duty Days"; Decimal)
        {
        }
        field(16; "Light Duty Days"; Decimal)
        {
        }
        field(17; "Off Duty Comments"; Text[200])
        {
        }
        field(18; "Off Duty"; Boolean)
        {
        }
        field(19; "Treatment Location"; Option)
        {
            OptionMembers = Main;
        }
        field(20; "Patient Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(21; Direct; Boolean)
        {
        }
        field(22; "Lab Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(23; "Radiology Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(24; "Pharmacy Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(25; "Injection Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(27; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(28; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(29; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(30; "ID Number"; Code[24])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(31; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(32; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(33; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(34; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(35; "Patient Name"; Code[250])
        {
            // CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No.")));
            // FieldClass = FlowField;
        }
        field(36; "Settlement Type"; Option)
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Settlement Type" where("Appointment No." = field("Appointment No")));
            FieldClass = FlowField;
            OptionCaption = ' ,Cash,Insurance,Credit';
            OptionMembers = " ",Cash,Insurance,Credit;
        }
        field(37; "Membership No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Membership No" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(38; "Insurance Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Insurance Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(39; "Adm No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Adm No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(40; "Lk No"; Code[20])
        {
            CalcFormula = lookup(
        "HMS Appointment Form Header"."Appointment No."
        where(
            "Patient No." = field("Patient No."),
            "Settlement Type" = field("Patient Type"),
            "Appointment Date" = field("Treatment Date")
        )
    );
            FieldClass = FlowField;
        }

        field(41; "Triage Notes"; Text[200])
        {
        }
        field(42; "Next Appointment Date"; Date)
        {
        }
        field(43; "Sick Off Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if ("Off Duty Days" <> 0) and ("Sick Off Start Date" <> 0D) then
                    "Sick Off End Date" := CalcDate('<+' + format("Off Duty Days") + 'D>', "Sick Off Start Date");
            end;
        }
        field(44; "Sick Off End Date"; Date)
        {
        }
        field(45; InPatient; Boolean)
        {
            TableRelation = "HMS Patient".Inpatient where("Patient No." = field("Patient No."));
        }
        field(46; "Status Remarks"; Text[30])
        {
        }
        field(47; Clinic; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Clinics Setup".No;
            // OptionCaption = ',Medical,Optical,Dental,Ortho,Neural,Gynaecology,Dialysis';
            // OptionMembers = ,Medical,Optical,Dental,Ortho,Neural,Gynaecology,Dialysis;
        }
        field(48; "Doctor's Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Waiting At"; Code[30])
        {

        }
        field(50; "Lab No"; Code[10])
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Laboratory No." where("Link No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(51; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(52; "Color Code"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '0,1,2';
            OptionMembers = "0","1","2";
        }
        field(53; "Next Appointment Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Special Clinics"; Code[20])
        {
            TableRelation = "HMS Clinics Setup".No;
        }
        field(55; "Observation No"; Code[20])
        {
            TableRelation = "HMS Observation Form Header"."Observation No.";
        }
        field(56; "Appointment No"; Code[20])
        {
            TableRelation = "HMS Appointment Form Header"."Appointment No.";
        }
        field(57; "isTherapy"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Urgency Status"; Enum "Urgency Status Enum")
        {
            DataClassification = CustomerContent;
        }
        field(59; "Form Generated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60; "Next Appointment Comments"; Text[250])
        {

        }
        field(61; "Resident Doctor"; Boolean)
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("HMS Setup Doctor".Resident where("Doctor ID" = field("Doctor ID")));
        }
        field(62; "Created By"; Code[50])
        {
        }
        field(63; "Modified By"; Code[50])
        {
        }
        field(64; isTranscription; Boolean)
        {
        }
        field(65; "Transcribed File No"; Text[50])
        {

        }
        field(66; "Clinic Visited"; Code[50])
        {

        }
    }

    keys
    {
        key(Key1; "Treatment No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Treatment No." = '' then begin
            HMSSetup.Get();
            HMSSetup.TestField("Visit Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Visit Nos", xRec."No. Series", 0D, "Treatment No.", "No. Series");
            Status := Status::New;
        end;
    end;

    var
        HMSSetup: Record "HMS Setup";
        Doc: Record "HMS Setup Doctor";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
