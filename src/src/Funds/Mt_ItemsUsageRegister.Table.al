table 52202455 "Items Usage Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SRN No"; code[20])
        {
            TableRelation = "Store Requistion Header"."No." where("Posted Count" = filter(> 0));
        }
        field(2; "Item No"; code[20])
        {
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                Itm: Record item;
            begin
                if Itm.get("Item No") then
                    Description := Itm.Description;
            end;
        }
        field(3; "Description"; text[100])
        {
        }
        field(4; "Date"; Date)
        {
        }
        field(5; "Quantity Received"; Decimal)
        {
            trigger OnValidate()
            begin
                Balance := "Quantity Received" - "Quantity Used";
            end;
        }
        field(6; "Quantity Used"; Decimal)
        {
            trigger OnValidate()
            begin
                Balance := "Quantity Received" - "Quantity Used";
            end;
        }
        field(7; "Balance"; Decimal)
        {
        }
        field(8; "Responsible Person"; code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(9; "Remarks"; Text[200])
        {
        }
        field(10; Type; Option)
        {
            OptionCaption = ' ,Chemicals,Materials';
            OptionMembers = ,Chemicals,Materials;
        }
        field(11; "Type of Materials"; code[20])
        {
        }
        field(12; "Section"; code[20])
        {
        }
    }

    keys
    {
        key(PK; "Item No", "SRN No")
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