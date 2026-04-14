Table 85121 "Payment Schedule"
{
    fields
    {
        field(50000; No; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                GenLedgerSetup.Get();
                GenLedgerSetup.TestField(GenLedgerSetup."Payment Schedule No");
                NoSeriesMgt.InitSeries(GenLedgerSetup."Payment Schedule No", xRec."No. Series", 0D, No, "No. Series");
            end;
        }
        field(50001; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Paying Bank No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No." where("Bank Type" = const(Normal));

            trigger OnValidate()
            begin
                if BankRec.Get("Paying Bank No") then begin
                    BankRec.TestField("Last Check No.");
                    "Cheque No" := IncStr(BankRec."Last Check No.");
                    "Cheque Format" := BankRec."Cheque Format";
                end;
            end;
        }
        field(50003; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Payment Schedule Line"."Cheque Amount" where(No = field(No)));
            FieldClass = FlowField;
        }
        field(50004; Payee; Text[150])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Payee := UpperCase(Payee);
            end;
        }
        field(50005; "Cheque No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Cheque Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Pending Approval,Approved';
            OptionMembers = Pending,"Pending Approval",Approved;
        }
        field(50008; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Posted By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Posting Dated"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Cheque Format"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Kalamazoo Format,Plain Format';
            OptionMembers = "Kalamazoo Format","Plain Format";
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //IF No = '' THEN BEGIN
        GenLedgerSetup.Get();
        GenLedgerSetup.TestField(GenLedgerSetup."Payment Schedule No");
        NoSeriesMgt.InitSeries(GenLedgerSetup."Payment Schedule No", xRec."No. Series", 0D, No, "No. Series");
        //END
    end;

    var
        BankRec: Record "Bank Account";
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
