table 85426 "HR Misc. Article Information"
{
    fields
    {
        field(50000; "Employee No."; Code[20])
        {
        }
        field(50001; "Misc. Article Code"; Code[10])
        {
        }
        field(50002; "Line No."; Integer)
        {
        }
        field(50003; Description; Text[100])
        {
        }
        field(50004; "From Date"; Date)
        {
        }
        field(50005; "To Date"; Date)
        {
        }
        field(50006; "In Use"; Boolean)
        {
        }
        field(50007; Comment; Boolean)
        {
        }
        field(50008; "Serial No."; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Misc. Article Code", "Line No.")
        {
        }
        key(Key2; "Line No.")
        {
        }
    }
}