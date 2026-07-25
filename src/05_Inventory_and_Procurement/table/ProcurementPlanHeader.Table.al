Table 85125 "Procurement Plan Header"
{
    DrillDownPageID = "Procurement Plan list";
    LookupPageID = "Procurement Plan list";

    fields
    {
        field(50000; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50001; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50002; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50003; "Procurement Plan Period"; Code[20])
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
