table 85349 "HMS Item Tracking Buffer"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Pharmacy No"; Code[20])
        {
            TableRelation = "HMS Pharmacy Header"."Pharmacy No.";
        }
        field(50002; "Item No"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(50003; Description; Text[250])
        {
        }
        field(50004; "Lot No"; Code[100])
        {
            TableRelation = "Item Ledger Entry"."Lot No." WHERE("Item No." = FIELD("Item No"));
        }
        field(50005; "Serial No"; Code[100])
        {
            TableRelation = "Item Ledger Entry"."Serial No.";
        }
        field(50006; "Expiration Date"; Date)
        {
        }
        field(50007; "Lot No Entry No"; Integer)
        {
            TableRelation = "Item Ledger Entry"."Entry No." WHERE("Item No." = FIELD("Item No"),
                                                                   "Remaining Quantity" = FILTER(> 0),
                                                                   "Location Code" = FIELD("Location Code"));

            trigger OnValidate()
            begin
                LedgerEntries.RESET();
                LedgerEntries.SETRANGE(LedgerEntries."Entry No.", "Lot No Entry No");
                IF LedgerEntries.FIND('-') THEN BEGIN
                    "Lot No" := LedgerEntries."Lot No.";
                    "Expiration Date" := LedgerEntries."Expiration Date";
                    "Serial No" := LedgerEntries."Serial No.";
                    "Remaining Quantity" := LedgerEntries."Remaining Quantity";
                END;
            end;
        }
        field(50008; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                IF Quantity > "Remaining Quantity" THEN
                    ERROR('Quantity cannnot be more than remaining quantity');
            end;
        }
        field(50009; "Location Code"; Code[30])
        {
            TableRelation = Location.Code;
        }
        field(50010; "Remaining Quantity"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        LedgerEntries: Record "Item Ledger Entry";
}
