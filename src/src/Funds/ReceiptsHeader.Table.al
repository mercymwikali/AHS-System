Table 52202894 "Receipts Header"
{
    DrillDownPageID = "Posted Receipts";
    LookupPageID = "Posted Receipts";

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Stores the code of the receipt in the database';
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the receipt was entered into the system';
        }
        field(3; Cashier; Code[20])
        {
            Description = 'Stores the user id of the cashier';
            TableRelation = User."User Name";
        }
        field(4; "Date Posted"; Date)
        {
        }
        field(5; "Time Posted"; Time)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; "Bank Code"; Code[20])
        {
            TableRelation = if ("Pay Mode" = const(Cash)) "Bank Account"."No." where("Bank Type" = filter(Cash))
            else
            if ("Pay Mode" = filter(<> Cash)) "Bank Account"."No." where("Bank Type" = filter(<> Cash));

            trigger OnValidate()
            begin
                /*
                IF PayLinesExist THEN BEGIN
                ERROR('You first need to delete the existing Receipt lines before changing the Currency Code'
                );
                END;
                */
                if bank.Get("Bank Code") then begin
                    "Bank Name" := bank.Name;
                    bank.CalcFields(Balance, "Balance (LCY)");
                    "Bank Balance" := bank.Balance;
                end;
            end;
        }
        field(9; "Received From"; Text[100])
        {
        }
        field(10; "On Behalf Of"; Text[100])
        {
        }
        field(11; "Amount Recieved"; Decimal)
        {
            trigger OnValidate()
            begin
                TotalBalance := 0;
                bank.Reset();
                bank.SetRange(bank."No.", "Bank Code");
                bank.SetRange(bank."Bank Type", bank."bank type"::Cash);
                if bank.Find('-') then begin
                    bank.CalcFields(Balance);
                    TotalBalance := "Amount Recieved" + "Bank Balance";
                    if TotalBalance > bank."Maximum Cashier Holding" then
                        Error(Erroo1);
                end;
            end;
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(27; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(29; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if PayLinesExist() then
                    Error('You first need to delete the existing Receipt lines before changing the Currency Code'
                    )
                else
                    "Bank Code" := '';
            end;
        }
        field(30; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(38; "Total Amount"; Decimal)
        {
            // CalcFormula = sum("Receipt Line q"."Total Amount" where(No = field("No.")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(39; "Posted By"; Code[20])
        {
        }
        field(40; "Print No."; Integer)
        {
        }
        field(41; Status; Option)
        {
            OptionMembers = " ",Normal,"Post Dated",Posted,Partial;
        }
        field(42; "Cheque No."; Code[20])
        {
        }
        field(43; "No. Printed"; Integer)
        {
        }
        field(44; "Created By"; Code[50])
        {
        }
        field(45; "Created Date Time"; DateTime)
        {
        }
        field(46; "Register No."; Integer)
        {
        }
        field(47; "From Entry No."; Integer)
        {
        }
        field(48; "To Entry No."; Integer)
        {
        }
        field(49; "Document Date"; Date)
        {
        }
        field(50; "Receipt Split Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Split".Amount where("Receipt No" = field("No.")));
            FieldClass = FlowField;
        }
        field(51; "Split Amount"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Split Amount" then begin
                    CalcFields("Receipt Split Amount");
                    // TestField("Receipt Split Amount");
                    "Amount Recieved" := "Receipt Split Amount";
                end;
            end;
        }
        field(81; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin
                if PayLinesExist() then
                    Error('You first need to delete the existing Receipt lines before changing the Currency Code'
                    )
                else
                    "Bank Code" := '';

                TestField(Status, Status::" ");

            end;
        }
        field(83; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                DimVal.Reset();
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code");
                if DimVal.Find('-') then
                    Dim3 := DimVal.Name
            end;
        }
        field(84; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                DimVal.Reset();
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code");
                if DimVal.Find('-') then
                    Dim4 := DimVal.Name
            end;
        }
        field(86; Dim3; Text[250])
        {
        }
        field(87; Dim4; Text[250])
        {
        }
        field(88; "Bank Name"; Text[250])
        {
        }
        field(89; "Receipt Reference"; Option)
        {
            Editable = false;
            OptionMembers = Normal,"Travel Advance Refunds","Other Advance Refunds";
        }
        field(90; "Staff Number"; Code[20])
        {
        }
        field(50000; "Patient No."; Code[20])
        {
            TableRelation = "HMS Patient"."Patient No." where(Activated = const(true));

            trigger OnValidate()
            begin

                // 1. Delete All Receipt Lines
                RLine.Reset();
                RLine.SetRange(RLine.No, "No.");
                if RLine.Find('-') then
                    RLine.DeleteAll();

                // 2. Reset Some Fields
                "Pharmacy No" := '';
                InPatient := false;
                "Laboratory No" := '';
                "Patient Appointment No" := '';
                // "Co-Pay" := false;

                if HMSPAT.Get("Patient No.") then begin
                    "Patient Appointment No" := HMSPAT."Active Visit No";
                    Validate("Patient Appointment No");
                    "Received From" := HMSPAT.Surname + ' ' + HMSPAT."Last Name";
                    "On Behalf Of" := HMSPAT.Surname + ' ' + HMSPAT."Last Name";
                    HMSPAT.CalcFields("Bill Balance");

                    InPatient := HMSPAT.Inpatient;

                    if (HMSPAT.Inpatient = false) and (HMSPAT."Walk-in" = false) then begin
                        PharmRec.Reset();
                        PharmRec.SetRange(PharmRec."Patient No.", "Patient No.");
                        PharmRec.SetRange(PharmRec.Status, PharmRec.Status::New);
                        PharmRec.SetRange(PharmRec."Link No.", HMSPAT."Active Visit No");
                        PharmRec.SetRange(Charged, true);
                        if PharmRec.Find('-') then begin
                            "Pharmacy No" := PharmRec."Pharmacy No.";
                            Validate("Pharmacy No");
                        end;
                    end;
                end;
            end;
        }
        field(50001; "Patient Appointment No"; Code[20])
        {
            TableRelation = "HMS Appointment Form Header"."Appointment No." where("Patient No." = field("Patient No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                HMSCU: Codeunit "HMS Patient-integration";
                HMSPatCharges: Record "HMS Patient Charges";
            begin
                if HMSPAT.Get("Patient No.") then
                    "Received From" := HMSPAT.Surname + ' ' + HMSPAT."Last Name";

                HMSSetup.Get();
                HMSSetup.TestField("Cash Control Account");
                RLine.Reset();
                RLine.SetRange(RLine.No, "No.");
                if RLine.Find('-') then
                    RLine.DeleteAll();

                //if (HMSPAT.Inpatient = true) or ("Co-Pay" = true) then begin
                if ("Co-Pay" = true) or (HMSPAT."Patient No." = HMSPAT."Insurance No.") then begin
                    RLine.Init();
                    RLine."Line No." := LineNo + 1;
                    RLine.No := "No.";
                    if "Co-Pay" = true then
                        RLine.Type := 'CO-PAY'
                    else
                        RLine.Type := 'PATIENT';
                    RLine.Validate(RLine.Type);
                    RLine."Account No." := HMSSetup."Cash Control Account";
                    RLine.Validate(RLine."Account No.");
                    RLine."Pay Mode" := RLine."pay mode"::Cash;
                    // TODO: Check If this is the Correct way to handle the amount
                    RLine.Amount := HMSCU.GetPatientBalance("Patient No.", "Patient Appointment No");
                    /* HMSPatCharges.Reset();
                    HMSPatCharges.SetRange("Appointment No", "Application No");
                    HMSPatCharges.SetRange("Patient No.", "Patient No.");
                    HMSPatCharges.SetRange("Receipt posted", false);
                    if HMSPatCharges.Find('-') then begin
                        RLine.Amount := HMSPatCharges."Total Amount";
                        RLine."Transaction Name" := HMSPatCharges.Description;
                    end; */
                    // RLine.Validate(RLine.Amount);
                    RLine."Bill Amount" := RLine.Amount;
                    // RLine."Transaction No.":=PatientCharges.Code;
                    RLine."Patient No" := "Patient No.";
                    RLine."HSM Transaction Type" := 'ZRECEIPTS';
                    RLine.Quantity := PatientCharges.Quantity;
                    RLine."Teller ID" := "Patient Appointment No";

                    RLine.Insert();
                end else begin

                    if RLine.FindLast() then
                        LineNo := RLine."Line No." + 1;

                    PatientCharges.Reset();
                    PatientCharges.SetRange(PatientCharges."Patient No.", "Patient No.");
                    PatientCharges.SetRange(PatientCharges."Visit No", "Patient Appointment No");
                    PatientCharges.SetFilter(PatientCharges.Amount, '<>%1', 0);
                    PatientCharges.SetRange(PatientCharges.Posted, false);
                    if PatientCharges.FindSet() then
                        repeat
                            // Message('Patient Charges %1', PatientCharges.Code);
                            // if not Itm.get(PatientCharges.Code) then begin
                            PatientCharges.CalcFields(PatientCharges."Charge Balance");
                            PatientCharges.CalcFields(PatientCharges."Receipt Amount");
                            // if PatientCharges."Total Amount" > PatientCharges."Receipt Amount" then begin
                            RLine.Init();
                            RLine."Line No." := LineNo + 1;
                            RLine.No := "No.";
                            RLine.Type := 'PATIENT';
                            //RLine.VALIDATE(RLine.Type);
                            RLine."Account No." := HMSSetup."Cash Control Account";
                            //RLine.VALIDATE(RLine."Account No.");
                            RLine."Transaction Name" := PatientCharges.Description;
                            RLine."Pay Mode" := RLine."pay mode"::Cash;
                            RLine.Amount := Round(PatientCharges."Total Amount", 1, '>') - PatientCharges."Receipt Amount";
                            RLine.Validate(RLine.Amount);
                            RLine."Bill Amount" := RLine.Amount;
                            RLine."Transaction No." := PatientCharges.Code;
                            RLine."Patient No" := "Patient No.";
                            RLine."HSM Transaction Type" := PatientCharges."Transaction Type";
                            RLine.Quantity := PatientCharges.Quantity;
                            RLine."Teller ID" := PatientCharges."Visit No";
                            RLine."Global Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                            Rline."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                            Rline."Claim No" := PatientCharges."Link No";
                            RLine.Insert();
                            LineNo := LineNo + 1;
                            if PatientCharges."Bill Section" = PatientCharges."bill section"::Pharmacy then begin // Get the pharmacy No from ooen pharmacy entries
                                PharmRec.Reset();
                                PharmRec.SetRange(PharmRec."Patient No.", "Patient No.");
                                PharmRec.SetRange(PharmRec.Status, PharmRec.Status::New);
                                PharmRec.SetRange(Charged, true);
                                if PharmRec.Find('+') then
                                    "Pharmacy No" := PharmRec."Pharmacy No.";
                            end;

                            PatientCharges.CalcFields("Visit Balance");
                            "Total Amount" := PatientCharges."Visit Balance";
                        // end;
                        // end;
                        until PatientCharges.Next() = 0;
                    if PharmRec.Get("Patient Appointment No") then begin
                        PharmRec.TestField(Charged, true);
                        "Pharmacy No" := "Patient Appointment No";
                        Validate("Pharmacy No");
                    end;
                end;
            end;
        }
        field(50002; "Surrender No"; Code[20])
        {
        }
        field(50003; "Manual Ref.Number"; Text[30])
        {
        }
        field(50004; "Imprest No"; Code[20])
        {
            TableRelation = "Imprest Header"."No." where(Status = const(Approved));
        }
        field(50006; "Application No"; Code[20])
        {
        }
        field(50007; "Applicant Name"; Text[100])
        {
        }
        field(50008; "Pay Mode Lk"; Option)
        {
            CalcFormula = lookup("Receipt Line q"."Pay Mode" where(No = field("No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Cash,Cheque,EFT,Deposit Slip,Banker''s Cheque,RTGS,MPESA';
            OptionMembers = " ",Cash,Cheque,EFT,"Deposit Slip","Banker's Cheque",RTGS,MPESA;
        }
        field(50009; "Pharmacy No"; Code[20])
        {
            TableRelation = "HMS Pharmacy Header"."Pharmacy No." where("Patient No." = field("Patient No."));

            trigger OnValidate()
            begin
                HMSPAT.get("Patient No.");
                if (HMSPAT.Inpatient = false) then begin
                    Amt := 0;
                    RLine.Reset();
                    RLine.SetRange(RLine.No, "No.");
                    RLine.SetRange("Transaction No.", "Pharmacy No");
                    if RLine.Find('-') then
                        RLine.DeleteAll();

                    RLine.Reset(); // Remove pharmacy entries inserted from Patient Charges
                    RLine.SetRange(RLine.No, "No.");
                    RLine.SetRange(RLine."Claim No", "Pharmacy No");
                    if RLine.Find('-') then
                        RLine.DeleteAll();

                    PharmLine.Reset();
                    PharmLine.SetRange(PharmLine."Pharmacy No.", "Pharmacy No");
                    if PharmLine.Find('-') then begin
                        repeat
                            LineNo := LineNo + 1;
                            RLine.Init();
                            RLine."Line No." := LineNo;
                            RLine.No := "No.";
                            RLine.Type := 'PATIENT';
                            RLine.Validate(Type);
                            RLine."Pay Mode" := RLine."pay mode"::Cash;
                            RLine."Cheque/Deposit Slip Date" := Date;
                            //  RLine."Bank Code" := 'BNK003';
                            RLine."Received From" := "Received From";
                            RLine.Amount := PharmLine."Unit Price" * PharmLine.Quantity;
                            RLine.Validate(Amount);
                            Amt := Amt + (PharmLine."Unit Price" * PharmLine.Quantity);
                            PharmLine.CalcFields("Drug Name");
                            RLine."Patient No" := "Patient No.";
                            RLine."Transaction Name" := PharmLine."Drug Name";
                            RLine."Transaction No." := PharmLine."Pharmacy No.";
                            Rline."Agent Code" := PharmLine."No.";
                            RLine."HSM Transaction Type" := 'PHARMACY';
                            RLine.Quantity := PharmLine.Quantity;
                            RLine."Global Dimension 1 Code" := HMSPAT."Global Dimension 1 Code";
                            RLine."Shortcut Dimension 2 Code" := 'PHARMACY';
                            Rline.Pharmacy := true;
                            RLine.Insert();
                        until PharmLine.Next() = 0;
                        "Amount Recieved" := Amt;
                    end;
                end;
            end;
        }
        field(50010; "Laboratory No"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "HMS Laboratory Form Header"."Laboratory No." where("Cash Sale" = filter(true),
                                                                                 "Receipt Count" = filter(0),
                                                                                 "Patient No." = field("Patient No."));

            trigger OnValidate()
            begin
                if "Laboratory No" <> '' then begin
                    Amt := 0;
                    RLine.Reset();
                    RLine.SetRange(RLine.No, "No.");
                    if RLine.Find('-') then
                        RLine.DeleteAll();

                    HMSLabLine.Reset();
                    HMSLabLine.SetRange(HMSLabLine."Link No", "Laboratory No");
                    if HMSLabLine.Find('-') then begin
                        "Bank Code" := "Bank Code";
                        // "Global Dimension 1 Code":='ACCOUNTS';
                        "Shortcut Dimension 2 Code" := 'LABORATORY';
                        //
                        repeat
                            LineNo := LineNo + 1;
                            RLine.Init();
                            RLine."Line No." := LineNo;
                            RLine.No := "No.";
                            RLine.Type := 'PATIENT';
                            RLine.Validate(Type);
                            RLine."Bank Code" := 'BNK003';
                            RLine."Pay Mode" := RLine."pay mode"::Cash;
                            RLine."Cheque/Deposit Slip Date" := Date;
                            RLine."Received From" := "Received From";
                            RLine.Amount := HMSLabLine.Amount;
                            RLine.Validate(Amount);
                            Amt := Amt + HMSLabLine.Amount;
                            RLine."Patient No" := "Patient No.";
                            RLine."Transaction Name" := HMSLabLine.Description;
                            RLine."Transaction No." := HMSLabLine."Link No";
                            RLine."HSM Transaction Type" := 'LABORATORY';
                            RLine.Quantity := PatientCharges.Quantity;
                            RLine.Insert();
                            "Amount Recieved" := Amt;
                        until HMSLabLine.Next() = 0;
                    end;
                end;
            end;
        }
        field(50011; "Customer No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Customer No") then
                    "Received From" := Cust.Name;
            end;
        }
        field(50012; "Co-Pay"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Co-Pay" = true then begin
                    RLine.Reset();
                    RLine.SetRange(RLine.No, "No.");
                    if RLine.FindSet() then
                        repeat
                            RLine.Delete();
                        until RLine.Next() = 0;

                    RLine.Init();
                    RLine.No := "No.";
                    RLine.Type := 'CO-PAY';
                    RLine.Validate(Type);
                    RLine.Amount := "Amount Recieved";
                    RLine."Patient No" := "Patient No.";
                    RLine."Teller ID" := "Patient Appointment No";
                    Rline."Global Dimension 1 Code" := "Global Dimension 1 Code";
                    RLine."HSM Transaction Type" := 'ZRECEIPTS';
                    RLine.Insert();

                    "Total Amount" := "Amount Recieved";
                end;
            end;
        }
        field(50512; "Reversed Posted"; Boolean)
        {
        }
        field(50312; "Reversed By"; code[20])
        {
        }
        field(50212; "Reversal Date"; date)
        {
        }
        field(50013; Reversed; Boolean)
        {
            CalcFormula = lookup("Bank Account Ledger Entry".Reversed where("Document No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50014; "Mobile Money Type"; Option)
        {
            OptionCaption = ' ,Safaricom - MPESA,Equity - Ezzy Money,KCB - MPESA,Orange - Money,Airtel - Money';
            OptionMembers = " ","Safaricom - MPESA","Equity - Ezzy Money","KCB - MPESA","Orange - Money","Airtel - Money";
        }
        field(50015; "Pay Mode"; Enum "Payment Modes")
        {
            trigger OnValidate()
            begin
                "Bank Code" := '';
                if "Pay Mode" <> "Pay Mode"::MPESA then
                    "Mobile Money Type" := "Mobile Money Type"::" ";

                if UserTemplate.get(Database.UserId) then begin
                    if "Pay Mode" = "Pay Mode"::Cash then
                        "Bank Code" := UserTemplate."Default Receipts Bank";
                    if "Pay Mode" = "Pay Mode"::MPESA then begin
                        "Bank Code" := UserTemplate."Default Mpesa Bank";
                        "Mobile Money Type" := "Mobile Money Type"::"Safaricom - MPESA"; // FIXME: Set Default mobile money Type if Mpesa. Remove this when you expose the type in paymode.
                    end;
                    if "Pay Mode" = "Pay Mode"::PDQ then
                        "Bank Code" := UserTemplate."Default PDQ Bank";
                    if "Pay Mode" = "Pay Mode"::EFT then
                        "Bank Code" := UserTemplate."Default PDQ Bank";
                    if "Pay Mode" = "Pay Mode"::RTGS then
                        "Bank Code" := UserTemplate."Default PDQ Bank";                        
                    if "Pay Mode" = "Pay Mode"::"Deposit Slip" then
                        "Bank Code" := UserTemplate."Default PDQ Bank";
                    if "Pay Mode" = "Pay Mode"::Cheque then
                        "Bank Code" := UserTemplate."Default Cheque Bank";

                end;
            end;
        }
        field(50016; "Posted Count"; Integer)
        {
            CalcFormula = count("Bank Account Ledger Entry" where("Document No." = field("No."),
                                                                   Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(50017; "Transaction Code"; Code[20])
        {
            trigger OnValidate()
            var
                RecH: Record "Receipts Header";
            begin
                if "Transaction Code" <> '' then begin
                    rech.reset();
                    rech.setrange(rech."Transaction Code", "Transaction Code");
                    if not rech.IsEmpty() then
                        if GuiAllowed then
                            if Confirm('Please note that the selected Transaction No has alrady been used, Do you want to re-use?', false) = false then
                                error('Transaction aborted.');
                end;
            end;
        }
        field(50018; "Bank Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "InterBank No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "InterBank No Filter"; code[20])
        {
            FieldClass = FlowFilter;
        }
        field(50021; "Disbursable Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Disbursed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Fully Disbursed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "isPartialPayment"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ReceiptLineq: Record "Receipt Line q";
                lineNo: Integer;
            begin
                if Rec.isPartialPayment then begin
                    ReceiptLineq.Reset();
                    if ReceiptLineq.FindLast() then
                        lineNo := ReceiptLineq."Line No." + 1;


                    ReceiptLineq.Reset();
                    ReceiptLineq.SetRange(ReceiptLineq.No, "No.");
                    if ReceiptLineq.Find('-') then
                        ReceiptLineq.DeleteAll();

                    ReceiptLineq.Init();
                    ReceiptLineq.No := "No.";
                    ReceiptLineq."Line No." := lineNo;
                    ReceiptLineq."Pay Mode" := "Pay Mode";
                    if "Pay Mode" = "Pay Mode"::Cheque then
                        ReceiptLineq."Cheque/Deposit Slip No" := "Transaction Code";
                    ReceiptLineq.Type := 'PATIENT';
                    ReceiptLineq.Validate(Type);
                    ReceiptLineq.Amount := "Amount Recieved";
                    ReceiptLineq."Patient No" := "Patient No.";
                    ReceiptLineq.Quantity := 1;
                    ReceiptLineq."Teller ID" := "Patient Appointment No";
                    ReceiptLineq."HSM Transaction Type" := 'ZRECEIPTS';
                    // "Global Dimension 1 Code" := "Global Dimension 1 Code";
                    // "Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                    // "Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                    // "Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                    ReceiptLineq.Insert(true);

                    "Total Amount" := "Amount Recieved";
                end;
            end;
        }
        field(50025; Remarks; Text[300])
        {

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Posted, false);
    end;

    trigger OnInsert()
    var
        DimRec: Record "Dimension Value";
        UserRec: Record "User Setup";
    begin
        if Cashier = '' then begin
            "Created By" := UserId;
            Cashier := UserId;
        end;
        if UserRec.get(Cashier) then;
        if "No." = '' then
            if UserRec."Branch Code" <> '' then begin
                dimrec.reset();
                dimrec.setrange(Code, UserRec."Branch Code");
                if dimrec.find('-') then begin
                    DimRec.testfield("Receipt No. Series");
                    NoSeriesMgt.InitSeries(DimRec."Receipt No. Series", xRec."No. Series", 0D, "No.", "No. Series");
                end;
            end else begin
                GenLedgerSetup.Get();
                GenLedgerSetup.TestField(GenLedgerSetup."Receipts No");
                NoSeriesMgt.InitSeries(GenLedgerSetup."Receipts No", xRec."No. Series", 0D, "No.", "No. Series");
            end;


        if UserTemplate.get(Cashier) then begin
            "Bank Code" := UserTemplate."Default Receipts Bank";
            "Global Dimension 1 Code" := UserTemplate."Default Branch Code";
        end;
        //*****************************JACK**************************//
        "Created Date Time" := CreateDatetime(Today, Time);
        //*****************************END***************************//
        "Date Posted" := Today;
        "Document Date" := Today;
    end;

    trigger OnModify()
    begin
        RLine.Reset();
        RLine.SetRange(RLine.No, "No.");
        if RLine.FindSet() then
            repeat
                RLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                RLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                RLine."Shortcut Dimension 3 Code" := "Shortcut Dimension 3 Code";
                RLine."Shortcut Dimension 4 Code" := "Shortcut Dimension 4 Code";
                RLine."Patient No" := "Patient No.";
                //  RLine."Patient No" :="Patient No";
                RLine.Modify();
            until RLine.Next() = 0;
    end;

    var
        bank: Record "Bank Account";
        GenLedgerSetup: Record "Cash Office Setup";
        UserTemplate: Record "Cash Office User Template";
        Cust: Record Customer;
        DimVal: Record "Dimension Value";
        HMSPAT: Record "HMS Patient";
        HMSLabLine: Record "HMS Patient Charges";
        PatientCharges: Record "HMS Patient Charges";
        PharmRec: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        HMSSetup: Record "HMS Setup";
        RLine: Record "Receipt Line q";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InPatient: Boolean;
        Amt: Decimal;
        TotalBalance: Decimal;
        LineNo: Integer;
        Erroo1: label 'The cash balance exceed your maximum credit limit,Kindly transfer amount to the main cashier Account.';

    procedure PayLinesExist(): Boolean
    begin
        RLine.Reset();
        RLine.SetRange(RLine.No, "No.");
        exit(RLine.FindFirst());
    end;

    procedure AssistEdit(OldCust: Record "Receipts Header"): Boolean
    var
        Cust: Record "Receipts Header";
    begin
        Cust := Rec;

        GenLedgerSetup.Get();
        GenLedgerSetup.TestField(GenLedgerSetup."Receipts No");

        if NoSeriesMgt.SelectSeries(GenLedgerSetup."Receipts No", OldCust."No. Series", Cust."No. Series") then begin
            NoSeriesMgt.SetSeries(Cust."No.");
            Rec := Cust;
            exit(true);
        end;
    end;
}
