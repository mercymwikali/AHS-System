Codeunit 52202425 "Tax Calculation2"
{
    trigger OnRun()
    begin
    end;

    procedure CalculateTax(Rec: Record "Payment Line"; CalculationType: Option VAT,"W/Tax",Retention,PAYE) Amount: Decimal
    begin
        case CalculationType of
            Calculationtype::VAT:

                Amount := (Rec."VAT Rate" / (100 + Rec."VAT Rate")) * Rec.Amount;
            /*CalculationType::"W/Tax":
              BEGIN
                  Amount:=(Rec.Amount-((Rec."VAT Rate"/(100+Rec."VAT Rate"))*Rec.Amount))
                  *(Rec."W/Tax Rate"/100);
              END;
              */
            Calculationtype::Retention:

                Amount := (Rec.Amount - ((Rec."VAT Rate" / (100 + Rec."VAT Rate")) * Rec.Amount))
                 * (Rec."Retention Rate" / 100);
            Calculationtype::PAYE:

                Amount := Rec."PAYE Amount";

            Calculationtype::"W/Tax":

                Amount := Rec."Withholding Tax Amount";
        end;
    end;
}
