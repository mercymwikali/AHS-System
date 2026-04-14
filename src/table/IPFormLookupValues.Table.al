table 85300 "IP Form Lookup Values"
{
    Caption = 'IP Form Lookup Values';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Type"; Enum "IP Form Types")
        {
            Caption = 'Type';
        }
        field(50001; Category; Code[100])
        {
            Caption = 'Category';
        }
        field(50002; "Sub Category"; text[100])
        {
            Caption = 'Sub Category';
        }
        field(50003; Description; Text[150])
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
