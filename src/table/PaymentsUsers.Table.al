Table 85119 "Payments-Users"
{
    fields
    {
        field(50000; No; Code[20])
        {
            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    GenLedgerSetup.Get();
                    if "Payment Type" = "payment type"::Normal then
                        NoSeriesMgt.TestManual(GenLedgerSetup."Normal Payments No")
                    else
                        NoSeriesMgt.TestManual(GenLedgerSetup."Imprest Req No");
                    "No. Series" := '';
                end;
            end;
        }
        field(50001; Date; Date)
        {
        }
        field(50002; Type; Code[20])
        {
            NotBlank = true;
            TableRelation = "Receipts and Payment Types".Code where(Type = filter(Payment));

            trigger OnValidate()
            begin

                "Account No." := '';
                "Account Name" := '';
                Remarks := '';
                RecPayTypes.Reset();
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);

                if RecPayTypes.Find('-') then
                    Grouping := RecPayTypes."Default Grouping";

                if RecPayTypes.Find('-') then begin
                    "Account Type" := RecPayTypes."Account Type";
                    "Transaction Name" := RecPayTypes.Description;

                    if RecPayTypes."Account Type" = RecPayTypes."account type"::"G/L Account" then begin
                        RecPayTypes.TestField(RecPayTypes."G/L Account");
                        "Account No." := RecPayTypes."G/L Account";
                        Validate("Account No.");
                    end;
                end;

                //VALIDATE("Account No.");
            end;
        }
        field(50003; "Pay Mode"; Option)
        {
            OptionMembers = ,Cash,Cheque,EFT,"Custom 1","Custom 2","Custom 3","Custom 4","Custom 5";
        }
        field(50004; "Cheque No"; Code[20])
        {
        }
        field(50005; "Cheque Date"; Date)
        {
        }
        field(50006; "Cheque Type"; Code[20])
        {
            TableRelation = Temp;
        }
        field(50007; "Bank Code"; Code[20])
        {
            //  TableRelation = "Cash Payments Header";
        }
        field(50008; "Received From"; Text[100])
        {
        }
        field(50009; "On Behalf Of"; Text[100])
        {
        }
        field(50010; Cashier; Code[20])
        {
            // TableRelation = Table2000000002.Field1;
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
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer where("Customer Posting Group" = field(Grouping))
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin

                "Account Name" := '';
                RecPayTypes.Reset();
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);

                if "Account Type" in ["account type"::"G/L Account", "account type"::Customer, "account type"::Vendor, "account type"::"IC Partner"]
                then
                    case "Account Type" of
                        "account type"::"G/L Account":
                            begin
                                GLAcc.Get("Account No.");
                                "Account Name" := GLAcc.Name;
                                "VAT Code" := RecPayTypes."VAT Code";
                                "Withholding Tax Code" := RecPayTypes."Withholding Tax Code";
                                "Global Dimension 1 Code" := '';
                            end;
                        "account type"::Customer:
                            begin
                                Cust.Get("Account No.");
                                "Account Name" := Cust.Name;
                                //      "VAT Code":=Cust."Default Withholding Tax Code";
                                //"Withholding Tax Code":=Cust.Province;
                                "Global Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            end;
                        "account type"::Vendor:
                            begin
                                Vend.Get("Account No.");
                                "Account Name" := Vend.Name;
                                //      "VAT Code":=Vend."Default VAT Code";
                                //      "Withholding Tax Code":=Vend."Default Withholding Tax Code";
                                "Global Dimension 1 Code" := Vend."Global Dimension 1 Code";
                            end;
                        "account type"::"Bank Account":
                            begin
                                BankAcc.Get("Account No.");
                                "Account Name" := BankAcc.Name;
                                "VAT Code" := RecPayTypes."VAT Code";
                                "Withholding Tax Code" := RecPayTypes."Withholding Tax Code";
                                "Global Dimension 1 Code" := BankAcc."Global Dimension 1 Code";
                            end;
                    /*
                  "Account Type"::"Fixed Asset":
                    BEGIN
                      FA.GET("Account No.");
                      "Account Name":=FA.Description;
                      "VAT Code":=FA."Default VAT Code";
                      "Withholding Tax Code":=FA."Default Withholding Tax Code";
                       "Global Dimension 1 Code":=FA."Global Dimension 1 Code";
                    END;
                    */
                    end;
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
            CalcFormula = sum("Imprest Lines".Amount where(No = field(No)));
            FieldClass = FlowField;
        }
        field(50020; Remarks; Text[250])
        {
        }
        field(50021; "Transaction Name"; Text[100])
        {
        }
        field(50022; "VAT Code"; Code[20])
        {
            TableRelation = "Tariff Codes";
        }
        field(50023; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Tariff Codes";
        }
        field(50024; "VAT Amount"; Decimal)
        {
        }
        field(50025; "Withholding Tax Amount"; Decimal)
        {
        }
        field(50026; "Net Amount"; Decimal)
        {
        }
        field(50027; "Paying Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No." where(test = field("Bank Type"));
        }
        field(50028; Payee; Text[100])
        {
        }
        field(50029; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50030; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50031; "PO/INV No"; Code[20])
        {
        }
        field(50032; "Bank Account No"; Code[20])
        {
        }
        field(50033; "Cashier Bank Account"; Code[20])
        {
        }
        field(50034; Status; Option)
        {
            OptionMembers = Pending,"1st Approval","2nd Approval","3rd Approval","Fully Approved",Cancelled;
        }
        field(50035; Select; Boolean)
        {
        }
        field(50036; Grouping; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(50037; "Payment Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(50038; "Bank Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(50039; "PV Type"; Option)
        {
            OptionMembers = Normal,Other;
        }
        field(50040; "Apply to"; Code[20])
        {
            TableRelation = "Vendor Ledger Entry"."Vendor No." where("Vendor No." = field("Account No."));
        }
        field(50041; "Apply to ID"; Code[20])
        {
        }
        field(50042; "No of Units"; Decimal)
        {
        }
        field(50043; "Surrender Date"; Date)
        {
        }
        field(50044; Surrendered; Boolean)
        {
        }
        field(50045; "Surrender Doc. No"; Code[20])
        {
        }
        field(50046; "Vote Book"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50047; "Total Allocation"; Decimal)
        {
        }
        field(50048; "Total Expenditure"; Decimal)
        {
        }
        field(50049; "Total Commitments"; Decimal)
        {
        }
        field(50050; Balance; Decimal)
        {
        }
        field(50051; "Balance Less this Entry"; Decimal)
        {
        }
        field(50052; "Applicant Designation"; Text[100])
        {
        }
        field(50053; "Petty Cash"; Boolean)
        {
        }
        field(50054; "Supplier Invoice No."; Code[30])
        {
        }
        field(50055; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50056; LineMGERID; Code[20])
        {
            //  TableRelation = Table2000000002.Field1;
        }
        field(50057; "User ID"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField(GenLedgerSetup."Normal Payments No");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Normal Payments No", xRec."No. Series", 0D, No, "No. Series");
        end;
    end;

    var
        BankAcc: Record "Bank Account";
        GenLedgerSetup: Record "Cash Office Setup";
        Cust: Record Customer;
        GLAcc: Record "G/L Account";
        RecPayTypes: Record "Receipts and Payment Types";
        Vend: Record Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
