Table 52202677 "HMS Ward Setup"
{
    LookupPageID = "HMS Ward List";

    fields
    {
        field(1; "Ward Code"; Code[20])
        {
        }
        field(2; "Ward Name"; Text[50])
        {
        }
        field(3; "Room Charges"; Decimal)
        {
        }
        field(4; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Charges Code"; Code[20])
        {
            TableRelation = "HMS Charges".Code;
        }
        field(6; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(1));
        }
        field(7; isRehab; Boolean)
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
