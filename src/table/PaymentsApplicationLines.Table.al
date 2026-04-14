Table 85120 "Payments Application Lines"
{
    fields
    {
        field(50000; No; Code[20])
        {
        }
        field(50001; "Document No"; Code[50])
        {
        }
        field(50002; Description; Text[100])
        {
        }
        field(50003; Date; Date)
        {
        }
        field(50004; Amount; Decimal)
        {
        }
        field(50005; "External No"; Code[50])
        {
        }
        field(50006; "Vendor No"; Code[20])
        {
        }
        field(50007; "Vendor Name"; Text[50])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; No, "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
