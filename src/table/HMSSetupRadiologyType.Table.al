table 85252 "HMS Setup Radiology Type"
{
    DataCaptionFields = Description, "Code";
    //   DrillDownPageID = UnknownPage70135119;
    //  LookupPageID = UnknownPage70135119;

    fields
    {
        field(50000; "Code"; Code[30])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[100])
        {
            NotBlank = true;
        }
        field(50002; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50003; Amount; Decimal)
        {
        }
        field(50004; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Radiology Section"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Code")
        {
        }
        fieldgroup(Brick; Description, "Code", "G/L Account")
        {
        }
    }
}
