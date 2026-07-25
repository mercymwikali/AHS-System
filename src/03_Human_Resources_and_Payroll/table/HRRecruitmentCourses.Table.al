Table 85432 "HR Recruitment Courses"
{
    DrillDownPageId = "HR Recruitment Courses";
    LookupPageId = "HR Recruitment Courses";
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; No; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Course Code"; Code[50])
        {
        }
        field(50002; "Course Description"; Text[100])
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
