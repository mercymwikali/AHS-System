table 52203005 "Replenshment Line"
{
    Caption = 'Replenshment Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(2; "Petty cash No"; Code[20])
        {
            Caption = 'Petty cash No';
        }
        field(3; Payee; Text[300])
        {
            Caption = 'Payee';
        }
        field(4; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
        }
        field(7; "Petty cash Account"; code[20])
        {
            Caption = 'Petty Cash Account';
        }
        field(8; "Replinshment No"; code[20])
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
