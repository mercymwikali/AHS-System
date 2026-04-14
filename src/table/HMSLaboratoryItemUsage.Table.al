Table 85312 "HMS Laboratory Item Usage"
{
    fields
    {
        field(50000; "Laboratory No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Laboratory Test Package Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Lab Package".Code;
        }
        field(50002; "Laboratory Test Package Name"; Text[30])
        {
            CalcFormula = lookup("HMS Setup Lab Package".Description where(Code = field("Laboratory Test Package Code")));
            FieldClass = FlowField;
        }
        field(50003; "Laboratory Test Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Lab Test".Code;
        }
        field(50004; "Laboratory Test Name"; Text[30])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Laboratory Test Code")));
            FieldClass = FlowField;
        }
        field(50005; "Specimen Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Test Specimen".Specimen where(Test = field("Laboratory Test Code"));
        }
        field(50006; "Specimen Name"; Text[30])
        {
            CalcFormula = lookup("HMS Setup Specimen".Description where(Code = field("Specimen Code")));
            FieldClass = FlowField;
        }
        field(50007; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(50008; "Item Name"; Text[30])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50009; "Item Quantity"; Decimal)
        {
        }
        field(50010; Location; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(50011; "Item Unit Of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(50012; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Laboratory No.", "Laboratory Test Package Code", "Laboratory Test Code", "Specimen Code", "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('Record already posted');
    end;

    trigger OnModify()
    begin
        if Posted = true then
            Error('Record already posted');
    end;
}
