table 85337 "HMS Therapy Form Header"
{
    // LookupPageID = "HMS Laboratory SubForm";

    fields
    {
        field(50000; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HMSSetup.Get();
                    NoSeriesMgt.TestManual(HMSSetup."Therapy Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(50001; Type; Option)
        {
            OptionMembers = Appointment,Visit,Admission;
        }
        field(50002; "Therapy Date"; Date)
        {
        }
        field(50003; "Therapy Time"; Time)
        {
        }
        field(50004; "Therapy User ID"; Code[20])
        {
            TableRelation = User;
        }
        field(50005; "Therapy Remarks"; Text[200])
        {
        }
        field(50006; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";

            trigger OnValidate()
            begin
                Patient.Reset();
                Patient.Get("Patient No.");
                "Middle Name" := Patient."Middle Name";
                "Last Name" := Patient."Last Name";
                "Surname Name" := Patient.Surname;
                Search_Name := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
            end;
        }
        field(50007; "Student No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50008; "Employee No."; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
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
            TableRelation = if (Type = const(Appointment)) "HMS Appointment Form Header"."Appointment No." where(Status = const(Dispatched),
                                                                                                                "Dispatch To" = const("Dispatch Areas"::Consultation))
            else
            if (Type = const(Visit)) "HMS Treatment Form Header"."Treatment No." where(Status = const(TreatmentStatus::New))
            else
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
        field(50020; "Therapy Notes"; blob)
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
        field(50024; "ID Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Middle Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; Address; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; Email; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; Search_Name; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; Doctor; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Setup Doctor";
        }
        field(50030; "Therapy Session"; Option)
        {
            OptionCaption = ' ,Morning (6:30-10am),Mid-Morning (10:30-2pm),Afternoon(2pm-6pm)';
            OptionMembers = " ",Morning,"Mid-Morning",Afternoon;
        }
        field(50031; "Therapy Type"; code[20])
        {
            TableRelation = "Therapy Types"."Therapy Code";
            trigger OnValidate()
            var
                TherapyTypes: Record "Therapy Types";
            begin
                if TherapyTypes.Get("Therapy Type") then
                    "Therapy Description" := TherapyTypes.Description;
            end;
        }
        field(50032; "Therapy Description"; Text[250])
        {
        }
        field(50035; Ward; Code[20])
        {
            TableRelation = "HMS Ward Setup"."Ward Code" where("Branch Code" = field(Branch));
        }
        field(50036; Bed; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Beds"."Bed No" where("Ward No" = field(Ward),
                                                       Occupied = const(false));
            trigger OnValidate()
            var
                Prebooked: Record "HMS Therapy Form Header";
            begin
                Prebooked.Reset();
                Prebooked.SetRange(Prebooked."Therapy Date", "Therapy Date");
                Prebooked.SetRange(Prebooked.Ward, Ward);
                Prebooked.SetRange(Prebooked.Bed, Bed);
                Prebooked.SetRange(Prebooked."Therapy Session", "Therapy Session");
                if not Prebooked.IsEmpty() then
                    Error('There is already a prior booking on %1 for the %2 session, ward %3 bed %4. Kindly book another bed or time', Format("Therapy Date"), Format("Therapy Session"), Ward, Bed);
            end;

            /*  trigger OnValidate()
             begin
                 if (xRec.Bed <> '') and (Bed <> '') then begin
                     if xRec.Bed <> Bed then begin
                         if Confirm('Do you want change the patient Bed Number?', false) then begin
                             HMSPatCharges.Reset;
                             HMSPatCharges.SetRange(HMSPatCharges."Patient No.", "Patient No.");
                             HMSPatCharges.SetRange(HMSPatCharges."Transaction Type", 'BED CHARGES');
                             HMSPatCharges.SetRange(HMSPatCharges.Date, Today);
                             if HMSPatCharges.Find('-') then begin
                                 HMSPatCharges.Code := Bed;
                                 HMSPatCharges.Modify;
                             end;
                         end;
                     end;
                 end;
             end; */
        }
        field(50033; "Branch"; Code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(1));
        }
        field(50034; "Nurse ID"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50037; "Hand-Over Nurse"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50038; "Treatment No."; Code[20])
        {
            TableRelation = "HMS Treatment Form Header"."Treatment No.";
        }
    }

    keys
    {
        key(Key1; "No.", "Treatment No.")
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
            HMSSetup.TestField("Therapy Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Therapy Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Therapy User ID" := Format(UserId);
    end;

    var
        Patient: Record "HMS Patient";
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}