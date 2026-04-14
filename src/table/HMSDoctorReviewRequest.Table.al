table 85186 "HMS Doctor Review Request"
{
    Caption = 'HMS Doctor Review Request';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Review Request No."; Code[30])
        {
            Caption = 'Review Request No.';
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50002; Clinic; Code[30])
        {
            Caption = 'Clinic';
            TableRelation = "HMS Clinics Setup".No;
        }
        field(50003; "Doctor ID"; Code[30])
        {
            Caption = 'Doctor ID';
            TableRelation = "HMS Setup Doctor"."Doctor ID" where(Specialization = field(Clinic),
                                                                    "Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            trigger OnValidate()
            var
                HMSDoctorSetup: Record "HMS Setup Doctor";
            begin
                if "Doctor ID" <> '' then begin
                    HMSDoctorSetup.Reset();
                    HMSDoctorSetup.SetRange("Doctor ID", "Doctor ID");
                    if HMSDoctorSetup.FindFirst() then
                        "Doctors Name" := HMSDoctorSetup."Doctors Name";
                end;
            end;
        }
        field(50004; "Doctors Name"; Text[250])
        {
            Caption = 'Doctors Name';
        }
        field(50005; "Patient No."; Code[30])
        {
            Caption = 'Patient No.';
            TableRelation = "HMS Patient"."Patient No.";
            trigger OnValidate()
            var
                Patient: Record "HMS Patient";
            begin
                if "Patient No." <> '' then begin
                    Patient.Reset();
                    Patient.SetRange("Patient No.", "Patient No.");
                    if Patient.FindFirst() then
                        "Patients Name" := Patient."Search Name";
                end;
            end;
        }
        field(50007; "Patients Name"; Text[250])
        {
            Caption = 'Doctors Name';
        }
        field(50006; "Request Date"; Date)
        {
            Caption = 'Date';
        }
        field(50008; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",New,Accepted,Cancelled;
            OptionCaption = ' ,New,Accepted,Cancelled';
        }
        field(50009; "Requesting Doctor"; Code[30])
        {
            Caption = 'Requesting Doctor';
            TableRelation = "HMS Setup Doctor"."Doctor ID";
        }
        field(50010; "Appointment Booking No"; Code[30])
        {
            Caption = 'Appointment Booking No';
        }
        field(50011; "Appointment Scheduled"; Boolean)
        {
            Caption = 'Appointment Scheduled';
        }
        field(50012; "Diagnosis"; Code[30])
        {
            Caption = 'Diagnosis';
            TableRelation = "HMS Setup Diagnosis".Code;
        }
        field(50013; "Treatement No."; Code[30])
        {
            Caption = 'Treatement No.';
        }
        field(50014; "Request Reason"; Text[1000])
        {
            Caption = 'Request Reason';
        }

    }
    keys
    {
        key(PK; "Review Request No.")
        {
            Clustered = true;
        }
    }
}
