Table 52202546 "HMS Scheme Plan Items"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                Objitem.SetRange(Objitem."No.", "No.");
                if Objitem.Find('-') then
                    "No. 2" := Objitem."No. 2";
                Description := Objitem.Description;
                "Search Description" := Objitem."Search Description";
                "Description 2" := Objitem."Description 2";
                "Unit Cost" := Objitem."Unit Cost";
                "Base Unit of Measure" := Objitem."Base Unit of Measure";
                Type := Objitem.Type;
                "Inventory Posting Group" := Objitem."Inventory Posting Group";
                "Shelf No." := Objitem."Shelf No.";
                "Price Unit Conversion" := Objitem."Price Unit Conversion";
                "Item Disc. Group" := Objitem."Item Disc. Group";
                "Allow Invoice Disc." := Objitem."Allow Invoice Disc.";
                "Statistics Group" := Objitem."Statistics Group";
                "Commission Group" := Objitem."Commission Group";
                "Price/Profit Calculation" := Objitem."Price/Profit Calculation";
                "Profit %" := Objitem."Profit %";
            end;
        }
        field(2; "No. 2"; Code[20])
        {
            Caption = 'No. 2';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := Description;
            end;
        }
        field(4; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
            DataClassification = ToBeClassified;
        }
        field(5; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }
        field(6; Insurance; Code[30])
        {
            FieldClass = Normal;
            TableRelation = Customer."No.";
        }
        field(7; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(9; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
            end;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Inventory,Service';
            OptionMembers = Inventory,Service;

            trigger OnValidate()
            begin
            end;
        }
        field(11; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group";
        }
        field(12; "Shelf No."; Code[10])
        {
            Caption = 'Shelf No.';
            DataClassification = ToBeClassified;
        }
        field(13; "Price Unit Conversion"; Integer)
        {
            Caption = 'Price Unit Conversion';
            DataClassification = ToBeClassified;
        }
        field(14; "Item Disc. Group"; Code[20])
        {
            Caption = 'Item Disc. Group';
            DataClassification = ToBeClassified;
            TableRelation = "Item Discount Group";
        }
        field(15; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(16; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
            DataClassification = ToBeClassified;
        }
        field(17; "Commission Group"; Integer)
        {
            Caption = 'Commission Group';
            DataClassification = ToBeClassified;
        }
        field(19; "Price/Profit Calculation"; Option)
        {
            Caption = 'Price/Profit Calculation';
            DataClassification = ToBeClassified;
            OptionCaption = 'Profit=Price-Cost,Price=Cost+Profit,No Relationship';
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";
        }
        field(20; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Validate("Price/Profit Calculation");
            end;
        }
    }

    keys
    {
        key(Key1; "No.", Insurance)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Objitem.SetRange(Objitem."No.", "No.");
        if Objitem.Find('-') then
            "No. 2" := Objitem."No. 2";
        Description := Objitem.Description;
        "Search Description" := Objitem."Search Description";
        "Description 2" := Objitem."Description 2";
        "Unit Cost" := Objitem."Unit Cost";
        "Base Unit of Measure" := Objitem."Base Unit of Measure";
        Type := Objitem.Type;
        "Inventory Posting Group" := Objitem."Inventory Posting Group";
        "Shelf No." := Objitem."Shelf No.";
        "Price Unit Conversion" := Objitem."Price Unit Conversion";
        "Item Disc. Group" := Objitem."Item Disc. Group";
        "Allow Invoice Disc." := Objitem."Allow Invoice Disc.";
        "Statistics Group" := Objitem."Statistics Group";
        "Commission Group" := Objitem."Commission Group";
        "Price/Profit Calculation" := Objitem."Price/Profit Calculation";
        "Profit %" := Objitem."Profit %";
    end;

    var
        Objitem: Record Item;

    local procedure CalcVAT(): Decimal
    begin
    end;
}
