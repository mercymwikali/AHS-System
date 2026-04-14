Table 85318 "HMS Setup Lab Test"
{
    DataCaptionFields = "Code", Description;

    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[100])
        {
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
        field(50005; Department; Code[20])
        {
        }
        field(50006; "MeasurementProc"; text[120])
        {
            CalcFormula = lookup("HMS Lab Parameters setup".Category where("Laboratory Test Code" = field(Code)));
            FieldClass = FlowField;
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
        fieldgroup(Brick; Description, "Code", Amount)
        {
        }
    }
}
