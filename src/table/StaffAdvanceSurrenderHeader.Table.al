Table 85015 "Staff Advance Surrender Header"
{
    // DrillDownPageID = UnknownPage70135177;
    //  LookupPageID = UnknownPage70135177;

    fields
    {
        field(50000; No; Code[20])
        {
            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    GenLedgerSetup.Get();
                    NoSeriesMgt.TestManual(GenLedgerSetup."Staff Advance Surrender No");
                    "No. Series" := '';
                end;
            end;
        }
        field(50001; "Surrender Date"; Date)
        {
        }
        field(50002; Type; Code[20])
        {
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

                    //Banks
                    if RecPayTypes."Account Type" = RecPayTypes."account type"::"Bank Account" then begin
                        //RecPayTypes.TESTFIELD(RecPayTypes."G/L Account");
                        "Account No." := RecPayTypes."Bank Account";
                        Validate("Account No.");
                    end;
                end;

                //VALIDATE("Account No.");
            end;
        }
        field(50003; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Custom 1","Custom 2","Custom 3","Custom 4","Custom 5";
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
            // TableRelation = "Cash Payments Header";
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
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                /*
                "Account Name":='';
                RecPayTypes.RESET;
                RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);

                IF "Account Type" IN ["Account Type"::"G/L Account","Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"]
                THEN

                CASE "Account Type" OF
                  "Account Type"::"G/L Account":
                    BEGIN
                      GLAcc.GET("Account No.");
                      "Account Name":=GLAcc.Name;
                      "VAT Code":=RecPayTypes."VAT Code";
                      "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                      "Global Dimension 1 Code":='';
                    END;
                  "Account Type"::Customer:
                    BEGIN
                      Cust.GET("Account No.");
                      "Account Name":=Cust.Name;
                //      "VAT Code":=Cust."Default Withholding Tax Code";
                //      "Withholding Tax Code":=Cust."Default Withholding Tax Code";
                      "Global Dimension 1 Code":=Cust."Global Dimension 1 Code";
                    END;
                  "Account Type"::Vendor:
                    BEGIN
                      Vend.GET("Account No.");
                      "Account Name":=Vend.Name;
                //      "VAT Code":=Vend."Default VAT Code";
                //      "Withholding Tax Code":=Vend."Default Withholding Tax Code";
                      "Global Dimension 1 Code":=Vend."Global Dimension 1 Code";
                    END;
                  "Account Type"::"Bank Account":
                    BEGIN
                      BankAcc.GET("Account No.");
                      "Account Name":=BankAcc.Name;
                      "VAT Code":=RecPayTypes."VAT Code";
                      "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                      "Global Dimension 1 Code":=BankAcc."Global Dimension 1 Code";
                    END;
                    {
                  "Account Type"::"Fixed Asset":
                    BEGIN
                      FA.GET("Account No.");
                      "Account Name":=FA.Description;
                      "VAT Code":=FA."Default VAT Code";
                      "Withholding Tax Code":=FA."Default Withholding Tax Code";
                       "Global Dimension 1 Code":=FA."Global Dimension 1 Code";
                    END;
                    }
                END;
                */
            end;
        }
        field(50013; "No. Series"; Code[20])
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
        }
        field(50020; Remarks; Text[250])
        {
        }
        field(50021; "Transaction Name"; Text[100])
        {
        }
        field(50022; "Net Amount"; Decimal)
        {
        }
        field(50023; "Paying Bank Account"; Code[20])
        {
        }
        field(50024; Payee; Text[100])
        {
        }
        field(50025; "Global Dimension 1 Code"; Code[20])
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
        field(50026; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin

                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Global Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name
            end;
        }
        field(50027; "Bank Account No"; Code[20])
        {
        }
        field(50028; "Cashier Bank Account"; Code[20])
        {
        }
        field(50029; Status; Option)
        {
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook,"Pending Approval",Approved;
        }
        field(50030; Grouping; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(50031; "Payment Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(50032; "Bank Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(50033; "PV Type"; Option)
        {
            OptionMembers = Normal,Other;
        }
        field(50034; "Apply to ID"; Code[20])
        {
        }
        field(50035; "Imprest Issue Date"; Date)
        {
        }
        field(50036; Surrendered; Boolean)
        {
        }
        field(50037; "Imprest Issue Doc. No"; Code[20])
        {
            Caption = 'Advance Issue Doc. No';
            TableRelation = "Staff Advance Header"."No." where(Posted = const(true),
                                                                "Account No." = field("Account No."),
                                                                "Surrender Status" = const(" "));

            trigger OnValidate()
            begin

                /*Copy the details from the payments header tableto the imprest surrender table to enable the user work on the same document*/
                /*Retrieve the header details using the get statement*/

                PayHeader.Reset();
                PayHeader.Get(Rec."Imprest Issue Doc. No");

                /*Copy the details to the user interface*/
                "Paying Bank Account" := PayHeader."Paying Bank Account";
                Payee := PayHeader.Payee;
                PayHeader.CalcFields(PayHeader."Total Net Amount");
                Amount := PayHeader."Total Net Amount";
                "Amount Surrendered LCY" := PayHeader."Total Net Amount LCY";
                //Currencies
                "Currency Factor" := PayHeader."Currency Factor";
                "Currency Code" := PayHeader."Currency Code";

                "Date Posted" := PayHeader."Date Posted";
                "Global Dimension 1 Code" := PayHeader."Global Dimension 1 Code";
                Validate("Global Dimension 1 Code");
                "Shortcut Dimension 2 Code" := PayHeader."Shortcut Dimension 2 Code";
                Validate("Shortcut Dimension 2 Code");
                "Shortcut Dimension 3 Code" := PayHeader."Shortcut Dimension 3 Code";
                Dim3 := PayHeader.Dim3;
                "Shortcut Dimension 4 Code" := PayHeader."Shortcut Dimension 4 Code";
                Dim4 := PayHeader.Dim4;
                "Imprest Issue Date" := PayHeader.Date;

                //Get Line No
                if ImpSurrLine.FindLast() then
                    LineNo := ImpSurrLine."Line No." + 1
                else
                    LineNo := LineNo + 1;

                /*Copy the detail lines from the imprest details table in the database*/
                PayLine.Reset();
                PayLine.SetRange(PayLine.No, "Imprest Issue Doc. No");
                if PayLine.Find('-') then /*Copy the lines to the line table in the database*/

                    repeat
                        ImpSurrLine.Init();
                        ImpSurrLine."Surrender Doc No." := Rec.No;
                        ImpSurrLine."Account No:" := PayLine."Account No:";
                        ImpSurrLine."Imprest Type" := PayLine."Advance Type";
                        ImpSurrLine.Validate(ImpSurrLine."Account No:");
                        ImpSurrLine."Account Name" := PayLine."Account Name";
                        ImpSurrLine.Amount := PayLine.Amount;
                        ImpSurrLine."Due Date" := PayLine."Due Date";
                        ImpSurrLine."Advance Holder" := PayLine."Advance Holder";
                        ImpSurrLine."Actual Spent" := PayLine."Actual Spent";
                        ImpSurrLine."Apply to" := PayLine."Apply to";
                        ImpSurrLine."Apply to ID" := PayLine."Apply to ID";
                        ImpSurrLine."Surrender Date" := PayLine."Surrender Date";
                        ImpSurrLine.Surrendered := PayLine.Surrendered;
                        ImpSurrLine."Cash Receipt No" := PayLine."M.R. No";
                        ImpSurrLine."Date Issued" := PayLine."Date Issued";
                        ImpSurrLine."Type of Surrender" := PayLine."Type of Surrender";
                        ImpSurrLine."Dept. Vch. No." := PayLine."Dept. Vch. No.";
                        ImpSurrLine."Currency Factor" := PayLine."Currency Factor";
                        ImpSurrLine."Currency Code" := PayLine."Currency Code";
                        ImpSurrLine."Imprest Req Amt LCY" := PayLine."Amount LCY";
                        ImpSurrLine."Budgetary Control A/C" := PayLine."Budgetary Control A/C";
                        ImpSurrLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                        ImpSurrLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                        ImpSurrLine."Shortcut Dimension 3 Code" := PayLine."Shortcut Dimension 3 Code";
                        ImpSurrLine."Shortcut Dimension 4 Code" := PayLine."Shortcut Dimension 4 Code";
                        ImpSurrLine."Line on Original Document" := true;
                        LineNo += 1;
                        ImpSurrLine."Line No." := LineNo;
                        ImpSurrLine.Insert();
                    until PayLine.Next() = 0;
            end;
        }
        field(50038; "Vote Book"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50039; "Total Allocation"; Decimal)
        {
        }
        field(50040; "Total Expenditure"; Decimal)
        {
        }
        field(50041; "Total Commitments"; Decimal)
        {
        }
        field(50042; Balance; Decimal)
        {
        }
        field(50043; "Balance Less this Entry"; Decimal)
        {
        }
        field(50044; "Petty Cash"; Boolean)
        {
        }
        field(50045; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name
            end;
        }
        field(50046; "Function Name"; Text[50])
        {
        }
        field(50047; "Budget Center Name"; Text[50])
        {
        }
        field(50048; "User ID"; Code[20])
        {
            TableRelation = User."User Security ID";
        }
        field(50049; "Issue Voucher Type"; Option)
        {
            OptionMembers = " ","Cash Voucher","Payment Voucher";
        }
        field(50050; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 3);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name
            end;
        }
        field(50051; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 4);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name
            end;
        }
        field(50052; Dim3; Text[250])
        {
        }
        field(50053; Dim4; Text[250])
        {
        }
        field(50054; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50055; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(50056; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin

                TestField(Status, Status::Pending);
                //  if not UserMgt.CheckRespCenter(1, "Shortcut Dimension 3 Code") then
                //    Error(
                //   Text001,
                //    RespCenter.TableCaption, UserMgt.GetPurchasesFilter);
            end;
        }
        field(50057; "Amount Surrendered LCY"; Decimal)
        {
            CalcFormula = sum("Imprest Surrender Details"."Imprest Req Amt LCY" where("Surrender Doc No." = field(No)));
            FieldClass = FlowField;
        }
        field(50058; "Actual Spent"; Decimal)
        {
            // CalcFormula = sum ("Staff Advanc Surrender Details"."Actual Spent" where("Surrender Doc No." = field(No)));
            FieldClass = FlowField;
        }
        field(50059; "No. Printed"; Integer)
        {
        }
        field(50060; "Surrender Posting Date"; Date)
        {
            trigger OnValidate()
            begin
                //Changed to ensure Posting date is not less than the Surrender Date entered
                if "Surrender Posting Date" < "Surrender Date" then
                    Error('The Surrender Posting Date cannot be lesser than the Surrender Date');
            end;
        }
        field(50061; "Total Amount Advanced"; Decimal)
        {
        }
        field(50062; "Allow Overexpenditure"; Boolean)
        {
            Editable = false;
        }
        field(50063; "Open for Overexpenditure by"; Code[20])
        {
            Editable = false;
        }
        field(50064; "Date opened for OvExpenditure"; Date)
        {
            Editable = false;
        }
        field(50065; "Cash Receipt Amount"; Decimal)
        {
            CalcFormula = sum("Staff Advanc Surrender Details"."Cash Receipt Amount" where("Surrender Doc No." = field(No)));
            FieldClass = FlowField;
        }
        field(50066; "Actual Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("Staff Advanc Surrender Details"."Amount LCY" where("Surrender Doc No." = field(No)));
            FieldClass = FlowField;
        }
        field(50067; "Commitment Status"; Boolean)
        {
        }
        field(50068; "Difference Owed"; Decimal)
        {
            CalcFormula = sum("Staff Advanc Surrender Details"."Difference Owed" where("Surrender Doc No." = field(No)));
            FieldClass = FlowField;
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

    trigger OnDelete()
    begin
        if Status = Status::Posted then
            Error('Cannot Delete Document is already Posted');
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
            GenLedgerSetup.Get();

            GenLedgerSetup.TestField(GenLedgerSetup."Staff Advance Surrender No");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Staff Advance Surrender No", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Account Type" := "account type"::Customer;
        "Surrender Date" := Today;
        Cashier := UserId;
        Validate(Cashier);
        /*
        IF UserSetup.GET(USERID)THEN BEGIN
        UserSetup.TESTFIELD(UserSetup."Imprest Account");
        "Account No.":=UserSetup."Imprest Account";
        VALIDATE("Account No.");
        END ELSE
            ERROR('User must be setup under User Setup and their respective Account Entered');
         */
    end;

    trigger OnModify()
    begin
        if Status = Status::Posted then
            Error('Cannot Modify Document is already Posted');
    end;

    var
        GenLedgerSetup: Record "Cash Office Setup";
        DimVal: Record "Dimension Value";
        RecPayTypes: Record "Receipts and Payment Types";
        PayHeader: Record "Staff Advance Header";
        PayLine: Record "Staff Advance Lines";
        ImpSurrLine: Record "Staff Advanc Surrender Details";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNo: Integer;
}
