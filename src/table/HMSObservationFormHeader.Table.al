Table 85202 "HMS Observation Form Header"
{
    // DrillDownPageID = UnknownPage70135139;
    // LookupPageID = UnknownPage70135139;

    fields
    {
        field(50000; "Observation No."; Code[20])
        {
            trigger OnValidate()
            begin
                /*
                    IF "Observation No." <> xRec."Observation No." THEN BEGIN
                    HMSSetup.GET;
                    NoSeriesMgt.TestManual(HMSSetup."Observation Nos");
                    "No. Series" := '';
                    END;
                 */
            end;
        }
        field(50001; "Observation Type"; Option)
        {
            OptionMembers = Appointment,Visit,Admission;
        }
        field(50002; "Observation Date"; Date)
        {
        }
        field(50003; "Observation Time"; Time)
        {
        }
        field(50004; "Observation User ID"; Code[20])
        {
            TableRelation = User;
        }
        field(50005; "Observation Remarks"; Text[1500])
        {
        }
        field(50006; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";

            trigger OnValidate()
            begin
                Patient.Reset();
                Patient.Get("Patient No.");

                Names := Patient."Search Name";
                "Patient Name" := Patient."Search Name";
            end;
        }
        field(50007; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50008; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
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
            // TableRelation = if ("Observation Type" = const(Appointment)) "HMS Appointment Form Header"."Appointment No." where(Status = const(Dispatched),
            //                                                                                                                   "Dispatch To" = const("Dispatch Areas"::Triage))
            // else
            // if ("Observation Type" = const(Visit)) "HMS Treatment Form Header"."Treatment No." where(Status = const(TreatmentStatus::New))
            // else
            // if ("Observation Type" = const(Admission)) "HMS Admission Form Header"."Admission No." where(Status = const(Admitted));

            trigger OnValidate()
            var
                HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
            begin
                //TODO: Get Branch from appointment Header
                if "Link Type" = 'Observation' then begin
                    HMSAppointmentFormHeader.Reset();
                    HMSAppointmentFormHeader.SetRange("Appointment No.", "Link No.");
                    if HMSAppointmentFormHeader.FindFirst() then
                        Branch := HMSAppointmentFormHeader.Branch;
                end;
            end;
        }
        field(50012; "No. Series"; Code[20])
        {
        }
        field(50013; Closed; Boolean)
        {
        }
        field(50014; Status; Option)
        {
            OptionMembers = New,Dispatched,Pending,Closed;
        }
        field(50015; Completed; Boolean)
        {
        }
        field(50016; "Patient Name"; Code[250])
        {

        }
        field(50017; "Observation Remarks2"; Text[250])
        {
        }
        field(50018; Doctor; Code[20])
        {
            TableRelation = "HMS Setup Doctor"."Doctor ID";
        }
        field(50019; Names; Text[250])
        {
        }
        field(50020; InPatient; Boolean)
        {
            TableRelation = "HMS Patient".Inpatient where("Patient No." = field("Patient No."));
        }
        field(50021; "TCA Status Remarks"; Text[30])
        {
            Caption = 'TCA Status Remarks';
        }
        field(50022; Physio; Boolean)
        {
        }
        field(50023; "Queued Doc"; Code[30])
        {
            CalcFormula = lookup("HMS Appointment Form Header".Doctor where("Appointment No." = field("Link No.")));
            FieldClass = FlowField;
        }
        field(50024; "Treatment No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Doctor Name"; Text[50])
        {
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field(Doctor)));
            FieldClass = FlowField;
        }
        field(50026; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
        }
        field(50027; "Special Clinics"; Code[30])
        {
            TableRelation = "HMS Clinics Setup".No;
            // OptionCaption = 'Medical,Orthopaedics,Physiotherapy,Psychatric,Neurology,Dental,Optical,Paediatric,Gynacology,Physician,MCH,Day Case,Dialysis,Trauma';
            // OptionMembers = Medical,Orthopaedics,Physiotherapy,Psychatric,Neurology,Dental,Optical,Paediatric,Gynacology,Physician,MCH,"Day Case",Dialysis,Trauma;
        }
        field(50028; isTherapy; Boolean)
        {

        }
        field(50029; "Urgency Status"; Enum "Urgency Status Enum")
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Observation No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Patient.Get("Patient No.");
        Names := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    trigger OnInsert()
    begin
        /*
        IF "Observation No." = '' THEN BEGIN
          HMSSetup.GET;
          HMSSetup.TESTFIELD("Observation Nos");
          NoSeriesMgt.InitSeries(HMSSetup."Observation Nos",xRec."No. Series",0D,"Observation No.","No. Series");
        END;
        */
        //"Observation User ID":=USERID;
        Patient.Get("Patient No.");
        Names := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    trigger OnModify()
    begin
        Patient.Get("Patient No.");
        Names := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    trigger OnRename()
    begin
        Patient.Get("Patient No.");
        Names := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    var
        Patient: Record "HMS Patient";
}
