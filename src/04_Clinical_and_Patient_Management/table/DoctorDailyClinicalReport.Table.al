table 85160 "Doctor Daily Clinical Report"
{
    Caption = 'Doctor Daily Clinical Report';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(50001; "Doctor ID"; Code[30])
        {
            Caption = 'Doctor ID';
            TableRelation = "HMS Setup Doctor"."Doctor ID" where(Resident = filter(true));
        }
        field(50002; "Doctor Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Setup Doctor"."Doctors Name" where("Doctor ID" = field("Doctor ID")));
        }
        field(50003; "Specialization"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HMS Setup Doctor".Specialization where("Doctor ID" = field("Doctor ID")));            
        }
        field(50004; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(50005; "Total OP"; Integer)
        {
            Caption = 'Total OP';
        }
        field(50006; "Total IP"; Integer)
        {
            Caption = 'Total IP';
        }
        field(50007; "Total Discharge"; Integer)
        {
            Caption = 'Total Discharge';
        }
        field(50008; "Insurance Count"; Integer)
        {
            Caption = 'Insurance Count';
        }
        field(50009; "Total New Admissions"; Integer)
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
