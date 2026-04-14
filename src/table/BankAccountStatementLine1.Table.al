table 85071 "Bank Account Statement Line1"
{
    Caption = 'Bank Account Statement Line';

    fields
    {
        field(50000; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(50001; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            TableRelation = "Bank Account Statement"."Statement No." WHERE("Bank Account No." = FIELD("Bank Account No."));
        }
        field(50002; "Statement Line No."; Integer)
        {
            Caption = 'Statement Line No.';
        }
        field(50003; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(50004; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
        field(50005; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(50006; "Statement Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            Caption = 'Statement Amount';
        }
        field(50007; Difference; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            Caption = 'Difference';
        }
        field(50008; "Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            Caption = 'Applied Amount';
            Editable = false;
        }
        field(50009; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Bank Account Ledger Entry,Check Ledger Entry,Difference';
            OptionMembers = "Bank Account Ledger Entry","Check Ledger Entry",Difference;
        }
        field(50010; "Applied Entries"; Integer)
        {
            Caption = 'Applied Entries';
            Editable = false;
        }
        field(50011; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
        field(50012; "Check No."; Code[20])
        {
            AccessByPermission = TableData "Check Ledger Entry" = R;
            Caption = 'Check No.';
        }
        field(50013; "Transaction ID"; Text[50])
        {
            Caption = 'Transaction ID';
        }
    }

    keys
    {
        key(Key1; "Bank Account No.", "Statement No.", "Statement Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        Text000: Label 'You cannot rename a %1.';

    procedure DisplayApplication()
    begin
        case Type of
            Type::"Bank Account Ledger Entry":
                begin
                    BankAccLedgEntry.Reset();
                    BankAccLedgEntry.SetCurrentKey("Bank Account No.", Open);
                    BankAccLedgEntry.SetRange("Bank Account No.", "Bank Account No.");
                    BankAccLedgEntry.SetRange(Open, false);
                    BankAccLedgEntry.SetRange("Statement Status", BankAccLedgEntry."Statement Status"::Closed);
                    BankAccLedgEntry.SetRange("Statement No.", "Statement No.");
                    BankAccLedgEntry.SetRange("Statement Line No.", "Statement Line No.");
                    PAGE.Run(0, BankAccLedgEntry);
                end;
            Type::"Check Ledger Entry":
                begin
                    CheckLedgEntry.Reset();
                    CheckLedgEntry.SetCurrentKey("Bank Account No.", Open);
                    CheckLedgEntry.SetRange("Bank Account No.", "Bank Account No.");
                    CheckLedgEntry.SetRange(Open, false);
                    CheckLedgEntry.SetRange("Statement Status", CheckLedgEntry."Statement Status"::Closed);
                    CheckLedgEntry.SetRange("Statement No.", "Statement No.");
                    CheckLedgEntry.SetRange("Statement Line No.", "Statement Line No.");
                    PAGE.Run(0, CheckLedgEntry);
                end;
        end;

        // OnAfterDisplayApplication(Rec);
    end;

    procedure GetCurrencyCode(): Code[10]
    var
        BankAcc: Record "Bank Account";
    begin
        if "Bank Account No." = BankAcc."No." then
            exit(BankAcc."Currency Code");

        if BankAcc.Get("Bank Account No.") then
            exit(BankAcc."Currency Code");

        exit('');
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDisplayApplication(var BankAccountStatementLine: Record "Bank Account Statement Line")
    begin
    end;
}
