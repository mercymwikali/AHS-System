Table 85047 "Bank Account2"
{
    Caption = 'Bank Account';
    DataCaptionFields = "No.", Name;

    // Permissions = TableData "Bank Account Ledger Entry"=r;

    fields
    {
        field(50000; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(50001; Name; Text[100])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(50002; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
        }
        field(50003; "Name 2"; Text[100])
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
        field(50010; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(50011; "Transit No."; Text[20])
        {
            Caption = 'Transit No.';
        }
        field(50012; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(50013; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50014; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50015; "Chain Name"; Code[10])
        {
            Caption = 'Chain Name';
        }
        field(50016; "Min. Balance"; Decimal)
        {
            //AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Min. Balance';
        }
        field(50017; "Bank Acc. Posting Group"; Code[10])
        {
            Caption = 'Bank Acc. Posting Group';
            TableRelation = "Bank Account Posting Group";
        }
        field(50018; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(50019; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
        }
        field(50020; "Our Contact Code"; Code[10])
        {
            Caption = 'Our Contact Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50021; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50022; Amount; Decimal)
        {
            //AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(50023; Comment; Boolean)
        {
            // CalcFormula = exist("Comment Line" where ("Table Name"=const(Bank field("No.")")";
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(50025; "Last Statement No."; Code[20])
        {
            Caption = 'Last Statement No.';
        }
        field(50026; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50027; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50028; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';
            CaptionClass = '1,3,1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50029; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 2 Filter';
            CaptionClass = '1,3,2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50030; Balance; Decimal)
        {
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50032; "Net Change"; Decimal)
        {
            // AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("No."),
                                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50033; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Posting Date" = field("Date Filter")));
            Caption = 'Net Change (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50034; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50035; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(50036; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50037; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50038; County; Text[30])
        {
            Caption = 'County';
        }
        field(50039; "Last Check No."; Code[20])
        {
            Caption = 'Last Check No.';
        }
        field(50040; "Balance Last Statement"; Decimal)
        {
        }
        field(50041; "Balance at Date"; Decimal)
        {
        }
        field(50042; "Balance at Date (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Posting Date" = field(upperlimit("Date Filter"))));
            Caption = 'Balance at Date (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50043; "Debit Amount"; Decimal)
        {
        }
        field(50044; "Credit Amount"; Decimal)
        {
            //AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Bank Account Ledger Entry"."Credit Amount" where("Bank Account No." = field("No."),
                                                                                 "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                 "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50045; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Bank Account Ledger Entry"."Debit Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                      "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                      "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                      "Posting Date" = field("Date Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50046; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Bank Account Ledger Entry"."Credit Amount (LCY)" where("Bank Account No." = field("No."),
                                                                                       "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                       "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                       "Posting Date" = field("Date Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50047; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(50048; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(50049; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(50050; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50051; "Check Report ID"; Integer)
        {
            Caption = 'Check Report ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(50052; "Check Report Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Report),
                                                                        "Object ID" = field("Check Report ID")));
            Caption = 'Check Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50053; Iban; Code[50])
        {
            Caption = 'IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.CheckIBAN(Iban);
            end;
        }
        field(50054; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
        }
        field(50055; TEXT; Integer)
        {
        }
        field(50056; "Bank Type"; Option)
        {
            OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection";
        }
        field(50057; "Pending Voucher Amount"; Decimal)
        {
            //CalcFormula = sum(Table39005995.Field5 where (Field27=field("No.")));
            FieldClass = FlowField;
        }
        field(50058; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center".Code;
        }
        field(50059; "Bank Branch Name"; Text[250])
        {
        }
        field(50060; "UnUsed PettyCash"; Decimal)
        {
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
        key(Key3; "Bank Acc. Posting Group")
        {
        }
        key(Key5; "Country/Region Code")
        {
        }
    }

    fieldgroups
    {
    }
}
