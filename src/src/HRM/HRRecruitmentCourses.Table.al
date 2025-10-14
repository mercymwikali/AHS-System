Table 52202520 "HR Recruitment Courses"
{
    DrillDownPageId = "HR Recruitment Courses";
    LookupPageId = "HR Recruitment Courses";
    DataClassification = ToBeClassified;
    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Course Code"; Code[50])
        {
        }
        field(3; "Course Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Course Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Course Code", "Course Description")
        {
        }
    }
}
