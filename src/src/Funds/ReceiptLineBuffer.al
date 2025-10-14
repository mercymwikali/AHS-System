Table 52202918 "Receipt Line Buffer"
{
    LookupPageID = "Receipts Line UP";

    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = false;
            TableRelation = "Receipts Header"."No.";
        }
        field(2; Date; Date)
        {
            CalcFormula = lookup("Receipts Header".Date where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(3; Type; Code[20])
        {
            TableRelation = "Receipts and Payment Types".Code where(Type = filter(Receipt));

            trigger OnValidate()
            begin
                "Account No." := '';
                "Account Name" := '';
                Remarks := '';
                RecPayTypes.Reset();
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Receipt);

                if RecPayTypes.Find('-') then begin
                    "Account Type" := RecPayTypes."Account Type";
                    "Transaction Name" := RecPayTypes.Description;
                    Grouping := RecPayTypes."Default Grouping";
                    Remarks := RecPayTypes."Transation Remarks";
                    // "Customer Payment On Account":=RecPayTypes."Customer Payment On Account";

                    if RecPayTypes."Account Type" = RecPayTypes."account type"::"G/L Account" then begin
                        // RecPayTypes.TESTFIELD(RecPayTypes."G/L Account");
                        "Account No." := RecPayTypes."G/L Account";
                        if "Account No." <> '' then
                            Validate("Account No.");
                    end;
                    if RecPayTypes."Account Type" = RecPayTypes."account type"::Customer then
                        "Account Name" := 'Receipts';
                end;

                //Check if the batch account has been inserted it the "Customer Payment On Account" is true
                RecPayTypes.Reset();
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Receipt);
                /*
                IF RecPayTypes.FIND('-') THEN
                  BEGIN
                    //check if the receipt type has Customer Payment On Account as True
                      IF RecPayTypes."Customer Payment On Account"=TRUE THEN
                        BEGIN
                          //check if the Receivable Batch Account is entered
                          SRSetup.GET();
                          SRSetup.TESTFIELD(SRSetup."Receivable Batch Account");
                        END;
                  END;
                  */
                if RHead.Get(No) then begin
                    "Cheque/Deposit Slip Date" := RHead."Document Date";
                    "Bank Code" := RHead."Bank Code";
                    "Transaction Name" := "Account Name";
                    "Total Amount" := RHead."Amount Recieved";
                    if Type = 'CO-PAY' then
                        "HSM Transaction Type" := 'CO-PAY';
                    RHead."Co-Pay" := true;
                    RHead.Modify();
                end;
            end;
        }
        field(4; "Pay Mode"; Option)
        {
            //OptionCaption = ' ,Cash,Cheque,EFT,Deposit Slip,Credit Card,RTGS,Mobile Money';
            OptionMembers = " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,MPESA,PayPal,PDQ,"RFH Baraka Card";

            trigger OnValidate()
            begin
                GenLedgerSetup.Reset();
                GenLedgerSetup.Get();

                if "Pay Mode" = "pay mode"::"Deposit Slip" then
                    "Bank Account" := GenLedgerSetup."Default Bank Deposit Slip A/C";
            end;
        }
        field(5; "Cheque/Deposit Slip No"; Code[20])
        {
        }
        field(6; "Cheque/Deposit Slip Date"; Date)
        {
            trigger OnValidate()
            begin

                GenLedgerSetup.Get();
                if CalcDate(GenLedgerSetup."Cheque Reject Period", "Cheque/Deposit Slip Date") <= Today then
                    Error('The cheque date is not within the allowed range.');
            end;
        }
        field(7; "Cheque/Deposit Slip Type"; Option)
        {
            OptionMembers = " "," Local","Up Country";
        }
        field(8; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(9; "Received From"; Text[100])
        {
        }
        field(10; "On Behalf Of"; Text[100])
        {
        }
        field(11; Cashier; Code[20])
        {
        }
        field(12; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true))
            else
            if ("Account Type" = const(Customer)) Customer where("Customer Posting Group" = field(Grouping))
            else
            if ("Account Type" = const(Vendor)) Vendor where("Vendor Posting Group" = field(Grouping))
            else
            if ("Account Type" = const("Bank Account")) "Bank Account" where("Bank Acc. Posting Group" = field(Grouping))
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin
                "Account Name" := '';

                if "Account Type" in ["account type"::"G/L Account", "account type"::Customer,
                "account type"::Vendor, "account type"::"IC Partner"] then
                    case "Account Type" of
                        "account type"::"G/L Account":
                            begin
                                GLAcc.Get("Account No.");
                                "Account Name" := GLAcc.Name;
                                //"Global Dimension 1 Code":=GLAcc."Global Dimension 1 Code";
                                "VAT Bus. Posting Group" := GLAcc."VAT Bus. Posting Group";
                                "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
                                "Gen. Posting Type" := GLAcc."Gen. Posting Type";
                                "Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
                                "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                                VATSetup.Reset();
                                VATSetup.SetRange(VATSetup."VAT Bus. Posting Group", "VAT Bus. Posting Group");
                                VATSetup.SetRange(VATSetup."VAT Prod. Posting Group", "VAT Prod. Posting Group");
                                if VATSetup.Find('-') then
                                    "VAT %" := VATSetup."VAT %";
                            end;
                        "account type"::Customer:
                            begin
                                Cust.Get("Account No.");
                                "Account Name" := Cust.Name;
                                if "Global Dimension 1 Code" = '' then
                                    "Global Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            end;
                        "account type"::Vendor:
                            begin
                                Vend.Get("Account No.");
                                "Account Name" := Vend.Name;
                                if "Global Dimension 1 Code" = '' then
                                    "Global Dimension 1 Code" := Vend."Global Dimension 1 Code";
                            end;
                        "account type"::"Bank Account":
                            begin
                                BankAcc.Get("Account No.");
                                "Account Name" := BankAcc.Name;
                                if "Global Dimension 1 Code" = '' then
                                    "Global Dimension 1 Code" := BankAcc."Global Dimension 1 Code";
                            end;
                        "account type"::"Fixed Asset":
                            begin
                                FA.Get("Account No.");
                                "Account Name" := FA.Description;
                                "Global Dimension 1 Code" := FA."Global Dimension 1 Code";
                            end;
                        "account type"::"IC Partner":
                            begin
                                ICPartner.Reset();
                                ICPartner.Get("Account No.");
                                "Account Name" := ICPartner.Name;
                            end;
                    end;
                /*
                {Check if the global dimension 1 code has een selected by the user}
                IF ("Global Dimension 1 Code"='') AND ("Account Type"<>"Account Type"::"G/L Account")THEN
                  BEGIN
                    ERROR('Please ensure that the Function code is selected');
                  END;
                */
            end;
        }
        field(14; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; "Account Name"; Text[150])
        {
        }
        field(16; Posted; Boolean)
        {
        }
        field(17; "Date Posted"; Date)
        {
        }
        field(18; "Time Posted"; Time)
        {
        }
        field(19; "Posted By"; Code[20])
        {
        }
        field(20; Amount; Decimal)
        {
        }
        field(21; Remarks; Text[250])
        {
        }
        field(22; "Transaction Name"; Text[100])
        {
            Editable = true;
        }
        field(23; "Branch Code"; Code[20])
        {
        }
        field(24; "Agent Code"; Code[20])
        {
        }
        field(25; Grouping; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(27; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(28; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(29; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(30; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(31; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(32; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(33; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(34; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(35; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(36; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(37; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(38; "Total Amount"; Decimal)
        {
            Editable = false;
        }
        field(39; "User ID"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(40; "Apply to"; Code[20])
        {
        }
        field(41; "Apply to ID"; Code[20])
        {
            Editable = true;
        }
        field(42; "Dest Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(43; "Dest Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(44; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(45; "Print No."; Integer)
        {
        }
        field(46; Status; Option)
        {
            OptionMembers = " ",Normal,"Post Dated",Posted;
        }
        field(47; "Deposit Slip Time"; Time)
        {
        }
        field(48; "Teller ID"; Code[20])
        {
        }
        field(49; "Customer Payment On Account"; Boolean)
        {
        }
        field(50; Select; Boolean)
        {
        }
        field(51; "Batch Posted"; Boolean)
        {
        }
        field(52; "Transaction No."; Code[50])
        {
        }
        field(53; "Cheque/Deposit Slip Bank"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(54; "Bank Account"; Code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(55; Confirmed; Boolean)
        {
        }
        field(56; Reconciled; Boolean)
        {
        }
        field(57; "Orig. Cashier"; Code[20])
        {
            CalcFormula = lookup("Receipts Header".Cashier where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(58; Cancelled; Boolean)
        {
        }
        field(59; "Cancelled By"; Code[20])
        {
        }
        field(60; "Cancelled Date"; Date)
        {
        }
        field(61; "Cancelled Time"; Time)
        {
        }
        field(62; "Post Dated"; Boolean)
        {
        }
        field(63; "Cheque Retrieved"; Boolean)
        {
        }
        field(64; "Register Number"; Integer)
        {
        }
        field(65; "From Entry No"; Integer)
        {
        }
        field(66; "To Entry No"; Integer)
        {
        }
        field(67; "Batch Posted UserID"; Code[20])
        {
        }
        field(68; "BD Register Number"; Integer)
        {
        }
        field(69; "BD From Number"; Integer)
        {
        }
        field(70; "BD To Number"; Integer)
        {
        }
        field(71; "Reversal By"; Code[20])
        {
        }
        field(72; "Reversal Date"; Date)
        {
        }
        field(73; "Reversal Time"; Time)
        {
        }
        field(74; "Reversal Register No."; Integer)
        {
        }
        field(75; "Reversal From Entry No."; Integer)
        {
        }
        field(76; "Reversal To Entry No."; Integer)
        {
        }
        field(77; Reversed; Boolean)
        {
        }
        field(83; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(84; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(85; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(86; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(87; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            begin
                if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
                    CustLedgEntry.SetCurrentkey("Customer No.", Open);
                    CustLedgEntry.SetRange("Customer No.", "Account No.");
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("Applies-to ID", xRec."Applies-to ID");
                    if CustLedgEntry.FindFirst() then
                        // CustEntrySetApplID.SetApplId(CustLedgEntry,TempCustLedgEntry,'');
                        CustLedgEntry.Reset();
                end;
            end;
        }
        field(88; "Deposit Slip Date"; Date)
        {
        }
        field(89; "Patient No"; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(90; "Claim No"; Code[20])
        {
        }
        field(91; "Member No"; Code[20])
        {
            trigger OnValidate()
            begin
                HMSPat.Reset();
                HMSPat.SetRange(HMSPat."Membership No", "Member No");
                if HMSPat.Find('-') then
                    "Patient No" := HMSPat."Patient No.";
                if "Patient No" = '' then begin
                    HmsPatIns.Reset();
                    HmsPatIns.SetRange(HmsPatIns."Member No", "Member No");
                    HmsPatIns.SetRange(HmsPatIns."Insurance No", "Account No.");
                    if HmsPatIns.Find('-') then
                        "Patient No" := HmsPatIns."Patient No";
                end;
            end;
        }
        field(92; "HSM Transaction Type"; Code[20])
        {
            TableRelation = "HMS Transactions code"."Transaction Type";
        }
        field(93; "Header Posted"; Boolean)
        {
            CalcFormula = lookup("Receipts Header".Posted where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(94; "Posting Time"; Time)
        {
            CalcFormula = lookup("Receipts Header"."Time Posted" where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(95; "Header Patient No"; Code[20])
        {
            CalcFormula = lookup("Receipts Header"."Patient No." where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(96; "Posted User"; Code[20])
        {
            CalcFormula = lookup("Receipts Header"."Posted By" where("No." = field(No)));
            FieldClass = FlowField;
            TableRelation = User."User Name";
        }
        field(97; "Mobile Money Type"; Option)
        {
            OptionCaption = ' ,Safaricom - MPESA,Equity - Ezzy Money,KCB - MPESA,Orange - Money,Airtel - Money';
            OptionMembers = " ","Safaricom - MPESA","Equity - Ezzy Money","KCB - MPESA","Orange - Money","Airtel - Money";
        }
        field(98; Quantity; Decimal)
        {
            InitValue = 1;
        }
        field(99; "Receipt From H"; Text[100])
        {
            CalcFormula = lookup("Receipts Header"."Received From" where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(100; Patient; Code[20])
        {
            CalcFormula = lookup("Receipts Header"."Patient No." where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(101; "Exists In Charges"; Integer)
        {
            CalcFormula = count("HMS Patient Charges" where(Code = field(No)));
            FieldClass = FlowField;
        }
        field(102; "Reversed Lk"; Boolean)
        {
            CalcFormula = lookup("Bank Account Ledger Entry".Reversed where("Document No." = field(No)));
            FieldClass = FlowField;
        }
        field(107; "Split Exits"; Boolean)
        {
            CalcFormula = exist("Receipt Split" where("Receipt No" = field(No)));
            FieldClass = FlowField;
        }
        field(103; "Bill Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(104; "Drawer Bank"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Admission No"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(106; "Application No"; code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No.", No)
        {
            Clustered = true;
            SumIndexFields = Amount, "Total Amount";
        }
    }

    fieldgroups
    {
    }

    var
        BankAcc: Record "Bank Account";
        GenLedgerSetup: Record "Cash Office Setup";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        FA: Record "Fixed Asset";
        GLAcc: Record "G/L Account";
        HMSPat: Record "HMS Patient";
        HmsPatIns: Record "HMS Patient Insuarance";
        ICPartner: Record "IC Partner";
        RecPayTypes: Record "Receipts and Payment Types";
        RHead: Record "Receipts Header";
        VATSetup: Record "VAT Posting Setup";
        Vend: Record Vendor;
}
