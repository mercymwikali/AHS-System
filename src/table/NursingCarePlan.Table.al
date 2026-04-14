table 85305 "Nursing Care Plan"
{
    Caption = 'Nursing Care Plan';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Admission No."; Code[30])
        {
            Caption = 'Admission No.';
        }
        field(50001; "Patient No."; Code[30])
        {
            Caption = 'Patient No.';
            TableRelation = "HMS Patient"."Patient No." where(Inpatient = filter(true));

            trigger OnValidate()
            begin
                HMSPatient.Reset();
                HMSPatient.SetRange("Patient No.", "Patient No.");
                if HMSPatient.FindFirst() then begin
                    "Admission No." := HMSPatient."Current Adm No";
                    "Patient Name" := HMSPatient."Search Name";
                end;
            end;
        }
        field(50002; "Patient Name"; Text[250])
        {
            Caption = 'Patient Name';
        }
        field(50003; "Date Taken"; Date)
        {
            Caption = 'Date';
        }
        field(50004; "Time Taken"; Time)
        {
            Caption = 'Time';
        }
        field(50005; "Physical Assessmet(MSA)"; Text[2000])
        {
            Caption = 'Physical Assesmet(MSA)';
        }
        field(50006; "Nursing Diagnosis"; Text[2000])
        {
            Caption = 'Nursing Diagnosis';
        }
        field(50007; Implementation; Text[2000])
        {
            Caption = 'Implementation';
        }
        field(50008; Rationale; Text[2000])
        {
            Caption = 'Rationale';
        }
        field(50009; Evaluation; Text[2000])
        {
            Caption = 'Evaluation';
        }
        field(50010; "Created By"; Code[30])
        {
            Caption = 'Created By';
            trigger OnValidate()
            var
                HREmployee: Record "HR-Employee";
            begin
                HREmployee.Reset();
                HREmployee.SetRange("No.", "Created By");
                    StaffName := HREmployee."Search Name";
            end;

        }
        field(50011; Plan; Text[2000])
        {
            Caption = 'Plan';
        }
        field(50012; StaffName; Text[200])
        {

        }
    }
    keys
    {
        key(PK; "Admission No.", "Patient No.", "Date Taken", "Time Taken")
        {
            Clustered = true;
        }
    }
    var
        HMSPatient: Record "HMS Patient";

    trigger OnInsert()
    begin
        if "Date Taken" = 0D then
            "Date Taken" := Today();

        if "Time Taken" = 0T then
            "Time Taken" := Time;

        if "Created By" = '' then
            "Created By" := USERID;
    end;
}
