Table 85106 "Interbank Transfer Lines"
{
    fields
    {
        field(50000; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50002; "Paying Bank No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                BankAcc.Reset();
                if BankAcc.Get("Paying Bank No") then
                    "Bank Name" := BankAcc.Name;
            end;
        }
        field(50003; "Receipt No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Receipts Header"."No." where(Posted = const(true));
        }
        field(50004; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Source Campus Code"; Code[20])
        {
            Caption = 'Source Funtion Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin

                /*
                DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SETRANGE(DimVal.Code,"Source Depot Code");
                 IF DimVal.FIND('-') THEN
                    "Source Depot Name":=DimVal.Name
                */
            end;
        }
        field(50006; "Source Department Code"; Code[20])
        {
            Caption = 'Source Budget Center Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50007; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Paying Bank No")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        BankAcc: Record "Bank Account";
}
