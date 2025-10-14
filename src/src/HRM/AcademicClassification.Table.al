namespace PTL.HRMIS;

table 52202480 "Academic Classification"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Academic Classification";
    LookupPageId = "Academic Classification";
    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Qualification; Code[30])
        {
            TableRelation = "HR Qualifications"."Qualification Type";
        }
        field(3; Classification; Code[30])
        {
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(4; Score; Integer)
        {
        }
    }

    keys
    {
        key(Key1; No, Classification, Qualification)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Qualification, Classification, Score)
        {
        }
    }
}
