Table 52202878 "Procurement Plan Header"
{
    DrillDownPageID = "Procurement Plan list";
    LookupPageID = "Procurement Plan list";

    fields
    {
        field(1; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(2; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(3; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(4; "Procurement Plan Period"; Code[20])
        {
            TableRelation = "Procurement Plan Period".Code;
        }
    }

    keys
    {
        key(Key1; "Budget Name", "Department Code", "Campus Code", "Procurement Plan Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
