table 85181 "HMS Charges Prices"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "HMS Charges Prices";
    LookupPageId = "HMS Charges Prices";
    fields
    {
        field(50000; "Charge Code"; code[20])
        {
        }
        field(50001; "Branch Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(50002; "Cash Amount"; Decimal)
        {
        }
        field(50003; "Corporate Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(PK; "Charge Code", "Branch Code")
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