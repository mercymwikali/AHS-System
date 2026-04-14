table 85584 "Therapy Types"
{
    Caption = 'Therapy Types';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Therapy Types";
    fields
    {
        field(50000; "Therapy Code"; Code[50])
        {
            Caption = 'Therapy Code';
        }
        field(50001; Description; Text[200])
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
