table 85045 "SMS Templates Table"
{
    Caption = 'SMS Templates Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; ID; Code[30])
        {
            Caption = 'ID';
        }
        field(50001; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(50002; "Template Text"; Text[2048])
        {
            Caption = 'Template Text';
        }
        field(50003; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(50004; Default; Boolean)
        {
            Caption = 'Default';
        }
        field(50005; "Entity Type"; Enum SMSTypes)
        {
            Caption = 'Entity Type';
        }
        field(50006; "Version No"; Code[10])
        {
            Caption = 'Version No';
        }
        field(50007; "Created By"; Code[30])
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
