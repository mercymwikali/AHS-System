Table 85178 "HMS Beds"
{
    // LookupPageID = UnknownPage70135226;

    fields
    {
        field(50000; "Ward No"; Code[20])
        {
            TableRelation = "HMS Ward Setup"."Ward Code";
        }
        field(50001; "Bed No"; Code[20])
        {
        }
        field(50002; "Bed Name"; Text[30])
        {
        }
        field(50003; Occupied; Boolean)
        {
        }
        field(50004; "Curr Patient No"; code[20])
        {
            CalcFormula = lookup("HMS Admission Form Header"."Patient No." where(Bed = field("Bed No"), Status = filter(Admitted)));
            FieldClass = FlowField;
        }
        field(50005; "Curr Adm No"; code[20])
        {
            CalcFormula = lookup("HMS Admission Form Header"."Admission No." where(Bed = field("Bed No"), Status = filter(Admitted)));
            FieldClass = FlowField;
        }
        field(50006; "Room No"; Code[20])
        { // TODO : Add to Primary Key
            TableRelation = "HMS Ward Rooms"."Room No." where("Ward No" = field("Ward No"));
        }
    }

    keys
    {
        key(Key1; "Ward No", "Room No", "Bed No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
