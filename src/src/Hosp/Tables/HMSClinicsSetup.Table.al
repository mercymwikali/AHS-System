table 52202944 "HMS Clinics Setup"
{
    Caption = 'HMS Clinics Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; No; Code[30])
        {
            Caption = 'No';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Default Clinic"; Boolean)
        {
            
        }
        field(4; "Clinic Type"; Option)
        {
            OptionCaption = 'General,Psychology';
            OptionMembers = General,Psychology;
        }
        field(5; "Dispatch Area"; Enum "Dispatch Areas")
        {
            
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
