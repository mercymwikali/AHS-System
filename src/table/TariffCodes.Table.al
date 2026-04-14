Table 85142 "Tariff Codes"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[50])
        {
        }
        field(50002; Percentage; Decimal)
        {
        }
        field(50003; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50004; Type; Option)
        {
            OptionMembers = " ","W/Tax",VAT,Excise,Others,Retention,PAYE,Commision;
        }
        field(50005; "Account No."; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No."
            else
            if ("Account Type" = const(Vendor)) Vendor."No.";
        }
        field(50006; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
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

    trigger OnDelete()
    begin
        PaymentLine.Reset();
        PaymentLine.SetRange(PaymentLine."VAT Code", Code);
        if PaymentLine.Find('-') then
            Error('You cannot delete the %1 Code its already used', Type);

        PaymentLine.Reset();
        PaymentLine.SetRange(PaymentLine."Withholding Tax Code", Code);
        if PaymentLine.Find('-') then
            Error('You cannot delete the %1 Code its already used', Type);
    end;

    var
        PaymentLine: Record "Payment Line";
}
