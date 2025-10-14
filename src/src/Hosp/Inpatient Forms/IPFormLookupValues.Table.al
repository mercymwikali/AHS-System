table 52202957 "IP Form Lookup Values"
{
    Caption = 'IP Form Lookup Values';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Type"; Enum "IP Form Types")
        {
            Caption = 'Type';
        }
        field(2; Category; Code[100])
        {
            Caption = 'Category';
        }
        field(3; "Sub Category"; text[100])
        {
            Caption = 'Sub Category';
        }
        field(4; Description; Text[150])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Type",Category,"Sub Category",Description)
        {
            Clustered = true;
        }
    }
}
