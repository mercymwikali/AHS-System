table 85297 "Dietary Intake Form Header"
{
    Caption = 'Dietary Intake Form Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Admission No."; Code[30])
        {
            Caption = 'Admission No.';
            TableRelation = "HMS Admission Form Header"."Admission No.";
        }
        field(50001; Height; Decimal)
        {
            Caption = 'Height';
        }
        field(50002; Weight; Decimal)
        {
            Caption = 'Weight';
        }
        field(50003; RM; Decimal)
        {
            Caption = 'RM';
        }
        field(50004; "Preferences (Meals)"; Text[300])
        {
            Caption = 'Preferences (Meals)';
        }
        field(50005; "Preferences (Beverages)"; Text[300])
        {
            Caption = 'Preferences (Beverages)';
        }
    }
    keys
    {
        key(PK; "Admission No.")
        {
            Clustered = true;
        }
    }
}
