table 52202945 "Sub-County Setup"
{
    Caption = 'Sub-County Setup';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Sub-County Setup";

    fields
    {
        field(1; "Sub County Code"; Code[50])
        {
            Caption = 'Sub County Code';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "County Code"; Code[30])
        {
            TableRelation = "Application Setup County".Code;
            Caption = 'County Code';
        }
    }
    keys
    {
        key(PK; "Sub County Code")
        {
            Clustered = true;
        }
    }
}
