Table 52202916 "Interbank Transfer Lines"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Paying Bank No"; Code[20])
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
        field(4; "Receipt No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Receipts Header"."No." where(Posted = const(true));
        }
        field(5; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Source Campus Code"; Code[20])
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
        field(7; "Source Department Code"; Code[20])
        {
            Caption = 'Source Budget Center Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(8; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Remaining Amount"; Decimal)
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
