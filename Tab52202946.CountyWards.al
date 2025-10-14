table 52202946 "County Wards"
{
    Caption = 'County Wards';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; County; Code[30])
        {
            Caption = 'County';
            TableRelation = "Application Setup County".Code;
        }
        field(4; "Sub-County"; Code[30])
        {
            Caption = 'Sub-County';
            TableRelation = "Sub-County Setup"."Sub County Code" where("County Code" = field(County));
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
