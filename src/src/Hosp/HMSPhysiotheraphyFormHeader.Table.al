Table 52202477 "HMS Physiotheraphy Form Header"
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
        field(3; "Physio Date"; Date)
        {
        }
        field(4; "Physio Time"; Time)
        {
        }
        field(5; "Physio User ID"; Code[20])
        {
            TableRelation = User;
        }
        field(6; "Physio Remarks"; Text[200])
        {
        }
        field(7; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";

            trigger OnValidate()
            begin
                Patient.Reset();
                Patient.Get("Patient No.");
                /*
                "Student No.":=Patient."Student No.";
                "Employee No.":=Patient."Employee No.";
                "Relative No.":=Patient."Relative No.";
                */
            end;
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
            TableRelation = if (Type = const(Appointment)) "HMS Appointment Form Header"."Appointment No." where(Status = const(Dispatched), "Dispatch To" = const("Dispatch Areas"::Triage)) else // FIXME Dispatch to hardcoded values funcitonality is changed to setup this will be misleading
            if (Type = const(Visit)) "HMS Treatment Form Header"."Treatment No." where(Status = const(TreatmentStatus::New)) else
            if (Type = const(Admission)) "HMS Admission Form Header"."Admission No." where(Status = const(Admitted));
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
        field(21; "Frequency/Duration"; Duration)
        {
        }
        field(22; "Frequency Per Week"; Decimal)
        {
        }
        field(23; Duration; Text[50])
        {
        }
        field(24; "Daily Activities"; Text[100])
        {
        }
        field(25; Examination; Text[100])
        {
        }
        field(26; "Assesment/Findings"; Text[100])
        {
        }
        field(27; "Physio DX"; Text[100])
        {
        }
        field(28; "Goals/Aim"; Text[100])
        {
        }
        field(29; "Means of RX"; Text[100])
        {
        }
        field(30; InPatient; Boolean)
        {
            CalcFormula = lookup("HMS Patient".Inpatient where("Patient No." = field("No.")));
            FieldClass = FlowField;
        }
        field(31; "Physio Area"; Option)
        {
            OptionCaption = ',Gym,Outpatient,Inpatient';
            OptionMembers = ,Gym,Outpatient,Inpatient;
        }
        field(32; Diagnosis; Text[100])
        {
        }
        field(33; Doctor; Code[20])
        {
            TableRelation = "HMS Setup Doctor"."Doctor ID";
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

        "Physio User ID" := UserId;
    end;

    var
        Patient: Record "HMS Patient";
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
