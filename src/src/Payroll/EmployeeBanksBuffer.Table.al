Table 52202573 "Employee Banks Buffer"
{
    fields
    {
        field(1; "PF No."; Code[30])
        {
        }
        field(2; "A/C No."; Code[30])
        {
        }
        field(3; Surname; Text[120])
        {
        }
        field(4; "Other Names"; Text[120])
        {
        }
        field(5; "Bank Code"; Code[20])
        {
        }
        field(6; "Bank Name"; Text[120])
        {
        }
        field(7; "Branch Code"; Code[20])
        {
        }
        field(8; "Branch Name"; Text[120])
        {
        }
        field(9; "Section Code"; Code[20])
        {
        }
        field(10; "Section Name"; Text[120])
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
