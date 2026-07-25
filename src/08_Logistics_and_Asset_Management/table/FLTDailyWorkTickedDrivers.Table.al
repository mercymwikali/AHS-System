Table 85092 "FLT-Daily Work Ticked Drivers"
{
    DrillDownPageID = "FLT Daily Work Ticket Drivers";
    LookupPageID = "FLT Daily Work Ticket Drivers";

    fields
    {
        field(50000; "line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Driver No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(50002; "Driver Name"; Text[50])
        {
            CalcFormula = lookup("HR-Employee"."First Name" where("No." = field("Driver No.")));
            FieldClass = FlowField;
        }
        field(50003; "Total Milleage"; Decimal)
        {
        }
        field(50004; "Total Fuel Consumed"; Decimal)
        {
        }
        field(50005; "Ticket No."; Code[20])
        {
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1; "line No.", "Ticket No.", "Driver No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
