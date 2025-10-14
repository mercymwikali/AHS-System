Table 52202906 "Payment Schedule Line"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Payment No"; Code[20])
        {
            TableRelation = if ("Document Type" = const(Payment)) "Payments Header"."No." where(Posted = filter(true),
                                                                                               "Payment Schedule No" = filter(''),
                                                                                               "Payment Type" = filter(Normal | "Petty Cash"))
            else
            if ("Document Type" = const(Imprest)) "Imprest Header"."No." where(Posted = const(true))
            else
            if ("Document Type" = const(Interbank)) "InterBank Transfers".No where(Posted = const(true));

            trigger OnValidate()
            begin
                if pH.Get("Payment No") then begin
                    pH.CalcFields("Total Net Amount");
                    Payee := pH.Payee;
                    Amount := pH."Total Net Amount";
                    "Cheque Amount" := pH."Total Net Amount";
                    "Payment Narration" := pH."Payment Narration";
                end;
                if ImpH.Get("Payment No") then begin
                    ImpH.CalcFields("Total Net Amount");
                    Payee := ImpH.Payee;
                    Amount := ImpH."Total Net Amount";
                    "Cheque Amount" := ImpH."Total Net Amount";
                    "Payment Narration" := ImpH.Purpose;
                end;

                if InterBnk.Get("Payment No") then begin
                    InterBnk.CalcFields(Amount);
                    Payee := InterBnk.Remarks;
                    Amount := InterBnk.Amount;
                    "Cheque Amount" := InterBnk.Amount;
                    "Payment Narration" := InterBnk.Remarks;
                end;
            end;
        }
        field(3; Payee; Text[100])
        {
        }
        field(4; "Payment Narration"; Text[250])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Document Type"; Option)
        {
            OptionCaption = 'Payment,Imprest,Interbank';
            OptionMembers = Payment,Imprest,Interbank;
        }
        field(7; "Cheque Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No, "Payment No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ImpH: Record "Imprest Header";
        InterBnk: Record "InterBank Transfers";
        pH: Record "Payments Header";
}
