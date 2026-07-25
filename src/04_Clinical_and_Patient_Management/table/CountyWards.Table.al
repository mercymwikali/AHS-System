table 85583 "County Wards"
{
    Caption = 'County Wards';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Code"; Code[30])
        {
            Caption = 'Code';
        }
        field(50001; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(50002; County; Code[30])
        {
            Caption = 'County';
            TableRelation = "Application Setup County".Code;
        }
        field(50003; "Sub-County"; Code[30])
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
