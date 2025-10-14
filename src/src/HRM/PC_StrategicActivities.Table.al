table 52202438 "PC Strategic Activities"
{
    DataClassification = ToBeClassified;
    LookupPageId = "PC Strategic Activities";
    fields
    {
        field(1; Code; code[20])
        {
        }
        field(2; Description; text[2000])
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