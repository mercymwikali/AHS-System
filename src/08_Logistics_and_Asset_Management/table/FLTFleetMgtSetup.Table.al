Table 85008 "FLT-Fleet Mgt Setup"
{
    fields
    {
        field(50000; "Transport Req No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Daily Work Ticket"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50002; "Fuel Register"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50003; "Maintenance Request"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50004; Missing; Code[10])
        {
        }
        field(50005; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(50006; "missing 2"; Text[30])
        {
        }
        field(50007; "Driver Rotation"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50008; "Rotation Interval"; DateFormula)
        {
        }
        field(50009; "Fuel Payment Batch No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50010; "Work Ticket No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50011; "Safari Notice No."; Code[20])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Driver Rotation")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
