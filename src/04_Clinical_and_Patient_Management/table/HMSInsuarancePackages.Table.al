table 85345 "HMS Insuarance Packages"
{
    Caption = 'HMS Insuarance Packages';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Insurance No"; Code[20])
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
        field(50001; "Insurance Name"; Text[150])
        {
            Caption = 'Insurance Name';
        }
        field(50002; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = Charge,Item;
        }
        field(50003; "Charge Item"; Code[20])
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
        field(50004; "Charge Name"; Text[250])
        {
            Caption = 'Charge Name';
        }
        field(50005; Amount; Decimal)
        {
            Caption = 'Amount';
            trigger OnValidate()
            begin
                "Total Amount" := Amount * Quantity;
            end;
        }
        field(50006; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(50007; "Package Name"; Text[200])
        {
            Caption = 'Package Name';
        }
        field(50008; Quantity; Decimal)
        {
            Caption = 'Quantity';
            trigger OnValidate()
            begin
                if Quantity > 0 then
                    "Total Amount" := Amount * Quantity;
            end;
        }
        field(50009; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            trigger OnValidate()
            begin
            end;
        }
        field(50010; "Procedure Total"; Decimal)
        {
            CalcFormula = Sum("HMS Insuarance Packages"."Total Amount" where("Insurance No" = field("Insurance No")));
            Caption = 'Procedure Total Amount';
            FieldClass = FlowField;
        }
        field(50011; "Transaction Type"; Code[20])
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
