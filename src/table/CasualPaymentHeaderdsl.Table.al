Table 85477 "Casual Payment Header.dsl"
{
    fields
    {
        field(50000; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CashMgtSetup.Get();
                    CashMgtSetup.TestField("Casual Payment Nos");
                    "No. Series" := '';
                    NoSeriesMgt.GetNextNo(CashMgtSetup."Casual Payment Nos");
                    Validate("Salary Account");
                end;
            end;
        }
        field(50001; "Salary Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                if BankAccount.Get("Salary Account") then begin
                    BankAccount.TestField(Blocked, false);
                    "Salary Acc Name" := BankAccount.Name;
                end;
            end;
        }
        field(50002; "Salary Acc Name"; Code[100])
        {
        }
        field(50003; "Account Type"; Option)
        {
            Caption = 'Account Type';
            Editable = false;
            InitValue = "G/L ACCOUNT";
            OptionCaption = 'G/L ACCOUNT';
            OptionMembers = "G/L ACCOUNT";
        }
        field(50004; "P.A.Y.E Acc"; Code[20])
        {
            Caption = 'P.A.Y.E Acc';
            TableRelation = if ("Account Type" = const("G/L ACCOUNT")) "G/L Account";

            trigger OnValidate()
            begin
                Vendor.Reset();
                Vendor.SetRange(Vendor."No.", "P.A.Y.E Acc");
                if Vendor.Find('-') then
                    Payee := Vendor.Name;
                Validate("Currency Code", Vendor."Currency Code");
            end;
        }
        field(50005; Payee; Text[50])
        {
        }
        field(50006; "Total Basic Amount"; Decimal)
        {
            CalcFormula = sum("Casual Payment Lines"."Basic Amount" where("Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Posting Date"; Date)
        {
        }
        field(50008; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(50009; Posted; Boolean)
        {
            Editable = true;
        }
        field(50010; "No. Series"; Code[20])
        {
        }
        field(50011; Remarks; Text[30])
        {
        }
        field(50012; "Cheque No."; Code[20])
        {
        }
        field(50013; "Cheque Date"; Date)
        {
        }
        field(50014; "Total To Pay"; Decimal)
        {
            CalcFormula = sum("Casual Payment Lines"."Basic Amount" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50015; "Payment Method"; Code[10])
        {
            TableRelation = "Payment Method".Code;
        }
        field(50016; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,GLJournal,Item Journal,Phys. Inventory Journal,FAJournal,Petty Cash,Advance,IOU,User (Store) Requisition,Store Manifest,Non-Conforming Products,Cooler Allocation,FA Reclass. Journal,Purchase Requisition,PayVoucher,Leave';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",GLJournal,"Item Journal","Phys. Inventory Journal",FAJournal,"Petty Cash",Advance,IOU,"User (Store) Requisition","Store Manifest","Non-Conforming Products","Cooler Allocation","FA Reclass. Journal","Purchase Requisition",PayVoucher,Leave;
        }
        field(50017; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Released,Pending Approval,Pending Action';
            OptionMembers = Open,Released,"Pending Approval","Pending Action";
        }
        field(50018; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
        }
        field(50019; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(50020; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50021; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;

            trigger OnLookup()
            begin
                ShowDocDim();
            end;
        }
        field(50022; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(50023; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50024; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50025; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(50026; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(50027; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(50028; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(50029; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(8,"Shortcut Dimension 8 Code");
            end;
        }
        field(50030; WTAXPosted; Boolean)
        {
        }
        field(50031; "Total PAYE"; Decimal)
        {
            CalcFormula = sum("Casual Payment Lines"."PAYE Amount" where("Document No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50032; "Net Payable"; Decimal)
        {
            CalcFormula = sum("Casual Payment Lines"."Net Pay" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50033; "Total NHIF"; Decimal)
        {
            CalcFormula = sum("Casual Payment Lines"."NHIF Amount" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50034; "Total NSSF"; Decimal)
        {
            CalcFormula = sum("Casual Payment Lines"."NSSF Amount" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50035; "NSSF Account"; Code[20])
        {
            Caption = 'NSSF Account';
            TableRelation = if ("Account Type" = const("G/L ACCOUNT")) "G/L Account";
        }
        field(50036; NHIFAccount; Code[20])
        {
            Caption = 'NHIF Account';
            TableRelation = if ("Account Type" = const("G/L ACCOUNT")) "G/L Account";
        }
        field(50037; "Salaries&Wages A/c"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50038; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(50039; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Casual,Part-Timer,Permanent';
            OptionMembers = ,Casual,"Part-Timer",Permanent;
        }
        field(50040; KUSU; Decimal)
        {
            CalcFormula = sum("Casual Payment Lines"."KUSU Amount" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50041; "Pension Total"; Decimal)
        {
            CalcFormula = sum("Casual Payment Lines"."Pension Amount" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50042; "UASU Total"; Decimal)
        {
            CalcFormula = sum("Casual Payment Lines"."UASU Amount" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.", "Payroll Period", "Employee Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        CashMgtSetup.Get();

        if "No." = '' then
            NoSeriesMgt.GetNextNo(CashMgtSetup."Casual Payment Nos");
        "Document Type" := "document type"::PayVoucher;
        Posted := false;
        "Posting Date" := Today;
        "User ID" := UserId;
        PayrollPosting.Get('PAYROLL');
        "Salary Account" := PayrollPosting."Net Salary Payable";
        "P.A.Y.E Acc" := PayrollPosting."Income Tax Account";
        "NSSF Account" := PayrollPosting."SHIF Employee Account";
        NHIFAccount := PayrollPosting."SHIF Employee Account";
        "Salaries&Wages A/c" := PayrollPosting."Salary Account";
        //(70134982)
    end;

    var
        BankAccount: Record "Bank Account";
        CashMgtSetup: Record "Cash Office Setup";
        Options: Record "Cash Office Setup";
        PayrollPosting: Record "prEmployee Posting Group";
        Vendor: Record Vendor;
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Text064: label 'You may have changed a dimension.\\Do you want to update the lines?';

    procedure PaymentLinesExist(): Boolean
    begin
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20]; Type5: Integer; No5: Code[20])
    begin
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";

        if "No." <> '' then
            Modify();

        if OldDimSetID <> "Dimension Set ID" then
            Modify();
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify();

            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        PaymentLines: Record "Casual Payment Lines";
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.

        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not Confirm(Text064) then
            exit;

        PaymentLines.Reset();
        PaymentLines.SetRange(PaymentLines."Document No.", "No.");
        PaymentLines.LockTable();
        if PaymentLines.Find('-') then
            repeat
                //NewDimSetID := DimMgt.GetDeltaDimSetID(PaymentLines."Dimension Set ID",NewParentDimSetID,OldParentDimSetID);
                if PaymentLines."Dimension Set ID" <> NewDimSetID then begin
                    PaymentLines."Dimension Set ID" := NewDimSetID;
                    //DimMgt.UpdateGlobalDimFromDimSetID(
                    //PaymentLines."Dimension Set ID",PaymentLines."Shortcut Dimension 1 Code",PaymentLines."Shortcut Dimension 2 Code");
                    PaymentLines.Modify();
                end;
            until PaymentLines.Next() = 0;
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        //DimMgt.GetShortcutDimensions("Dimension Set ID",ShortcutDimCode);
        Options.Get();
        /**
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID",STRSUBSTNO('%1 %2 %3',Options."Payment Template Name",Options."Payment Batch Name"),
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        **/
    end;

    procedure GetSourceCode(): Code[10]
    // PaySetup: Record UnknownRecord50101;
    begin
        /*IF Options.GET THEN BEGIN
          EXIT(Options."Payment Source Code");
        END;*/
    end;

    procedure CopyDimensionsToLine()
    begin
    end;

    procedure DeletePayLines(PayHeader: Record "Casual Payment Header")
    begin
        /*PayLines.RESET;
        PayLines.SETRANGE(PayLines."Document No.",PayHeader."No.");
        IF PayLines.FINDFIRST THEN REPEAT
          PayLines.DeleteEncumCommitLines(PayLines);
        UNTIL PayLines.NEXT = 0;*/
    end;

    procedure PostPV()
    begin
        /*//TESTFIELD("Currency Code");
        IF CONFIRM(Text1000,FALSE) = FALSE THEN EXIT;

        CALCFIELDS("Total To Pay");
        //CALCFIELDS(Amount);
        //....CHECK IF PAYMENT VOUCHER IS POSTED...............
        IF Posted=TRUE THEN
          BEGIN
              ERROR(Text003,"No.");
          END;

          //...............CHECK IF LINES TO BE POSTED EXIST................
        IF NOT PaymentLinesExist THEN
          ERROR(Text002);

        //ApprovalMgt.PrePostApprovalCheckPV(Rec);

        //CHECK IF THERE IS A DIFFERENCE IS POSTING DATES BETWEEN HEADER AND LINES
        WtaxAmount:=0;
        PaymentLine.RESET;
        PaymentLine.SETRANGE(PaymentLine."Document No.","No.");
        //PaymentLine.SETRANGE(PaymentLine."Invoice To Pay",TRUE);
        IF PaymentLine.FIND('-') THEN REPEAT

          //PaymentLine.CompareHeaderDates;

          WtaxAmount:=WtaxAmount+PaymentLine."WTax Amount";
        UNTIL PaymentLine.NEXT = 0;
        //......DELETE ANY UNSELECTED LINES......

        //..........RETRIEVE JOURNAL TEMPLATE AND BATCH..............
        CashMgtSetup.GET();
        CashMgtSetup.TESTFIELD(CashMgtSetup."Payment Template Name");
        CashMgtSetup.TESTFIELD(CashMgtSetup."Payment Batch Name");
        CashMgtSetup.TESTFIELD(CashMgtSetup."Payment Source Code");
        CashMgtSetup.TESTFIELD(CashMgtSetup."Payment Reason Code");

        JournalTemplate:=CashMgtSetup."Payment Template Name";
        JournalBatch:=CashMgtSetup."Payment Batch Name";

        //....... DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name",JournalTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name",JournalBatch);
        GenJnlLine.DELETEALL;

        //.................INSERT THE BANK TRANSACTION................

        GenJnlLine.INIT;
        GenJnlLine.VALIDATE(GenJnlLine."Currency Code",PaymentHeader."Currency Code");
        GenJnlLine."Journal Template Name":=CashMgtSetup."Payment Template Name";
        GenJnlLine."Journal Batch Name":=CashMgtSetup."Payment Batch Name";
        GenJnlLine."Source Code":='PAYMENTJNL';
        GenJnlLine."Posting Date":="Posting Date";
        GenJnlLine."Document No.":="No.";
         GenJnlLine."External Document No." := "Cheque No.";//Added to show check no as ext. doc no.
        GenJnlLine."Line No.":=GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type":=GenJnlLine."Account Type"::"Bank Account";
        GenJnlLine."Account No.":="Salary Account";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        CALCFIELDS("Total To Pay");

        {IF PaymentLine."WTax Amount"<=0 THEN
        GenJnlLine.Amount:=-("Total To Pay")
        ELSE }
          GenJnlLine.Amount:=-("Total To Pay"-WtaxAmount);

        GenJnlLine.VALIDATE(GenJnlLine.Amount);

        IF Remarks <> '' THEN
          GenJnlLine.Description:=Remarks
        ELSE
          GenJnlLine.Description:=Payee + ': PV No-' + Rec."No.";
        IF GenJnlLine.Amount<>0 THEN
        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account Type",GenJnlLine."Bal. Account Type"::Vendor);
        GenJnlLine."Reason Code" := CashMgtSetup."Payment Reason Code";
        GenJnlLine."Source Code" := CashMgtSetup."Payment Source Code";

        //Validate dimensionsSH
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code","Shortcut Dimension 1 Code");
        GenJnlLine.INSERT;

        //.........INSERT VENDOR TRANSACTIONS...............

        PaymentLine.RESET;
        PaymentLine.SETRANGE(PaymentLine."Document No.","No.");
        PaymentLine.SETRANGE(PaymentLine."Invoice To Pay",TRUE);
        IF PaymentLine.FIND('-') THEN BEGIN
            REPEAT
                  //CHECK IF VAT GROUPS ARE SET AND THAT ITS FOR G/L EXPENSES ONLY
                  IF PaymentLine."Post VAT Amount" THEN BEGIN //Posting VAT
                    IF ((PaymentLine."VAT Bus. Posting Group" <> '')
                      AND (PaymentLine."Account Type" <> PaymentLine."Account Type"::"0")) THEN
                        ERROR(Err100);
                    IF ((PaymentLine."VAT Prod. Posting Group" <> '')
                      AND (PaymentLine."Account Type" <> PaymentLine."Account Type"::"0")) THEN
                        ERROR(Err100);
                    IF (PaymentLine."VAT Prod. Posting Group" <> '') AND (PaymentLine."VAT Bus. Posting Group" <> '') THEN BEGIN
                       VATSetup.GET(PaymentLine."VAT Bus. Posting Group",PaymentLine."VAT Prod. Posting Group");
                       IF VATSetup."VAT %" = 0 THEN ERROR(Err200,VATSetup."VAT Identifier");
                    END;
                  END; //End Posting VAT
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name":=CashMgtSetup."Payment Template Name";
                    GenJnlLine."Journal Batch Name":=CashMgtSetup."Payment Batch Name";
                    GenJnlLine."Source Code":='PAYMENTJNL';
                    GenJnlLine."Posting Date":="Posting Date";
                    GenJnlLine."Document No.":=PaymentLine."Document No.";
                    GenJnlLine."External Document No." := "Cheque No.";//Added to show check no as ext. doc no.
                    GenJnlLine."Line No.":=GenJnlLine."Line No." + 1000;
                    GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                    GenJnlLine."Account Type":=PaymentLine."Account Type";
                    GenJnlLine."Account No.":=PaymentLine."Account No.";
                    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    GenJnlLine."Applies-to Doc. Type":=PaymentLine."Applies-to Doc. Type";
                    GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                    GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                    GenJnlLine.Description:=PaymentLine.Description;
                    GenJnlLine.Amount:=PaymentLine."Line Amount";

                    GenJnlLine.VALIDATE(GenJnlLine.Amount);
                    GenJnlLine."VAT Bus. Posting Group":='';
                    GenJnlLine."VAT Prod. Posting Group":='';
                    IF PaymentLine."Post VAT Amount" THEN BEGIN //Posting VAT
                      IF PaymentLine."VAT Amount" <> 0 THEN BEGIN
                        GenJnlLine."VAT Bus. Posting Group":= PaymentLine."VAT Bus. Posting Group";
                        GenJnlLine."VAT Prod. Posting Group":= PaymentLine."VAT Prod. Posting Group";
                      END;
                    END; //End Posting VAT
                    GenJnlLine.VALIDATE("VAT Bus. Posting Group");
                    GenJnlLine.VALIDATE("VAT Prod. Posting Group");
                    GenJnlLine."Reason Code" := CashMgtSetup."Payment Reason Code";
                    GenJnlLine."Source Code" := CashMgtSetup."Payment Source Code";
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
                    GenJnlLine.VALIDATE(GenJnlLine."Currency Code",PaymentLine."Currency Code");
                    //Validate dimensions
                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code","Shortcut Dimension 1 Code");
                    IF GenJnlLine.Amount <>0 THEN
                      GenJnlLine.INSERT;

                  //------------------------******POST WITH HOLDING TAX ENTRIES******----------------------------
                      IF PaymentLine."WTax Amount" <> 0 THEN BEGIN
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name":=CashMgtSetup."Payment Template Name";
                        GenJnlLine."Journal Batch Name":=CashMgtSetup."Payment Batch Name";
                        GenJnlLine."Source Code":='PAYMENTJNL';
                        GenJnlLine."Posting Date":="Posting Date";
                        GenJnlLine."Document No.":=PaymentLine."Document No.";
                         GenJnlLine."External Document No." := "Cheque No.";//Added to show check no as ext. doc no.
                        GenJnlLine."Line No.":=GenJnlLine."Line No." + 1000;
                        GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
                        GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                        GenJnlLine."Account No.":='200701';
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                        GenJnlLine.VALIDATE("Bal. Account Type");
                        GenJnlLine."Bal. Account No." := '';
                        GenJnlLine.VALIDATE("Bal. Account No.");
                       GenJnlLine."Applies-to Doc. Type":=PaymentLine."Applies-to Doc. Type";                   //734500
                       GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                       GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                        GenJnlLine.VALIDATE(GenJnlLine."Currency Code",PaymentLine."Currency Code");
                        IF GLAcc.GET(VATSetup."Purchase VAT Account") THEN
                          GenJnlLine.Description:=GLAcc.Name
                        ELSE
                          GenJnlLine.Description:='WithHolding Tax on Payment';
                        GenJnlLine.Amount:=-PaymentLine."WTax Amount";
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine."Reason Code" := CashMgtSetup."Payment Reason Code";
                        GenJnlLine."Source Code" := CashMgtSetup."Payment Source Code";
                        //Validate dimensions
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code","Shortcut Dimension 1 Code");
                        IF GenJnlLine.Amount <>0 THEN
                          GenJnlLine.INSERT;
                  END;
                  //------------------------******POST WITH HOLDING TAX ENTRIES******----------------------------
            UNTIL PaymentLine.NEXT=0;
          END;

        //............POST THE PAYMENT VOUCHER.............
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name",CashMgtSetup."Payment Template Name");
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name",CashMgtSetup."Payment Batch Name");
        IF GenJnlLine.FIND('-') THEN
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnlLine);

        //.......MODIFY HEADER FIELDS..................
        RESET;
        GLEntry.RESET;
        GLEntry.SETRANGE(GLEntry."Document No.","No.");
        GLEntry.SETRANGE(GLEntry."Posting Date","Posting Date");
        IF GLEntry.FIND('-') THEN BEGIN
          Posted:=TRUE;
          MODIFY;
          //......MODIFY LINE FIELDS................
          PaymentLine.RESET;
          PaymentLine.SETRANGE(PaymentLine."Document No.","No.");
          PaymentLine.SETRANGE(PaymentLine."Invoice To Pay",TRUE);
          IF PaymentLine.FIND('-') THEN
              REPEAT
                PaymentLine.Posted:=TRUE;
                //BudgetManager.PayVoucherEncumberSingleLine(PaymentLine,EncumbEntry.Signage::Negative);
                PaymentLine.MODIFY;
              UNTIL PaymentLine.NEXT=0;
        END;
        */
    end;

    procedure PostWTAX()
    begin
    end;
}
