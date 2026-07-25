table 85454 "PC Strategic Activities"
{
    DataClassification = ToBeClassified;
    LookupPageId = "PC Strategic Activities";
    fields
    {
        field(50000; Code; code[20])
        {
        }
        field(50001; Description; text[2000])
        {
        }
    }

    keys
    {
        key(PK; code)
        {
            Clustered = true;
        }
    }
}