table 85161 "Doctor Category Setup"
{
    Caption = 'Doctor Category Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(50001; "Clinic Type"; Code[30])
        {
            Caption = 'Clinic Type';
            TableRelation = "HMS Clinics Setup".No;
        }
        field(50002; Description; Code[30])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
