table 85112 "Items Usage Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "SRN No"; code[20])
        {
            TableRelation = "Store Requistion Header"."No." where("Posted Count" = filter(> 0));
        }
        field(50001; "Item No"; code[20])
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
        field(50002; "Description"; text[100])
        {
        }
        field(50003; "Date"; Date)
        {
        }
        field(50004; "Quantity Received"; Decimal)
        {
            trigger OnValidate()
            begin
                Balance := "Quantity Received" - "Quantity Used";
            end;
        }
        field(50005; "Quantity Used"; Decimal)
        {
            trigger OnValidate()
            begin
                Balance := "Quantity Received" - "Quantity Used";
            end;
        }
        field(50006; "Balance"; Decimal)
        {
        }
        field(50007; "Responsible Person"; code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50008; "Remarks"; Text[200])
        {
        }
        field(50009; Type; Option)
        {
            OptionCaption = ' ,Chemicals,Materials';
            OptionMembers = ,Chemicals,Materials;
        }
        field(50010; "Type of Materials"; code[20])
        {
        }
        field(50011; "Section"; code[20])
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