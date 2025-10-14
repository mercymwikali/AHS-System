table 52202436 "Water Production"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Name of the Operator"; code[20])
        {
        }
        field(4; "Time In"; time)
        {
        }
        field(5; "Time Out"; time)
        {
        }
        field(6; "Chemical Code Used"; code[20])
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
        field(7; "Chemical Description"; Text[80])
        {
        }
        field(8; "Chemicals Qty Used"; Decimal)
        {
        }
        field(9; "Metering Type"; Option)
        {
            OptionMembers = "METER STARTED","METER STOPPED","WATER PUMPED",HOURS;
        }
        field(10; "Units"; Decimal)
        {
        }
        field(11; Remarks; text[100])
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