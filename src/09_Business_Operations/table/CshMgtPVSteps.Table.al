Table 85088 "CshMgt PV Steps"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            Description = 'Stores the code of the status in the database';
        }
        field(50001; Description; Text[30])
        {
            Description = 'Stores the description of the status in the database';
        }
        field(50002; Users; Integer)
        {
            CalcFormula = count("CshMgt PV Steps Users" where(Code = field(Code)));
            Description = 'Stores the number of user for the steps';
            FieldClass = FlowField;
        }
        field(50003; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit","Custom 3","Custom 4","Custom 5";
        }
        field(50004; "Default Account"; Code[20])
        {
            Description = 'Stores the default account in the database';
            TableRelation = "Bank Account"."No.";
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
