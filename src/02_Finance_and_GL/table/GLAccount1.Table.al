Table 85052 "G/L Account1"
{
    Caption = 'G/L Account';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Chart of Accounts";
    LookupPageID = "G/L Account List";

    fields
    {
        field(50000; "No."; Code[50])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(50001; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;

                //Prevent Changing once entries exist
                //TestNoEntriesExist(FIELDCAPTION(Name));
            end;
        }
        field(50002; "Search Name"; Code[70])
        {
            Caption = 'Search Name';
        }
        field(50003; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";
        }
        field(50004; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50005; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50006; "Income/Balance"; Option)
        {
            Caption = 'Income/Balance';
            OptionCaption = 'Income Statement,Balance Sheet';
            OptionMembers = "Income Statement","Balance Sheet";

            trigger OnValidate()
            var
                CostType: Record "Cost Type";
            begin
                if ("Income/Balance" = "income/balance"::"Balance Sheet") and ("Cost Type No." <> '') then begin
                    if CostType.Get("No.") then begin
                        CostType."G/L Account Range" := '';
                        CostType.Modify();
                    end;
                    "Cost Type No." := '';
                end;
                //Prevent Changing once entries exist
                //TestNoEntriesExist(FIELDCAPTION("Income/Balance"));
            end;
        }
        field(50007; "Debit/Credit"; Option)
        {
            Caption = 'Debit/Credit';
            OptionCaption = 'Both,Debit,Credit';
            OptionMembers = Both,Debit,Credit;
        }
        field(50008; "No. 2"; Code[20])
        {
            Caption = 'No. 2';
        }
        field(50009; Comment; Boolean)
        {
            //  CalcFormula = exist("Comment Line" where ("Table Name"=const(Gfield("No.")")";
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(50011; "Direct Posting"; Boolean)
        {
            Caption = 'Direct Posting';
            InitValue = true;

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                //TestNoEntriesExist(FIELDCAPTION("Direct Posting"));
            end;
        }
        field(50012; "Reconciliation Account"; Boolean)
        {
            AccessByPermission = TableData "Bank Account" = R;
            Caption = 'Reconciliation Account';
        }
        field(50013; "New Page"; Boolean)
        {
            Caption = 'New Page';
        }
        field(50014; "No. of Blank Lines"; Integer)
        {
            Caption = 'No. of Blank Lines';
            MinValue = 0;
        }
        field(50015; Indentation; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
        }
        field(50016; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50017; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50018; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';
            CaptionClass = '1,3,1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50019; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 2 Filter';
            CaptionClass = '1,3,2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50020; "Balance at Date"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("No."),
                                                        "G/L Account No." = field(filter(Totaling)),
                                                        "Business Unit Code" = field("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                        "Posting Date" = field(upperlimit("Date Filter"))));
            Caption = 'Balance at Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "Net Change"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("No."),
                                                        "G/L Account No." = field(filter(Totaling)),
                                                        "Business Unit Code" = field("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                        "Posting Date" = field("Date Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50022; "Budgeted Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No." = field("No."),
                                                               "G/L Account No." = field(filter(Totaling)),
                                                               "Business Unit Code" = field("Business Unit Filter"),
                                                               "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                               "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                               Date = field("Date Filter"),
                                                               "Budget Name" = field("Budget Filter")));
            Caption = 'Budgeted Amount';
            FieldClass = FlowField;
        }
        field(50023; Totaling; Text[250])
        {
            Caption = 'Totaling';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if not ("Account Type" in ["account type"::Total, "account type"::"End-Total"]) then
                    FieldError("Account Type");
                CalcFields(Balance);
            end;
        }
        field(50024; "Budget Filter"; Code[10])
        {
            Caption = 'Budget Filter';
            FieldClass = FlowFilter;
            TableRelation = "G/L Budget Name";
        }
        field(50025; Balance; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("No."),
                                                        "G/L Account No." = field(filter(Totaling)),
                                                        "Business Unit Code" = field("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; "Budget at Date"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No." = field("No."),
                                                               "G/L Account No." = field(filter(Totaling)),
                                                               "Business Unit Code" = field("Business Unit Filter"),
                                                               "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                               "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                               Date = field(upperlimit("Date Filter")),
                                                               "Budget Name" = field("Budget Filter")));
            Caption = 'Budget at Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50027; "Consol. Translation Method"; Option)
        {
            AccessByPermission = TableData "Business Unit" = R;
            Caption = 'Consol. Translation Method';
            OptionCaption = 'Average Rate (Manual),Closing Rate,Historical Rate,Composite Rate,Equity Rate';
            OptionMembers = "Average Rate (Manual)","Closing Rate","Historical Rate","Composite Rate","Equity Rate";
        }
        field(50028; "Consol. Debit Acc."; Code[20])
        {
            AccessByPermission = TableData "Business Unit" = R;
            Caption = 'Consol. Debit Acc.';
        }
        field(50029; "Consol. Credit Acc."; Code[20])
        {
            AccessByPermission = TableData "Business Unit" = R;
            Caption = 'Consol. Credit Acc.';
        }
        field(50030; "Business Unit Filter"; Code[10])
        {
            Caption = 'Business Unit Filter';
            FieldClass = FlowFilter;
            TableRelation = "Business Unit";
        }
        field(50031; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale';
            OptionMembers = " ",Purchase,Sale;
        }
        field(50032; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50033; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(50034; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50035; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("G/L Entry"."Debit Amount" where("G/L Account No." = field("No."),
                                                                "G/L Account No." = field(filter(Totaling)),
                                                                "Business Unit Code" = field("Business Unit Filter"),
                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                "Posting Date" = field("Date Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50036; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("G/L Entry"."Credit Amount" where("G/L Account No." = field("No."),
                                                                 "G/L Account No." = field(filter(Totaling)),
                                                                 "Business Unit Code" = field("Business Unit Filter"),
                                                                 "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                 "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                 "Posting Date" = field("Date Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50037; "Automatic Ext. Texts"; Boolean)
        {
            Caption = 'Automatic Ext. Texts';
        }
        field(50038; "Budgeted Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankNumbers = BlankNegAndZero;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No." = field("No."),
                                                               "G/L Account No." = field(filter(Totaling)),
                                                               "Business Unit Code" = field("Business Unit Filter"),
                                                               "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                               "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                               Date = field("Date Filter"),
                                                               "Budget Name" = field("Budget Filter")));
            Caption = 'Budgeted Debit Amount';
            FieldClass = FlowField;
        }
        field(50039; "Budgeted Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankNumbers = BlankNegAndZero;
            CalcFormula = - sum("G/L Budget Entry".Amount where("G/L Account No." = field("No."),
                                                                "G/L Account No." = field(filter(Totaling)),
                                                                "Business Unit Code" = field("Business Unit Filter"),
                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                Date = field("Date Filter"),
                                                                "Budget Name" = field("Budget Filter")));
            Caption = 'Budgeted Credit Amount';
            FieldClass = FlowField;
        }
        field(50040; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(50041; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(50042; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(50043; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(50044; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(50045; "Additional-Currency Net Change"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50046; "Add.-Currency Balance at Date"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50047; "Additional-Currency Balance"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50048; "Exchange Rate Adjustment"; Option)
        {
            AccessByPermission = TableData Currency = R;
            Caption = 'Exchange Rate Adjustment';
            OptionCaption = 'No Adjustment,Adjust Amount,Adjust Additional-Currency Amount';
            OptionMembers = "No Adjustment","Adjust Amount","Adjust Additional-Currency Amount";
        }
        field(50049; "Add.-Currency Debit Amount"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50050; "Add.-Currency Credit Amount"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50051; "Default IC Partner G/L Acc. No"; Code[20])
        {
            Caption = 'Default IC Partner G/L Acc. No';
            TableRelation = "IC G/L Account"."No.";
        }
        field(50052; "Omit Default Descr. in Jnl."; Boolean)
        {
            Caption = 'Omit Default Descr. in Jnl.';
        }
        field(50053; "Cost Type No."; Code[20])
        {
            Caption = 'Cost Type No.';
            Editable = false;
            TableRelation = "Cost Type";
            ValidateTableRelation = false;
        }
        field(50054; "Budget Controlled"; Boolean)
        {
        }
        field(50055; "Account Category"; Option)
        {
            OptionMembers = " ","Capital Fund","Revaluation Reserve","Revenue Reserve","Year PL ","Prior year","Long Term Liability","Current Liability","Fixed Asset","Current Asset",Revenue,"Direct Costs",Expense;
        }
        field(50056; "Global Dimension 3 Filter"; Code[20])
        {
            Caption = 'Global Dimension 3 Filter';
            CaptionClass = '1,2,3';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50057; "Global Dimension 4 Filter"; Code[20])
        {
            Caption = 'Global Dimension 4 Filter';
            CaptionClass = '1,2,4';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50058; "Expense Code"; Code[10])
        {
            TableRelation = "Expense Code";

            trigger OnValidate()
            begin
                //Expense code only applicable if account type is posting and Budgetary control is applicable
                TestField("Account Type", "account type"::Posting);
                TestField("Budget Controlled", true);
            end;
        }
        field(50059; "Donor defined Account"; Boolean)
        {
            Description = 'Select if the Account is donor Defined';
        }
        field(50060; test; Code[20])
        {
        }
        field(50061; "Grant Expense"; Boolean)
        {
        }
        field(50062; Status; Option)
        {
            Editable = true;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(50063; "Responsibility Center"; Code[20])
        {
            // TableRelation = "HMS Patient History"."History Code";
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
        key(Key3; "Reconciliation Account")
        {
        }
        key(Key4; "Gen. Bus. Posting Group")
        {
        }
        key(Key5; "Gen. Prod. Posting Group")
        {
        }
        key(Key6; "Consol. Debit Acc.", "Consol. Translation Method")
        {
            Enabled = false;
        }
        key(Key7; "Consol. Credit Acc.", "Consol. Translation Method")
        {
            Enabled = false;
        }
        key(Key8; Name)
        {
        }
        key(Key9; "Account Type")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Income/Balance", Blocked, "Direct Posting")
        {
        }
    }
}
