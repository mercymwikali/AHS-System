Table 85118 "Payment Line"
{
    DrillDownPageID = "Payments List";
    LookupPageID = "Payments List";

    fields
    {
        field(50000; No; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            var
                PaymentsHeader: Record "Payments Header";
            begin
                /*
                IF No <> xRec.No THEN BEGIN
                  GenLedgerSetup.GET;
                  IF "Payment Type"="Payment Type"::Normal THEN BEGIN
                    NoSeriesMgt.TestManual(GenLedgerSetup."Normal Payments No");
                  END
                  ELSE BEGIN
                    NoSeriesMgt.TestManual(GenLedgerSetup."Petty Cash Payments No");
                  END;
                  "No. Series" := '';
                END;
                */

                //Budget  G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner
                if "Account Type" = "account type"::Customer then begin
                    if Cust_.Get(No) then
                        if CustPostGrp.Get(Cust_."Customer Posting Group") then
                            "G/L Account" := CustPostGrp."Receivables Account";
                end else
                    if "Account Type" = "account type"::"Fixed Asset" then begin
                        if FA_.Get(No) then
                            if FAPostSetup.Get(FA_."FA Posting Group") then
                                "G/L Account" := FAPostSetup."Acquisition Cost Account";
                    end else
                        if "Account Type" = "account type"::Vendor then
                            if Vend_.Get(No) then begin
                                if VendPostSetup.Get(Vend_."Vendor Posting Group") then
                                    "G/L Account" := VendPostSetup."Payables Account";
                            end else
                                if "Account Type" = "account type"::"G/L Account" then
                                    "G/L Account" := No;



                //End Budget
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
            var
                TarrifCode: Record "Tariff Codes";
            begin

                "Account No." := '';
                "Account Name" := '';
                Remarks := '';
                RecPayTypes.Reset();
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);

                if RecPayTypes.Find('-') then begin
                    Grouping := RecPayTypes."Default Grouping";
                    "Require Surrender" := RecPayTypes."Pending Voucher";
                    "Payment Reference" := RecPayTypes."Payment Reference";
                    "Not Vatable" := RecPayTypes."Not Vatable";
                    // "Budgetary Control A/C":=RecPayTypes."Direct Expense";

                    if RecPayTypes."VAT Chargeable" = RecPayTypes."vat chargeable"::Yes then begin
                        //  "VAT Withheld Code":='VAT 6';
                        //  "VAT Six % Rate":=0.06;
                        "VAT Code" := RecPayTypes."VAT Code";

                        if TarrifCode.Get("VAT Code") then
                            "VAT Rate" := TarrifCode.Percentage;
                    end;
                    if RecPayTypes."Withholding Tax Chargeable" = RecPayTypes."withholding tax chargeable"::Yes then begin

                        "Withholding Tax Code" := RecPayTypes."Withholding Tax Code";
                        if TarrifCode.Get("Withholding Tax Code") then
                            "W/Tax Rate" := TarrifCode.Percentage;
                    end;
                    if RecPayTypes."PAYE Tax Chargeable" = RecPayTypes."paye tax chargeable"::Yes then begin
                        "PAYE Code" := RecPayTypes."PAYE Tax Code";
                        if TarrifCode.Get("PAYE Code") then
                            "PAYE Rate" := TarrifCode.Percentage;
                    end;

                    if RecPayTypes."Calculate Retention" = RecPayTypes."calculate retention"::Yes then begin
                        "Retention Code" := RecPayTypes."Retention Code";
                        if TarrifCode.Get("Retention Code") then
                            "Retention Rate" := TarrifCode.Percentage;
                    end;
                end;

                if RecPayTypes.Find('-') then begin
                    "Account Type" := RecPayTypes."Account Type";
                    Validate("Account Type");
                    "Transaction Name" := RecPayTypes.Description;
                    // "Budgetary Control A/C":=RecPayTypes."Direct Expense";
                    /*
                     IF RecPayTypes."Account Type"=RecPayTypes."Account Type"::"G/L Account" THEN
                       BEGIN
                         RecPayTypes.TESTFIELD(RecPayTypes."G/L Account");
                         "Account No.":=RecPayTypes."G/L Account";
                         VALIDATE("Account No.");
                       END;

                            */
                    /////////////////////
                    if RecPayTypes."VAT Chargeable" = RecPayTypes."vat chargeable"::Yes then begin
                        "VAT Withheld Code" := RecPayTypes."VAT Withheld Code";
                        if TarrifCode.Get("VAT Withheld Code") then
                            "VAT Six % Rate" := TarrifCode.Percentage;
                    end;

                    /////////////////////

                    //Banks
                    if RecPayTypes."Account Type" = RecPayTypes."account type"::"Bank Account" then begin
                        "Account No." := RecPayTypes."Bank Account";
                        Validate("Account No.");
                    end;
                end;
                //GL
                if RecPayTypes."Account Type" = RecPayTypes."account type"::"G/L Account" then begin
                    "Account No." := RecPayTypes."G/L Account";
                    Validate("Account No.");
                end;

                PaymentHeader.Reset();
                PaymentHeader.SetRange(PaymentHeader."No.", No);
                PaymentHeader.SetRange("Apply to Document Type", PaymentHeader."Apply to Document Type"::" ");
                if PaymentHeader.FindFirst() then begin
                    Date := PaymentHeader.Date;
                    // PHead.TestField("Responsibility Center");
                    "Global Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := PaymentHeader."Shortcut Dimension 2 Code";
                    "Shortcut Dimension 3 Code" := PaymentHeader."Shortcut Dimension 3 Code";
                    "Shortcut Dimension 4 Code" := PaymentHeader."Shortcut Dimension 4 Code";
                    "Currency Code" := PaymentHeader."Currency Code";
                    "Currency Factor" := PaymentHeader."Currency Factor";
                    "Payment Type" := PaymentHeader."Payment Type";
                end;
            end;
        }
        field(50003; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Custom 2","Custom 3","Custom 4","Custom 5";
        }
        field(50004; "Cheque No"; Code[20])
        {
        }
        field(50005; "Cheque Date"; Date)
        {
        }
        field(50006; "Cheque Type"; Code[20])
        {
        }
        field(50007; "Bank Code"; Code[20])
        {
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

            trigger OnValidate()
            begin
                /*  PayLines.RESET;
                  PayLines.SETRANGE(PayLines."Account Type",PayLines."Account Type"::Vendor);
                  PayLines.SETRANGE(PayLines.No,No);
                  IF PayLines.FIND('-') THEN
                     ERROR('There is already another existing Payment to a Vendor in this document');

                  PayLines.RESET;
                  PayLines.SETRANGE(PayLines."Account Type",PayLines."Account Type"::Customer);
                  PayLines.SETRANGE(PayLines.No,No);
                  IF PayLines.FIND('-') THEN
                     ERROR('There is already another existing Payment to a Customer in this document');

                  IF ("Account Type"= "Account Type"::Vendor) OR  ("Account Type"= "Account Type"::Customer) THEN  BEGIN
                     IF PayLinesExist THEN
                     ERROR('There is already another existing Line for this document');
                  END;
                  */
            end;
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
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner";

            trigger OnValidate()
            var
                Text0001: label 'The Account number CANNOT be the same as the Paying Bank Account No.';

            begin
                PH.Reset();
                PH.Get(No);
                "Account Name" := '';
                RecPayTypes.Reset();
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);
                TestField(Committed, false);
                if "Account Type" in ["account type"::"G/L Account", "account type"::Customer, "account type"::Vendor, "account type"::"IC Partner",
                "account type"::"Bank Account"]
                then
                    case "Account Type" of
                        "account type"::"G/L Account":
                            begin
                                if GLAcc.Get("Account No.") then
                                    GLAcc.Validate(GLAcc."No.");
                                "Account Name" := GLAcc.Name;
                                "Budgetary Control A/C" := GLAcc."Budget Controlled";
                                // PH.TestField("Global Dimension 1 Code");
                                // PH.TestField("Shortcut Dimension 2 Code");
                                //PH.TESTFIELD("Shortcut Dimension 3 Code");

                                //"Global Dimension 1 Code":='';
                                //"Shortcut Dimension 2 Code":='';
                                CalcFields("Council Claim");
                                if "Council Claim" = true then begin
                                    PH.Payee := "Account Name";
                                    PH."Payment Narration" := GLAcc.Name;
                                    // PH.Modify;
                                end;
                            end;
                        "account type"::Customer:
                            begin
                                Cust.Get("Account No.");
                                "Account Name" := Cust.Name;
                                "Student No" := "Account No.";
                                if "Global Dimension 1 Code" = '' then
                                    "Global Dimension 1 Code" := Cust."Global Dimension 1 Code";
                            end;
                        "account type"::Vendor:
                            begin
                                Vend.Get("Account No.");
                                "Account Name" := Vend.Name;
                                "KRA Pin No." := Vend."VAT Registration No.";
                                PH.Payee := Vend.Name;
                                if "Global Dimension 1 Code" = '' then
                                    "Global Dimension 1 Code" := Vend."Global Dimension 1 Code";
                                if PH.Payee = '' then begin
                                    PH.Payee := "Account Name";
                                    PH.Modify();
                                end;
                                if PH."On Behalf Of" = '' then begin
                                    PH."On Behalf Of" := "Account Name";
                                    PH.Modify();
                                end;
                            end;
                        "account type"::"Bank Account":
                            begin
                                if BankAcc.Get("Account No.") then
                                    "Account Name" := BankAcc.Name;
                                PH.TestField("Paying Bank Account");
                                if PH."Paying Bank Account" = "Account No." then
                                    Error(Text0001);
                                if "Global Dimension 1 Code" = '' then
                                    "Global Dimension 1 Code" := BankAcc."Global Dimension 1 Code";
                            end;
                        "account type"::"IC Partner":
                            begin
                                ICPartner.Reset();
                                ICPartner.Get("Account No.");
                                "Account Name" := ICPartner.Name;
                            end;
                    end;
                //Set the application to Invoice if Account type is vendor
                if "Account Type" = "account type"::Vendor then
                    "Applies-to Doc. Type" := "applies-to doc. type"::Invoice;
                CalculateVoteBalance();
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
                CalcFields("Council Claim");
                if "Council Claim" = true then
                    TestField("Council No.");

                CalculateTax();
                Validate("Retention  Amount");
                PaymentHeader.Reset();
                PaymentHeader.SetRange(PaymentHeader."No.", No);
                if PaymentHeader.FindFirst() then
                    if (PaymentHeader.Status = PaymentHeader.Status::Approved) or (PaymentHeader.Status = PaymentHeader.Status::Posted) or
                     (PaymentHeader.Status = PaymentHeader.Status::"Pending Approval") then
                        Error('You Cannot modify documents that are approved/posted/Send for Approval');
                TestField(Committed, false);
            end;
        }
        field(50020; Remarks; Text[250])
        {
        }
        field(50021; "Transaction Name"; Text[100])
        {
        }
        field(50022; "VAT Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code where(Type = const(VAT));

            trigger OnValidate()
            begin
                CalculateTax();
            end;
        }
        field(50023; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Tariff Codes" where(Type = const("W/Tax"));

            trigger OnValidate()
            begin
                //CalculateTax();
            end;
        }
        field(50024; "VAT Amount"; Decimal)
        {
        }
        field(50025; "Withholding Tax Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                CalculateTax();
            end;
        }
        field(50026; "Net Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Currency Factor" <> 0 then
                    "NetAmount LCY" := "Net Amount" / "Currency Factor"
                else
                    "NetAmount LCY" := "Net Amount";
            end;
        }
        field(50027; "Paying Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50028; Payee; Text[100])
        {
        }
        field(50029; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin

                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name
            end;
        }
        field(50030; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin

                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Branch Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name
            end;
        }
        field(50031; "PO/INV No"; Code[500])
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
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook;
        }
        field(50035; Select; Boolean)
        {
        }
        field(50036; Grouping; Code[20])
        {
            TableRelation = "Vendor Posting Group".Code;
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
        field(50040; "Apply to"; Code[50])
        {
            TableRelation = "Vendor Ledger Entry"."Vendor No." where("Vendor No." = field("Account No."));
        }
        field(50041; "Apply to ID"; Code[50])
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

            trigger OnValidate()
            begin
                /*
                          IF Amount<=0 THEN
                        ERROR('Please enter the Amount');

                       //Confirm the Amount to be issued doesnot exceed the budget and amount Committed
                        EVALUATE(CurrMonth,FORMAT(DATE2DMY(Date,2)));
                        EVALUATE(CurrYR,FORMAT(DATE2DMY(Date,3)));
                        EVALUATE(BudgetDate,FORMAT('01'+'/'+CurrMonth+'/'+CurrYR));

                          //Get the last day of the month

                          LastDay:=CALCDATE('1M', BudgetDate);
                          LastDay:=CALCDATE('-1D',LastDay);

                        //Get Budget for the G/L
                      IF GenLedSetup.GET THEN BEGIN
                        GLAccount.SETFILTER(GLAccount."Budget Filter",GenLedSetup."Current Budget");
                        GLAccount.SETRANGE(GLAccount."No.","Vote Book");
                        GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change");
                        {Get the exact Monthly Budget}
                        //Start from first date of the budget.//BudgetDate
                        GLAccount.SETRANGE(GLAccount."Date Filter",GenLedSetup."Current Budget Start Date",LastDay);

                        IF GLAccount.FIND('-') THEN BEGIN
                         GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change");
                         MonthBudget:=GLAccount."Budgeted Amount";
                         Expenses:=GLAccount."Net Change";
                         BudgetAvailable:=GLAccount."Budgeted Amount"-GLAccount."Net Change";
                         "Total Allocation":=MonthBudget;
                         "Total Expenditure":=Expenses;
                         END;
                     END;

                     CommitmentEntries.RESET;
                     CommitmentEntries.SETCURRENTKEY(CommitmentEntries.Account);
                     CommitmentEntries.SETRANGE(CommitmentEntries.Account,"Vote Book");
                     CommitmentEntries.SETRANGE(CommitmentEntries."Commitment Date",GenLedSetup."Current Budget Start Date",LastDay);
                     CommitmentEntries.CALCSUMS(CommitmentEntries."Committed Amount");
                     CommittedAmount:=CommitmentEntries."Committed Amount";

                     "Total Commitments":=CommittedAmount;
                     Balance:=BudgetAvailable-CommittedAmount;
                     "Balance Less this Entry":=BudgetAvailable-CommittedAmount-Amount;
                     MODIFY;
                     {
                     IF CommittedAmount+Amount>BudgetAvailable THEN
                        ERROR('%1,%2,%3,%4','You have Exceeded Budget for G/L Account No',"Vote Book",'by',
                        ABS(BudgetAvailable-(CommittedAmount+Amount)));
                      }
                     //End of Confirming whether Budget Allows Posting
                */
            end;
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
        field(50056; "Imprest Request No"; Code[20])
        {
            TableRelation = "Payments-Users" where(Posted = const(false));

            trigger OnValidate()
            begin

                /*
                          TotAmt:=0;
                     //On Delete/Change of Request No. then Clear from Imprest Details
                     IF ("Imprest Request No"='') OR ("Imprest Request No"<>xRec."Imprest Request No") THEN
                        LoadImprestDetails.RESET;
                        LoadImprestDetails.SETRANGE(LoadImprestDetails.No,No);
                        IF LoadImprestDetails.FIND('-') THEN BEGIN
                           LoadImprestDetails.DELETEALL;
                           Amount:=TotAmt;
                           "Net Amount":=Amount;
                           MODIFY;
                        END;
                     //New Imprest Details
                     ImprestReqDet.RESET;
                     ImprestReqDet.SETRANGE(ImprestReqDet.No,"Imprest Request No");
                     IF ImprestReqDet.FIND('-') THEN BEGIN
                     REPEAT
                         LoadImprestDetails.INIT;
                         LoadImprestDetails.No:=No;
                         LoadImprestDetails.Date:=ImprestReqDet."Account No:";
                         LoadImprestDetails.Type:=ImprestReqDet."Account Name";
                         LoadImprestDetails."Pay Mode":=ImprestReqDet.Amount;
                         LoadImprestDetails."Cheque No":=ImprestReqDet."Due Date";
                         LoadImprestDetails."Cheque Date":=ImprestReqDet."Imprest Holder";
                         LoadImprestDetails.INSERT;
                         TotAmt:=TotAmt+ImprestReqDet.Amount;
                     UNTIL ImprestReqDet.NEXT=0;
                         Amount:=TotAmt;
                         "Account No.":=ImprestReqDet."Imprest Holder";
                         "Net Amount":=Amount;
                         MODIFY;
                     END;
                {
                       //ImprestDetForm.GETRECORD(LoadImprestDetails);
                }
                      */
            end;
        }
        field(50057; "Batched Imprest Tot"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50058; "Function Name"; Text[30])
        {
        }
        field(50059; "Budget Center Name"; Text[150])
        {
        }
        field(50060; "Farmer Purchase No"; Code[20])
        {
        }
        field(50061; "Transporter Ananlysis No"; Code[20])
        {
        }
        field(50062; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50063; "Journal Template"; Code[20])
        {
        }
        field(50064; "Journal Batch"; Code[20])
        {
        }
        field(50065; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50066; "Require Surrender"; Boolean)
        {
            Editable = false;
        }
        field(50067; "Commited Ammount"; Decimal)
        {
            FieldClass = FlowFilter;
        }
        field(50068; "Select to Surrender"; Boolean)
        {
        }
        field(50069; "Payment Reference"; Option)
        {
            OptionMembers = Normal,"Farmer Purchase";
        }
        field(50070; "ID Number"; Code[8])
        {
        }
        field(50071; "VAT Rate"; Decimal)
        {
            trigger OnValidate()
            begin
                /*"VAT Amount":=(Amount * 100);
                "VAT Amount":=Amount-("VAT Amount"/(100 + "VAT Rate"));*/
            end;
        }
        field(50072; "Amount With VAT"; Decimal)
        {
        }
        field(50073; "Currency Code"; Code[20])
        {
        }
        field(50074; "Exchange Rate"; Decimal)
        {
        }
        field(50075; "Currency Reciprical"; Decimal)
        {
        }
        field(50076; "VAT Prod. Posting Group"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "VAT Product Posting Group".Code;
        }
        field(50077; "Budgetary Control A/C"; Boolean)
        {
            Editable = false;
        }
        field(50078; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name
            end;
        }
        field(50079; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name
            end;
        }
        field(50080; Committed; Boolean)
        {
        }
        field(50081; "Currency Factor"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Currency Factor" <> 0 then
                    "NetAmount LCY" := "Net Amount" / "Currency Factor"
                else
                    "NetAmount LCY" := "Net Amount";
            end;
        }
        field(50082; "NetAmount LCY"; Decimal)
        {
        }
        field(50083; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(50084; "Applies-to Doc. No."; Code[50])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                VendLedgEntry2: Record "Vendor Ledger Entry";
                ApplyVendEntries: Page "Apply Vendor Entries2";
                OK: Boolean;
                PayToVendorNo: Code[20];
                Text000: label 'You must specify %1 or %2.';
            begin
                //CODEUNIT.RUN(CODEUNIT::"Payment Voucher Apply",Rec);

                if (Rec."Account Type" <> Rec."account type"::Customer) and (Rec."Account Type" <> Rec."account type"::Vendor) then
                    Error('You cannot apply to %1', "Account Type");

                Rec.Amount := 0;
                Rec.Validate(Amount);
                VendLedgEntry2.reset();
                VendLedgEntry2.setrange("Vendor No.", Rec."Account No.");
                PayToVendorNo := Rec."Account No.";
                VendLedgEntry.SetCurrentkey("Vendor No.", Open);
                VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                VendLedgEntry.SetRange(Open, true);
                if Rec."Applies-to ID" = '' then
                    Rec."Applies-to ID" := Rec.No;
                if Rec."Applies-to ID" = '' then
                    Error(
                      Text000,
                      Rec.FieldCaption(No), Rec.FieldCaption("Applies-to ID"));

                //ApplyVendEntries."SetPVLine-Delete"(PVLine,PVLine.FIELDNO("Applies-to ID"));
                if VendLedgEntry.find('-') then begin
                    ApplyVendEntries.SetPVLine(Rec, VendLedgEntry, Rec.FieldNo("Applies-to ID"));
                    ApplyVendEntries.SetRecord(VendLedgEntry);
                    ApplyVendEntries.SetTableview(VendLedgEntry);
                end else
                    if VendLedgEntry2.find('-') then begin
                        ApplyVendEntries.SetPVLine(Rec, VendLedgEntry2, Rec.FieldNo("Applies-to ID"));
                        ApplyVendEntries.SetRecord(VendLedgEntry2);
                        ApplyVendEntries.SetTableview(VendLedgEntry2);
                    end;
                ApplyVendEntries.LookupMode(true);
                OK := ApplyVendEntries.RunModal() = Action::LookupOK;
                Clear(ApplyVendEntries);
                if not OK then
                    exit;
                VendLedgEntry.Reset();
                VendLedgEntry.SetCurrentkey("Vendor No.", Open);
                VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                VendLedgEntry.SetRange(Open, true);
                VendLedgEntry.SetRange("Applies-to ID", Rec."Applies-to ID");
                if VendLedgEntry.Find('-') then begin
                    Rec."Applies-to Doc. Type" := 0;
                    Rec."Applies-to Doc. No." := '';
                end else
                    Rec."Applies-to ID" := '';

                //Calculate  Total To Apply
                VendLedgEntry.Reset();
                VendLedgEntry.SetCurrentkey("Vendor No.", Open, "Applies-to ID");
                VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                VendLedgEntry.SetRange(Open, true);
                VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if VendLedgEntry.Find('-') then begin
                    VendLedgEntry.CalcSums("Amount to Apply");
                    Amount := Abs(VendLedgEntry."Amount to Apply");
                    Validate(Amount);
                    "Applies-to Doc. No." := VendLedgEntry."Document No.";
                    "Global Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
                    // "Shortcut Dimension 3 Code" := VendLedgEntry."Shortcut Dimension 3 Code";
                    // "Shortcut Dimension 4 Code" := VendLedgEntry."Shortcut Dimension 4 Code";
                    // "Shortcut Dimension 4 Code" := VendLedgEntry."Shortcut Dimension 5 Code";
                    if PaymentHeader.get(No) then begin
                        PaymentHeader."Global Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
                        PaymentHeader."Shortcut Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
                        //   PHead."Shortcut Dimension 3 Code" := VendLedgEntry."Shortcut Dimension 3 Code";
                        //  PHead."Shortcut Dimension 4 Code" := VendLedgEntry."Shortcut Dimension 4 Code";
                        ///   PHead."Shortcut Dimension 4 Code" := VendLedgEntry."Shortcut Dimension 5 Code";
                        PaymentHeader.modify();
                    end;
                end;
                //Calculate Application Lines
                PVAppLines.Reset();
                PVAppLines.SetRange(PVAppLines.No, No);
                if PVAppLines.Find('-') then
                    repeat
                        PVAppLines.Delete();
                    until PVAppLines.Next() = 0;

                VendLedgEntry.Reset();
                VendLedgEntry.SetCurrentkey("Vendor No.", Open);
                VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
                VendLedgEntry.SetRange(Open, true);
                VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
                if VendLedgEntry.Find('-') then
                    repeat
                        PVAppLines.Init();
                        PVAppLines.No := No;
                        PVAppLines."Document No" := VendLedgEntry."Document No.";
                        PVAppLines.Description := VendLedgEntry.Description;
                        PVAppLines.Date := VendLedgEntry."Posting Date";
                        PVAppLines.Amount := VendLedgEntry."Amount to Apply";
                        PVAppLines."External No" := VendLedgEntry."External Document No.";
                        PVAppLines."Vendor No" := PayToVendorNo;
                        PVAppLines.Insert();
                    until VendLedgEntry.Next() = 0;
            end;

            trigger OnValidate()
            begin
                //IF "Applies-to Doc. No." <> '' THEN
                //TESTFIELD("Bal. Account No.",'');

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
        field(50085; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            begin
                //IF "Applies-to ID" <> '' THEN
                //  TESTFIELD("Bal. Account No.",'');
                if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
                    VendLedgEntry.SetCurrentkey("Vendor No.", Open);
                    VendLedgEntry.SetRange("Vendor No.", "Account No.");
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Applies-to ID", xRec."Applies-to ID");
                    if VendLedgEntry.FindFirst() then
                        //  VendEntrySetApplID.SetApplId(VendLedgEntry,TempVendLedgEntry,0,0,'');
                        VendLedgEntry.Reset();
                end;
            end;
        }
        field(50086; "Retention Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code where(Type = const(Retention));

            trigger OnValidate()
            begin
                if Tarrif.Get("Retention Code") then
                    "Retention Rate" := Tarrif.Percentage;
            end;
        }
        field(50087; "Retention  Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                // CalculateTax();
            end;
        }
        field(50088; "Retention Rate"; Decimal)
        {
        }
        field(50089; "W/Tax Rate"; Decimal)
        {
        }
        field(50090; "Vendor Bank Account"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Account No."));

            trigger OnValidate()
            begin
                VBank.Reset();
                VBank.SetRange(VBank."Vendor No.", "Account No.");
                VBank.SetRange(VBank.Code, "Vendor Bank Account");
                if VBank.Find('-') then begin
                    "EFT Bank Account No" := VBank."Bank Account No.";
                    "EFT Bank Code" := VBank.Code;
                    "EFT Account Name" := VBank.Name;
                    "EFT Branch No." := VBank."Bank Branch No.";
                end;
            end;
        }
        field(50091; "EFT Bank Account No"; Code[20])
        {
        }
        field(50092; "EFT Bank Code"; Code[20])
        {
        }
        field(50093; "EFT Account Name"; Text[50])
        {
        }
        field(50094; "EFT Branch No."; Code[20])
        {
        }
        field(50095; "Document Type"; Option)
        {
            OptionCaption = ' ,Imprest,Claim';
            OptionMembers = " ",Imprest,Claim;
        }
        field(50096; "Document No"; Code[50])
        {
            TableRelation = if ("Document Type" = const(Imprest)) "Imprest Header"
            else
            if ("Document Type" = const(Claim)) "Payments Header" where("Payment Type" = const("Petty Cash"));

            trigger OnValidate()
            begin
                /* IF "Document Type"="Document Type"::Imprest THEN BEGIN
                  ImprestLines.RESET;
                 ImprestLines.SETRANGE(ImprestLines.No,"Document No");
                 ImprestLines.SETRANGE(ImprestLines."Account No:","Account No.");
                 IF ImprestLines.FIND('-') THEN BEGIN
                 "Account No.":=ImprestLines."Account No:";
                 "Account Name":=ImprestLines."Account Name";
                  Amount:=ImprestLines.Amount;
                 "Net Amount":=ImprestLines.Amount;
                 VALIDATE(Amount);
                 VALIDATE("Net Amount");
                 END ELSE
                 IF "Document Type"="Document Type"::Claim THEN BEGIN
                 PayLine.RESET;
                 PayLine.SETRANGE(PayLine.No,"Document No");
                 PayLine.SETRANGE(PayLine."Account No.","Document Line");
                 IF PayLine.FIND('-') THEN
                 "Account No.":=PayLine."Account No.";
                 "Account Name":=PayLine."Account Name";
                 Amount:=PayLine.Amount;
                 "Net Amount":=PayLine."Net Amount";
                 VALIDATE(Amount);
                 VALIDATE("Net Amount");
                   END;
                 END;
                //END;
                 */
            end;
        }
        field(50097; "Document Line"; Code[20])
        {
            TableRelation = if ("Document Type" = const(Imprest)) "Imprest Lines"."Account No:"
            else
            if ("Document Type" = const(Claim)) "Payment Line"."Account No." where("Payment Type" = const("Petty Cash"));

            trigger OnValidate()
            begin
                if "Document Type" = "document type"::Imprest then begin
                    ImprestLines.Reset();
                    ImprestLines.SetRange(ImprestLines.No, "Document No");
                    ImprestLines.SetRange(ImprestLines."Account No:", "Document Line");
                    if ImprestLines.Find('-') then begin
                        "Account No." := ImprestLines."Imprest Holder";
                        "Account Name" := ImprestLines."Account Name";
                        Amount := ImprestLines.Amount;
                        "Net Amount" := ImprestLines.Amount;
                        Validate(Amount);
                        Validate("Net Amount");
                    end;
                end;
                if "Document Type" = "document type"::Claim then begin
                    PayLine.Reset();
                    PayLine.SetRange(PayLine.No, "Document No");
                    PayLine.SetRange(PayLine."Account No.", "Document Line");
                    if PayLine.Find('-') then begin
                        "Account No." := PayLine."Account No.";
                        "Account Name" := PayLine."Account Name";
                        Amount := PayLine.Amount;
                        "Net Amount" := PayLine."Net Amount";
                        Validate(Amount);
                        Validate("Net Amount");
                    end;
                end;
                //END;
            end;
        }
        field(50098; Reversed; Boolean)
        {

        }
        field(50099; "PAYE Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                CalculateTax();
            end;
        }
        field(50100; "PAYE Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code where(Type = const(PAYE));
        }
        field(50101; "Budgeted Amount"; Decimal)
        {
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No." = field("Account No."),
                                                               "Global Dimension 1 Code" = field("Global Dimension 1 Code"),
                                                               "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                               Date = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50102; "Actual Expenditure"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Account No."),
                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Code"),
                                                        "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                        "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50103; "Committed Amount"; Decimal)
        {
            CalcFormula = sum(Committment.Amount where("G/L Account No." = field("Account No."),
                                                        "Shortcut Dimension 1 Code" = field("Global Dimension 1 Code"),
                                                        "Shortcut Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                        "Posting Date" = field("Date Filter"), Cancelled = const(False)));
            FieldClass = FlowField;
        }
        field(50104; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50105; "Budget Balance"; Decimal)
        {
        }
        field(50106; "VAT Withheld Amount"; Decimal)
        {
        }
        field(50107; "VAT Withheld Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code where(Type = const(VAT));
        }
        field(50108; "VAT Six % Rate"; Decimal)
        {
        }
        field(50109; "Not Vatable"; Boolean)
        {
        }
        field(50110; "Council No."; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                if CouncilRec.Get("Council No.") then
                    "Account Name" := CouncilRec.Name;

                PH.Get(No);
                CalcFields("Council Claim");
                if "Council Claim" = true then begin
                    GLAcc.Get("Account No.");
                    PH.Payee := "Account Name";
                    PH."Payment Narration" := GLAcc.Name;
                    PH.Modify();
                end;
            end;
        }
        field(50111; "Council Claim"; Boolean)
        {
            CalcFormula = lookup("Receipts and Payment Types"."Council Claim?" where(Code = field(Type)));
            FieldClass = FlowField;
        }
        field(50112; "Telephone Allowance"; Boolean)
        {
            CalcFormula = lookup("Receipts and Payment Types"."Telephone Allowance?" where(Code = field(Type)));
            FieldClass = FlowField;
        }
        field(50113; "PAYE Rate"; Decimal)
        {
        }
        field(50114; "Medical Claim Type"; Option)
        {
            OptionCaption = ' ,Student,Employee';
            OptionMembers = " ",Student,Employee;
        }
        field(50115; "Medical Ref. No"; Code[20])
        {
            TableRelation = if ("Medical Claim Type" = const(Student)) Customer."No." where("Customer Posting Group" = const('STUDENT'))
            else
            if ("Medical Claim Type" = const(Employee)) "HR-Employee"."No.";
        }
        field(50116; "Payment Status"; Option)
        {
            CalcFormula = lookup("Payments Header".Status where("No." = field(No)));
            FieldClass = FlowField;
            OptionCaption = 'Pending,1st Approval,2nd Approval,Cheque Printing,Posted,Cancelled,Checking,VoteBook,Pending Approval,Approved';
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook,"Pending Approval",Approved;
        }
        field(50117; Commission; Code[20])
        {
            TableRelation = "Tariff Codes".Code where(Type = const(Commision));

            trigger OnValidate()
            begin
                CalculateTax();
            end;
        }
        field(50118; "Commision Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                // CalculateTax();
            end;
        }
        field(50119; "Student No"; Code[20])
        {
            TableRelation = Customer."No." where("Customer Type1" = const(Student));
        }
        field(50120; Posteds; Boolean)
        {
            CalcFormula = lookup("Payments Header".Posted where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(50121; "Posted Date"; Date)
        {
            CalcFormula = lookup("Payments Header".Date where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(50122; "KRA Pin No."; Code[20])
        {
        }
        field(50123; "G/L Account"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50124; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50125; "Patient No"; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No." where(Activated = filter(true));
        }
        field(50126; "Shortcut Dimension 5 Code"; Code[20])
        {
            // Caption = 'Sub-Department';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
    }

    keys
    {
        key(Key1; "Line No.", No, Type, "Account No.")
        {
            Clustered = true;
            SumIndexFields = Amount, "VAT Amount", "Withholding Tax Amount", "Net Amount", "NetAmount LCY", "Retention  Amount", "PAYE Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
        PHead.RESET;
        PHead.SETRANGE(PHead."No.",No);
         IF PHead.FINDFIRST THEN BEGIN
            IF (PHead.Status=PHead.Status::Approved) OR (PHead.Status=PHead.Status::Posted) OR
            (PHead.Status=PHead.Status::"Pending Approval") THEN
               ERROR('You Cannot Delete this record its already approved/posted/Send for Approval');
         END;
          TESTFIELD(Committed,FALSE);
         */
    end;

    trigger OnInsert()
    begin

        if No = '' then begin
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField(GenLedgerSetup."Normal Payments No");
            NoSeriesMgt.GetNextNo(GenLedgerSetup."Normal Payments No");
        end;
        PaymentHeader.Reset();
        PaymentHeader.SetRange(PaymentHeader."No.", No);
        PaymentHeader.SetRange("Apply to Document Type", PaymentHeader."Apply to Document Type"::" ");
        if PaymentHeader.FindFirst() then begin
            Date := PaymentHeader.Date;
            // PaymentHeader.TestField("Responsibility Center");
            "Global Dimension 1 Code" := PaymentHeader."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := PaymentHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := PaymentHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := PaymentHeader."Shortcut Dimension 4 Code";
            "Shortcut Dimension 5 Code" := PaymentHeader."Shortcut Dimension 5 Code";

            "Currency Code" := PaymentHeader."Currency Code";
            "Currency Factor" := PaymentHeader."Currency Factor";
            "Payment Type" := PaymentHeader."Payment Type";
            "Pay Mode" := PaymentHeader."Pay Mode";
        end;
        //
        PaymentHeader.Reset();
        PaymentHeader.SetRange(PaymentHeader."No.", No);
        if PaymentHeader.FindFirst() then
            if (PaymentHeader.Status = PaymentHeader.Status::Approved) or (PaymentHeader.Status = PaymentHeader.Status::Posted) or
             (PaymentHeader.Status = PaymentHeader.Status::"Pending Approval") then
                Error('You Cannot modify documents that are approved/posted/Send for Approval');
        TestField(Committed, false);
    end;

    trigger OnModify()
    begin
        /*
        PHead.RESET;
        PHead.SETRANGE(PHead."No.",No);
         IF PHead.FINDFIRST THEN BEGIN
            IF (PHead.Status=PHead.Status::Approved) OR (PHead.Status=PHead.Status::Posted) OR
             (PHead.Status=PHead.Status::"Pending Approval") THEN
               ERROR('You Cannot modify documents that are approved/posted/Send for Approval');
         END;
          TESTFIELD(Committed,FALSE);
         */
    end;

    var
        BankAcc: Record "Bank Account";
        GenLedgerSetup: Record "Cash Office Setup";
        Cust: Record Customer;
        Cust_: Record Customer;
        CustPostGrp: Record "Customer Posting Group";
        DimVal: Record "Dimension Value";
        FAPostSetup: Record "FA Posting Group";
        FA_: Record "Fixed Asset";
        GLAcc: Record "G/L Account";
        ICPartner: Record "IC Partner";
        ImprestLines: Record "Imprest Lines";
        PayLine: Record "Payment Line";
        PVAppLines: Record "Payments Application Lines";
        PH: Record "Payments Header";
        PaymentHeader: Record "Payments Header";
        VitalSetup: Record "prVital Setup Info";
        RecPayTypes: Record "Receipts and Payment Types";
        Tarrif: Record "Tariff Codes";
        CouncilRec: Record Vendor;
        Vend: Record Vendor;
        Vend_: Record Vendor;
        VBank: Record "Vendor Bank Account";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendPostSetup: Record "Vendor Posting Group";
        NoSeriesMgt: Codeunit "No. Series";
        curReliefPersonal: Decimal;

    procedure SetAmountToApply(AppliesToDocNo: Code[20]; VendorNo: Code[20])
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SetCurrentkey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliesToDocNo);
        VendLedgEntry.SetRange("Vendor No.", VendorNo);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst() then begin
            if VendLedgEntry."Amount to Apply" = 0 then begin
                VendLedgEntry.CalcFields("Remaining Amount");
                VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
            end else
                VendLedgEntry."Amount to Apply" := 0;
            VendLedgEntry."Accepted Payment Tolerance" := 0;
            VendLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
            Codeunit.Run(Codeunit::"Vend. Entry-Edit", VendLedgEntry);
        end;
    end;

    procedure CalculateTax()
    var
        prPayroll: Codeunit prPayrollProcessing;
        TotalTax: Decimal;
    begin
        "VAT Amount" := 0;
        "Retention  Amount" := 0;
        TotalTax := 0;
        "Net Amount" := 0;
        "Commision Amount" := 0; //"PAYE Amount":=0;,"Withholding Tax Amount":=0;
        if Amount <> 0 then begin
            if "VAT Rate" <> 0 then
                //  "VAT Amount":=TaxCalc.CalculateTax(Rec,CalculationType::VAT);
                "VAT Amount" := ("VAT Rate" / 116) * Amount;
            // TotalTax:=TotalTax+"VAT Amount"

            /* IF "W/Tax Rate"<>0 THEN BEGIN
              "Withholding Tax Amount":=TaxCalc.CalculateTax(Rec,CalculationType::"W/Tax");
              TotalTax:=TotalTax+ "Withholding Tax Amount"
             END;
             */

            if "VAT Withheld Code" <> '' then begin
                //ERROR('Test'+"VAT Withheld Code");
                "VAT Withheld Amount" := 0;
                // "VAT Withheld Amount":=("VAT Amount"*("VAT Six % Rate")/100);
                "VAT Withheld Amount" := ROUND((Amount * "VAT Six % Rate") / 116, 1, '=');
                TotalTax := TotalTax + "VAT Withheld Amount"
            end;

            if "Withholding Tax Code" <> '' then begin
                // "Withholding Tax Amount":=ROUND(TaxCalc.CalculateTax(Rec,CalculationType::"W/Tax"),1,'>');
                if "Not Vatable" = false then
                    "Withholding Tax Amount" := ROUND((("W/Tax Rate" / 116) * Amount), 1, '=')
                else
                    "Withholding Tax Amount" := ROUND((("W/Tax Rate" / 100) * Amount), 1, '=');

                TotalTax := TotalTax + "Withholding Tax Amount"
            end;

            /*IF "Retention Rate"<>0 THEN BEGIN
             "Retention  Amount":=TaxCalc.CalculateTax(Rec,CalculationType::Retention);
             TotalTax:=TotalTax+"Retention  Amount"
            END; */

            if "Retention Code" <> '' then begin
                // "Retention  Amount":=TaxCalc.CalculateTax(Rec,CalculationType::Retention);
                // "VAT Amount":=Amount*0.16;
                "Retention  Amount" := ROUND((("Retention Rate" / 100) * (Amount)), 1, '=');
                TotalTax := TotalTax + "Retention  Amount"
            end;

            if Commission <> '' then begin
                // CALCFIELDS("Commision Amount");
                "Commision Amount" := (0.07 * Amount);

                "Net Amount" := Amount - "Commision Amount";
            end;

            if "PAYE Code" <> '' then begin
                CalcFields("Telephone Allowance");
                if "Telephone Allowance" = true then
                    "PAYE Amount" := (0.3 * Amount) * 0.3
                else
                    "PAYE Amount" := (0.3 * Amount);

                // "PAYE Amount":=TaxCalc.CalculateTax(Rec,CalculationType::PAYE);
                RecPayTypes.Reset();
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                if RecPayTypes.Find('-') then
                    if RecPayTypes."Use PAYE Table" = true then begin
                        VitalSetup.FindFirst();
                        curReliefPersonal := VitalSetup."Tax Relief";
                        "PAYE Amount" := prPayroll.fnGetEmployeePaye(Amount) - curReliefPersonal;
                    end;
                TotalTax := TotalTax + "PAYE Amount";
            end;
        end;

        "Net Amount" := Amount - TotalTax;
        Validate("Net Amount");
    end;

    procedure PayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line";
    begin
        PayLine.Reset();
        //PayLine.SETRANGE(No,No);
        exit(PayLine.FindFirst());
    end;

    local procedure CalculateVoteBalance()
    var
        BudgetControl: Record "Budgetary Control Setup";
    begin
        BudgetControl.Get();
        SetFilter("Date Filter", '%1..%2', BudgetControl."Current Budget Start Date", BudgetControl."Current Budget End Date");
        CalcFields("Budgeted Amount");
        CalcFields("Committed Amount");
        CalcFields("Actual Expenditure");
    end;
}
