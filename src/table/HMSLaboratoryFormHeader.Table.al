Table 85311 "HMS Laboratory Form Header"
{
    // DrillDownPageID = "HMS Beds";
    // LookupPageID = "HMS Beds";

    fields
    {
        field(50000; "Laboratory No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "Laboratory No." <> xRec."Laboratory No." then begin
                    HMSSetup.Get();
                    NoSeriesMgt.TestManual(HMSSetup."Lab Test Request Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(50001; "Laboratory Date"; Date)
        {
        }
        field(50002; "Laboratory Time"; Time)
        {
        }
        field(50003; "Patient No."; Code[20])
        {
        }
        field(50004; "Student No."; Code[20])
        {
        }
        field(50005; "Employee No."; Code[20])
        {
        }
        field(50006; "Relative No."; Integer)
        {
        }
        field(50007; "Scheduled Date"; Date)
        {
        }
        field(50008; "Scheduled Time"; Time)
        {
        }
        field(50009; "Supervisor ID"; Code[20])
        {
        }
        field(50010; Status; Option)
        {
            OptionCaption = 'New,Forwarded,Cancelled,Completed,Recalled,Review,Interim';
            OptionMembers = New,Forwarded,Cancelled,Completed,Recalled,Review,Interim;
            trigger OnValidate()
            begin
                // "Doctor ID" := 'Inafika';
            end;
        }
        field(50011; "Link Type"; Code[20])
        {
        }
        field(50012; "Link No."; Code[20])
        {
        }
        field(50013; Remarks; Text[100])
        {
        }
        field(50014; "Request Area"; Option)
        {
            OptionMembers = Doctor,Admission,Walkin;
        }
        field(50015; "No. Series"; Code[20])
        {
        }
        field(50016; "Patient Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Others,Student,Employee,Dependant,High School Student,High School Staff,Primary School Student,Primary School Staff,Roses Staff,Relative';
            OptionMembers = " ",Others,Student,Employee,Dependant,"High School Student","High School Staff","Primary School Student","Primary School Staff","Roses Staff",Relative;
        }
        field(50017; "Lab. Reference No."; Code[20])
        {
        }
        field(50018; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50019; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50020; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50021; "ID Number"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50022; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50023; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50024; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50025; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50026; "Settlement Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(50027; "Cash Sale"; Boolean)
        {
        }
        field(50028; "ADM No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Adm No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50029; "Memeber No"; Code[30])
        {
            CalcFormula = lookup("HMS Patient"."Membership No" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50030; "Receipt Count"; Integer)
        {
            CalcFormula = count("Receipts Header" where("Laboratory No" = field("Laboratory No.")));
            FieldClass = FlowField;
        }
        field(50031; "Open Charges"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Posted = const(false)));
            FieldClass = FlowField;
        }
        field(50032; "Walk-In"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Patient"."Walk-in" where("Patient No." = field("Patient No.")));
        }
        field(50033; "Doctor ID"; Code[50])
        {
        }
        field(50034; "Completion Date"; Date)
        {
        }
        field(50035; "Completion Time"; Time)
        {
        }
        field(50036; "Insurance Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Insurance Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50037; "Appointment No"; Code[30])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Link No." where("Treatment No." = field("Link No.")));
            FieldClass = FlowField;
        }
        field(50038; "Waiting At"; Enum "Dispatch Areas")
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Waiting At" where("Appointment No." = field("Appointment No")));
            FieldClass = FlowField;
            // OptionCaption = ',Registration,Triage,Doctor,Lab,Pharmacy,Imaging,Lab Results';
            // OptionMembers = ,Registration,Triage,Doctor,Lab,Pharmacy,Imaging,"Lab Results";
        }
        field(50039; "Patient Names"; Text[250])
        {
            CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50040; "Doctor Names"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field("Doctor ID")));
            FieldClass = FlowField;
        }
        field(50041; Age; Integer)
        {
            CalcFormula = lookup("HMS Patient"."Age in Years" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50042; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50043; "Global Dimension 1"; Code[30])
        {
            CalcFormula = lookup("HMS Patient"."Global Dimension 1 Code" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50044; "Test Voided"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Reason For Voiding"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50046; "Sampled Received"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50047; "Received by"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Color Code"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '0,1,2';
            OptionMembers = "0","1","2";
        }
        field(50049; "Reviewed By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Reveiw Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "Review Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; Gender; Option)
        {
            CalcFormula = lookup("HMS Patient".Gender where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ',Male,Female';
            OptionMembers = ,Male,Female;
        }
        field(50053; Type; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; Inpatient; Boolean)
        {
            //TODO: Change this to boolean for Accurate Reports
            // DataClassification = ToBeClassified;            
        }
        field(50055; "Treatment No"; code[20])
        {
        }
        field(50056; "Insurance No"; code[20])
        {
            CalcFormula = Lookup("HMS Patient"."Insurance No." WHERE("Patient No." = FIELD("Patient No."), "Patient Type" = FILTER(Corporate)));
            FieldClass = FlowField;
        }
        field(50057; "Samples Collected"; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Laboratory No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Laboratory No." = '' then begin
            HMSSetup.Get();
            HMSSetup.TestField("Lab Test Request Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Lab Test Request Nos", xRec."No. Series", 0D, "Laboratory No.", "No. Series");
        end;
    end;

    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
