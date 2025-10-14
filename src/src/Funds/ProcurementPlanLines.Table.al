Table 52202877 "Procurement Plan Lines"
{
    fields
    {
        field(1; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(2; Department; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(3; Type; Option)
        {
            OptionCaption = ' ,G/L Account,Item,Fixed Asset';
            OptionMembers = " ","G/L Account",Item,"Fixed Asset";
        }
        field(4; "Type No"; Code[20])
        {
            TableRelation = if (Type = const("G/L Account")) "G/L Account"."No."
            else
            if (Type = const(Item)) Item."No."
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                if Type = 1 then
                    if GL.Get("Type No") then
                        Description := GL.Name;
                        // Category:=GL."Expense Code";
                if Type = 2 then begin
                    if ITM.Get("Type No") then
                        Description := ITM.Description;
                    Category := ITM."Gen. Prod. Posting Group";
                end;
                if Type = 3 then begin
                    if FA.Get("Type No") then
                        Description := FA.Description;
                    Category := FA."FA Subclass Code";
                end;
            end;
        }
        field(5; Description; Text[100])
        {
        }
        field(6; Quantity; Decimal)
        {
            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";
                "Remaining Qty" := Quantity;
            end;
        }
        field(7; "Unit Cost"; Decimal)
        {
            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Cost";
            end;
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "Remaining Qty"; Decimal)
        {
            Editable = false;
        }
        field(10; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(11; Category; Code[20])
        {
        }
        field(12; "Plan Date"; Date)
        {
        }
        field(13; "Procurement Plan Period"; Code[20])
        {
            TableRelation = "Procurement Plan Period".Code;
        }
    }

    keys
    {
        key(Key1; "Budget Name", Department, Type, "Type No", Campus, "Procurement Plan Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        FA: Record "Fixed Asset";
        GL: Record "G/L Account";
        ITM: Record Item;
}
