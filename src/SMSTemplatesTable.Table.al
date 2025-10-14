table 52202992 "SMS Templates Table"
{
    Caption = 'SMS Templates Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; ID; Code[30])
        {
            Caption = 'ID';
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(3; "Template Text"; Text[2048])
        {
            Caption = 'Template Text';
        }
        field(4; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(5; Default; Boolean)
        {
            Caption = 'Default';
        }
        field(6; "Entity Type"; Enum SMSTypes)
        {
            Caption = 'Entity Type';
        }
        field(7; "Version No"; Code[10])
        {
            Caption = 'Version No';
        }
        field(8; "Created By"; Code[30])
        {
            Caption = 'Created By';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
