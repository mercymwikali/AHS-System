Table 52202537 Customer2
{
    Caption = 'Customer';
    DataCaptionFields = "No.", Name;
    //DrillDownFormID = Form22;
    // LookupFormID = Form22;
    Permissions = TableData "Cust. Ledger Entry" = r;

    fields
    {
        field(1; "No."; Code[20])
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
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
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
        field(5; Address; Text[50])
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
        }
        field(8; Contact; Text[50])
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
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
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
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(18; "Chain Name"; Code[10])
        {
            Caption = 'Chain Name';
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
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
        field(24; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(26; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(28; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            TableRelation = "Finance Charge Terms";
        }
        field(29; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
                    Validate("Shipping Agent Service Code", '');
            end;
        }
        field(32; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export';
        }
        field(33; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = Customer;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(34; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(36; "Collection Method"; Code[20])
        {
            Caption = 'Collection Method';
        }
        field(37; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(Customer),
                                                      "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(40; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies';
        }
        field(41; "Last Statement No."; Integer)
        {
            Caption = 'Last Statement No.';
        }
        field(42; "Print Statements"; Boolean)
        {
            Caption = 'Print Statements';
        }
        field(45; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(46; Priority; Integer)
        {
            Caption = 'Priority';
        }
        field(47; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(55; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';
            CaptionClass = '1,3,1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 2 Filter';
            CaptionClass = '1,3,2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(58; Balance; Decimal)
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
        field(59; "Balance (LCY)"; Decimal)
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
        field(60; "Net Change"; Decimal)
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
        field(61; "Net Change (LCY)"; Decimal)
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
        field(62; "Sales (LCY)"; Decimal)
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
        field(63; "Profit (LCY)"; Decimal)
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
        field(64; "Inv. Discounts (LCY)"; Decimal)
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
        field(65; "Pmt. Discounts (LCY)"; Decimal)
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
        field(66; "Balance Due"; Decimal)
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
        field(67; "Balance Due (LCY)"; Decimal)
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
        field(69; Payments; Decimal)
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
        field(70; "Invoice Amounts"; Decimal)
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
        field(71; "Cr. Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CalcFormula = -sum("Detailed Cust. Ledg. Entry".Amount where ("Initial Document Type"=const(Credit field("No.")","
        }
        field(72; "Finance Charge Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            //CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where ("Initial Document Type"=const(Finance field("No.")","
        }
        field(74; "Payments (LCY)"; Decimal)
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
        field(75; "Inv. Amounts (LCY)"; Decimal)
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
        field(79; "Shipped Not Invoiced"; Decimal)
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
        field(80; "Application Method"; Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(82; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
        }
        field(83; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(85; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", "No.", Database::Customer);
            end;
        }
        field(87; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments';
        }
        field(88; "Gen. Bus. Posting Group"; Code[10])
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
        field(89; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; County; Text[30])
        {
            Caption = 'County';
        }
        field(97; "Debit Amount"; Decimal)
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
        field(98; "Credit Amount"; Decimal)
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
        field(99; "Debit Amount (LCY)"; Decimal)
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
        field(100; "Credit Amount (LCY)"; Decimal)
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
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(104; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code';
            TableRelation = "Reminder Terms";
        }
        field(105; "Reminder Amounts"; Decimal)
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
        field(106; "Reminder Amounts (LCY)"; Decimal)
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
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(109; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(110; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(111; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(113; "Outstanding Orders (LCY)"; Decimal)
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
        field(114; "Shipped Not Invoiced (LCY)"; Decimal)
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
        field(115; Reserve; Option)
        {
            Caption = 'Reserve';
            InitValue = Optional;
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(116; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
        }
        field(117; "Pmt. Disc. Tolerance (LCY)"; Decimal)
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
        field(118; "Pmt. Tolerance (LCY)"; Decimal)
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
        field(119; "IC Partner Code"; Code[20])
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
        field(120; Refunds; Decimal)
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
        field(121; "Refunds (LCY)"; Decimal)
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
        field(122; "Other Amounts"; Decimal)
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
        field(123; "Other Amounts (LCY)"; Decimal)
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
        field(124; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(125; "Outstanding Invoices (LCY)"; Decimal)
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
        field(126; "Outstanding Invoices"; Decimal)
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
        field(130; "Bill-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = count("Sales Header Archive" where("Document Type" = const(Order),
                                                              "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-to No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(131; "Sell-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = count("Sales Header Archive" where("Document Type" = const(Order),
                                                              "Sell-to Customer No." = field("No.")));
            Caption = 'Sell-to No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(5049; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.';
            TableRelation = Contact;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5750; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(5790; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(5792; "Shipping Agent Service Code"; Code[10])
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
        field(5900; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            TableRelation = "Service Zone";
        }
        field(5902; "Contract Gain/Loss Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Contract Gain/Loss Entry".Amount where("Customer No." = field("No."),
                                                                       "Ship-to Code" = field("Ship-to Filter"),
                                                                       "Change Date" = field("Date Filter")));
            Caption = 'Contract Gain/Loss Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5903; "Ship-to Filter"; Code[10])
        {
            Caption = 'Ship-to Filter';
            FieldClass = FlowFilter;
            TableRelation = "Ship-to Address".Code where("Customer No." = field("No."));
        }
        field(5910; "Outstanding Serv. Orders (LCY)"; Decimal)
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
        field(5911; "Serv Shipped Not Invoiced(LCY)"; Decimal)
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
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7171; "No. of Quotes"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Quote),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7172; "No. of Blanket Orders"; Integer)
        {
            //  CalcFormula = count("Sales Header" where ("Document Type"=const(Blanket field("No.")")";
            Caption = 'No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7173; "No. of Orders"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7174; "No. of Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7175; "No. of Return Orders"; Integer)
        {
            // CalcFormula = count("Sales Header" where ("Document Type"=const(Return field("No.")")";
            Caption = 'No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7176; "No. of Credit Memos"; Integer)
        {
            //  CalcFormula = count("Sales Header" where ("Document Type"=const(Credit field("No.")")";
            Caption = 'No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7177; "No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7178; "No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = count("Sales Invoice Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7179; "No. of Pstd. Return Receipts"; Integer)
        {
            CalcFormula = count("Return Receipt Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Return Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7180; "No. of Pstd. Credit Memos"; Integer)
        {
            CalcFormula = count("Sales Cr.Memo Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7181; "No. of Ship-to Addresses"; Integer)
        {
            CalcFormula = count("Ship-to Address" where("Customer No." = field("No.")));
            Caption = 'No. of Ship-to Addresses';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7182; "Bill-To No. of Quotes"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Quote),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7183; "Bill-To No. of Blanket Orders"; Integer)
        {
            //  CalcFormula = count("Sales Header" where ("Document Type"=const(Blanket field("No.")")";
            Caption = 'Bill-To No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7184; "Bill-To No. of Orders"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7185; "Bill-To No. of Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7186; "Bill-To No. of Return Orders"; Integer)
        {
            // CalcFormula = count("Sales Header" where ("Document Type"=const(Return field("No.")")";
            Caption = 'Bill-To No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7187; "Bill-To No. of Credit Memos"; Integer)
        {
            // CalcFormula = count("Sales Header" where ("Document Type"=const(Credit field("No.")")";
            Caption = 'Bill-To No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7188; "Bill-To No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7189; "Bill-To No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = count("Sales Invoice Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7190; "Bill-To No. of Pstd. Return R."; Integer)
        {
            CalcFormula = count("Return Receipt Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Return R.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7191; "Bill-To No. of Pstd. Cr. Memos"; Integer)
        {
            CalcFormula = count("Sales Cr.Memo Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Cr. Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(7601; "Copy Sell-to Addr. to Qte From"; Option)
        {
            Caption = 'Copy Sell-to Addr. to Qte From';
            OptionCaption = 'Company,Person';
            OptionMembers = Company,Person;
        }
        field(50002; "Average Cummulative GPA"; Decimal)
        {
            // CalcFormula = average("Student Units"."GPA Points" where ("Student No."=field("No.")));
            DecimalPlaces = 1 : 1;
            FieldClass = FlowField;
        }
        field(50050; "Balance (Cafe)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CalcFormula = sum("Detailed Students Cafe Ledgers".Amount where ("Customer No."=field("No.")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50051; "Debit Amount (Cafe)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            //  CalcFormula = sum("Detailed Students Cafe Ledgers"."Debit Amount" where ("Customer No."=field("No.")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50052; "Credit Amount (Cafe)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            //  CalcFormula = sum("Detailed Students Cafe Ledgers"."Credit Amount" where ("Customer No."=field("No.")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(53074; test; Text[30])
        {
        }
        field(63000; Gender; Option)
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
        field(63001; "Date Of Birth"; Date)
        {
        }
        field(63002; Age; Decimal)
        {
        }
        field(63003; "Marital Status"; Option)
        {
            OptionMembers = Single,Married,Divorced,Widowed;
        }
        field(63004; "Blood Group"; Text[30])
        {
        }
        field(63005; Weight; Decimal)
        {
        }
        field(63006; Height; Decimal)
        {
        }
        field(63007; Religion; Code[50])
        {
            Caption = 'Religions';
            //  TableRelation = Religion.Relegion;
        }
        field(63008; Citizenship; Text[30])
        {
        }
        field(63011; "ID No"; Code[30])
        {
        }
        field(63012; "Date Registered"; Date)
        {
        }
        field(63013; "Membership No"; Text[100])
        {
        }
        field(63014; "Customer Type"; Option)
        {
            OptionCaption = 'Customer,Student,Hotel,Staff';
            OptionMembers = Customer,Student,Hotel,Staff;
        }
        field(63015; "Birth Cert"; Code[30])
        {
            trigger OnValidate()
            begin
                Cust.Reset();
                Cust.SetRange(Cust."Birth Cert", "Birth Cert");
                //IF Cust.FIND('-') THEN
                //ERROR('Birth Cert/KNEC No. exists.');
            end;
        }
        field(63016; "UNISA No"; Code[30])
        {
        }
        field(63017; "Opening Balance"; Decimal)
        {
        }
        field(63018; "Old Student Code"; Code[20])
        {
        }
        field(63019; "Name 3"; Text[100])
        {
        }
        field(63020; Status; Option)
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
        field(63022; "Library Code"; Code[20])
        {
        }
        field(63023; "JKUAT No"; Code[30])
        {
        }
        field(63024; "KNEC No"; Code[30])
        {
        }
        field(63025; "Passport No"; Code[30])
        {
        }
        field(63027; "New Date"; Date)
        {
        }
        field(63028; "New Receipt Date"; Date)
        {
        }
        field(63031; "From Entry"; Text[50])
        {
            FieldClass = FlowFilter;
            TableRelation = "Cust. Ledger Entry"."Entry No." where("Customer No." = field("No."));
        }
        field(63032; "To Entry"; Text[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "Cust. Ledger Entry"."Entry No." where("Customer No." = field("No."));
        }
        field(63033; "Student Balance"; Decimal)
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
        field(63034; "Confirmed Ok"; Boolean)
        {
            trigger OnValidate()
            begin
                "User ID" := UserId;
            end;
        }
        field(63035; "User ID"; Code[20])
        {
        }
        field(63038; "Library Membership"; Option)
        {
            OptionCaption = 'DIP IT,BSC IT,IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,TEACHING STAFF,DIRECTORS,ADMIN STAFF,BR MATHS,IT,PACKAGES,DCEDHM';
            OptionMembers = "DIP IT","BSC IT",IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,"TEACHING STAFF",DIRECTORS,"ADMIN STAFF","BR MATHS",IT,PACKAGES,DCEDHM;
        }
        field(63039; libsecurity; Text[30])
        {
        }
        field(63040; "Can Use Library"; Boolean)
        {
            Description = 'USED BY LIBRARY TO CHECK WETHER STUDENT EXISTS IN LIB SYSTEM - 12TH JUNE 2008 - TONY';
        }
        field(63041; "Lib Membership"; Text[30])
        {
            Description = 'STORES THE STUDENTS LATEST LIBRARY MEMBSERSHIP CATEGORY - 12TH JUNE 2008 - TONY';
        }
        field(63042; "No Of Reversals"; Integer)
        {
            CalcFormula = count("Cust. Ledger Entry" where("Customer No." = field("No."),
                                                            Reversed = const(true)));
            FieldClass = FlowField;
        }
        field(63043; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Cust. Ledger Entry"."Document No.";
        }
        field(63045; "R Balance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Posting Date" = field("Date Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63046; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = Semester.Code;
        }
        field(63047; "Staff No."; Code[20])
        {
        }
        field(63048; "Programme Category"; Option)
        {
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(63051; "Accredited Centre no."; Code[20])
        {
        }
        field(63055; Adults; Integer)
        {
            InitValue = 1;
        }
        field(63056; "Vehicle No."; Code[20])
        {
        }
        field(63057; "Children Under 12"; Integer)
        {
        }
        field(63058; "Group/Company"; Code[20])
        {
        }
        field(63059; "Departure Date"; Date)
        {
        }
        field(63060; "Arrival Date"; Date)
        {
        }
        field(63061; Nationality; Text[30])
        {
            InitValue = 'KENYAN';
        }
        field(63063; "Room Type"; Code[20])
        {
        }
        field(63064; "Receipt No"; Code[10])
        {
        }
        field(63065; Rate; Decimal)
        {
        }
        field(63066; Cashier; Text[30])
        {
        }
        field(63067; Deposit; Decimal)
        {
        }
        field(63068; "Payment Date"; Date)
        {
        }
        field(63069; Remarks; Text[50])
        {
        }
        field(63070; "Guest Agent Code"; Code[10])
        {
            //  TableRelation = "Booking Agents".No;
        }
        field(63071; Singles; Integer)
        {
        }
        field(63073; Doubles; Integer)
        {
        }
        field(63074; Triples; Integer)
        {
        }
        field(63075; "Taken By"; Text[30])
        {
        }
        field(63076; "Checked By"; Text[30])
        {
        }
        field(63078; "Check Out Date"; Date)
        {
        }
        field(63079; "Check In Time"; Time)
        {
        }
        field(63080; "HTL Status"; Option)
        {
            OptionMembers = ,,Reserved,Current,Old;
        }
        field(63081; "HELB No."; Code[50])
        {
        }
        field(63082; "Deferement Period"; DateFormula)
        {
        }
        field(63083; "Status Change Date"; Date)
        {
        }
        field(63084; "Revenue Cash Account"; Code[20])
        {
            TableRelation = "Bank Account"."No." where("Bank Acc. Posting Group" = const('CASH'));
        }
        field(63085; Password; Text[100])
        {
            Editable = true;
        }
        field(63086; "Gown 1"; Boolean)
        {
        }
        field(63087; "Gown 2"; Boolean)
        {
        }
        field(63088; "Gown 3"; Boolean)
        {
        }
        field(63089; "Date Issued"; Date)
        {
        }
        field(63090; "Gown Status"; Option)
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
        field(63091; "Date Returned"; Date)
        {
        }
        field(63092; "Certificate Status"; Option)
        {
            OptionCaption = ' ,Pending,Collected';
            OptionMembers = " ",Pending,Collected;

            trigger OnValidate()
            begin
                if "Certificate Status" = "certificate status"::Collected then
                    "Date Collected" := Today;
            end;
        }
        field(63093; "Date Collected"; Date)
        {
        }
        field(63094; Confirmed; Boolean)
        {
        }
        field(63095; "Confirmed Remarks"; Text[100])
        {
        }
        field(63096; "Special Requrements"; Text[200])
        {
        }
        field(63097; "Certificate No."; Text[50])
        {
        }
        field(63099; "No Of Creidts"; Integer)
        {
            CalcFormula = count("Detailed Cust. Ledg. Entry" where("Customer No." = field("No."),
                                                                    "Entry Type" = const("Initial Entry"),
                                                                    "Credit Amount (LCY)" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(63100; District; Code[20])
        {
            //  TableRelation = "Application Setup District".Code;

            trigger OnValidate()
            begin
            end;
        }
        field(63103; "Transfer to No."; Code[20])
        {
        }
        field(63104; "Transfer to"; Code[20])
        {
            Caption = 'Transfer to';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(63105; "Imported Rcpt"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(63106; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(63112; "Paid PartTime"; Integer)
        {
        }
        field(63113; "Hostel Black Listed"; Boolean)
        {
        }
        field(63114; "Black Listed Reason"; Text[100])
        {
        }
        field(63115; "Black Listed By"; Code[20])
        {
        }
        field(63116; "Audit Issue"; Boolean)
        {
        }
        field(63117; "Not Billed"; Boolean)
        {
        }
        field(63118; "New Stud"; Boolean)
        {
        }
        field(63119; "Programme Category Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ',Diploma,Undergraduate,Postgraduate,Course List';
            OptionMembers = ,Diploma,Undergraduate,Postgraduate,"Course List";
        }
        field(63120; sms_Password; Text[30])
        {
        }
        field(63121; "BroadCast Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            // TableRelation = Table39003902.Field1;
        }
        field(63123; "Imprest Unsurrendered"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(63124; "Lock Online Application"; Boolean)
        {
        }
        field(63125; "Department Description"; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Global Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(63127; "Entry Semester"; Code[20])
        {
            // TableRelation = Semester.Code;
        }
        field(63128; "Entry Semester Description"; Text[50])
        {
            //  CalcFormula = lookup(Semester.Description where (Code=field("Entry Semester")));
            FieldClass = FlowField;
        }
        field(63130; "Changed Password"; Boolean)
        {
        }
        field(63131; "Current Stage"; Code[20])
        {
        }
        field(63132; "Hostel No."; Code[10])
        {
        }
        field(63133; "Room No."; Code[10])
        {
        }
        field(63134; "Meal Card Valid From"; Date)
        {
        }
        field(63135; "Meal Card Valid To"; Date)
        {
        }
        field(63136; "Lib. Card Valid From"; Date)
        {
        }
        field(63137; "Lib. Card Valid To"; Date)
        {
        }
        field(63138; "Current Sem"; Code[10])
        {
            //  TableRelation = Semester.Code;
        }
        field(63142; "Graduating Semester"; Code[20])
        {
            // TableRelation = Semester.Code;
        }
        field(63143; "University Reference Number"; Code[50])
        {
        }
        field(63144; "Library Charges"; Decimal)
        {
            // CalcFormula = sum("Library Charges"."Amount owing" where (StudentNo=field("No.")));
            FieldClass = FlowField;
        }
        field(63145; "Open Bal"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(63146; "Library Username"; Text[20])
        {
        }
        field(63147; "Library Security"; Integer)
        {
            InitValue = 1;
        }
        field(63148; "Common Units Done"; Integer)
        {
            FieldClass = FlowField;
        }
        field(63149; "Core Units Done"; Integer)
        {
            FieldClass = FlowField;
        }
        field(63150; "Electives Done"; Integer)
        {
            FieldClass = FlowField;
        }
        field(63151; "Library Category"; Code[20])
        {
        }
        field(63152; "Library Expiry Date"; Date)
        {
        }
        field(63153; "Library Branch"; Code[10])
        {
        }
        field(63154; "Library Gender"; Code[10])
        {
        }
        field(63155; "Old No."; Code[20])
        {
        }
        field(63156; "No Change date"; Date)
        {
        }
        field(63157; "Settlement type"; Option)
        {
            OptionMembers = " ",SSP,KUCCPS;
        }
        field(63158; "Balance B/F"; Decimal)
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
