Table 52202444 "HMS General Observation Setup"
{
    //LookupPageID = "ELECT Login";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Description"; Text[100])
        {
        }
        field(3; System; Code[20])
        {
            Description = '$';
            TableRelation = "HMS Systems".Code;
        }
    }

    keys
    {
        key(Key1; "Code", System)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
