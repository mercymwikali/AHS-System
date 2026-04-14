table 85043 "SMS Setup"
{
    Caption = 'SMS Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(50001; "Partner ID"; Text[200])
        {
            Caption = 'Partner ID';
            DataClassification = ToBeClassified;
        }
        field(50002; "ApiKey"; Text[200])
        {
            Caption = 'ApiKey';
            DataClassification = ToBeClassified;
        }
        field(50003; "Shortcode"; Text[30])
        {
            Caption = 'ShortCode';
            DataClassification = ToBeClassified;
        }
        field(50004; "Send SMS API URL"; Text[200])
        {
            Caption = 'Send SMS API URL';
            DataClassification = ToBeClassified;
        }
        field(50005; "Clinical Report SMS Template"; Text[2000])
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
