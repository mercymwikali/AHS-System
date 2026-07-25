Table 85251 "HMS Setup Process"
{
    // LookupPageID = UnknownPage50006;

    fields
    {
        field(50000; "Code"; Code[20])
        {
            Description = 'Stores the code of the process in the database';
            NotBlank = true;
        }
        field(50001; Description; Text[100])
        {
            Description = 'Stores the description of the process in the database';
            NotBlank = true;
        }
        field(50002; Mandatory; Boolean)
        {
            Description = 'Stores the state of t he process in the database whether the process is mandatory or not';
        }
        field(50003; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50004; Amount; Decimal)
        {
        }
        field(50005; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Range; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Systolic Lower"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Systolic Upper"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Diastolic Lower"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Diastolic Upper"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Min Range"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Max Range"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Min 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Max 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Normal Range"; Text[40])
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
