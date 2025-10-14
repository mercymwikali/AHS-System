table 52202970 "HMS Procedure Requests"
{
    Caption = 'HMS Procedure Requests';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Link No"; Code[30])
        {
            Caption = 'Link No';
            trigger OnValidate()
            begin
                
            end;
        }
        field(3; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(4; "Patient No"; Code[30])
        {
            Caption = 'Patient No';
        }
        field(5; "Patient Name"; Code[30])
        {
            Caption = 'Patient Name';
        }
        field(6; "Procedure Type"; Enum PatientProcedureTypesEnum)
        {
            Caption = 'Procedure Type';
        }
        field(7; "Doctor ID"; Code[30])
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
        field(8; "Doctors Name"; Code[30])
        {
            Caption = 'Doctors Name';
        }
        field(9; "Procedure Date"; Date)
        {
            Caption = 'Procedure Date';
        }
        field(10; "Total count"; Integer)
        {
            Caption = 'Total count';
        }
        field(11; "Total Done"; Integer)
        {
            Caption = 'Total Done';
        }
        field(12; "Procedure Notes"; Text[2048])
        {
            Caption = 'ECT Notes';
        }
        field(13; "Requesting Doctor"; Code[30])
        {
            Caption = 'Requesting Doctor';
        }
        field(14; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = ,New,"Request Sent",Active,Done;
        }
        field(15; "Charge Code"; Code[150])
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
