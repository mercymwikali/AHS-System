table 52202947 "Therapy Types"
{
    Caption = 'Therapy Types';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Therapy Types";
    fields
    {
        field(1; "Therapy Code"; Code[50])
        {
            Caption = 'Therapy Code';
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Therapy Code")
        {
            Clustered = true;
        }
    }
}
