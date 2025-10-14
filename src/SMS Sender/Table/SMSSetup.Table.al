table 52202964 "SMS Setup"
{
    Caption = 'SMS Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Partner ID"; Text[200])
        {
            Caption = 'Partner ID';
            DataClassification = ToBeClassified;
        }
        field(3; "ApiKey"; Text[200])
        {
            Caption = 'ApiKey';
            DataClassification = ToBeClassified;
        }
        field(4; "Shortcode"; Text[30])
        {
            Caption = 'ShortCode';
            DataClassification = ToBeClassified;
        }
        field(5; "Send SMS API URL"; Text[200])
        {
            Caption = 'Send SMS API URL';
            DataClassification = ToBeClassified;
        }
        field(6; "Clinical Report SMS Template"; Text[2000])
        {

        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
