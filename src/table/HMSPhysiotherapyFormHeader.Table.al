Table 85225 "HMS Physiotherapy Form Header"
{
    //  LookupPageID = UnknownPage70135085;

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
        field(50005; "Observation Remarks"; Text[200])
        {
        }
        field(50006; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";

            trigger OnValidate()
            begin
                Patient.Reset();
                Patient.Get("Patient No.");
                "Student No." := Patient."Student No.";
                "Employee No." := Patient."Employee No.";
                //  "Relative No." := Patient."Relative No.";
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
            TableRelation = if ("Observation Type" = const(Appointment)) "HMS Appointment Form Header"."Appointment No." where(Status = const(Dispatched),
                                                                                                                              "Dispatch To" = const("Dispatch Areas"::Consultation))
            else
            if ("Observation Type" = const(Visit)) "HMS Treatment Form Header"."Treatment No." where(Status = const(TreatmentStatus::New))
            else
            if ("Observation Type" = const(Admission)) "HMS Admission Form Header"."Admission No." where(Status = const(Admitted));
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
        field(50016; "Patient Name"; Code[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
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
    end;

    var
        Patient: Record "HMS Patient";
}
