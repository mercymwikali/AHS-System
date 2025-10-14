table 52202953 "Dietary Intake Form Header"
{
    Caption = 'Dietary Intake Form Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Admission No."; Code[30])
        {
            Caption = 'Admission No.';
            TableRelation = "HMS Admission Form Header"."Admission No.";
        }
        field(2; Height; Decimal)
        {
            Caption = 'Height';
        }
        field(3; Weight; Decimal)
        {
            Caption = 'Weight';
        }
        field(4; RM; Decimal)
        {
            Caption = 'RM';
        }
        field(5; "Preferences (Meals)"; Text[300])
        {
            Caption = 'Preferences (Meals)';
        }
        field(6; "Preferences (Beverages)"; Text[300])
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
