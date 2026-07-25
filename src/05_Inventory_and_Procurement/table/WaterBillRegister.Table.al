table 85114 "Water Bill Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "House No"; code[20])
        {
            TableRelation = "Estate Houses";
        }
        field(50001; "Meter No"; code[20])
        {
        }
        field(50002; "Reading Date"; date)
        {
        }
        field(50003; "Prev. Reading"; code[20])
        {
        }
        field(50004; "Current Reading"; code[20])
        {
        }
        field(50005; "Consumption Cubic"; Decimal)
        {
        }
        field(50006; "Rate PerCubic"; Decimal)
        {
        }
        field(50007; "Amount"; Decimal)
        {
        }
        field(50008; "Bill Arrears"; Decimal)
        {
        }
        field(50009; "Total Bill"; Decimal)
        {
        }
        field(50010; "Bill Type"; Option)
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