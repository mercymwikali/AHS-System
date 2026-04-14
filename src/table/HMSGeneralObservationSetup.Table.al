Table 85192 "HMS General Observation Setup"
{
    //LookupPageID = "ELECT Login";

    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; "Description"; Text[100])
        {
        }
        field(50002; System; Code[20])
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
