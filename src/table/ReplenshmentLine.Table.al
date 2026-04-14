table 85000 "Replenshment Line"
{
    Caption = 'Replenshment Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(50001; "Petty cash No"; Code[20])
        {
            Caption = 'Petty cash No';
        }
        field(50002; Payee; Text[300])
        {
            Caption = 'Payee';
        }
        field(50003; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
        field(50004; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(50005; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
        }
        field(50006; "Petty cash Account"; code[20])
        {
            Caption = 'Petty Cash Account';
        }
        field(50007; "Replinshment No"; code[20])
        {
            Caption = 'Replinshment No';
        }
    }
    keys
    {
        key(PK; "Line No", "Petty cash No", "Replinshment No")
        {
            Clustered = true;
        }
    }
}
