table 85350 "HMS Clinics Setup"
{
    Caption = 'HMS Clinics Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; No; Code[30])
        {
            Caption = 'No';
        }
        field(50001; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(50002; "Default Clinic"; Boolean)
        {
            
        }
        field(50003; "Clinic Type"; Option)
        {
            OptionCaption = 'General,Psychology';
            OptionMembers = General,Psychology;
        }
        field(50004; "Dispatch Area"; Enum "Dispatch Areas")
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
