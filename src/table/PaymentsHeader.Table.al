Table 85123 "Payments Header"
{
    DrillDownPageID = "Payment List";
    LookupPageID = "Payment List";

    fields
    {
        field(50000; "No."; Code[20])
        {
            Description = 'Stores the reference of the payment voucher in the database';
            NotBlank = false;
        }
        field(50001; Date; Date)
        {
            Description = 'Stores the date when the payment voucher was inserted into the system';

            trigger OnValidate()
            begin
                if PayLinesExist() then
                    Error('You first need to delete the existing Payment lines before changing the Currency Code'
                    )
                else begin
                    "Paying Bank Account" := '';
                    Validate("Paying Bank Account");
                end;
                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor();

                if "Currency Code" <> xRec."Currency Code" then
                    UpdateCurrencyFactor()
                else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor();

                //Update Payment Lines
                UpdateLines();
            end;
        }
        field(50002; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50003; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Enabled = true;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if PayLinesExist() then
                    Error('You first need to delete the existing Payment lines before changing the Currency Code'
                    )
                else begin
                    "Paying Bank Account" := '';
                    Validate("Paying Bank Account");
                end;
                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor();

                if "Currency Code" <> xRec."Currency Code" then
                    UpdateCurrencyFactor()
                else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor();

                //Update Payment Lines
                UpdateLines();
            end;
        }
        field(50004; Payee; Text[100])
        {
            Description = 'Stores the name of the person who received the money';
        }
        field(50005; "On Behalf Of"; Text[100])
        {
            Description = 'Stores the name of the person on whose behalf the payment voucher was taken';
        }
        field(50006; Cashier; Code[50])
        {
            Description = 'Stores the identifier of the cashier in the database';

            trigger OnValidate()
            begin
                /*
                 UserDept.RESET;
                UserDept.SETRANGE(UserDept.UserID,Cashier);
                IF UserDept.FIND('-') THEN
                  //"Global Dimension 1 Code":=UserDept.Department;
                */
            end;
        }
        field(50007; Posted; Boolean)
        {
            Description = 'Stores whether the payment voucher is posted or not';
        }
        field(50008; "Date Posted"; Date)
        {
            Description = 'Stores the date when the payment voucher was posted';
        }
        field(50009; "Time Posted"; Time)
        {
            Description = 'Stores the time when the payment voucher was posted';
        }
        field(50010; "Posted By"; Code[30])
        {
            Description = 'Stores the name of the person who posted the payment voucher';
        }
        field(50011; "Total Payment Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line".Amount where(No = field("No.")));
            Description = 'Stores the amount of the payment voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Paying Bank Account"; Code[20])
        {
            Description = 'Stores the name of the paying bank account in the database';
            TableRelation = if ("Payment Type" = const(Normal)) "Bank Account"."No." where("Bank Type" = filter(Normal | "Mobile Collection"))
            else
            if ("Payment Type" = const("Petty Cash")) "Bank Account"."No." where("Currency Code" = field("Currency Code"),
                                                                                                     "Bank Type" = const(Cash));

            trigger OnValidate()
            begin
                BankAcc.Reset();
                "Bank Name" := '';

                if BankAcc.Get("Paying Bank Account") then begin
                    //BankAcc.TESTFIELD(BankAcc."Last Pv No.");
                    //"Reference No.":=BankAcc."Last Pv No."+'-'+COPYSTR("No.",4,20);
                    //BankAcc."Last Pv No.":=INCSTR(BankAcc."Last Pv No.");
                    //BankAcc.MODIFY;
                    // IF "Pay Mode"="Pay Mode"::Cash THEN BEGIN
                    //  IF BankAcc.Test<>BankAcc.Test::"1" THEN
                    //    ERROR('This Payment can only be made against Banks Handling Cash');
                    // END;

                    "Bank Name" := BankAcc.Name;
                    "Currency Code" := BankAcc."Currency Code";
                    // VALIDATE("Currency Code");
                end;

                PLine.Reset();
                PLine.SetRange(PLine.No, "No.");
                PLine.SetRange(PLine."Account Type", PLine."account type"::"Bank Account");
                PLine.SetRange(PLine."Account No.", "Paying Bank Account");
                if PLine.FindFirst() then
                    Error(Text002);
            end;
        }
        field(50013; "Global Dimension 1 Code"; Code[30])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 1);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Function Name" := DimVal.Name;
                UpdateLines();
            end;
        }
        field(50014; Status; Option)
        {
            Description = 'Stores the status of the record in the database';
            OptionMembers = Pending,"1st Approval","2nd Approval","Cheque Printing",Posted,Cancelled,Checking,VoteBook,"Pending Approval",Approved;

            trigger OnValidate()
            var
                ComRec: Record Committment;
            begin
                if Status = Status::Pending then begin
                    ComRec.reset();
                    ComRec.setrange("Document No.", "No.");
                    if ComRec.find('-') then
                        ComRec.DeleteAll();
                end;
            end;
        }
        field(50015; "Payment Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash",Cash,"Fixed Deposit",SMPA,"Chq Collection";
        }
        field(50016; "Shortcut Dimension 2 Code"; Code[30])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                if DimVal.Find('-') then
                    "Budget Center Name" := DimVal.Name;
                UpdateLines()
            end;
        }
        field(50017; "Function Name"; Text[100])
        {
            Description = 'Stores the name of the function in the database';
        }
        field(50018; "Budget Center Name"; Text[150])
        {
            Description = 'Stores the name of the budget center in the database';
        }
        field(50019; "Bank Name"; Text[100])
        {
            Description = 'Stores the description of the paying bank account in the database';
        }
        field(50020; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(50021; Select; Boolean)
        {
            Description = 'Enables the user to select a particular record';
        }
        field(50022; "Total VAT Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line"."VAT Amount" where(No = field("No.")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(50023; "Total Witholding Tax Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line"."Withholding Tax Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Total Net Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line"."Net Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Current Status"; Code[20])
        {
            Description = 'Stores the current status of the payment voucher in the database';
        }
        field(50026; "Cheque No."; Code[20])
        {
        }
        field(50027; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Letter of Credit","M-Pesa","Custom 4","Custom 5";
        }
        field(50028; "Payment Release Date"; Date)
        {
            trigger OnValidate()
            begin
                //Changed to ensure Release date is not less than the Date entered
                if "Payment Release Date" < Date then
                    Error('The Payment Release Date cannot be lesser than the Document Date');
            end;
        }
        field(50029; "No. Printed"; Integer)
        {
        }
        field(50030; "VAT Base Amount"; Decimal)
        {
        }
        field(50031; "Exchange Rate"; Decimal)
        {
        }
        field(50032; "Currency Reciprical"; Decimal)
        {
        }
        field(50033; "Current Source A/C Bal."; Decimal)
        {
        }
        field(50034; "Cancellation Remarks"; Text[250])
        {
        }
        field(50035; "Register Number"; Integer)
        {
        }
        field(50036; "From Entry No."; Integer)
        {
        }
        field(50037; "To Entry No."; Integer)
        {
        }
        field(50038; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(50039; "Total Payment Amount LCY"; Decimal)
        {
            CalcFormula = sum("Payment Line"."NetAmount LCY" where(No = field("No.")));
            FieldClass = FlowField;
        }
        field(50040; "Document Type"; Option)
        {
            OptionMembers = "Payment Voucher","Petty Cash";
        }
        field(50041; "Shortcut Dimension 3 Code"; Code[20])
        {
            // Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 3);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name;
                UpdateLines()
            end;
        }
        field(50042; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 4);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name;
                UpdateLines()
            end;
        }
        field(50043; Dim3; Text[250])
        {
        }
        field(50044; Dim4; Text[250])
        {
        }
        field(50045; "Responsibility Center"; Code[50])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin

                // TestField(Status, Status::Pending);

                /*IF PayLinesExist THEN BEGIN
                  ERROR('You first need to delete the existing Payment lines before changing the Responsibility Center');
                END ELSE BEGIN
                  "Currency Code":='';
                  VALIDATE("Currency Code");
                  "Paying Bank Account":='';
                  VALIDATE("Paying Bank Account");
                END;

                */
                if not UserMgt.CheckRespCenter(1, "Responsibility Center") then
                    Error(
                      Text001,
                      RespCenter.TableCaption, UserMgt.GetPurchasesFilter());
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */
            end;
        }
        field(50046; "Cheque Type"; Option)
        {
            OptionCaption = ' ,Computer Check,Manual Check';
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(50047; "Total Retention Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line"."Retention  Amount" where(No = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50048; "Payment Narration"; Text[200])
        {
        }
        field(50049; "Total PAYE Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line"."PAYE Amount" where(No = field("No.")));
            FieldClass = FlowField;
        }
        field(50050; "Reference No."; Code[50])
        {
        }
        field(50051; "Cheque Printed"; Boolean)
        {
        }
        field(50052; "Apply to Document Type"; Option)
        {
            OptionCaption = ' ,Imprest,Claim';
            OptionMembers = " ",Imprest,Claim;
        }
        field(50053; "Apply to Document No"; Code[50])
        {
            TableRelation = if ("Apply to Document Type" = const(Imprest)) "Imprest Header"."No." where(Status = const(Approved),
                                                                                                       Posted = const(false))
            else
            if ("Apply to Document Type" = const(Claim)) "Staff Claims Header" where(Status = const(Approved),
                                                                                     Posted = const(false));

            trigger OnValidate()
            begin
                PLine.reset();
                PLine.setrange("No", "No.");
                if PLine.Find('-') then
                    PLine.Deleteall();

                if "Apply to Document Type" = "apply to document type"::Imprest then begin
                    if ImpH.Get("Apply to Document No") then begin
                        "Global Dimension 1 Code" := ImpH."Global Dimension 1 Code";
                        "Shortcut Dimension 2 Code" := ImpH."Shortcut Dimension 2 Code";
                        Validate("Shortcut Dimension 2 Code");
                        "Imprest No." := ImpH."No.";
                        Payee := ImpH.Payee;
                        "On Behalf Of" := ImpH.Payee;
                        "Payment Narration" := ImpH.Purpose;
                    end;

                    ImpLines.Reset();
                    ImpLines.SetRange(ImpLines.No, "Apply to Document No");
                    if ImpLines.Find('-') then
                        repeat
                            PLine.Init();
                            PLine.No := "No.";
                            PLine.Type := 'IMPREST';
                            PLine."Line No." := PLine."Line No." + 100;
                            PLine."Account No." := ImpLines."Imprest Holder";
                            PLine.Date := Today;
                            PLine."Account Type" := PLine."account type"::Customer;
                            PLine."Account Name" := ImpLines."Account Name";
                            PLine.Amount := ImpLines.Amount;
                            PLine.Validate(PLine.Amount);
                            PLine."Global Dimension 1 Code" := ImpLines."Global Dimension 1 Code";
                            PLine."Shortcut Dimension 2 Code" := PLine."Shortcut Dimension 2 Code";
                            PLine.Insert();
                        until ImpLines.Next() = 0;
                end;

                if "Apply to Document Type" = "apply to document type"::Claim then begin
                    if Claim.Get("Apply to Document No") then begin
                        "Global Dimension 1 Code" := Claim."Global Dimension 1 Code";
                        "Shortcut Dimension 2 Code" := Claim."Shortcut Dimension 2 Code";
                        Validate("Shortcut Dimension 2 Code");
                        "Claim No." := Claim."No.";
                        Payee := Claim.Payee;
                        "On Behalf Of" := Claim.Payee;
                        "Payment Narration" := Claim.Purpose;
                    end;
                    ClaimLines.Reset();
                    ClaimLines.SetRange(ClaimLines.No, "Apply to Document No");
                    if ClaimLines.Find('-') then
                        repeat
                            PLine.Init();
                            PLine.No := "No.";
                            PLine.Type := 'CLAIM';
                            PLine.Validate(PLine.Type);
                            PLine."Line No." := PLine."Line No." + 100;
                            PLine."Account No." := ClaimLines."Account No:";
                            PLine.Date := Today;
                            PLine."Account Type" := PLine."account type"::"G/L Account";
                            PLine."Account Name" := ClaimLines."Account Name";
                            PLine.Amount := ClaimLines.Amount;
                            PLine.Validate(PLine.Amount);
                            PLine."Global Dimension 1 Code" := ClaimLines."Global Dimension 1 Code";
                            PLine."Shortcut Dimension 2 Code" := ClaimLines."Shortcut Dimension 2 Code";
                            PLine.Insert();
                        until ClaimLines.Next() = 0;
                end;
            end;
        }
        field(50054; "Imprest No."; Code[20])
        {
        }
        field(50055; "Claim No."; Code[20])
        {
        }
        field(50056; "PF No"; Code[30])
        {
            NotBlank = true;
            TableRelation = Customer."No." where("Customer Posting Group" = filter(<> 'STUDENT'));

            trigger OnValidate()
            begin
                LecturerName := '';
                HREmployee.Reset();
                HREmployee.SetRange(HREmployee."No.", "PF No");
                if HREmployee.Find('-') then begin
                    LecturerName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";

                    "On Behalf Of" := LecturerName;
                end;

                if LecturerName = '' then begin
                    Cust.Reset();
                    Cust.SetRange(Cust."No.", "PF No");
                    if Cust.Find('-') then
                        "On Behalf Of" := Cust.Name;
                end;
            end;
        }
        field(50057; "Financial Period"; Code[20])
        {
            // TableRelation = "Financial Periods"."Period Code" where("Current Period" = filter(Yes));
        }
        field(50058; "Budgeted Amount"; Decimal)
        {
            Editable = false;
        }
        field(50059; "Actual Expenditure"; Decimal)
        {
            Editable = false;
        }
        field(50060; "Committed Amount"; Decimal)
        {
            Editable = false;
        }
        field(50061; "Budget Balance"; Decimal)
        {
            Editable = false;
        }
        field(50062; "Bank Criteria"; Option)
        {
            OptionCaption = ' ,Recurrent  Exp,Development Exp';
            OptionMembers = " ","Recurrent  Exp","Development Exp";
        }
        field(50063; "Contract No."; Integer)
        {
        }
        field(50064; "Contract Amount"; Decimal)
        {
        }
        field(50065; "Contract Balance"; Decimal)
        {
        }
        field(50066; "Certificate No."; Integer)
        {
        }
        field(50067; Reversed; Boolean)
        {
        }
        field(50068; "Total VAT Withholding Amount"; Decimal)
        {
            CalcFormula = sum("Payment Line"."VAT Withheld Amount" where(No = field("No.")));
            DecimalPlaces = 2 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50069; "Vendor No."; Code[30])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vend.Reset();
                Vend.SetRange(Vend."No.", "Vendor No.");
                if Vend.Find('-') then
                    "On Behalf Of" := Vend.Name;
            end;
        }
        field(50070; "Vendor Name"; Text[150])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            FieldClass = FlowField;
        }
        field(50071; "Posted Count"; Integer)
        {
            CalcFormula = count("G/L Entry" where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50072; "Payment Schedule No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Reversed PV"; Boolean)
        {
            CalcFormula = lookup("Bank Account Ledger Entry".Reversed where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50074; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR-Employee"."No.";
        }
        field(50075; "Dimension Set ID"; Integer)
        {
        }
        field(50076; "Doctors Batch No"; code[20])
        {
            TableRelation = "HMS Doctors Payment Batch".No;
            trigger OnValidate()
            begin

                PatientVisitNos.Reset();
                PatientVisitNos.SetRange(PatientVisitNos."Batch No", "Doctors Batch No");
                if PatientVisitNos.Find('-') then
                    repeat
                        PLine.Init();
                        PLine.No := "No.";
                        PLine.Type := 'DOCTORS';
                        PLine.Validate(PLine.Type);
                        PLine."Line No." := PLine."Line No." + 100;
                        PLine."Account No." := PatientVisitNos."Doctor ID";
                        PLine.Date := Today;
                        PLine."Account Type" := PLine."account type"::Vendor;
                        PatientVisitNos.CalcFields("Doctor Name");
                        PLine."Account Name" := PatientVisitNos."Doctor Name";
                        PatientVisitNos.CalcFields("Batch Total Amount");
                        PLine.Amount := PatientVisitNos."Batch Total Amount";
                        PLine.Validate(PLine.Amount);
                        PLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        PLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                        PLine2.Reset();
                        PLine2.SetRange(PLine2.No, "No.");
                        PLine2.SetRange(PLine2."Account No.", PatientVisitNos."Doctor ID");
                        if PLine2.Find('-') then
                            PLine.Validate(PLine.Amount)
                    //else
                    //   PLine.Insert;
                    until PatientVisitNos.Next() = 0;
            end;
        }
        field(50077; "Doctors Batch Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "Shortcut Dimension 5 Code"; Code[20])
        {
            // Caption = 'Sub-Department';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Responsibility Center")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /* IF (Status=Status::Approved) OR (Status=Status::Posted) OR (Status=Status::"Pending Approval")THEN
            ERROR('You Cannot Delete this record');   */
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            GenLedgerSetup.Get();
            if "Payment Type" = "payment type"::Normal then begin
                GenLedgerSetup.TestField(GenLedgerSetup."Normal Payments No");
                NoSeriesMgt.InitSeries(GenLedgerSetup."Normal Payments No", xRec."No. Series", 0D, "No.", "No. Series");
            end
            else begin
                GenLedgerSetup.TestField(GenLedgerSetup."Petty Cash Payments No");
                NoSeriesMgt.InitSeries(GenLedgerSetup."Petty Cash Payments No", xRec."No. Series", 0D, "No.", "No. Series");
            end;
        end;
        UserTemplate.Reset();
        UserTemplate.SetRange(UserTemplate.UserID, UserId);
        if UserTemplate.FindFirst() then begin
            if "Payment Type" = "payment type"::"Petty Cash" then begin
                //UserTemplate.TESTFIELD(UserTemplate."Default Petty Cash Bank");
                // "Paying Bank Account":=UserTemplate."Default Petty Cash Bank";
            end else
                "Paying Bank Account" := UserTemplate."Default Payment Bank";
            Validate("Paying Bank Account");
        end;

        Date := Today;
        Cashier := UserId;
        Validate(Cashier);
        //"Global Dimension 1 Code":='FIN';
        //VALIDATE("Global Dimension 1 Code");

        //"Global Dimension 1 Code":='MAIN';
        //"Responsibility Center":='FINANCE';
    end;

    trigger OnModify()
    begin
        if Status = Status::Pending then
            UpdateLines();

        //  IF (Status=Status::Approved) OR (Status=Status::Posted) OR ((Status=Status::"Pending Approval")) THEN
        //     ERROR('You Cannot modify an already approved/posted document');
    end;

    procedure AssistEdit(PV: Record "Payments Header"): Boolean
    begin
        PV := Rec;

        GenLedgerSetup.GET();
        GenLedgerSetup.TESTFIELD(GenLedgerSetup."Normal Payments No");

        IF NoSeriesMgt.SelectSeries(GenLedgerSetup."Normal Payments No", PV."No. Series", PV."No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries(PV."No.");
            Rec := PV;
            EXIT(TRUE);
        END;
    end;

    var
        BankAcc: Record "Bank Account";
        GenLedgerSetup: Record "Cash Office Setup";
        UserTemplate: Record "Cash Office User Template";
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        DimVal: Record "Dimension Value";

        PatientVisitNos: Record "HMS Patient Visit Nos";
        HREmployee: Record "HR-Employee";
        ImpH: Record "Imprest Header";
        ImpLines: Record "Imprest Lines";
        PayLine: Record "Payment Line";
        PLine: Record "Payment Line";
        PLine2: Record "Payment Line";
        RespCenter: Record "Responsibility Center BR";
        ClaimLines: Record "Staff Claim Lines";
        Claim: Record "Staff Claims Header";
        Vend: Record Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserMgt: Codeunit "User Setup Management BR";
        Text001: label 'Your identification is set up to process from %1 %2 only.';
        Text002: label 'There is an Account number on the  payment lines the same as Paying Bank Account you are trying to select.';
        LecturerName: Text[80];

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
    begin
        OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then
            Modify();

        if OldDimSetID <> "Dimension Set ID" then
            Modify();

        OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCode(var PurchHeader: Record "Payments Header"; xPurchHeader: Record "Payments Header"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateShortcutDimCode(var PurchaseHeader: Record "Payments Header"; var xPurchaseHeader: Record "Payments Header"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate := Date;
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;

    procedure UpdateLines()
    begin
        PLine.Reset();
        PLine.SetRange(PLine.No, "No.");
        if PLine.FindFirst() then
            repeat
                PLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                PLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                PLine."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                PLine."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                PLine."Currency Factor" := "Currency Factor";
                PLine."Paying Bank Account" := "Paying Bank Account";
                PayLine."Payment Type" := "Payment Type";
                PLine.Validate("Currency Factor");
                PLine.Modify();
            until PLine.Next() = 0;
    end;

    procedure PayLinesExist(): Boolean
    begin
        PayLine.Reset();
        PayLine.SetRange("Payment Type", "Payment Type");
        PayLine.SetRange(PayLine.No, "No.");
        exit(PayLine.FindFirst());
    end;
}
