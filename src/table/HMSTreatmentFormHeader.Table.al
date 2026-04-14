table 85265 "HMS Treatment Form Header"
{
    DrillDownPageID = "HMS Treatment List";
    LookupPageID = "HMS Treatment List";

    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
            trigger OnValidate()
            begin

            end;
        }
        field(50001; "Treatment Type"; Option)
        {
            OptionMembers = Outpatient,Inpatient;
        }
        field(50002; "Treatment Date"; Date)
        {
        }
        field(50003; "Treatment Time"; Time)
        {
        }
        field(50004; "Doctor ID"; Code[20])
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
        field(50005; "Patient No."; Code[20])
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
        field(50006; "Student No."; Code[20])
        {
        }
        field(50007; "Employee No."; Code[20])
        {
        }
        field(50008; "Relative No."; Integer)
        {
        }
        field(50009; "Doctor Notes"; Text[200])
        {
        }
        field(50010; Status; Enum TreatmentStatus)
        {
        }
        field(50011; "Link No."; Code[20])
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
        field(50012; "Link Type"; Code[20])
        {
        }
        field(50013; "No. Series"; Code[20])
        {
        }
        field(50014; "Off Duty Days"; Decimal)
        {
        }
        field(50015; "Light Duty Days"; Decimal)
        {
        }
        field(50016; "Off Duty Comments"; Text[200])
        {
        }
        field(50017; "Off Duty"; Boolean)
        {
        }
        field(50018; "Treatment Location"; Option)
        {
            OptionMembers = Main;
        }
        field(50019; "Patient Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(50020; Direct; Boolean)
        {
        }
        field(50021; "Lab Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(50022; "Radiology Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(50023; "Pharmacy Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(50024; "Injection Status"; Option)
        {
            OptionCaption = ' ,Pending,Cleared';
            OptionMembers = " ",Pending,Cleared;
        }
        field(50025; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50026; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50027; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50028; "ID Number"; Code[24])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50029; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50030; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50031; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50032; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50033; "Patient Name"; Code[250])
        {
            // CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No.")));
            // FieldClass = FlowField;
        }
        field(50034; "Settlement Type"; Option)
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Settlement Type" where("Appointment No." = field("Appointment No")));
            FieldClass = FlowField;
            OptionCaption = ' ,Cash,Insurance,Credit';
            OptionMembers = " ",Cash,Insurance,Credit;
        }
        field(50035; "Membership No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Membership No" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50036; "Insurance Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Insurance Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50037; "Adm No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Adm No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50038; "Lk No"; Code[20])
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

        field(50039; "Triage Notes"; Text[200])
        {
        }
        field(50040; "Next Appointment Date"; Date)
        {
        }
        field(50041; "Sick Off Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if ("Off Duty Days" <> 0) and ("Sick Off Start Date" <> 0D) then
                    "Sick Off End Date" := CalcDate('<+' + format("Off Duty Days") + 'D>', "Sick Off Start Date");
            end;
        }
        field(50042; "Sick Off End Date"; Date)
        {
        }
        field(50043; InPatient; Boolean)
        {
            TableRelation = "HMS Patient".Inpatient where("Patient No." = field("Patient No."));
        }
        field(50044; "Status Remarks"; Text[30])
        {
        }
        field(50045; Clinic; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Clinics Setup".No;
            // OptionCaption = ',Medical,Optical,Dental,Ortho,Neural,Gynaecology,Dialysis';
            // OptionMembers = ,Medical,Optical,Dental,Ortho,Neural,Gynaecology,Dialysis;
        }
        field(50046; "Doctor's Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Waiting At"; Code[30])
        {

        }
        field(50048; "Lab No"; Code[10])
        {
            CalcFormula = lookup("HMS Laboratory Form Header"."Laboratory No." where("Link No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(50049; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50050; "Color Code"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '0,1,2';
            OptionMembers = "0","1","2";
        }
        field(50051; "Next Appointment Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "Special Clinics"; Code[20])
        {
            TableRelation = "HMS Clinics Setup".No;
        }
        field(50053; "Observation No"; Code[20])
        {
            TableRelation = "HMS Observation Form Header"."Observation No.";
        }
        field(50054; "Appointment No"; Code[20])
        {
            TableRelation = "HMS Appointment Form Header"."Appointment No.";
        }
        field(50055; "isTherapy"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Urgency Status"; Enum "Urgency Status Enum")
        {
            DataClassification = CustomerContent;
        }
        field(50057; "Form Generated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50058; "Next Appointment Comments"; Text[250])
        {

        }
        field(50059; "Resident Doctor"; Boolean)
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("HMS Setup Doctor".Resident where("Doctor ID" = field("Doctor ID")));
        }
        field(50060; "Created By"; Code[50])
        {
        }
        field(50061; "Modified By"; Code[50])
        {
        }
        field(50062; isTranscription; Boolean)
        {
        }
        field(50063; "Transcribed File No"; Text[50])
        {

        }
        field(50064; "Clinic Visited"; Code[50])
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
