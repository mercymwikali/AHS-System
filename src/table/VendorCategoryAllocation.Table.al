Table 85581 "Vendor Category Allocation"
{
    fields
    {
        field(50000; "Vendor No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Category; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Category".Code;
        }
        field(50002; "Vendor Name"; Text[50])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Vendor No", Category)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
