table 52202950 "Doctor Category Setup"
{
    Caption = 'Doctor Category Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Clinic Type"; Code[30])
        {
            Caption = 'Clinic Type';
            TableRelation = "HMS Clinics Setup".No;
        }
        field(3; Description; Code[30])
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
