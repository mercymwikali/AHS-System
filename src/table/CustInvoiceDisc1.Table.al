Table 85048 "Cust. Invoice Disc.1"
{
    Caption = 'Cust. Invoice Disc.';
    LookupPageID = "Cust. Invoice Discounts";

    fields
    {
        field(50000; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(50001; "Minimum Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Minimum Amount';
            MinValue = 0;
        }
        field(50002; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50003; "Service Charge"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Service Charge';
            MinValue = 0;
        }
        field(50004; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
    }

    keys
    {
        key(Key1; "Code", "Currency Code", "Minimum Amount")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure GetRec(NewCode: Code[20]; CurrencyCode: Code[10]; CurrencyDate: Date; BaseAmount: Decimal)
    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyFactor: Decimal;
    begin
        SetRange(Code, NewCode);
        SetRange("Currency Code", CurrencyCode);
        SetRange("Minimum Amount", 0, BaseAmount);
        if not Find('+') then
            if CurrencyCode <> '' then begin
                CurrencyFactor := CurrExchRate.ExchangeRate(CurrencyDate, CurrencyCode);
                SetRange("Currency Code", '');
                SetRange(
                  "Minimum Amount", 0,
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    CurrencyDate, CurrencyCode,
                    BaseAmount, CurrencyFactor));
                if not Find('+') then
                    Init()
                else begin
                    Currency.Get(CurrencyCode);
                    "Service Charge" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          CurrencyDate, CurrencyCode,
                          "Service Charge", CurrencyFactor),
                        Currency."Amount Rounding Precision");
                end;
            end else
                Init();
    end;
}
