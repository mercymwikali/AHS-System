table 85301 "IP Visitors List"
{
    Caption = 'IP Visitors List';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Admission No."; Code[30])
        {
            Caption = 'Admission No.';
        }
        field(50002; "Visitor Name"; Text[300])
        {
            Caption = 'Visitor Name';
        }
        field(50003; "Id Number"; Text[20])
        {
            Caption = 'Id Number';
        }
        field(50004; "Phone Number"; Text[20])
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
