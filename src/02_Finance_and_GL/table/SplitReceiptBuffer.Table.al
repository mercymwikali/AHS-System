table 85138 "Split Receipt Buffer"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Receipt Split";
    fields
    {
        field(50000; "Receipt No"; code[20])
        {
        }
        field(50001; "Pay Mode"; Option)
        {
            OptionCaption = ' ,Cash,Cheque,EFT,Deposit Slip,Banker''s Cheque,RTGS,MPESA,PayPal,PDQ,RFH Baraka Card';
            OptionMembers = " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,MPESA,PayPal,PDQ,"RFH Baraka Card";
        }
        field(50002; "Amount"; Decimal)
        {
        }
        field(50003; "Bank Account No"; code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50004; "Transaction No"; code[20])
        {
        }
        field(50005; "Transaction Type"; Code[20])
        {
        }
        field(50006; "Patient No"; code[20])
        {
        }
        field(50007; "Visit No"; code[20])
        {
        }
        field(50008; "Date Posted"; Date)
        {
        }
        field(50009; "Posted By"; Code[100])
        {
            TableRelation = User;
        }
        field(50010; "Time Posted"; Time)
        {
        }
        field(50011; "Patient Name"; Text[250])
        {
        }
        field(50012; "Receipt Line No"; Integer)
        {
        }
        field(50013; "Branch Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(50014; "Transaction Name"; Text[150])
        {
        }
    }
    keys
    {
        key(PK; "Receipt No", "Pay Mode", Amount, "Receipt Line No")
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