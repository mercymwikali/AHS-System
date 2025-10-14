table 52202963 "HMS Secondary Diagnosis Setup"
{
    Caption = 'HMS Secondary Diagnosis Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Diagnosis Code"; Code[30])
        {
            Caption = 'Diagnosis Code';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; Diagnosis; Code[200])
        {
            Caption = 'Diagnosis';
        }
        field(4; "MOH Code"; Code[200])
        {
            Caption = 'MOH Code';
        }
        field(5; "MOH Description"; Code[200])
        {
            Caption = 'MOH Description';
        }
        field(6; "Male Counter"; Integer)
        {
            Caption = 'Male Counter';
        }
        field(7; "Female Counter"; Integer)
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
