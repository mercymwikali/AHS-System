table 52202974 "Mpesa Integration Setup"
{
    Caption = 'Mpesa Integration Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(3; "Short Code"; Integer)
        {
            Caption = 'Short Code';
        }
        field(4; "Consumer Key"; Text[50])
        {
            Caption = 'Consumer Key';
        }
        field(5; "Consumer Secret"; Text[50])
        {
            Caption = 'Consumer Secret';
        }
        field(6; "API Integration Type"; Option)
        {
            Caption = 'API Integration Type';
            OptionMembers = "C2B","STK PUSH";
        }
        field(7; "CallBack URL"; Text[2048])
        {
            Caption = 'CallBack URL';
        }
    }
    keys
    {
        key(PK; "Entry No", "Global Dimension 1 Code")
        {
            Clustered = true;
        }
    }
}
