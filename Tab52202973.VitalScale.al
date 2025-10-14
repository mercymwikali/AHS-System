table 52202973 "Vital Scale"
{
    Caption = 'Vital Scale';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Tier; Integer)
        {
            Caption = 'Tier';
        }
        field(2; "Lower Limit"; Decimal)
        {
            Caption = 'Lower Limit';
        }
        field(3; "Upper Limit"; Decimal)
        {
            Caption = 'Upper Limit';
        }
        field(4; "Vital Type"; Option)
        {
            Caption = 'Vital Type';
            OptionCaption = 'Blood Pressure,Blood Sugars,Blood Oxygen';
            OptionMembers = "Blood Pressure","Blood Sugars","Blood Oxygen";
        }
        field(5; Remarks; Text[50])
        {
            Caption = 'Upper Limit';
        }
    }
    keys
    {
        key(PK; Tier)
        {
            Clustered = true;
        }
    }
}
