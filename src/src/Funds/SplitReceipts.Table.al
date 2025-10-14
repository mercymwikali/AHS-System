table 52202429 "Split Receipt Buffer"
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
        }
        field(3; "Amount"; Decimal)
        {
        }
        field(4; "Bank Account No"; code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(5; "Transaction No"; code[20])
        {
        }
        field(6; "Transaction Type"; Code[20])
        {
        }
        field(7; "Patient No"; code[20])
        {
        }
        field(8; "Visit No"; code[20])
        {
        }
        field(9; "Date Posted"; Date)
        {
        }
        field(10; "Posted By"; Code[100])
        {
            TableRelation = User;
        }
        field(11; "Time Posted"; Time)
        {
        }
        field(12; "Patient Name"; Text[250])
        {
        }
        field(13; "Receipt Line No"; Integer)
        {
        }
        field(14; "Branch Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(15; "Transaction Name"; Text[150])
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