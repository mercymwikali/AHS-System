Table 52202663 "HMS Admission Form Header"
{
    // LookupPageID = "WF Designation List";

    fields
    {
        field(1; "Admission No."; Code[20])
        {
        }
        field(2; "Admission Date"; Date)
        {
            NotBlank = true;
        }
        field(3; "Admission Time"; Time)
        {
            NotBlank = true;
        }
        field(4; "Admission Area"; Option)
        {
            OptionMembers = Doctor,Referral,Rehab;
        }
        field(5; "Patient No."; Code[20])
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
        field(6; "Employee No."; Code[20])
        {
            NotBlank = false;
        }
        field(7; "Relative No."; Integer)
        {
        }
        field(8; Ward; Code[20])
        {
            TableRelation = "HMS Ward Setup"."Ward Code" where("Branch Code" = field(Branch));
        }
        field(9; Bed; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Beds"."Bed No" where("Ward No" = field(Ward),
                                                        "Room No" = field("Ward Room"),
                                                       Occupied = const(false));
        }
        field(10; Doctor; Code[20])
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
        field(11; Remarks; Text[250])
        {
        }
        field(12; Status; Enum AdmissionStatusEnum)
        {
        }
        field(13; "No. Series"; Code[20])
        {
        }
        field(14; "Student No."; Code[20])
        {
        }
        field(15; "Link Type"; Code[20])
        {
        }
        field(16; "Link No."; Code[20])
        {
        }
        field(17; "Admission Reason"; Text[250])
        {
        }
        field(27; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(28; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(29; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(30; "ID Number"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(31; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(32; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(33; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(34; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(35; "Nurse Notes"; Text[200])
        {
        }
        field(36; NHIF; Boolean)
        {
        }
        field(37; "Search Name"; Text[200])
        {
        }
        field(38; Scheme; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(39; "Current Bill"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Patient No." = field("Patient No."),
                                                                          "Total Amount" = filter(> 0),
                                                                          Posted = const(false),
                                                                          Closed = const(false)));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(40; Receipts; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges".Amount where("Patient No." = field("Patient No."),
                                                                  Amount = filter(< 0),
                                                                  Closed = const(false)));
            FieldClass = FlowField;
        }
        field(41; Balance; Decimal)
        {
            FieldClass = Normal;
        }
        field(42; "Admission Type"; Option)
        {
            OptionCaption = ' ,Voluntary,Involuntary';
            OptionMembers = " ",Voluntary,Involuntary;
        }
        field(43; "Admission Height"; Decimal)
        {
        }
        field(44; "Admission Weight"; Decimal)
        {
        }
        field(45; "Admission BMI"; Decimal)
        {
        }
        field(46; Nutrition; Boolean)
        {
        }
        field(47; "Nutrition Status"; Option)
        {
            OptionCaption = ',Sent,Stopped,Start,Aborted,On hold';
            OptionMembers = ,Sent,Stopped,Start,Aborted,"On hold";
        }
        field(48; Counselling; Boolean)
        {
        }
        field(49; "Counselling Status"; Option)
        {
            OptionCaption = ',Sent,Stopped,Start,Aborted,On hold';
            OptionMembers = ,Sent,Stopped,Start,Aborted,"On hold";
        }
        field(50; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(51; "Age in Years"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Date OF Birth"; Date)
        {
            CalcFormula = lookup("HMS Patient"."Date Of Birth" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(53; "CCC Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Sent,Stopped,Start,Aborted,On hold';
            OptionMembers = ,Sent,Stopped,Start,Aborted,"On hold";
        }
        field(54; CCC; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Exists In Discharge"; Integer)
        {
            CalcFormula = count("HMS Admission Discharge Header" where("Admission No." = field("Admission No."),
                                                                        Status = filter(Completed)));
            FieldClass = FlowField;
        }
        field(56; "Appointment No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Dr Name"; Text[30])
        {
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field(Doctor)));
            FieldClass = FlowField;
        }
        field(58; "Patient Name"; text[100])
        {
            CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(59; "Global Dimension1"; code[20])
        {
            CalcFormula = lookup("HMS Patient"."Global Dimension 1 Code" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(60; "Settlement Type"; Option)
        {
            CalcFormula = lookup("HMS Patient"."Patient Type" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Cash,Insurance,Credit';
            OptionMembers = " ",Cash,Insurance,Credit;
        }
        field(61; "Insurance Code"; code[20])
        {
            CalcFormula = Lookup("HMS Patient"."Insurance No." WHERE("Patient No." = FIELD("Patient No."), "Patient Type" = FILTER(Corporate)));
            FieldClass = FlowField;
        }
        field(62; "Therapy Session"; Option) // REFACTOR: Use Setup Based
        {
            OptionCaption = ' ,Morning (6:30-10am),Mid-Morning (10:30-2pm),Afternoon(2pm-6pm)';
            OptionMembers = " ",Morning,"Mid-Morning",Afternoon;
        }
        field(63; "Therapy Type"; code[20])
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
        field(64; "Therapy Description"; Text[200])
        {
        }
        field(65; "Expected Date of Discharge"; Date)
        {

        }
        field(66; "Diagnosis Code"; Code[200])
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
        field(67; "Ward Room"; Code[30])
        {
            TableRelation = "HMS Ward Rooms"."Room No." where("Ward No" = field(Ward));
        }
        field(68; "Psychiatric Coding"; Enum "Psychiatric Coding Enum")
        {

        }
        field(69; "Code Reason"; Text[250])
        {

        }
        field(70; "Cormobidities"; Integer)
        {// Count secondary diagnosis
            FieldClass = FlowField;
            CalcFormula = count("HMS Treatment Form Diagnosis" where("Diagnosis Type" = filter("Secondary Diagnosis"),
                                                                       "Treatment No." = field("Admission No.")));
        }
        field(71; "Next Appointment Date"; Date)
        {

        }
        field(72; "Next Apointment Slot"; Code[30])
        {
            TableRelation = "Doctor Availablity Plan".Slot where("Doctor ID" = field(Doctor),
                                                                 Date = field("Next Appointment Date"),
                                                                 Booked = filter(false));

        }
        field(73; "Next Appointment Time"; Time)
        {

        }
        field(74; "Final Diagnosis"; Code[200])
        {
            TableRelation = "HMS Setup Diagnosis".Code;
        }
        field(75; "Off Duty Days"; Decimal)
        {
        }
        field(76; "Light Duty Days"; Decimal)
        {
        }
        field(77; "Off Duty Comments"; Text[200])
        {
        }
        field(78; "Off Duty"; Boolean)
        {
        }
        field(79; "Sick Off Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if ("Off Duty Days" <> 0) and ("Sick Off Start Date" <> 0D) then
                    "Sick Off End Date" := CalcDate('<+' + format("Off Duty Days") + 'D>', "Sick Off Start Date");
            end;
        }
        field(80; "Sick Off End Date"; Date)
        {
        }
        field(81; "Discharged Date"; Date)
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("HMS Admission Discharge Header"."Discharge Date" where("Admission No." = field("Admission No."), Status = filter(Completed)));           
        }
        field(82; "Final Diagnosis Name"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Setup Diagnosis".Description where(Code = field("Final Diagnosis")));
        }
        field(83; "Next Appointment Comments"; Text[250])
        {
        }
        field(84; "Discharged By"; Code[30])
        {

        }
        field(85; "Resident Doctor"; Boolean)
        {
            // FieldClass = FlowField;
            // CalcFormula = lookup("HMS Setup Doctor".Resident where("Doctor ID" = field(Doctor)));
        }
        field(86; "Created By"; Code[50])
        {

        }
        field(87; "Modified By"; Code[50])
        {

        }
        field(88; isTranscription; Boolean)
        {

        }
        field(89; "Transcribed File No"; Text[50])
        {

        }
        field(90; "Clinic Visited"; Code[50])
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
        NoSeriesMgt: Codeunit NoSeriesManagement;
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
