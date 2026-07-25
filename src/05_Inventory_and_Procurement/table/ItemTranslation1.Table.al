Table 85060 "Item Translation1"
{
    Caption = 'Item Translation';
    DataCaptionFields = "Item No.", "Variant Code", "Language Code", Description;
    LookupPageID = "Item Translations";

    fields
    {
        field(50000; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(50001; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            NotBlank = true;
            TableRelation = Language;
        }
        field(50002; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(50003; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(50004; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
    }

    keys
    {
        key(Key1; "Item No.", "Variant Code", "Language Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
