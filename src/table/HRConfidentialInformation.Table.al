table 85404 "HR Confidential Information"
{
    fields
    {
        field(50000; "Employee No."; Code[20])
        {
        }
        field(50001; "Confidential Code"; Code[10])
        {
        }
        field(50002; "Line No."; Integer)
        {
        }
        field(50003; Description; Text[100])
        {
        }
        field(50004; Comment; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Confidential Code", "Line No.")
        {
        }
    }
}