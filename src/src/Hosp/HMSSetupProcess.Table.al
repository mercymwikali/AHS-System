Table 52202695 "HMS Setup Process"
{
    // LookupPageID = UnknownPage50006;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'Stores the code of the process in the database';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Description = 'Stores the description of the process in the database';
            NotBlank = true;
        }
        field(3; Mandatory; Boolean)
        {
            Description = 'Stores the state of t he process in the database whether the process is mandatory or not';
        }
        field(4; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(5; Amount; Decimal)
        {
        }
        field(7; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Range; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Systolic Lower"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Systolic Upper"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Diastolic Lower"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Diastolic Upper"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Min Range"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Max Range"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Min 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Max 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Normal Range"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
