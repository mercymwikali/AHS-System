Table 85485 "Employee Banks Buffer"
{
    fields
    {
        field(50000; "PF No."; Code[30])
        {
        }
        field(50001; "A/C No."; Code[30])
        {
        }
        field(50002; Surname; Text[120])
        {
        }
        field(50003; "Other Names"; Text[120])
        {
        }
        field(50004; "Bank Code"; Code[20])
        {
        }
        field(50005; "Bank Name"; Text[120])
        {
        }
        field(50006; "Branch Code"; Code[20])
        {
        }
        field(50007; "Branch Name"; Text[120])
        {
        }
        field(50008; "Section Code"; Code[20])
        {
        }
        field(50009; "Section Name"; Text[120])
        {
        }
    }

    keys
    {
        key(Key1; "PF No.", "A/C No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
