table 85115 "Water Production"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; Date; Date)
        {
        }
        field(50002; "Name of the Operator"; code[20])
        {
        }
        field(50003; "Time In"; time)
        {
        }
        field(50004; "Time Out"; time)
        {
        }
        field(50005; "Chemical Code Used"; code[20])
        {
            TableRelation = Item;
            trigger OnValidate()
            Var
                Itm: Record Item;
            begin
                if Itm.Get("Chemical Code Used") then
                    "Chemical Description" := Itm.Description;
            end;
        }
        field(50006; "Chemical Description"; Text[80])
        {
        }
        field(50007; "Chemicals Qty Used"; Decimal)
        {
        }
        field(50008; "Metering Type"; Option)
        {
            OptionMembers = "METER STARTED","METER STOPPED","WATER PUMPED",HOURS;
        }
        field(50009; "Units"; Decimal)
        {
        }
        field(50010; Remarks; text[100])
        {
        }
    }

    keys
    {
        key(PK; "Entry No")
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