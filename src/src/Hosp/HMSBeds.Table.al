Table 52202678 "HMS Beds"
{
    // LookupPageID = UnknownPage70135226;

    fields
    {
        field(1; "Ward No"; Code[20])
        {
            TableRelation = "HMS Ward Setup"."Ward Code";
        }
        field(2; "Bed No"; Code[20])
        {
        }
        field(3; "Bed Name"; Text[30])
        {
        }
        field(4; Occupied; Boolean)
        {
        }
        field(5; "Curr Patient No"; code[20])
        {
            CalcFormula = lookup("HMS Admission Form Header"."Patient No." where(Bed = field("Bed No"), Status = filter(Admitted)));
            FieldClass = FlowField;
        }
        field(6; "Curr Adm No"; code[20])
        {
            CalcFormula = lookup("HMS Admission Form Header"."Admission No." where(Bed = field("Bed No"), Status = filter(Admitted)));
            FieldClass = FlowField;
        }
        field(7; "Room No"; Code[20])
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
