Table 85072 "Bank Payments"
{
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Doc No"; Code[20])
        {
        }
        field(50002; Payee; Code[20])
        {
        }
        field(50003; Amount; Decimal)
        {
        }
        field(50004; "Bank A/C No"; Code[20])
        {
        }
        field(50005; "Bank Branch No"; Code[20])
        {
        }
        field(50006; "Bank A/C Name"; Text[50])
        {
        }
        field(50007; "Bank Code"; Code[20])
        {
        }
        field(50008; Status; Option)
        {
            OptionMembers = New,Submitted,Cleared;
        }
        field(50009; Date; Date)
        {
        }
        field(50010; Select; Boolean)
        {
        }
        field(50011; Type; Option)
        {
            OptionMembers = Creditors,Salaries;
        }
        field(50012; Paid; Boolean)
        {
        }
        field(50013; "Paid By"; Code[20])
        {
        }
        field(50014; "Paid Date"; Date)
        {
        }
        field(50015; OPN; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('Please note that you can not delete EFT payments');
    end;
}
