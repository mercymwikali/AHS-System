table 85585 "Vital Scale"
{
    Caption = 'Vital Scale';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; Tier; Integer)
        {
            Caption = 'Tier';
        }
        field(50001; "Lower Limit"; Decimal)
        {
            Caption = 'Lower Limit';
        }
        field(50002; "Upper Limit"; Decimal)
        {
            Caption = 'Upper Limit';
        }
        field(50003; "Vital Type"; Option)
        {
            Caption = 'Vital Type';
            OptionCaption = 'Blood Pressure,Blood Sugars,Blood Oxygen';
            OptionMembers = "Blood Pressure","Blood Sugars","Blood Oxygen";
        }
        field(50004; Remarks; Text[50])
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
