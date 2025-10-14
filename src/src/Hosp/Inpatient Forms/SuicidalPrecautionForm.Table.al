table 52202951 "Suicidal Precaution Form"
{
    Caption = 'Suicidal Precaution Form';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Admission No."; Code[30])
        {
            Caption = 'Admission No';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; "Time"; Time)
        {
            Caption = 'Time';
        }
        field(5; "Handing Over"; Text[50])
        {
            Caption = 'Handing Over';
        }
        field(6; "Taking Over"; Text[50])
        {
            Caption = 'Taking Over';
        }
        field(7; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
    }
    keys
    {
        key(PK; "Line No", "Admission No.", Date)
        {
            Clustered = true;
        }
    }
}
