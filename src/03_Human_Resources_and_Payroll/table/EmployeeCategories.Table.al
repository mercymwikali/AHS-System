Table 85486 "Employee Categories"
{
    DrillDownPageId = "Employee Categories";
    LookupPageId = "Employee Categories";
    fields
    {
        field(50002; Section; Option)
        {
            OptionCaption = ' ,Payroll,HR';
            OptionMembers = " ",Payroll,HR;
        }
        field(50000; "Code"; Code[70])
        {
        }
        field(50001; Description; Text[150])
        {
        }
        field(50003; "Ritirement Age"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
