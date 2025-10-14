table 52202435 "Water Bill Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "House No"; code[20])
        {
            TableRelation = "Estate Houses";
        }
        field(2; "Meter No"; code[20])
        {
        }
        field(3; "Reading Date"; date)
        {
        }
        field(4; "Prev. Reading"; code[20])
        {
        }
        field(5; "Current Reading"; code[20])
        {
        }
        field(6; "Consumption Cubic"; Decimal)
        {
        }
        field(7; "Rate PerCubic"; Decimal)
        {
        }
        field(8; "Amount"; Decimal)
        {
        }
        field(9; "Bill Arrears"; Decimal)
        {
        }
        field(10; "Total Bill"; Decimal)
        {
        }
        field(11; "Bill Type"; Option)
        {
            OptionMembers = Water,Electricty;
        }
    }

    keys
    {
        key(PK; "House No", "Reading Date")
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