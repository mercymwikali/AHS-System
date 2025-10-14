table 52202939 "HMS Insuarance Packages"
{
    Caption = 'HMS Insuarance Packages';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Insurance No"; Code[20])
        {
            Caption = 'Insurance No';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if Cust.get("Insurance No") then
                    "Insurance Name" := Cust.Name;
            end;
        }
        field(2; "Insurance Name"; Text[150])
        {
            Caption = 'Insurance Name';
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = Charge,Item;
        }
        field(4; "Charge Item"; Code[20])
        {
            Caption = 'Charge Item';
            TableRelation = if (Type = filter(Item)) Item."No."
            else
            if (Type = filter(Charge)) "HMS Charges".Code;
            trigger OnValidate()
            var
                HmsCharge: Record "HMS Charges";
                objItem: Record Item;
            begin
                if Type = Type::Item then begin
                    if objItem.Get("Charge Item") then
                        "Charge Name" := objItem.Description;
                    Amount := objItem."Unit Price";
                end else
                    if Type = Type::Charge then begin
                        if HmsCharge.Get("Charge Item") then
                            "Charge Name" := HmsCharge.Description;
                        "Transaction Type" := HmsCharge."Transaction Type";
                        Amount := HmsCharge.Amount;
                    end;
            end;
        }
        field(5; "Charge Name"; Text[250])
        {
            Caption = 'Charge Name';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            trigger OnValidate()
            begin
                "Total Amount" := Amount * Quantity;
            end;
        }
        field(7; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(8; "Package Name"; Text[200])
        {
            Caption = 'Package Name';
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            trigger OnValidate()
            begin
                if Quantity > 0 then
                    "Total Amount" := Amount * Quantity;
            end;
        }
        field(10; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            trigger OnValidate()
            begin
            end;
        }
        field(11; "Procedure Total"; Decimal)
        {
            CalcFormula = Sum("HMS Insuarance Packages"."Total Amount" where("Insurance No" = field("Insurance No")));
            Caption = 'Procedure Total Amount';
            FieldClass = FlowField;
        }
        field(12; "Transaction Type"; Code[20])
        {
            TableRelation = "HMS Transactions code"."Transaction Type";
        }
    }
    keys
    {
        key(PK; "Insurance No", Type, "Charge Item")
        {
            Clustered = true;
        }
    }
}
