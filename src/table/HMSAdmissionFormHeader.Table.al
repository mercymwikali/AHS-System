Table 85173 "HMS Admission Form Header"
{
    // LookupPageID = "WF Designation List";

    fields
    {
        field(50000; "Admission No."; Code[20])
        {
        }
        field(50001; "Admission Date"; Date)
        {
            NotBlank = true;
        }
        field(50002; "Admission Time"; Time)
        {
            NotBlank = true;
        }
        field(50003; "Admission Area"; Option)
        {
            OptionMembers = Doctor,Referral,Rehab;
        }
        field(50004; "Patient No."; Code[20])
        {
            NotBlank = true;
            trigger OnValidate()
            var
                HMSPat: Record "HMS Patient";
            begin
                if HMSPat.get("Patient No.") then
                    Branch := HMSPat."Global Dimension 1 Code";
            end;
        }
        field(50005; "Employee No."; Code[20])
        {
            NotBlank = false;
        }
        field(50006; "Relative No."; Integer)
        {
        }
        field(50007; Ward; Code[20])
        {
            TableRelation = "HMS Ward Setup"."Ward Code" where("Branch Code" = field(Branch));
        }
        field(50008; Bed; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Beds"."Bed No" where("Ward No" = field(Ward),
                                                        "Room No" = field("Ward Room"),
                                                       Occupied = const(false));
        }
        field(50009; Doctor; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Doctor"."Doctor ID";
            trigger OnValidate()
            var
                HMSSetupDoctor: Record "HMS Setup Doctor";
            begin
                HMSSetupDoctor.Reset();
                HMSSetupDoctor.SetRange("Doctor ID", Doctor);
                if HMSSetupDoctor.FindFirst() then
                    "Resident Doctor" := HMSSetupDoctor.Resident;
            end;
        }
        field(50010; Remarks; Text[250])
        {
        }
        field(50011; Status; Enum AdmissionStatusEnum)
        {
        }
        field(50012; "No. Series"; Code[20])
        {
        }
        field(50013; "Student No."; Code[20])
        {
        }
        field(50014; "Link Type"; Code[20])
        {
        }
        field(50015; "Link No."; Code[20])
        {
        }
        field(50016; "Admission Reason"; Text[250])
        {
        }
        field(50017; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50018; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50019; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50020; "ID Number"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50021; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50022; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50023; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50024; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50025; "Nurse Notes"; Text[200])
        {
        }
        field(50026; NHIF; Boolean)
        {
        }
        field(50027; "Search Name"; Text[200])
        {
        }
        field(50028; Scheme; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(50029; "Current Bill"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Total Amount" = filter(> 0),
                                                                          Posted = const(false),
                                                                          Closed = const(false)));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(50030; Receipts; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Amount = filter(< 0),
                                                                  Closed = const(false)));
            FieldClass = FlowField;
        }
        field(50031; Balance; Decimal)
        {
            FieldClass = Normal;
        }
        field(50032; "Admission Type"; Option)
        {
            OptionCaption = ' ,Voluntary,Involuntary';
            OptionMembers = " ",Voluntary,Involuntary;
        }
        field(50033; "Admission Height"; Decimal)
        {
        }
        field(50034; "Admission Weight"; Decimal)
        {
        }
        field(50035; "Admission BMI"; Decimal)
        {
        }
        field(50036; Nutrition; Boolean)
        {
        }
        field(50037; "Nutrition Status"; Option)
        {
            OptionCaption = ',Sent,Stopped,Start,Aborted,On hold';
            OptionMembers = ,Sent,Stopped,Start,Aborted,"On hold";
        }
        field(50038; Counselling; Boolean)
        {
        }
        field(50039; "Counselling Status"; Option)
        {
            OptionCaption = ',Sent,Stopped,Start,Aborted,On hold';
            OptionMembers = ,Sent,Stopped,Start,Aborted,"On hold";
        }
        field(50040; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(50041; "Age in Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Date OF Birth"; Date)
        {
            CalcFormula = lookup("HMS Patient"."Date Of Birth" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50043; "CCC Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Sent,Stopped,Start,Aborted,On hold';
            OptionMembers = ,Sent,Stopped,Start,Aborted,"On hold";
        }
        field(50044; CCC; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Exists In Discharge"; Integer)
        {
            CalcFormula = count("HMS Admission Discharge Header" where("Admission No." = field("Admission No."),
                                                                        Status = filter(Completed)));
            FieldClass = FlowField;
        }
        field(50046; "Appointment No."; Code[20])
        {
            CalcFormula = lookup("HMS Appointment Form Header"."Appointment No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            }
        field(50047; "Dr Name"; Text[30])
        {
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field(Doctor)));
            FieldClass = FlowField;
        }
        field(50048; "Patient Name"; text[100])
        {
            CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50049; "Global Dimension1"; code[20])
        {
            CalcFormula = lookup("HMS Patient"."Global Dimension 1 Code" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50050; "Settlement Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Cash,Insurance,Credit';
            OptionMembers = " ",Cash,Insurance,Credit;
        }
        field(50051; "Insurance Code"; code[20])
        {
            CalcFormula = Lookup("HMS Patient"."Insurance No." WHERE("Patient No." = FIELD("Patient No."), "Patient Type" = FILTER(Corporate)));
            FieldClass = FlowField;
        }
        field(50052; "Therapy Session"; Option) // REFACTOR: Use Setup Based
        {
            OptionCaption = ' ,Morning (6:30-10am),Mid-Morning (10:30-2pm),Afternoon(2pm-6pm)';
            OptionMembers = " ",Morning,"Mid-Morning",Afternoon;
        }
        field(50053; "Therapy Type"; code[20])
        {
            TableRelation = "Therapy Types"."Therapy Code";
            trigger OnValidate()
            var
                TherapyType: Record "Therapy Types";
            begin
                if TherapyType.Get("Therapy Type") then
                    "Therapy Description" := TherapyType.Description;
            end;
        }
        field(50054; "Therapy Description"; Text[200])
        {
        }
        field(50055; "Expected Date of Discharge"; Date)
        {

        }
        field(50056; "Diagnosis Code"; Code[200])
        {
            // NotBlank = true; TODO: A Patient must have a diagnosis for them to be admitted            
            TableRelation = "HMS Setup Diagnosis".Code;

            trigger OnValidate()
            var
                HMSSetupDiagnosis: Record "HMS Setup Diagnosis";
            begin
                HMSSetupDiagnosis.Reset();
                HMSSetupDiagnosis.SetRange(Code, "Diagnosis Code");
                if HMSSetupDiagnosis.FindFirst() then
                    "Expected Date of Discharge" := CalcDate(HMSSetupDiagnosis."Expected Date of Discharge", "Admission Date");
            end;
        }
        field(50057; "Ward Room"; Code[30])
        {
            TableRelation = "HMS Ward Rooms"."Room No." where("Ward No" = field(Ward));
        }
        field(50058; "Psychiatric Coding"; Enum "Psychiatric Coding Enum")
        {

        }
        field(50059; "Code Reason"; Text[250])
        {

        }
        field(50060; "Cormobidities"; Integer)
        {// Count secondary diagnosis
            FieldClass = FlowField;
            CalcFormula = count("HMS Treatment Form Diagnosis" where("Diagnosis Type" = filter("Secondary Diagnosis"),
                                                                       "Treatment No." = field("Admission No.")));
        }
        field(50061; "Next Appointment Date"; Date)
        {

        }
        field(50062; "Next Apointment Slot"; Code[30])
        {
            TableRelation = "Doctor Availablity Plan".Slot where("Doctor ID" = field(Doctor),
                                                                 Date = field("Next Appointment Date"),
                                                                 Booked = filter(false));

        }
        field(50063; "Next Appointment Time"; Time)
        {

        }
        field(50064; "Final Diagnosis"; Code[200])
        {
            TableRelation = "HMS Setup Diagnosis".Code;
        }
        field(50065; "Off Duty Days"; Decimal)
        {
        }
        field(50066; "Light Duty Days"; Decimal)
        {
        }
        field(50067; "Off Duty Comments"; Text[200])
        {
        }
        field(50068; "Off Duty"; Boolean)
        {
        }
        field(50069; "Sick Off Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if ("Off Duty Days" <> 0) and ("Sick Off Start Date" <> 0D) then
                    "Sick Off End Date" := CalcDate('<+' + format("Off Duty Days") + 'D>', "Sick Off Start Date");
            end;
        }
        field(50070; "Sick Off End Date"; Date)
        {
        }
        field(50071; "Discharged Date"; Date)
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("HMS Admission Discharge Header"."Discharge Date" where("Admission No." = field("Admission No."), Status = filter(Completed)));           
        }
        field(50072; "Final Diagnosis Name"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Setup Diagnosis".Description where(Code = field("Final Diagnosis")));
        }
        field(50073; "Next Appointment Comments"; Text[250])
        {
        }
        field(50074; "Discharged By"; Code[30])
        {

        }
        field(50075; "Resident Doctor"; Boolean)
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("HMS Setup Doctor".Resident where("Doctor ID" = field(Doctor)));
        }
        field(50076; "Created By"; Code[50])
        {

        }
        field(50077; "Modified By"; Code[50])
        {

        }
        field(50078; isTranscription; Boolean)
        {

        }
        field(50079; "Transcribed File No"; Text[50])
        {

        }
        field(50080; "Clinic Visited"; Code[50])
        {

        }
    }

    keys
    {
        key(Key1; "Admission No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    var
        HmsPatient: Record "HMS Patient";
        HmsSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
    begin
        if "Admission No." = '' then begin
            HMSSetup.Get();
            "Admission No." := NoSeriesMgt.GetNextNo(HMSSetup."Admission Request Nos", 0D, true);
        end;
        //Check if admisisons already exists
        if "Patient No." <> '' then begin
            HMSAdmissionFormHeader.Reset();
            HMSAdmissionFormHeader.SetRange("Patient No.", "Patient No.");
            HMSAdmissionFormHeader.SetRange(Status, HMSAdmissionFormHeader.Status::Admitted);
            if HMSAdmissionFormHeader.FindFirst() then
                if not isTranscription then
                    Error('Patient Already has an active Admission %1', HMSAdmissionFormHeader."Admission No.");

            // Should only update patient if admitted

            // HmsPatient.Reset();
            // HmsPatient.SetRange("Patient No.", Rec."Patient No.");
            // if HmsPatient.FindFirst() then begin
            //     if HmsPatient."Global Dimension 1 Code" <> Rec.Branch then
            //         HmsPatient."Global Dimension 1 Code" := CopyStr(Rec.Branch, 1, MaxStrLen(HmsPatient."Global Dimension 1 Code"));
            //     HmsPatient."Active Visit No" := rec."Admission No.";
            //     HmsPatient.Modify();
            // end;
        end;
    end;

    trigger OnDelete()
    begin
        // Error('Deletion is not allowed');
    end;
}
