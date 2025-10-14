Table 52202485 "HMS ICU Form Header"
{
   // LookupPageID = UnknownPage39006006;

    fields
    {
        field(1;"No.";Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  HMSSetup.Get;
                  NoSeriesMgt.TestManual(HMSSetup."Observation Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;Type;Option)
        {
            OptionMembers = Appointment,Visit,Admission;
        }
        field(3;"ICU Date";Date)
        {
        }
        field(4;"ICU Time";Time)
        {
        }
        field(5;"ICU User ID";Code[20])
        {
            TableRelation = User;
        }
        field(6;"ICU Remarks";Text[200])
        {
        }
        field(7;"Patient No.";Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";

            trigger OnValidate()
            begin
                Patient.Reset;
                Patient.Get("Patient No.");
                /*
                "Student No.":=Patient."Student No.";
                "Employee No.":=Patient."Employee No.";
                "Relative No.":=Patient."Relative No.";
                */

            end;
        }
        field(8;"Student No.";Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(9;"Employee No.";Code[20])
        {
            TableRelation = "HMS ICU Process".Code;
        }
        field(10;"Relative No.";Integer)
        {
            TableRelation = "Employee Relative"."Line No." where ("Employee No."=field("Employee No."));
        }
        field(11;"Link Type";Code[20])
        {
        }
        field(12;"Link No.";Code[20])
        {
            TableRelation = if (Type=const(Appointment)) "HMS Appointment Form Header"."Appointment No." where (Status=const(Dispatched),
                                                                                                                "Dispatch To"=const("Dispatch Areas"::Triage))
                                                                                                                else if (Type=const(Visit)) "HMS Treatment Form Header"."Treatment No." where (Status=const(TreatmentStatus::New))
                                                                                                                else if (Type=const(Admission)) "HMS Admission Form Header"."Admission No." where (Status=const(Admitted));
        }
        field(13;"No. Series";Code[20])
        {
        }
        field(14;Closed;Boolean)
        {
        }
        field(15;Status;Option)
        {
            OptionMembers = New,Pending,Closed;
        }
        field(16;Completed;Boolean)
        {
        }
        field(17;"Next Appointment Date";Date)
        {

            trigger OnValidate()
            begin
                 if HMSSetup.Get("Patient No.") then begin
                 Patient."Next Appointment":="Next Appointment Date";
                 Patient.Modify;
                 end;
            end;
        }
        field(18;"Surname Name";Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where ("Patient No."=field("Patient No.")));
            FieldClass = FlowField;
        }
        field(19;"Last Name";Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where ("Patient No."=field("Patient No.")));
            FieldClass = FlowField;
        }
        field(20;"ADM No";Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Adm No." where ("Patient No."=field("Patient No.")));
            FieldClass = FlowField;
        }
        field(21;"ICU Notes";Text[200])
        {
        }
        field(22;"Operation Notes";Text[200])
        {
        }
        field(23;"Nurse Notes";Text[200])
        {
        }
        field(24;"Treatment Notes";Text[200])
        {
        }
    }

    keys
    {
        key(Key1;"No.")
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
          HMSSetup.Get;
          HMSSetup.TestField("Observation Nos");
          NoSeriesMgt.InitSeries(HMSSetup."Observation Nos",xRec."No. Series",0D,"No.","No. Series");
        end;

        "ICU User ID":=UserId;
    end;

    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Patient: Record "HMS Patient";
}

