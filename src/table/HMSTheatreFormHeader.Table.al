Table 85256 "HMS Theatre Form Header"
{
    LookupPageID = "HMS Observation List";

    fields
    {
        field(50000; "No."; Code[20])
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
        field(50001; Type; Option)
        {
            OptionMembers = Appointment,Visit,Admission;
        }
        field(50002; "Theatre Date"; Date)
        {
        }
        field(50003; "Theatre Time"; Time)
        {
        }
        field(50004; "Surgery Code"; Code[100])
        {
            trigger OnValidate()
            begin
                Charges.Reset();
                Charges.SetRange(Charges.Code, "Surgery Code");
                if Charges.Find('-') then
                    Surgery := Charges.Description;
            end;
        }
        field(50005; Surgery; Text[200])
        {
        }
        field(50006; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50007; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50008; "Employee No."; Code[20])
        {
            TableRelation = "HMS ICU Process".Code;
        }
        field(50009; "Relative No."; Integer)
        {
            TableRelation = "Employee Relative"."Line No." where("Employee No." = field("Employee No."));
        }
        field(50010; "Link Type"; Code[20])
        {
        }
        field(50011; "Link No."; Code[20])
        {
        }
        field(50012; "No. Series"; Code[20])
        {
        }
        field(50013; Closed; Boolean)
        {
        }
        field(50014; Status; Option)
        {
            OptionMembers = New,Pending,Closed;
        }
        field(50015; Completed; Boolean)
        {
        }
        field(50016; "Next Appointment Date"; Date)
        {
            trigger OnValidate()
            begin
                if HMSSetup.Get("Patient No.") then begin
                    Patient."Next Appointment" := "Next Appointment Date";
                    Patient.Modify();
                end;
            end;
        }
        field(50017; "Surname Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50018; "Last Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50019; "ADM No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Adm No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50020; "Surgeon Notes"; Text[200])
        {
        }
        field(50021; "Operation Notes"; Text[200])
        {
        }
        field(50022; "Nurse Notes"; Text[200])
        {
        }
        field(50023; "Treatment Notes"; Text[200])
        {
        }
        field(50024; "Doctor ID"; Code[50])
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
        field(50025; "Circulating Nurse ID"; Code[50])
        {
        }
        field(50026; "Anaesthetist ID"; Code[50])
        {
        }
        field(50027; Instructions; Text[250])
        {
        }
        field(50028; "Scrub Nurse"; Code[50])
        {
        }
        field(50029; "Pre-op Diagnosis"; Text[250])
        {
        }
        field(50030; "Post-op Diagnosis"; Text[250])
        {
        }
        field(50031; "Start Time"; Time)
        {
        }
        field(50032; "End Time"; Time)
        {
        }
        field(50033; "Theatre Procedure"; Option)
        {
            OptionCaption = ' ,Minor,Major';
            OptionMembers = " ",Minor,Major;
        }
        field(50034; "Theatre Assistant"; Code[50])
        {
        }
        field(50035; Incision; Text[100])
        {
        }
        field(50036; "Estimated Blood Loss"; Text[50])
        {
        }
        field(50037; "Count"; Option)
        {
            OptionCaption = ' ,Correct,Incorrect';
            OptionMembers = " ",Correct,Incorrect;
        }
        field(50038; Anaesthesia; Code[50])
        {
        }
        field(50039; "Anaesthetist Name"; Text[50])
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
