table 52202484 "Receipt Split"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Receipt Split";
    fields
    {
        field(1; "Receipt No"; code[20])
        {
        }
        field(2; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,EFT,Deposit Slip,Banker''s Cheque,RTGS,MPESA,PayPal,PDQ,RFH Baraka Card';
            OptionMembers = " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,MPESA,PayPal,PDQ,"RFH Baraka Card";
            trigger OnValidate()
            var
                UserTemplate: Record "Cash Office User Template";
            begin
                "Bank Account No" := '';
                if UserTemplate.get(UserId) then begin
                    if "Pay Mode" = "Pay Mode"::PDQ then
                        "Bank Account No" := UserTemplate."Default PDQ Bank";
                    if "Pay Mode" = "Pay Mode"::MPESA then
                        "Bank Account No" := UserTemplate."Default Mpesa Bank"
                end;
            end;
        }
        field(3; "Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                TestField("Bank Account No");
                if "Pay Mode" = "Pay Mode"::MPESA then
                    TestField("Transaction No");
            end;
        }
        field(4; "Bank Account No"; code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(5; "Transaction No"; code[20])
        {
        }
        field(6; "Shown On Report"; Boolean)
        {
        }
    }

    keys
    {
        key(PK; "Receipt No", "Pay Mode")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}