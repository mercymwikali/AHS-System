table 85239 "HMS Secondary Diagnosis Setup"
{
    Caption = 'HMS Secondary Diagnosis Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Diagnosis Code"; Code[30])
        {
            Caption = 'Diagnosis Code';
        }
        field(50001; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(50002; Diagnosis; Code[200])
        {
            Caption = 'Diagnosis';
        }
        field(50003; "MOH Code"; Code[200])
        {
            Caption = 'MOH Code';
        }
        field(50004; "MOH Description"; Code[200])
        {
            Caption = 'MOH Description';
        }
        field(50005; "Male Counter"; Integer)
        {
            Caption = 'Male Counter';
        }
        field(50006; "Female Counter"; Integer)
        {
            Caption = 'Female Counter';
        }
    }
    keys
    {
        key(PK; "Diagnosis Code")
        {
            Clustered = true;
        }
        key(key2; Description)
        {

        }
        key(key3; Diagnosis)
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Description, "Diagnosis Code")
        {
        }
        fieldgroup(Brick; Description, "Diagnosis Code")
        {
        }
    }
}
