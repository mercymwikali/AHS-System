table 85001 "Clinical Report Recepients"
{
    Caption = 'Clinical Report Recepients';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(50001; Name; Text[150])
        {
            Caption = 'Name';
        }
        field(50002; "Phone No"; Text[30])
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
