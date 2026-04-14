Table 85535 "prPayroll Type"
{
    LookupPageId = "prPayroll Type";
    fields
    {
        field(50000; "Payroll Code"; Code[20])
        {
        }
        field(50001; "Payroll Name"; Text[50])
        {
        }
        field(50002; Comment; Text[200])
        {
        }
        field(50003; "Period Length"; DateFormula)
        {
        }
        field(50004; EntryNo; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Payroll Code")
        {
            Clustered = true;
        }
        key(Key2; EntryNo)
        {
        }
    }

    fieldgroups
    {
    }
}
