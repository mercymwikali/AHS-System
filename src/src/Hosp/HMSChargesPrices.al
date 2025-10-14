table 52202938 "HMS Charges Prices"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "HMS Charges Prices";
    LookupPageId = "HMS Charges Prices";
    fields
    {
        field(1; "Charge Code"; code[20])
        {
        }
        field(2; "Branch Code"; code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(3; "Cash Amount"; Decimal)
        {
        }
        field(4; "Corporate Amount"; Decimal)
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