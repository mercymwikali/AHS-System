Table 85223 "HMS Physiotheraphy Form Header"
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
        field(50002; "Physio Date"; Date)
        {
        }
        field(50003; "Physio Time"; Time)
        {
        }
        field(50004; "Physio User ID"; Code[20])
        {
            TableRelation = User;
        }
        field(50005; "Physio Remarks"; Text[200])
        {
        }
        field(50006; "Patient No."; Code[20])
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
            TableRelation = if (Type = const(Appointment)) "HMS Appointment Form Header"."Appointment No." where(Status = const(Dispatched), "Dispatch To" = const("Dispatch Areas"::Triage)) else // FIXME Dispatch to hardcoded values funcitonality is changed to setup this will be misleading
            if (Type = const(Visit)) "HMS Treatment Form Header"."Treatment No." where(Status = const(TreatmentStatus::New)) else
            if (Type = const(Admission)) "HMS Admission Form Header"."Admission No." where(Status = const(Admitted));
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
        field(50020; "Frequency/Duration"; Duration)
        {
        }
        field(50021; "Frequency Per Week"; Decimal)
        {
        }
        field(50022; Duration; Text[50])
        {
        }
        field(50023; "Daily Activities"; Text[100])
        {
        }
        field(50024; Examination; Text[100])
        {
        }
        field(50025; "Assesment/Findings"; Text[100])
        {
        }
        field(50026; "Physio DX"; Text[100])
        {
        }
        field(50027; "Goals/Aim"; Text[100])
        {
        }
        field(50028; "Means of RX"; Text[100])
        {
        }
        field(50029; InPatient; Boolean)
        {
            CalcFormula = lookup("HMS Patient".Inpatient where("Patient No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50030; "Physio Area"; Option)
        {
            OptionCaption = ',Gym,Outpatient,Inpatient';
            OptionMembers = ,Gym,Outpatient,Inpatient;
        }
        field(50031; Diagnosis; Text[100])
        {
        }
        field(50032; Doctor; Code[20])
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
