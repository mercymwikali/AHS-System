Table 52202602 "prPayroll Type"
{
    LookupPageId = "prPayroll Type";
    fields
    {
        field(1; "Payroll Code"; Code[20])
        {
        }
        field(2; "Payroll Name"; Text[50])
        {
        }
        field(3; Comment; Text[200])
        {
        }
        field(4; "Period Length"; DateFormula)
        {
        }
        field(5; EntryNo; Integer)
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
