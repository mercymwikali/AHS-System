table 85306 "Suicidal Precaution Form"
{
    Caption = 'Suicidal Precaution Form';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Admission No."; Code[30])
        {
            Caption = 'Admission No';
        }
        field(50002; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(50003; "Time"; Time)
        {
            Caption = 'Time';
        }
        field(50004; "Handing Over"; Text[50])
        {
            Caption = 'Handing Over';
        }
        field(50005; "Taking Over"; Text[50])
        {
            Caption = 'Taking Over';
        }
        field(50006; Remarks; Text[250])
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
