Table 85131 "Receipt Line q"
{
    LookupPageID = "Receipts Line UP";

    fields
    {
        field(50000; No; Code[20])
        {
            NotBlank = false;
            TableRelation = "Receipts Header"."No.";
        }
        field(50001; Date; Date)
        {
            CalcFormula = lookup("Receipts Header".Date where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(50002; Type; Code[20])
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

                    if not GuiAllowed then begin
                        RHead."Co-Pay" := true;
                        RHead.Modify();
                    end;
                end;
            end;
        }
        field(50003; "Pay Mode"; Enum "Payment Modes")
        {
            trigger OnValidate()
            begin
                GenLedgerSetup.Reset();
                GenLedgerSetup.Get();

                if "Pay Mode" = "pay mode"::"Deposit Slip" then
                    "Bank Account" := GenLedgerSetup."Default Bank Deposit Slip A/C";
            end;
        }
        field(50004; "Cheque/Deposit Slip No"; Code[20])
        {
            trigger OnValidate()
            begin
                CheckSlipDetails();
            end;
        }
        field(50005; "Cheque/Deposit Slip Date"; Date)
        {
            trigger OnValidate()
            begin

                GenLedgerSetup.Get();
                if CalcDate(GenLedgerSetup."Cheque Reject Period", "Cheque/Deposit Slip Date") <= Today then
                    Error('The cheque date is not within the allowed range.');

                CheckSlipDetails();
            end;
        }
        field(50006; "Cheque/Deposit Slip Type"; Option)
        {
            OptionMembers = " "," Local","Up Country";
        }
        field(50007; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50008; "Received From"; Text[100])
        {
        }
        field(50009; "On Behalf Of"; Text[100])
        {
        }
        field(50010; Cashier; Code[20])
        {
        }
        field(50011; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(50012; "Account No."; Code[20])
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
        field(50013; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50014; "Account Name"; Text[150])
        {
        }
        field(50015; Posted; Boolean)
        {
        }
        field(50016; "Date Posted"; Date)
        {
        }
        field(50017; "Time Posted"; Time)
        {
        }
        field(50018; "Posted By"; Code[20])
        {
        }
        field(50019; Amount; Decimal)
        {
            trigger OnValidate()
            begin
                "VAT Amount" := (Amount * "VAT %") / 100;
                "VAT Amount" := ROUND("VAT Amount", 0.05, '=');
                "Total Amount" := Amount + "VAT Amount";
            end;
        }
        field(50020; Remarks; Text[250])
        {
        }
        field(50021; "Transaction Name"; Text[100])
        {
            Editable = true;
        }
        field(50022; "Branch Code"; Code[20])
        {
        }
        field(50023; "Agent Code"; Code[20])
        {
        }
        field(50024; Grouping; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(50025; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50026; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50027; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(50028; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(50029; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50030; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                if "Account Type" in ["account type"::Customer, "account type"::Vendor, "account type"::"Bank Account"] then
                    TestField("VAT Bus. Posting Group", '');
                Validate("VAT Prod. Posting Group");
            end;
        }
        field(50031; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                if "Account Type" in ["account type"::Customer, "account type"::Vendor, "account type"::"Bank Account"] then
                    TestField("VAT Prod. Posting Group", '');

                "VAT %" := 0;
                "VAT Calculation Type" := "vat calculation type"::"Normal VAT";
                if "Gen. Posting Type" <> 0 then begin
                    if not VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then
                        VATPostingSetup.Init();
                    "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                    case "VAT Calculation Type" of
                        "vat calculation type"::"Normal VAT":
                            "VAT %" := VATPostingSetup."VAT %";
                        "vat calculation type"::"Full VAT":
                            case "Gen. Posting Type" of
                                "gen. posting type"::Sale:
                                    begin
                                        VATPostingSetup.TestField("Sales VAT Account");
                                        TestField("Account No.", VATPostingSetup."Sales VAT Account");
                                    end;
                                "gen. posting type"::Purchase:
                                    begin
                                        VATPostingSetup.TestField("Purchase VAT Account");
                                        TestField("Account No.", VATPostingSetup."Purchase VAT Account");
                                    end;
                            end;
                    end;
                end;
                Validate("VAT %");
            end;
        }
        field(50032; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;

            trigger OnValidate()
            begin
                if "Account Type" in ["account type"::Customer, "account type"::Vendor, "account type"::"Bank Account"] then
                    TestField("Gen. Posting Type", "gen. posting type"::" ");
                if ("Gen. Posting Type" = "gen. posting type"::Settlement) and (CurrFieldNo <> 0) then
                    Error(Text001, "Gen. Posting Type");

                if "Gen. Posting Type" > 0 then
                    Validate("VAT Prod. Posting Group");
            end;
        }
        field(50033; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin

                if "Account Type" in ["account type"::Customer, "account type"::Vendor, "account type"::"Bank Account"] then
                    TestField("Gen. Bus. Posting Group", '');
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(50034; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin

                if "Account Type" in ["account type"::Customer, "account type"::Vendor, "account type"::"Bank Account"] then
                    TestField("Gen. Prod. Posting Group", '');
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingGrp."Def. VAT Prod. Posting Group");
            end;
        }
        field(50035; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(50036; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(50037; "Total Amount"; Decimal)
        {
            Editable = false;
        }
        field(50038; "User ID"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(50039; "Apply to"; Code[20])
        {
        }
        field(50040; "Apply to ID"; Code[20])
        {
            Editable = true;
        }
        field(50041; "Dest Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50042; "Dest Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50043; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50044; "Print No."; Integer)
        {
        }
        field(50045; Status; Option)
        {
            OptionMembers = " ",Normal,"Post Dated",Posted;
        }
        field(50046; "Deposit Slip Time"; Time)
        {
            trigger OnValidate()
            begin
                CheckSlipDetails();
            end;
        }
        field(50047; "Teller ID"; Code[20])
        {
            trigger OnValidate()
            begin
                CheckSlipDetails();
            end;
        }
        field(50048; "Customer Payment On Account"; Boolean)
        {
        }
        field(50049; Select; Boolean)
        {
        }
        field(50050; "Batch Posted"; Boolean)
        {
        }
        field(50051; "Transaction No."; Code[50])
        {
        }
        field(50052; "Cheque/Deposit Slip Bank"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50053; "Bank Account"; Code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50054; Confirmed; Boolean)
        {
        }
        field(50055; Reconciled; Boolean)
        {
        }
        field(50056; "Orig. Cashier"; Code[20])
        {
            CalcFormula = lookup("Receipts Header".Cashier where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(50057; Cancelled; Boolean)
        {
        }
        field(50058; "Cancelled By"; Code[20])
        {
        }
        field(50059; "Cancelled Date"; Date)
        {
        }
        field(50060; "Cancelled Time"; Time)
        {
        }
        field(50061; "Post Dated"; Boolean)
        {
        }
        field(50062; "Cheque Retrieved"; Boolean)
        {
        }
        field(50063; "Register Number"; Integer)
        {
        }
        field(50064; "From Entry No"; Integer)
        {
        }
        field(50065; "To Entry No"; Integer)
        {
        }
        field(50066; "Batch Posted UserID"; Code[20])
        {
        }
        field(50067; "BD Register Number"; Integer)
        {
        }
        field(50068; "BD From Number"; Integer)
        {
        }
        field(50069; "BD To Number"; Integer)
        {
        }
        field(50070; "Reversal By"; Code[20])
        {
        }
        field(50071; "Reversal Date"; Date)
        {
        }
        field(50072; "Reversal Time"; Time)
        {
        }
        field(50073; "Reversal Register No."; Integer)
        {
        }
        field(50074; "Reversal From Entry No."; Integer)
        {
        }
        field(50075; "Reversal To Entry No."; Integer)
        {
        }
        field(50076; Reversed; Boolean)
        {
        }
        field(50077; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50078; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50079; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(50080; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                OK: Boolean;
                BilToCustNo: Code[20];
                Text000: label 'You must specify %1 or %2.';
            begin
                // CODEUNIT.RUN(CODEUNIT::"Receipt Apply", Rec);
                if (Rec."Account Type" <> Rec."account type"::Customer) and (Rec."Account Type" <> Rec."account type"::Vendor) then
                    Error('You cannot apply to %1', "Account Type");

                Rec.Amount := 0;
                Rec.Validate(Amount);
                BilToCustNo := Rec."Account No.";
                CustLedgEntry.SetCurrentkey("Customer No.", Open);
                CustLedgEntry.SetRange("Customer No.", Rec."Account No.");
                CustLedgEntry.SetRange(Open, true);
                if Rec."Applies-to ID" = '' then
                    Rec."Applies-to ID" := Rec.No;
                if Rec."Applies-to ID" = '' then
                    Error(
                      Text000,
                      Rec.FieldCaption(No), Rec.FieldCaption("Applies-to ID"));
                // ApplyCustEntries.SetReceipts(Rec,CustLedgEntry,Rec.FieldNo("Applies-to ID"));
                ApplyCustEntries.SetRecord(CustLedgEntry);
                ApplyCustEntries.SetTableview(CustLedgEntry);
                ApplyCustEntries.LookupMode(true);
                OK := ApplyCustEntries.RunModal() = Action::LookupOK;
                Clear(ApplyCustEntries);
                if not OK then
                    exit;
                CustLedgEntry.Reset();
                CustLedgEntry.SetCurrentkey("Customer No.", Open);
                CustLedgEntry.SetRange("Customer No.", Rec."Account No.");
                CustLedgEntry.SetRange(Open, true);
                CustLedgEntry.SetRange("Applies-to ID", Rec."Applies-to ID");
                if CustLedgEntry.Find('-') then begin
                    Rec."Applies-to Doc. Type" := 0;
                    Rec."Applies-to Doc. No." := '';
                end else
                    Rec."Applies-to ID" := '';
                //Calculate Total Amount
                CustLedgEntry.Reset();
                CustLedgEntry.SetCurrentkey("Customer No.", Open, "Applies-to ID");
                CustLedgEntry.SetRange("Customer No.", "Account No.");
                CustLedgEntry.SetRange(Open, true);
                CustLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if CustLedgEntry.Find('-') then begin
                    CustLedgEntry.CalcSums(CustLedgEntry."Amount to Apply");
                    Amount := Abs(CustLedgEntry."Amount to Apply");
                    Validate(Amount);
                end;
            end;

            trigger OnValidate()
            begin

                if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." <> '') and
                   ("Applies-to Doc. No." <> '')
                then begin
                    SetAmountToApply("Applies-to Doc. No.", "Account No.");
                    SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
                end else
                    if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." = '') then
                        SetAmountToApply("Applies-to Doc. No.", "Account No.")
                    else
                        if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." = '') then
                            SetAmountToApply(xRec."Applies-to Doc. No.", "Account No.");
            end;
        }
        field(50081; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempCustLedgEntry: Record "Cust. Ledger Entry";
            begin
                if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
                    CustLedgEntry.SetCurrentkey("Customer No.", Open);
                    CustLedgEntry.SetRange("Customer No.", "Account No.");
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("Applies-to ID", xRec."Applies-to ID");
                    if CustLedgEntry.FindFirst() then
                        CustEntrySetApplID.SetApplId(CustLedgEntry, TempCustLedgEntry, '');
                    CustLedgEntry.Reset();
                end;
            end;
        }
        field(50082; "Deposit Slip Date"; Date)
        {
        }
        field(50083; "Patient No"; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50084; "Claim No"; Code[20])
        {
        }
        field(50085; "Member No"; Code[20])
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
        field(50086; "HSM Transaction Type"; Code[20])
        {
            TableRelation = "HMS Transactions code"."Transaction Type";
        }
        field(50087; "Header Posted"; Boolean)
        {
            CalcFormula = lookup("Receipts Header".Posted where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(50088; "Posting Time"; Time)
        {
            CalcFormula = lookup("Receipts Header"."Time Posted" where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(50089; "Header Patient No"; Code[20])
        {
            CalcFormula = lookup("Receipts Header"."Patient No." where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(50090; "Posted User"; Code[20])
        {
            CalcFormula = lookup("Receipts Header"."Posted By" where("No." = field(No)));
            FieldClass = FlowField;
            TableRelation = User."User Name";
        }
        field(50091; "Mobile Money Type"; Option)
        {
            OptionCaption = ' ,Safaricom - MPESA,Equity - Ezzy Money,KCB - MPESA,Orange - Money,Airtel - Money';
            OptionMembers = " ","Safaricom - MPESA","Equity - Ezzy Money","KCB - MPESA","Orange - Money","Airtel - Money";
        }
        field(50092; Quantity; Decimal)
        {
            InitValue = 1;
        }
        field(50093; "Receipt From H"; Text[100])
        {
            CalcFormula = lookup("Receipts Header"."Received From" where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(50094; Patient; Code[20])
        {
            CalcFormula = lookup("Receipts Header"."Patient No." where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(50095; "Exists In Charges"; Integer)
        {
            CalcFormula = count("HMS Patient Charges" where(Code = field(No)));
            FieldClass = FlowField;
        }
        field(50096; "Reversed Lk"; Boolean)
        {
            CalcFormula = lookup("Bank Account Ledger Entry".Reversed where("Document No." = field(No)));
            FieldClass = FlowField;
        }
        field(50101; "Split Exits"; Boolean)
        {
            CalcFormula = exist("Receipt Split" where("Receipt No" = field(No)));
            FieldClass = FlowField;
        }
        field(50097; "Bill Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50098; "Drawer Bank"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50099; "Admission No"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Application No"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Pharmacy"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Buffer Report"; Boolean)
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

    trigger OnDelete()
    begin
        if Posted = true then
            Error('The transaction has already been posted and therefore cannot be modified.');

        if Pharmacy = true then
            error('Please note that you can only delete pharmacy items from Pharmacy Section');
    end;

    trigger OnInsert()
    begin
        RHead.Reset();
        RHead.SetRange(RHead."No.", No);
        if RHead.FindFirst() then begin
            "Global Dimension 1 Code" := RHead."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := RHead."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := RHead."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := RHead."Shortcut Dimension 4 Code";
            "Patient No" := RHead."Patient No.";
        end;
    end;

    trigger OnModify()
    begin
        /*RHead.RESET;
        RHead.SETRANGE(RHead."No.",No);
        IF RHead.FINDFIRST THEN BEGIN
           IF RHead.Posted THEN
            ERROR('The transaction has already been posted and therefore cannot be modified.');
        END;*/

        /* IF (Posted=TRUE) AND ("Customer Payment On Account"=FALSE)  THEN
         ERROR('The transaction has already been posted and therefore cannot be modified.');
         IF (Posted=TRUE) AND ("Customer Payment On Account"=TRUE)  AND ("Batch Posted"=TRUE) THEN
         ERROR('The transaction has already been posted and therefore cannot be modified.');*/
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('The transaction has already been posted and therefore cannot be modified.');
    end;

    var
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        GenLedgerSetup: Record "Cash Office Setup";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        Cust2: Record Customer;
        FA: Record "Fixed Asset";
        GLAcc: Record "G/L Account";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        HMSPat: Record "HMS Patient";
        HmsPatIns: Record "HMS Patient Insuarance";
        ICPartner: Record "IC Partner";
        RecLine: Record "Receipt Line q";
        RecPayTypes: Record "Receipts and Payment Types";
        RHead: Record "Receipts Header";
        VATPostingSetup: Record "VAT Posting Setup";
        VATSetup: Record "VAT Posting Setup";
        Vend: Record Vendor;
        Vend2: Record Vendor;
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        ApplyCustEntries: Page "Apply Customer Entries";
        Text001: label 'The %1 option can only be used internally in the system.';
        Text002: label 'LCY';

    local procedure SetCurrencyCode(AccType2: Option "G/L Account",Customer,Vendor,"Bank Account"; AccNo2: Code[20]): Boolean
    begin
        "Currency Code" := '';
        if AccNo2 <> '' then
            case AccType2 of
                Acctype2::Customer:
                    if Cust2.Get(AccNo2) then
                        "Currency Code" := Cust2."Currency Code";
                Acctype2::Vendor:
                    if Vend2.Get(AccNo2) then
                        "Currency Code" := Vend2."Currency Code";
                Acctype2::"Bank Account":
                    if BankAcc2.Get(AccNo2) then
                        "Currency Code" := BankAcc2."Currency Code";
            end;
        exit("Currency Code" <> '');
    end;

    local procedure GetCurrency()
    begin
    end;

    procedure GetShowCurrencyCode(CurrencyCode: Code[10]): Code[10]
    begin
        if CurrencyCode <> '' then
            exit(CurrencyCode)
        else
            exit(Text002);
    end;

    procedure CheckSlipDetails()
    var
        IsExistent: Boolean;
    begin
        //this function checks the details on the deposit slip to ensure no double presentation of slips
        //the checks will be the slip date,slip no,slip time and teller and the account

        IsExistent := false;

        case "Pay Mode" of
            "pay mode"::"Deposit Slip", "pay mode"::Cheque:
                begin
                    //reset the variable for holding the records
                    RecLine.Reset();
                    //RecLine.SETRANGE(RecLine."Account Type","Account Type");
                    //RecLine.SETRANGE(RecLine."Account No.","Account No.");
                    RecLine.SetRange(RecLine."Pay Mode", "Pay Mode");
                    RecLine.SetRange(RecLine."Cheque/Deposit Slip Type", "Cheque/Deposit Slip Type");
                    RecLine.SetRange(RecLine."Cheque/Deposit Slip No", "Cheque/Deposit Slip No");
                    RecLine.SetRange(RecLine."Cheque/Deposit Slip Date", "Cheque/Deposit Slip Date");
                    RecLine.SetRange(RecLine."Deposit Slip Time", "Deposit Slip Time");
                    RecLine.SetRange(RecLine."Teller ID", "Teller ID");
                    //check if there is a record with the same details
                    if RecLine.Find('-') then
                        repeat
                            if (RecLine."Line No." <> "Line No.") then
                                IsExistent := true;
                        until RecLine.Next() = 0;
                end;
        end;
        //ask for user confirmation is the IsExistent
        if IsExistent then
            if Confirm('Bank Deposit Slip(s) with the same details exist. Continue?', false) = false then
                Error('Operation Cancelled by User Interrupt');
    end;

    procedure SetAmountToApply(AppliesToDocNo: Code[20]; CustomerNo: Code[20])
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.SetCurrentkey("Document No.");
        CustLedgEntry.SetRange("Document No.", AppliesToDocNo);
        CustLedgEntry.SetRange("Customer No.", CustomerNo);
        CustLedgEntry.SetRange(Open, true);
        if CustLedgEntry.FindFirst() then begin
            if CustLedgEntry."Amount to Apply" = 0 then begin
                CustLedgEntry.CalcFields("Remaining Amount");
                CustLedgEntry."Amount to Apply" := CustLedgEntry."Remaining Amount";
            end else
                CustLedgEntry."Amount to Apply" := 0;
            CustLedgEntry."Accepted Payment Tolerance" := 0;
            CustLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
            Codeunit.Run(Codeunit::"Cust. Entry-Edit", CustLedgEntry);
        end;
    end;
}
