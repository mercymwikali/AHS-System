Table 52202544 "HMS Scheme Plan Header"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                /*IF "No." <> xRec."No." THEN BEGIN
                  SalesSetup.GET;
                  NoSeriesMgt.TestManual(SalesSetup."Customer Nos.");
                  "No. Series" := '';
                END;
                IF "Invoice Disc. Code" = '' THEN
                  "Invoice Disc. Code" := "No.";
                  */
                cust.Get("No.");
                Name := cust.Name;
                "Search Name" := cust."Search Name";
                "Name 2" := cust."Name 2";
                Address := cust.Address;
                "Address 2" := cust."Address 2";
                City := cust.City;
                Contact := cust.Contact;
                "Phone No." := cust."Phone No.";
                "Telex No." := cust."Telex No.";
                "Global Dimension 1 Code" := cust."Global Dimension 1 Code";
                "Global Dimension 2 Code" := cust."Global Dimension 2 Code";
                "Credit Limit (LCY)" := cust."Credit Limit (LCY)";
                "Customer Posting Group" := cust."Customer Posting Group";
                "Currency Code" := cust."Currency Code";
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                ///IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
                 // "Search Name" := Name;
            end;
        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(8; Contact; Text[50])
        {
            Caption = 'Contact';

            trigger OnLookup()
            begin
            end;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(11; "Document Sending Profile"; Code[20])
        {
            Caption = 'Document Sending Profile';
            TableRelation = "Document Sending Profile".Code;
        }
        field(14; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(18; "Chain Name"; Code[10])
        {
            Caption = 'Chain Name';
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
        }
        field(20; "Credit Limit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Credit Limit (LCY)';
        }
        field(21; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(23; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        cust.Get("No.");
        Name := cust.Name;
        "Search Name" := cust."Search Name";
        "Name 2" := cust."Name 2";
        Address := cust.Address;
        "Address 2" := cust."Address 2";
        City := cust.City;
        Contact := cust.Contact;
        "Phone No." := cust."Phone No.";
        "Telex No." := cust."Telex No.";
        "Global Dimension 1 Code" := cust."Global Dimension 1 Code";
        "Global Dimension 2 Code" := cust."Global Dimension 2 Code";
        "Credit Limit (LCY)" := cust."Credit Limit (LCY)";
        "Customer Posting Group" := cust."Customer Posting Group";
        "Currency Code" := cust."Currency Code";
    end;

    var
        cust: Record Customer;
}
