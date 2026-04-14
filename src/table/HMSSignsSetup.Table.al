Table 85253 "HMS Signs Setup"
{
    //LookupPageID = "ELECT Login";

    fields
    {
        field(50000; "Sign Code"; Code[20])
        {
        }
        field(50001; "Signs Name"; Text[100])
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
        key(Key1; "Sign Code", System)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
