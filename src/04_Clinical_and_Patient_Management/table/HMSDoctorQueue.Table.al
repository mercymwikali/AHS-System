Table 85185 "HMS Doctor Queue"
{
    fields
    {
        field(50000; "Patient No"; Code[30])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50001; "Visit No"; Code[20])
        {
        }
        field(50002; "Document No"; Code[30])
        {
            // TableRelation = if (Type = const('CONSULTATION')) "HMS Treatment Form Header"."Treatment No." where("Treatment No." = field("Document No"))
            // else
            // if (Type = const('LABORATORY')) "HMS Laboratory Form Header"."Laboratory No." where("Laboratory No." = field("Document No"))
            // else
            // if (Type = const('RADIOLOGY')) "HMS Radiology Form Header"."Radiology No." where("Radiology No." = field("Document No"));
        }
        field(50003; Type; Code[20])
        {
        }
        field(50004; "Doctor ID"; Code[30])
        {
        }
        field(50005; Status; Option)
        {
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;
        }
        field(50006; Date; Date)
        {
        }
        field(50007; Time; Time)
        {
        }
        field(50008; "Closed Time"; Time)
        {
        }
        field(50009; "Closed Date"; Date)
        {
        }
        field(50010; "Queue Type"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Patient No", "Visit No", "Document No")
        {
            Clustered = true;
        }
        key(Key2; "Visit No")
        {
        }
        key(Key3; "Document No")
        {
        }
        key(Key4; "Queue Type")
        {
        }
    }

    fieldgroups
    {
    }
}
