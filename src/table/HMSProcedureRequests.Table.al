table 85336 "HMS Procedure Requests"
{
    Caption = 'HMS Procedure Requests';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Link No"; Code[30])
        {
            Caption = 'Link No';
            trigger OnValidate()
            begin
                
            end;
        }
        field(50002; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(50003; "Patient No"; Code[30])
        {
            Caption = 'Patient No';
        }
        field(50004; "Patient Name"; Code[30])
        {
            Caption = 'Patient Name';
        }
        field(50005; "Procedure Type"; Enum PatientProcedureTypesEnum)
        {
            Caption = 'Procedure Type';
        }
        field(50006; "Doctor ID"; Code[30])
        {
            Caption = 'Doctor ID';
            TableRelation = "HMS Setup Doctor"."Doctor ID";
            // TODO: Add Filter of Doctor Type
            trigger OnValidate()
            var
                Doctor: Record "HMS Setup Doctor";
            begin
                if Doctor.Get("Doctor ID") then
                    "Doctors Name" := Doctor."Doctors Name";
            end;
        }
        field(50007; "Doctors Name"; Code[30])
        {
            Caption = 'Doctors Name';
        }
        field(50008; "Procedure Date"; Date)
        {
            Caption = 'Procedure Date';
        }
        field(50009; "Total count"; Integer)
        {
            Caption = 'Total count';
        }
        field(50010; "Total Done"; Integer)
        {
            Caption = 'Total Done';
        }
        field(50011; "Procedure Notes"; Text[2048])
        {
            Caption = 'ECT Notes';
        }
        field(50012; "Requesting Doctor"; Code[30])
        {
            Caption = 'Requesting Doctor';
        }
        field(50013; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = ,New,"Request Sent",Active,Done;
        }
        field(50014; "Charge Code"; Code[150])
        {
            Caption = 'Charge Code';
            TableRelation = "HMS Charges".Code;
        }
    }
    keys
    {
        key(PK; "Line No","Link No")
        {
            Clustered = true;
        }
        key(Key1; "Request Date", "Patient No", "Procedure Type", "Doctor ID", "Procedure Date")
        {
        }
    }
}
