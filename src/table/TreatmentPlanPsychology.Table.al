table 85339 "Treatment Plan(Psychology)"
{
    Caption = 'Treatment Plan(Psychology)';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Plan No."; Code[30])
        {
            Caption = 'Plan No.';
        }
        field(50001; "Patient No."; Code[30])
        {
            Caption = 'Patient No.';
            TableRelation = "HMS Patient"."Patient No.";

            trigger OnValidate()
            var
                HMSPatient: Record "HMS Patient";
            begin
                if HMSPatient.Get("Patient No.") then
                    "Patient Name" := HMSPatient."Search Name"
            end;
        }
        field(50002; "Patient Name"; Text[250])
        {
            Caption = 'Patient Name';
        }
        field(50003; "Doctor No."; Code[30])
        {
            Caption = 'Doctor No.';
            TableRelation = "HMS Setup Doctor"."Doctor ID";
            trigger OnValidate()
            var
                HMSSetupDoctor: Record "HMS Setup Doctor";
            begin
                if HMSSetupDoctor.Get("Doctor No.") then
                    "Doctor Name" := HMSSetupDoctor."Doctors Name";
            end;
        }
        field(50004; "Doctor Name"; Text[250])
        {
            Caption = 'Doctor Name';
        }
        field(50005; Diagnosis; Code[100])
        {
            Caption = 'Diagnosis';
        }
        field(50006; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'new, in progress, completed';
            OptionMembers = New,"In Progress",Completed;

        }
        field(50007; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
    }
    keys
    {
        key(PK; "Plan No.")
        {
            Clustered = true;
        }
    }
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()

    begin
        if "Plan No." = '' then begin
            HMSSetup.Get();
            HMSSetup.TestField("Treatment Plan Nos(Therapy)");
            "Plan No." := NoSeriesMgt.GetNextNo(HMSSetup."Treatment Plan Nos(Therapy)", 0D, true);
            "No. Series" := '';
        end;
    end;
}