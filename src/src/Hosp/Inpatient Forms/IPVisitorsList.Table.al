table 52202956 "IP Visitors List"
{
    Caption = 'IP Visitors List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Admission No."; Code[30])
        {
            Caption = 'Admission No.';
        }
        field(3; "Visitor Name"; Text[300])
        {
            Caption = 'Visitor Name';
        }
        field(4; "Id Number"; Text[20])
        {
            Caption = 'Id Number';
        }
        field(5; "Phone Number"; Text[20])
        {
            Caption = 'Phone Number';
        }
    }
    keys
    {
        key(PK; "Line No", "Admission No.", "Id Number")
        {
            Clustered = true;
        }
    }
}
