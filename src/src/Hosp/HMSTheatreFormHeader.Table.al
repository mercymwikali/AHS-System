Table 52202479 "HMS Theatre Form Header"
{
    LookupPageID = "HMS Observation List";

    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HMSSetup.Get();
                    NoSeriesMgt.TestManual(HMSSetup."Observation Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Type; Option)
        {
            OptionMembers = Appointment,Visit,Admission;
        }
        field(3; "Theatre Date"; Date)
        {
        }
        field(4; "Theatre Time"; Time)
        {
        }
        field(5; "Surgery Code"; Code[100])
        {
            trigger OnValidate()
            begin
                Charges.Reset();
                Charges.SetRange(Charges.Code, "Surgery Code");
                if Charges.Find('-') then
                    Surgery := Charges.Description;
            end;
        }
        field(6; Surgery; Text[200])
        {
        }
        field(7; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(8; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(9; "Employee No."; Code[20])
        {
            TableRelation = "HMS ICU Process".Code;
        }
        field(10; "Relative No."; Integer)
        {
            TableRelation = "Employee Relative"."Line No." where("Employee No." = field("Employee No."));
        }
        field(11; "Link Type"; Code[20])
        {
        }
        field(12; "Link No."; Code[20])
        {
        }
        field(13; "No. Series"; Code[20])
        {
        }
        field(14; Closed; Boolean)
        {
        }
        field(15; Status; Option)
        {
            OptionMembers = New,Pending,Closed;
        }
        field(16; Completed; Boolean)
        {
        }
        field(17; "Next Appointment Date"; Date)
        {
            trigger OnValidate()
            begin
                if HMSSetup.Get("Patient No.") then begin
                    Patient."Next Appointment" := "Next Appointment Date";
                    Patient.Modify();
                end;
            end;
        }
        field(18; "Surname Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(19; "Last Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(20; "ADM No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Adm No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(21; "Surgeon Notes"; Text[200])
        {
        }
        field(22; "Operation Notes"; Text[200])
        {
        }
        field(23; "Nurse Notes"; Text[200])
        {
        }
        field(24; "Treatment Notes"; Text[200])
        {
        }
        field(25; "Doctor ID"; Code[50])
        {
            trigger OnValidate()
            begin
                Doc.Get("Doctor ID");
                TheatrePersonnel.Init();
                TheatrePersonnel."Treatment No" := "Link No.";
                TheatrePersonnel."Theatre No" := "No.";
                TheatrePersonnel."Personnel Name" := Doc."Doctors Name";
                TheatrePersonnel."Personnel Type" := TheatrePersonnel."personnel type"::Surgeon;
                TheatrePersonnel."Employee No." := "Doctor ID";
                TheatrePersonnel.Insert();
            end;
        }
        field(26; "Circulating Nurse ID"; Code[50])
        {
        }
        field(27; "Anaesthetist ID"; Code[50])
        {
        }
        field(28; Instructions; Text[250])
        {
        }
        field(29; "Scrub Nurse"; Code[50])
        {
        }
        field(30; "Pre-op Diagnosis"; Text[250])
        {
        }
        field(31; "Post-op Diagnosis"; Text[250])
        {
        }
        field(32; "Start Time"; Time)
        {
        }
        field(33; "End Time"; Time)
        {
        }
        field(34; "Theatre Procedure"; Option)
        {
            OptionCaption = ' ,Minor,Major';
            OptionMembers = " ",Minor,Major;
        }
        field(35; "Theatre Assistant"; Code[50])
        {
        }
        field(36; Incision; Text[100])
        {
        }
        field(37; "Estimated Blood Loss"; Text[50])
        {
        }
        field(38; "Count"; Option)
        {
            OptionCaption = ' ,Correct,Incorrect';
            OptionMembers = " ",Correct,Incorrect;
        }
        field(39; Anaesthesia; Code[50])
        {
        }
        field(40; "Anaesthetist Name"; Text[50])
        {
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field("Anaesthetist ID")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            HMSSetup.Get();
            HMSSetup.TestField("Observation Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Observation Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Surgery Code" := UserId;
    end;

    var
        Charges: Record "HMS Charges";
        Patient: Record "HMS Patient";
        HMSSetup: Record "HMS Setup";
        Doc: Record "HMS Setup Doctor";
        TheatrePersonnel: Record "HMS Theatre Personnel";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
