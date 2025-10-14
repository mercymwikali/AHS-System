table 52202991 "Clinical Report Recepients"
{
    Caption = 'Clinical Report Recepients';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; Name; Text[150])
        {
            Caption = 'Name';
        }
        field(3; "Phone No"; Text[30])
        {
            Caption = 'Phone No';
        }
    }
    keys
    {
        key(PK; "Line No", "Phone No")
        {
            Clustered = true;
        }
    }
}
