Table 85050 Customer2
{
    Caption = 'Customer';
    DataCaptionFields = "No.", Name;
    //DrillDownFormID = Form22;
    // LookupFormID = Form22;
    Permissions = TableData "Cust. Ledger Entry" = r;

    fields
    {
        field(50000; "No."; Code[20])
        {
            Caption = 'Customer/Student Number';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(SalesSetup."Customer Nos.");
                    "No. Series" := '';
                end;
                if "Invoice Disc. Code" = '' then
                    "Invoice Disc. Code" := "No.";
                /*
                IF "Current Programme"='' THEN BEGIN
                  IF "Customer Type"="Customer Type"::Student THEN BEGIN
                     "Current Programme":=COPYSTR(FORMAT("No."),1,3);
                     MODIFY;
                  END;
                END;
                */
            end;
        }
        field(50001; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(50002; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(50003; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(50004; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(50005; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(50006; City; Text[30])
        {
            Caption = 'City';
        }
        field(50007; Contact; Text[50])
        {
            Caption = 'Contact';

            trigger OnValidate()
            begin
                if RMSetup.Get() then
                    if RMSetup."Bus. Rel. Code for Customers" <> '' then
                        if (xRec.Contact = '') and (xRec."Primary Contact No." = '') then begin
                            Modify();
                            //  UpdateContFromCust.OnModify(Rec);
                            // UpdateContFromCust.InsertNewContactPerson(Rec,false);
                            Modify(true);
                        end
            end;
        }
        field(50008; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(50009; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(50010; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
        }
        field(50011; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(50012; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");

                if "Global Dimension 1 Code" = 'TOWN' then
                    "Library Branch" := 'PUNBI'
                else
                    "Library Branch" := 'PUEA';
            end;
        }
        field(50013; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(50014; "Chain Name"; Code[10])
        {
            Caption = 'Chain Name';
        }
        field(50015; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
        }
        field(50016; "Credit Limit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Credit Limit (LCY)';
        }
        field(50017; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(50018; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(50019; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(50020; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(50021; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
        }
        field(50022; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(50023; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            TableRelation = "Finance Charge Terms";
        }
        field(50024; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50025; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(50026; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
                    Validate("Shipping Agent Service Code", '');
            end;
        }
        field(50027; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export';
        }
        field(50028; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = Customer;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50029; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(50030; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50031; "Collection Method"; Code[20])
        {
            Caption = 'Collection Method';
        }
        field(50032; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(50033; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(Customer),
                                                      "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50034; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(50035; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies';
        }
        field(50036; "Last Statement No."; Integer)
        {
            Caption = 'Last Statement No.';
        }
        field(50037; "Print Statements"; Boolean)
        {
            Caption = 'Print Statements';
        }
        field(50038; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(50039; Priority; Integer)
        {
            Caption = 'Priority';
        }
        field(50040; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(50041; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50042; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50043; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';
            CaptionClass = '1,3,1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50044; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 2 Filter';
            CaptionClass = '1,3,2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50045; Balance; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter"),
                                                                         "Posting Date" = field("Date Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50046; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = field("Currency Filter"),
                                                                                 "Posting Date" = field("Date Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50047; "Net Change"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50048; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Net Change (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50049; "Sales (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cust. Ledger Entry"."Sales (LCY)" where("Customer No." = field("No."),
                                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        "Currency Code" = field("Currency Filter")));
            Caption = 'Sales (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50050; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cust. Ledger Entry"."Profit (LCY)" where("Customer No." = field("No."),
                                                                         "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                         "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Profit (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50051; "Inv. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cust. Ledger Entry"."Inv. Discount (LCY)" where("Customer No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Posting Date" = field("Date Filter"),
                                                                                "Currency Code" = field("Currency Filter")));
            Caption = 'Inv. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50052; "Pmt. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Discount" .. "Payment Discount (VAT Adjustment)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50053; "Balance Due"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Posting Date" = field(upperlimit("Date Filter")),
                                                                         "Initial Entry Due Date" = field("Date Filter"),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50054; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                 "Posting Date" = field(upperlimit("Date Filter")),
                                                                                 "Initial Entry Due Date" = field("Date Filter"),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Balance Due (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50055; Payments; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Payment),
                                                                          "Entry Type" = const("Initial Entry"),
                                                                          "Customer No." = field("No."),
                                                                          "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Payments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50056; "Invoice Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Invoice),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Invoice Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50057; "Cr. Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CalcFormula = -sum("Detailed Cust. Ledg. Entry".Amount where ("Initial Document Type"=const(Credit field("No.")","
        }
        field(50058; "Finance Charge Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            //CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where ("Initial Document Type"=const(Finance field("No.")","
        }
        field(50059; "Payments (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Payment),
                                                                                  "Entry Type" = const("Initial Entry"),
                                                                                  "Customer No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Payments (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50060; "Inv. Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Invoice),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Inv. Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50061; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Shipped Not Invoiced" where("Document Type" = const(Order),
                                                                         "Bill-to Customer No." = field("No."),
                                                                         "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                         "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Shipped Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50062; "Application Method"; Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(50063; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
        }
        field(50064; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(50065; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50066; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(50067; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", "No.", Database::Customer);
            end;
        }
        field(50068; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments';
        }
        field(50069; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(50070; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50071; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50072; County; Text[30])
        {
            Caption = 'County';
        }
        field(50073; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Debit Amount" where("Customer No." = field("No."),
                                                                                 "Entry Type" = filter(<> Application),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50074; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Credit Amount" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter(<> Application),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50075; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Debit Amount (LCY)" where("Customer No." = field("No."),
                                                                                       "Entry Type" = filter(<> Application),
                                                                                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                       "Posting Date" = field("Date Filter"),
                                                                                       "Currency Code" = field("Currency Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50076; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Credit Amount (LCY)" where("Customer No." = field("No."),
                                                                                        "Entry Type" = filter(<> Application),
                                                                                        "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                        "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                        "Posting Date" = field("Date Filter"),
                                                                                        "Currency Code" = field("Currency Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50077; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(50078; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(50079; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code';
            TableRelation = "Reminder Terms";
        }
        field(50080; "Reminder Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Reminder),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Reminder Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50081; "Reminder Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Reminder),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Reminder Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50082; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50083; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(50084; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(50085; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(50086; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(50087; "Outstanding Orders (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount (LCY)" where("Document Type" = const(Order),
                                                                             "Bill-to Customer No." = field("No."),
                                                                             "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                             "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50088; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Shipped Not Invoiced (LCY)" where("Document Type" = const(Order),
                                                                               "Bill-to Customer No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Currency Code" = field("Currency Filter")));
            Caption = 'Shipped Not Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50089; Reserve; Option)
        {
            Caption = 'Reserve';
            InitValue = Optional;
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(50090; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
        }
        field(50091; "Pmt. Disc. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Discount Tolerance" | "Payment Discount Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Disc. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50092; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Tolerance" | "Payment Tolerance (VAT Adjustment)" | "Payment Tolerance (VAT Excl.)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50093; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";

            trigger OnValidate()
            var
                AccountingPeriod: Record "Accounting Period";
                CustLedgEntry: Record "Cust. Ledger Entry";
                ICPartner: Record "IC Partner";
            begin
                if xRec."IC Partner Code" <> "IC Partner Code" then begin
                    CustLedgEntry.SetCurrentkey("Customer No.", "Posting Date");
                    CustLedgEntry.SetRange("Customer No.", "No.");
                    AccountingPeriod.SetRange(Closed, false);
                    if AccountingPeriod.Find('-') then
                        CustLedgEntry.SetFilter("Posting Date", '>=%1', AccountingPeriod."Starting Date");
                    if CustLedgEntry.Find('-') then
                        if not Confirm(Text011, false, TableCaption) then
                            "IC Partner Code" := xRec."IC Partner Code";

                    CustLedgEntry.Reset();
                    if not CustLedgEntry.SetCurrentkey("Customer No.", Open) then
                        CustLedgEntry.SetCurrentkey("Customer No.");
                    CustLedgEntry.SetRange("Customer No.", "No.");
                    CustLedgEntry.SetRange(Open, true);
                    if CustLedgEntry.Find('+') then
                        Error(Text012, FieldCaption("IC Partner Code"), TableCaption);
                end;

                if "IC Partner Code" <> '' then begin
                    ICPartner.Get("IC Partner Code");
                    if (ICPartner."Customer No." <> '') and (ICPartner."Customer No." <> "No.") then
                        Error(Text010, FieldCaption("IC Partner Code"), "IC Partner Code", TableCaption, ICPartner."Customer No.");
                    ICPartner."Customer No." := "No.";
                    ICPartner.Modify();
                end;

                if (xRec."IC Partner Code" <> "IC Partner Code") and ICPartner.Get(xRec."IC Partner Code") then begin
                    ICPartner."Customer No." := '';
                    ICPartner.Modify();
                end;
            end;
        }
        field(50094; Refunds; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Refund),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Refunds';
            FieldClass = FlowField;
        }
        field(50095; "Refunds (LCY)"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Refund),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Refunds (LCY)';
            FieldClass = FlowField;
        }
        field(50096; "Other Amounts"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(" "),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Other Amounts';
            FieldClass = FlowField;
        }
        field(50097; "Other Amounts (LCY)"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(" "),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Other Amounts (LCY)';
            FieldClass = FlowField;
        }
        field(50098; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50099; "Outstanding Invoices (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount (LCY)" where("Document Type" = const(Invoice),
                                                                             "Bill-to Customer No." = field("No."),
                                                                             "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                             "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Invoices (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50100; "Outstanding Invoices"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount" where("Document Type" = const(Invoice),
                                                                       "Bill-to Customer No." = field("No."),
                                                                       "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                       "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50101; "Bill-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = count("Sales Header Archive" where("Document Type" = const(Order),
                                                              "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-to No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(50102; "Sell-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = count("Sales Header Archive" where("Document Type" = const(Order),
                                                              "Sell-to Customer No." = field("No.")));
            Caption = 'Sell-to No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(50103; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.';
            TableRelation = Contact;
        }
        field(50104; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(50105; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(50106; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(50107; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field("Shipping Agent Code"));

            trigger OnValidate()
            begin
                if ("Shipping Agent Code" <> '') and
                   ("Shipping Agent Service Code" <> '')
                then
                    if ShippingAgentService.Get("Shipping Agent Code", "Shipping Agent Service Code") then
                        "Shipping Time" := ShippingAgentService."Shipping Time"
                    else
                        Evaluate("Shipping Time", '<>');
            end;
        }
        field(50108; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            TableRelation = "Service Zone";
        }
        field(50109; "Contract Gain/Loss Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Contract Gain/Loss Entry".Amount where("Customer No." = field("No."),
                                                                       "Ship-to Code" = field("Ship-to Filter"),
                                                                       "Change Date" = field("Date Filter")));
            Caption = 'Contract Gain/Loss Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50110; "Ship-to Filter"; Code[10])
        {
            Caption = 'Ship-to Filter';
            FieldClass = FlowFilter;
            TableRelation = "Ship-to Address".Code where("Customer No." = field("No."));
        }
        field(50111; "Outstanding Serv. Orders (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Service Line"."Outstanding Amount (LCY)" where("Document Type" = const(Order),
                                                                               "Bill-to Customer No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Serv. Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50112; "Serv Shipped Not Invoiced(LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Service Line"."Shipped Not Invoiced (LCY)" where("Document Type" = const(Order),
                                                                                 "Bill-to Customer No." = field("No."),
                                                                                 "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                 "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Serv Shipped Not Invoiced(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50113; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(50114; "No. of Quotes"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Quote),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50115; "No. of Blanket Orders"; Integer)
        {
            //  CalcFormula = count("Sales Header" where ("Document Type"=const(Blanket field("No.")")";
            Caption = 'No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50116; "No. of Orders"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50117; "No. of Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50118; "No. of Return Orders"; Integer)
        {
            // CalcFormula = count("Sales Header" where ("Document Type"=const(Return field("No.")")";
            Caption = 'No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50119; "No. of Credit Memos"; Integer)
        {
            //  CalcFormula = count("Sales Header" where ("Document Type"=const(Credit field("No.")")";
            Caption = 'No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50120; "No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50121; "No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = count("Sales Invoice Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50122; "No. of Pstd. Return Receipts"; Integer)
        {
            CalcFormula = count("Return Receipt Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Return Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50123; "No. of Pstd. Credit Memos"; Integer)
        {
            CalcFormula = count("Sales Cr.Memo Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50124; "No. of Ship-to Addresses"; Integer)
        {
            CalcFormula = count("Ship-to Address" where("Customer No." = field("No.")));
            Caption = 'No. of Ship-to Addresses';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50125; "Bill-To No. of Quotes"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Quote),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50126; "Bill-To No. of Blanket Orders"; Integer)
        {
            //  CalcFormula = count("Sales Header" where ("Document Type"=const(Blanket field("No.")")";
            Caption = 'Bill-To No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50127; "Bill-To No. of Orders"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50128; "Bill-To No. of Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50129; "Bill-To No. of Return Orders"; Integer)
        {
            // CalcFormula = count("Sales Header" where ("Document Type"=const(Return field("No.")")";
            Caption = 'Bill-To No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50130; "Bill-To No. of Credit Memos"; Integer)
        {
            // CalcFormula = count("Sales Header" where ("Document Type"=const(Credit field("No.")")";
            Caption = 'Bill-To No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50131; "Bill-To No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50132; "Bill-To No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = count("Sales Invoice Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50133; "Bill-To No. of Pstd. Return R."; Integer)
        {
            CalcFormula = count("Return Receipt Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Return R.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50134; "Bill-To No. of Pstd. Cr. Memos"; Integer)
        {
            CalcFormula = count("Sales Cr.Memo Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Cr. Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50135; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(50136; "Copy Sell-to Addr. to Qte From"; Option)
        {
            Caption = 'Copy Sell-to Addr. to Qte From';
            OptionCaption = 'Company,Person';
            OptionMembers = Company,Person;
        }
        field(50137; "Average Cummulative GPA"; Decimal)
        {
            // CalcFormula = average("Student Units"."GPA Points" where ("Student No."=field("No.")));
            DecimalPlaces = 1 : 1;
            FieldClass = FlowField;
        }
        field(50138; "Balance (Cafe)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CalcFormula = sum("Detailed Students Cafe Ledgers".Amount where ("Customer No."=field("No.")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50139; "Debit Amount (Cafe)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            //  CalcFormula = sum("Detailed Students Cafe Ledgers"."Debit Amount" where ("Customer No."=field("No.")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50140; "Credit Amount (Cafe)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            //  CalcFormula = sum("Detailed Students Cafe Ledgers"."Credit Amount" where ("Customer No."=field("No.")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50141; test; Text[30])
        {
        }
        field(50142; Gender; Option)
        {
            OptionMembers = Male,Female;

            trigger OnValidate()
            begin
                if Gender = Gender::Male then
                    "Library Gender" := 'M';
                if Gender = Gender::Female then
                    "Library Gender" := 'F';
            end;
        }
        field(50143; "Date Of Birth"; Date)
        {
        }
        field(50144; Age; Decimal)
        {
        }
        field(50145; "Marital Status"; Option)
        {
            OptionMembers = Single,Married,Divorced,Widowed;
        }
        field(50146; "Blood Group"; Text[30])
        {
        }
        field(50147; Weight; Decimal)
        {
        }
        field(50148; Height; Decimal)
        {
        }
        field(50149; Religion; Code[50])
        {
            Caption = 'Religions';
            //  TableRelation = Religion.Relegion;
        }
        field(50150; Citizenship; Text[30])
        {
        }
        field(50151; "ID No"; Code[30])
        {
        }
        field(50152; "Date Registered"; Date)
        {
        }
        field(50153; "Membership No"; Text[100])
        {
        }
        field(50154; "Customer Type"; Option)
        {
            OptionCaption = 'Customer,Student,Hotel,Staff';
            OptionMembers = Customer,Student,Hotel,Staff;
        }
        field(50155; "Birth Cert"; Code[30])
        {
            trigger OnValidate()
            begin
                Cust.Reset();
                Cust.SetRange(Cust."Birth Cert", "Birth Cert");
                //IF Cust.FIND('-') THEN
                //ERROR('Birth Cert/KNEC No. exists.');
            end;
        }
        field(50156; "UNISA No"; Code[30])
        {
        }
        field(50157; "Opening Balance"; Decimal)
        {
        }
        field(50158; "Old Student Code"; Code[20])
        {
        }
        field(50159; "Name 3"; Text[100])
        {
        }
        field(50160; Status; Option)
        {
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred;

            trigger OnValidate()
            begin
                "Status Change Date" := Today;
                if Status = Status::Alluminae then
                    // if "Current Programme" = '' then Error('The current Programme is not specified.');
                    // if "Graduating Year" = '' then Error('Please specify the Year of Graduation for the student.');
                    if "Graduating Semester" = '' then
                        Error('Please specify the Semester of Graduation for the student.');
                        /*IF "University Reference Number" = '' THEN BEGIN
                          AppSetup.GET;
                          AppSetup.TESTFIELD(AppSetup."University Reference Number");
                          NoSeriesMgt.InitSeries(AppSetup."University Reference Number",xRec."No. Series",0D,"University Reference Number","No. Series");
                          "University Reference Number":='PUEA/'+progs."Programme Abreviation"+
                            '-'+progs."Award Abbreviation"+'/'+"University Reference Number"+'-'+FORMAT("Graduating Year");
                        END;*/
            end;
        }
        field(50161; "Library Code"; Code[20])
        {
        }
        field(50162; "JKUAT No"; Code[30])
        {
        }
        field(50163; "KNEC No"; Code[30])
        {
        }
        field(50164; "Passport No"; Code[30])
        {
        }
        field(50165; "New Date"; Date)
        {
        }
        field(50166; "New Receipt Date"; Date)
        {
        }
        field(50167; "From Entry"; Text[50])
        {
            FieldClass = FlowFilter;
            TableRelation = "Cust. Ledger Entry"."Entry No." where("Customer No." = field("No."));
        }
        field(50168; "To Entry"; Text[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "Cust. Ledger Entry"."Entry No." where("Customer No." = field("No."));
        }
        field(50169; "Student Balance"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter"),
                                                                         "Posting Date" = field("Date Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50170; "Confirmed Ok"; Boolean)
        {
            trigger OnValidate()
            begin
                "User ID" := UserId;
            end;
        }
        field(50171; "User ID"; Code[20])
        {
        }
        field(50172; "Library Membership"; Option)
        {
            OptionCaption = 'DIP IT,BSC IT,IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,TEACHING STAFF,DIRECTORS,ADMIN STAFF,BR MATHS,IT,PACKAGES,DCEDHM';
            OptionMembers = "DIP IT","BSC IT",IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,"TEACHING STAFF",DIRECTORS,"ADMIN STAFF","BR MATHS",IT,PACKAGES,DCEDHM;
        }
        field(50173; libsecurity; Text[30])
        {
        }
        field(50174; "Can Use Library"; Boolean)
        {
            Description = 'USED BY LIBRARY TO CHECK WETHER STUDENT EXISTS IN LIB SYSTEM - 12TH JUNE 2008 - TONY';
        }
        field(50175; "Lib Membership"; Text[30])
        {
            Description = 'STORES THE STUDENTS LATEST LIBRARY MEMBSERSHIP CATEGORY - 12TH JUNE 2008 - TONY';
        }
        field(50176; "No Of Reversals"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("No."),
                                                            Reversed = const(true)));
            FieldClass = FlowField;
        }
        field(50177; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Cust. Ledger Entry"."Document No.";
        }
        field(50178; "R Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Posting Date" = field("Date Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50179; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = Semester.Code;
        }
        field(50180; "Staff No."; Code[20])
        {
        }
        field(50181; "Programme Category"; Option)
        {
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(50182; "Accredited Centre no."; Code[20])
        {
        }
        field(50183; Adults; Integer)
        {
            InitValue = 1;
        }
        field(50184; "Vehicle No."; Code[20])
        {
        }
        field(50185; "Children Under 12"; Integer)
        {
        }
        field(50186; "Group/Company"; Code[20])
        {
        }
        field(50187; "Departure Date"; Date)
        {
        }
        field(50188; "Arrival Date"; Date)
        {
        }
        field(50189; Nationality; Text[30])
        {
            InitValue = 'KENYAN';
        }
        field(50190; "Room Type"; Code[20])
        {
        }
        field(50191; "Receipt No"; Code[10])
        {
        }
        field(50192; Rate; Decimal)
        {
        }
        field(50193; Cashier; Text[30])
        {
        }
        field(50194; Deposit; Decimal)
        {
        }
        field(50195; "Payment Date"; Date)
        {
        }
        field(50196; Remarks; Text[50])
        {
        }
        field(50197; "Guest Agent Code"; Code[10])
        {
            //  TableRelation = "Booking Agents".No;
        }
        field(50198; Singles; Integer)
        {
        }
        field(50199; Doubles; Integer)
        {
        }
        field(50200; Triples; Integer)
        {
        }
        field(50201; "Taken By"; Text[30])
        {
        }
        field(50202; "Checked By"; Text[30])
        {
        }
        field(50203; "Check Out Date"; Date)
        {
        }
        field(50204; "Check In Time"; Time)
        {
        }
        field(50205; "HTL Status"; Option)
        {
            OptionMembers = ,,Reserved,Current,Old;
        }
        field(50206; "HELB No."; Code[50])
        {
        }
        field(50207; "Deferement Period"; DateFormula)
        {
        }
        field(50208; "Status Change Date"; Date)
        {
        }
        field(50209; "Revenue Cash Account"; Code[20])
        {
            TableRelation = "Bank Account"."No." where("Bank Acc. Posting Group" = const('CASH'));
        }
        field(50210; Password; Text[100])
        {
            Editable = true;
        }
        field(50211; "Gown 1"; Boolean)
        {
        }
        field(50212; "Gown 2"; Boolean)
        {
        }
        field(50213; "Gown 3"; Boolean)
        {
        }
        field(50214; "Date Issued"; Date)
        {
        }
        field(50215; "Gown Status"; Option)
        {
            OptionCaption = ' ,Loaned,Returned';
            OptionMembers = " ",Loaned,Returned;

            trigger OnValidate()
            begin
                if "Gown Status" = "gown status"::Loaned then
                    "Date Issued" := Today;

                if "Gown Status" = "gown status"::Returned then
                    "Date Returned" := Today;
            end;
        }
        field(50216; "Date Returned"; Date)
        {
        }
        field(50217; "Certificate Status"; Option)
        {
            OptionCaption = ' ,Pending,Collected';
            OptionMembers = " ",Pending,Collected;

            trigger OnValidate()
            begin
                if "Certificate Status" = "certificate status"::Collected then
                    "Date Collected" := Today;
            end;
        }
        field(50218; "Date Collected"; Date)
        {
        }
        field(50219; Confirmed; Boolean)
        {
        }
        field(50220; "Confirmed Remarks"; Text[100])
        {
        }
        field(50221; "Special Requrements"; Text[200])
        {
        }
        field(50222; "Certificate No."; Text[50])
        {
        }
        field(50223; "No Of Creidts"; Integer)
        {
            CalcFormula = count("Detailed Cust. Ledg. Entry" where("Customer No." = field("No."),
                                                                    "Entry Type" = const("Initial Entry"),
                                                                    "Credit Amount (LCY)" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(50224; District; Code[20])
        {
            //  TableRelation = "Application Setup District".Code;

            trigger OnValidate()
            begin
            end;
        }
        field(50225; "Transfer to No."; Code[20])
        {
        }
        field(50226; "Transfer to"; Code[20])
        {
            Caption = 'Transfer to';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(50227; "Imported Rcpt"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50228; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50229; "Paid PartTime"; Integer)
        {
        }
        field(50230; "Hostel Black Listed"; Boolean)
        {
        }
        field(50231; "Black Listed Reason"; Text[100])
        {
        }
        field(50232; "Black Listed By"; Code[20])
        {
        }
        field(50233; "Audit Issue"; Boolean)
        {
        }
        field(50234; "Not Billed"; Boolean)
        {
        }
        field(50235; "New Stud"; Boolean)
        {
        }
        field(50236; "Programme Category Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ',Diploma,Undergraduate,Postgraduate,Course List';
            OptionMembers = ,Diploma,Undergraduate,Postgraduate,"Course List";
        }
        field(50237; sms_Password; Text[30])
        {
        }
        field(50238; "BroadCast Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = Table39003902.Field1;
        }
        field(50239; "Imprest Unsurrendered"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50240; "Lock Online Application"; Boolean)
        {
        }
        field(50241; "Department Description"; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Global Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(50242; "Entry Semester"; Code[20])
        {
            // TableRelation = Semester.Code;
        }
        field(50243; "Entry Semester Description"; Text[50])
        {
            //  CalcFormula = lookup(Semester.Description where (Code=field("Entry Semester")));
            FieldClass = FlowField;
        }
        field(50244; "Changed Password"; Boolean)
        {
        }
        field(50245; "Current Stage"; Code[20])
        {
        }
        field(50246; "Hostel No."; Code[10])
        {
        }
        field(50247; "Room No."; Code[10])
        {
        }
        field(50248; "Meal Card Valid From"; Date)
        {
        }
        field(50249; "Meal Card Valid To"; Date)
        {
        }
        field(50250; "Lib. Card Valid From"; Date)
        {
        }
        field(50251; "Lib. Card Valid To"; Date)
        {
        }
        field(50252; "Current Sem"; Code[10])
        {
            //  TableRelation = Semester.Code;
        }
        field(50253; "Graduating Semester"; Code[20])
        {
            // TableRelation = Semester.Code;
        }
        field(50254; "University Reference Number"; Code[50])
        {
        }
        field(50255; "Library Charges"; Decimal)
        {
            // CalcFormula = sum("Library Charges"."Amount owing" where (StudentNo=field("No.")));
            FieldClass = FlowField;
        }
        field(50256; "Open Bal"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50257; "Library Username"; Text[20])
        {
        }
        field(50258; "Library Security"; Integer)
        {
            InitValue = 1;
        }
        field(50259; "Common Units Done"; Integer)
        {
            FieldClass = FlowField;
        }
        field(50260; "Core Units Done"; Integer)
        {
            FieldClass = FlowField;
        }
        field(50261; "Electives Done"; Integer)
        {
            FieldClass = FlowField;
        }
        field(50262; "Library Category"; Code[20])
        {
        }
        field(50263; "Library Expiry Date"; Date)
        {
        }
        field(50264; "Library Branch"; Code[10])
        {
        }
        field(50265; "Library Gender"; Code[10])
        {
        }
        field(50266; "Old No."; Code[20])
        {
        }
        field(50267; "No Change date"; Date)
        {
        }
        field(50268; "Settlement type"; Option)
        {
            OptionMembers = " ",SSP,KUCCPS;
        }
        field(50269; "Balance B/F"; Decimal)
        {
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Customer Posting Group")
        {
        }
        key(Key4; "Currency Code")
        {
        }
        key(Key5; "Country/Region Code")
        {
        }
        key(Key6; "Gen. Bus. Posting Group")
        {
        }
        key(Key7; Name, Address, City)
        {
        }
        key(Key8; "VAT Registration No.")
        {
        }
        key(Key9; Name)
        {
        }
        key(Key10; City)
        {
        }
        key(Key11; "Post Code")
        {
        }
        key(Key12; "Phone No.")
        {
        }
        key(Key13; Contact)
        {
        }
        key(Key14; Status)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, City, "Post Code", "Phone No.", Contact)
        {
        }
    }

    trigger OnDelete()
    var
        CampaignTargetGr: Record "Campaign Target Group";
        ContactBusRel: Record "Contact Business Relation";
        Job: Record Job;
        StdCustSalesCode: Record "Standard Customer Sales Code";
    begin
        // CreditCards.DeleteByCustomer(Rec);

        ServiceItem.SetRange("Customer No.", "No.");
        if ServiceItem.Find('-') then
            if Confirm(
                 Text008,
                 false,
                 TableCaption,
                 "No.",
                 ServiceItem.FieldCaption("Customer No."))
            then
                ServiceItem.ModifyAll("Customer No.", '')
            else
                Error(Text009);

        Job.SetRange("Bill-to Customer No.", "No.");
        if Job.Find('-') then
            Error(Text015, TableCaption, "No.", Job.TableCaption);

        // MoveEntries.MoveCustEntries(Rec);

        CommentLine.SetRange("Table Name", CommentLine."table name"::Customer);
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll();

        CustBankAcc.SetRange("Customer No.", "No.");
        CustBankAcc.DeleteAll();

        ShipToAddr.SetRange("Customer No.", "No.");
        ShipToAddr.DeleteAll();

        SalesPrice.SetRange("Sales Type", SalesPrice."sales type"::Customer);
        SalesPrice.SetRange("Sales Code", "No.");
        SalesPrice.DeleteAll();

        SalesLineDisc.SetRange("Sales Type", SalesLineDisc."sales type"::Customer);
        SalesLineDisc.SetRange("Sales Code", "No.");
        SalesLineDisc.DeleteAll();

        SalesPrepmtPct.SetCurrentkey("Sales Type", "Sales Code");
        SalesPrepmtPct.SetRange("Sales Type", SalesPrepmtPct."sales type"::Customer);
        SalesPrepmtPct.SetRange("Sales Code", "No.");
        SalesPrepmtPct.DeleteAll();

        StdCustSalesCode.SetRange("Customer No.", "No.");
        StdCustSalesCode.DeleteAll(true);

        // ItemCrossReference.SetCurrentkey("Cross-Reference Type", "Cross-Reference Type No.");
        // ItemCrossReference.SetRange("Cross-Reference Type", ItemCrossReference."cross-reference type"::Customer);
        // ItemCrossReference.SetRange("Cross-Reference Type No.", "No.");
        // ItemCrossReference.DeleteAll;

        SalesOrderLine.SetCurrentkey("Document Type", "Bill-to Customer No.");
        SalesOrderLine.SetFilter(
          "Document Type", '%1|%2',
          SalesOrderLine."document type"::Order,
          SalesOrderLine."document type"::"Return Order");
        SalesOrderLine.SetRange("Bill-to Customer No.", "No.");
        if SalesOrderLine.Find('-') then
            Error(
              Text000,
              TableCaption, "No.", SalesOrderLine."Document Type");

        SalesOrderLine.SetRange("Bill-to Customer No.");
        SalesOrderLine.SetRange("Sell-to Customer No.", "No.");
        if SalesOrderLine.Find('-') then
            Error(
              Text000,
              TableCaption, "No.", SalesOrderLine."Document Type");

        CampaignTargetGr.SetRange("No.", Rec."No.");
        CampaignTargetGr.SetRange(Type, CampaignTargetGr.Type::Customer);
        if CampaignTargetGr.Find('-') then begin
            ContactBusRel.SetRange("Link to Table", ContactBusRel."link to table"::Customer);
            ContactBusRel.SetRange("No.", Rec."No.");
            ContactBusRel.Find('-');
            repeat
            // CampaignTargetGrMgmt.ConverttoContact(Rec,ContactBusRel."Contact No.");
            until CampaignTargetGr.Next() = 0;
        end;

        ServContract.SetFilter(Status, '<>%1', ServContract.Status::Cancelled);
        ServContract.SetRange("Customer No.", "No.");
        if ServContract.Find('-') then
            Error(
              Text007,
              TableCaption, "No.");

        ServContract.SetRange(Status);
        ServContract.ModifyAll("Customer No.", '');

        ServContract.SetFilter(Status, '<>%1', ServContract.Status::Cancelled);
        ServContract.SetRange("Bill-to Customer No.", "No.");
        if ServContract.Find('-') then
            Error(
              Text007,
              TableCaption, "No.");

        ServContract.SetRange(Status);
        ServContract.ModifyAll("Bill-to Customer No.", '');

        ServHeader.SetCurrentkey("Customer No.", "Order Date");
        ServHeader.SetRange("Customer No.", "No.");
        if ServHeader.Find('-') then
            Error(
              Text013,
              TableCaption, "No.", ServHeader."Document Type");

        ServHeader.SetRange("Bill-to Customer No.");
        if ServHeader.Find('-') then
            Error(
              Text013,
              TableCaption, "No.", ServHeader."Document Type");

        // UpdateContFromCust.OnDelete(Rec);

        DimMgt.DeleteDefaultDim(Database::Customer, "No.");
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Customer Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        if "Invoice Disc. Code" = '' then
            "Invoice Disc. Code" := "No.";

        DimMgt.UpdateDefaultDim(
          Database::Customer, "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");

        "Library Expiry Date" := 20200101D;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;

        if (Name <> xRec.Name) or
           ("Search Name" <> xRec."Search Name") or
           ("Name 2" <> xRec."Name 2") or
           (Address <> xRec.Address) or
           ("Address 2" <> xRec."Address 2") or
           (City <> xRec.City) or
           ("Phone No." <> xRec."Phone No.") or
           ("Telex No." <> xRec."Telex No.") or
           ("Territory Code" <> xRec."Territory Code") or
           ("Currency Code" <> xRec."Currency Code") or
           ("Language Code" <> xRec."Language Code") or
           ("Salesperson Code" <> xRec."Salesperson Code") or
           ("Country/Region Code" <> xRec."Country/Region Code") or
           ("Fax No." <> xRec."Fax No.") or
           ("Telex Answer Back" <> xRec."Telex Answer Back") or
           ("VAT Registration No." <> xRec."VAT Registration No.") or
           ("Post Code" <> xRec."Post Code") or
           (County <> xRec.County) or
           ("E-Mail" <> xRec."E-Mail") or
           ("Home Page" <> xRec."Home Page") or
           (Contact <> xRec.Contact)
        then
            Modify();
            //   UpdateContFromCust.OnModify(Rec);

        /*IF "Current Programme"='' THEN BEGIN
          IF "Customer Type"="Customer Type"::Student THEN BEGIN
             "Current Programme":=COPYSTR(FORMAT("No."),1,3);
             MODIFY;
          END;
        END; */
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        // if "Customer Type"="customer type"::Student then
        //accesscont.Check_Access(UserId,Areaoption::Students,'Modify');
    end;

    var
        CommentLine: Record "Comment Line";
        Cust: Record Customer;
        CustBankAcc: Record "Customer Bank Account";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        //   ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        //accesscont: Codeunit UnknownCodeunit39005480;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesOrderLine: Record "Sales Line";
        SalesLineDisc: Record "Sales Line Discount";
        SalesPrepmtPct: Record "Sales Prepayment %";
        SalesPrice: Record "Sales Price";
        ServContract: Record "Service Contract Header";
        ServHeader: Record "Service Header";
        ServiceItem: Record "Service Item";
        ShipToAddr: Record "Ship-to Address";
        ShippingAgentService: Record "Shipping Agent Services";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;

        InsertFromContact: Boolean;
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
        Text002: label 'Do you wish to create a contact for %1 %2?';
        Text004: label 'post';
        Text005: label 'create';
        Text006: label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Text007: label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.';
        Text008: label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?';
        Text009: label 'Cannot delete customer.';
        Text010: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.';
        Text011: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text012: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text013: label 'You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.';
        Text014: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text015: label 'You cannot delete %1 %2 because there is at least one %3 associated to this customer.';

    procedure AssistEdit(OldCust: Record Customer): Boolean
    begin
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Customer, "No.", FieldNumber, ShortcutDimCode);
        Modify();
    end;

    procedure ShowContact()
    var
        Cont: Record Contact;
        ContBusRel: Record "Contact Business Relation";
    begin
        if "No." = '' then
            exit;

        ContBusRel.SetCurrentkey("Link to Table", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
        ContBusRel.SetRange("No.", "No.");
        if not ContBusRel.Find('-') then begin
            if not Confirm(Text002, false, TableCaption, "No.") then
                exit;
            // UpdateContFromCust.InsertNewContact(Rec,false);
            ContBusRel.Find('-');
        end;
        Commit();

        if ISSERVICETIER then begin
            Cont.SetCurrentkey("Company Name", "Company No.", Type, Name);
            Cont.SetRange("Company No.", ContBusRel."Contact No.");
            // FORM.Run(Form::"Contact List",Cont);
            exit;
        end;

        Cont.Get(ContBusRel."Contact No.");
        // FORM.Run(Form::"Contact Card",Cont);
    end;

    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;

    procedure CheckBlockedCustOnDocs(Cust2: Record Customer; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; Shipment: Boolean; Transaction: Boolean)
    begin
        if ((Cust2.Blocked = Cust2.Blocked::All) or
    ((Cust2.Blocked = Cust2.Blocked::Invoice) and (DocType in [Doctype::Quote, Doctype::Order, Doctype::Invoice, Doctype::"Blanket Order"])) or
    ((Cust2.Blocked = Cust2.Blocked::Ship) and (DocType in [Doctype::Quote, Doctype::Order, Doctype::"Blanket Order"]) and
     (not Transaction)) or
    ((Cust2.Blocked = Cust2.Blocked::Ship) and (DocType in [Doctype::Quote, Doctype::Order, Doctype::Invoice, Doctype::"Blanket Order"]) and
     Shipment and Transaction))
then
            Cust2.CustBlockedErrorMessage(Cust2, Transaction);
    end;

    procedure CheckBlockedCustOnJnls(Cust2: Record Customer; DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge",Reminder,Refund; Transaction: Boolean)
    begin
        if (Cust2.Blocked = Cust2.Blocked::All) or
   ((Cust2.Blocked = Cust2.Blocked::Invoice) and (DocType in [Doctype::Invoice, Doctype::" "]))
then
            Cust2.CustBlockedErrorMessage(Cust2, Transaction)
    end;

    procedure CustBlockedErrorMessage(Cust2: Record Customer; Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        if Transaction then
            Action := Text004
        else
            Action := Text005;
        Error(Text006, Action, Cust2."No.", Cust2.Blocked);
    end;

    procedure LookUpAdjmtValueEntries(CustDateFilter: Text[30])
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.SetCurrentkey("Source Type", "Source No.");
        ValueEntry.SetRange("Source Type", ValueEntry."source type"::Customer);
        ValueEntry.SetRange("Source No.", "No.");
        ValueEntry.SetFilter("Posting Date", CustDateFilter);
        ValueEntry.SetFilter("Global Dimension 1 Code", GetFilter("Global Dimension 1 Filter"));
        ValueEntry.SetFilter("Global Dimension 2 Code", GetFilter("Global Dimension 2 Filter"));
        ValueEntry.SetRange(Adjustment, true);
        ValueEntry.SetRange("Expected Cost", false);
        //FORM.RunModal(0,ValueEntry);
    end;

    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.Find('-') then
            MapMgt.MakeSelection(Database::Customer, GetPosition())
        else
            Message(Text014);
    end;
}
