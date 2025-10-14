table 52202988 "Doctor Daily Clinical Report"
{
    Caption = 'Doctor Daily Clinical Report';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; "Doctor ID"; Code[30])
        {
            Caption = 'Doctor ID';
            TableRelation = "HMS Setup Doctor"."Doctor ID" where(Resident = filter(true));
        }
        field(3; "Doctor Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field("Doctor ID")));
        }
        field(4; "Specialization"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Setup Doctor".Specialization where("Doctor ID" = field("Doctor ID")));            
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(6; "Total OP"; Integer)
        {
            Caption = 'Total OP';
        }
        field(7; "Total IP"; Integer)
        {
            Caption = 'Total IP';
        }
        field(8; "Total Discharge"; Integer)
        {
            Caption = 'Total Discharge';
        }
        field(9; "Insurance Count"; Integer)
        {
            Caption = 'Insurance Count';
        }
        field(10; "Total New Admissions"; Integer)
        {
            Caption = 'Total New Admissions';
        }
    }
    keys
    {
        key(PK; "Line No",Date,"Doctor ID")
        {
            Clustered = true;
        }
    }
}
