XmlPort 52202424 "Import Insurance Receipts."
{
    Format = VariableText;

    schema
    {
        textelement(RC)
        {
            tableelement("Receipt Line q"; "Receipt Line q")
            {
                XmlName = 'RLine';
                fieldelement(INvoice; "Receipt Line q"."Applies-to Doc. No.")
                {
                }
                fieldelement(MemberNo; "Receipt Line q"."Member No")
                {
                }
                fieldelement(Pdate; "Receipt Line q"."Deposit Slip Date")
                {
                }
                fieldelement(Amt; "Receipt Line q".Amount)
                {
                }
                fieldelement(Desc; "Receipt Line q"."Transaction Name")
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                begin
                    Ln := Ln + 20;
                    "Receipt Line q".No := RecNo;
                    "Receipt Line q".Type := 'CORPORATE';
                    "Receipt Line q".Grouping := 'CORPORATE';
                    "Receipt Line q"."Account Type" := "Receipt Line q"."account type"::Customer;
                    "Receipt Line q"."Account No." := CustNo;
                    "Receipt Line q".Validate("Account No.");
                    "Receipt Line q"."Line No." := Ln;
                    "Receipt Line q".Date := "Receipt Line q"."Deposit Slip Date";
                    "Receipt Line q"."Pay Mode" := "Receipt Line q"."pay mode"::EFT;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    begin
        RecNo := "Receipt Line q".GetFilter("Receipt Line q".No);
        CustNo := "Receipt Line q".GetFilter("Receipt Line q"."Account No.");
    end;

    var
        CustNo: Code[20];
        RecNo: Code[20];
        Ln: Integer;
}
