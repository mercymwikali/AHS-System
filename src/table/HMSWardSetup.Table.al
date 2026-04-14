Table 85278 "HMS Ward Setup"
{
    LookupPageID = "HMS Ward List";

    fields
    {
        field(50000; "Ward Code"; Code[20])
        {
        }
        field(50001; "Ward Name"; Text[50])
        {
        }
        field(50002; "Room Charges"; Decimal)
        {
        }
        field(50003; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Charges Code"; Code[20])
        {
            TableRelation = "HMS Charges".Code;
        }
        field(50005; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(1));
        }
        field(50006; isRehab; Boolean)
        {
            
        }
    }

    keys
    {
        key(Key1; "Ward Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
