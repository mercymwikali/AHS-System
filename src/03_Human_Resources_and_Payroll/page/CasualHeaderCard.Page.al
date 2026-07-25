Page 85746 "Casual Header Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Casual Payment Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = editablegrp;
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(UserID; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field(PaymentMethod; Rec."Payment Method")
                {
                    ToolTip = 'Specifies the value of the Payment Method field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(AccountType; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(SalariesWagesAc; Rec."Salaries&Wages A/c")
                {
                    ToolTip = 'Specifies the value of the Salaries&Wages A/c field.';
                }
                field(NetPayableAcc; Rec."Salary Account")
                {
                    Caption = 'Net Payable Acc';
                    ToolTip = 'Specifies the value of the Net Payable Acc field.';
                }
                field(PAYEAcc; Rec."P.A.Y.E Acc")
                {
                    ToolTip = 'Specifies the value of the P.A.Y.E Acc field.';
                }
                field(NSSFAccount; Rec."NSSF Account")
                {
                    ToolTip = 'Specifies the value of the NSSF Account field.';
                }
                field(NHIFAccount; Rec.NHIFAccount)
                {
                    ToolTip = 'Specifies the value of the NHIF Account field.';
                }
                field(TotalBasicAmount; Rec."Total Basic Amount")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Basic Amount field.';
                }
                field(TotalPAYE; Rec."Total PAYE")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total PAYE field.';
                }
                field(TotalNHIF; Rec."Total NHIF")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total NHIF field.';
                }
                field(TotalNSSF; Rec."Total NSSF")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total NSSF field.';
                }
                field(KUSU; Rec.KUSU)
                {
                    Caption = 'KUSU Totals';
                    Editable = false;
                    ToolTip = 'Specifies the value of the KUSU Totals field.';
                }
                field(PensionTotal; Rec."Pension Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Pension Total field.';
                }
                field(UASUTotal; Rec."UASU Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the UASU Total field.';
                }
                field(NetPayable; Rec."Net Payable")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Net Payable field.';
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field(EmployeeType; Rec."Employee Type")
                {
                    ToolTip = 'Specifies the value of the Employee Type field.';
                }
            }
            part(Control1120054014; "Casual Payment Line")
            {
                Editable = editablegrp;
                SubPageLink = "Document No." = field("No."),
                              "Payroll Period" = field("Payroll Period"),
                              "Employee Type" = field("Employee Type");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Casual Salary")
            {
                Image = PostBatch;
                Promoted = true;
                ToolTip = 'Executes the Post Casual Salary action.';

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    Rec.TestField(Posted, false);
                    Rec.CalcFields("Total Basic Amount", "Total NHIF", "Total NSSF", "Total PAYE");
                    Rec."Net Payable" := Rec."Total Basic Amount" - (Rec."Total NHIF" + Rec."Total NSSF" + Rec."Total PAYE");
                    "Post CasualSalaries`"();
                    Rec.Posted := true;
                end;
            }
            action("Approve Casuals")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                ToolTip = 'Executes the Approve Casuals action.';

                trigger OnAction()
                begin
                    if UserSetup.Get(UserId) then
                        if UserSetup."View Payroll" = true then begin
                            Rec.Status := Rec.Status::Released;
                            Message('Document Sucessfully Realesed');
                            Rec.Modify();
                        end else
                            Error('You do not have permission kindly contact Administrator');
                    Rec.TestField("Payroll Period");
                    Rec.TestField("Payment Method");
                    Rec.CalcFields("Net Payable");
                    if Rec."Net Payable" <= 0 then
                        Error('Net payable amount must be greater than zero');
                end;
            }
            action("Print Payment Schedule")
            {
                Image = PrintVoucher;
                Promoted = true;
                ToolTip = 'Executes the Print Payment Schedule action.';

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    PaymentHeader.Reset();
                    PaymentHeader.SetRange(PaymentHeader."No.", Rec."No.");
                    if PaymentHeader.Find('-') then
                        if PaymentHeader."Employee Type" = PaymentHeader."employee type"::Casual then
                            Report.Run(51068, true, false, PaymentHeader)
                        else
                            if PaymentHeader."Employee Type" = PaymentHeader."employee type"::Permanent then
                                Report.Run(51074, true, false, PaymentHeader)
                            else
                                if PaymentHeader."Employee Type" = PaymentHeader."employee type"::"Part-Timer" then
                                    Report.Run(51077, true, false, PaymentHeader)
                end;
            }
            action("Print Bank Schedule")
            {
                Image = PrintVoucher;
                Promoted = true;
                ToolTip = 'Executes the Print Bank Schedule action.';

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    PaymentHeader.Reset();
                    PaymentHeader.SetRange(PaymentHeader."No.", Rec."No.");
                    if PaymentHeader.Find('-') then
                        if PaymentHeader."Employee Type" = PaymentHeader."employee type"::Casual then
                            Report.Run(51069, true, false, PaymentHeader)
                        else
                            if PaymentHeader."Employee Type" = PaymentHeader."employee type"::Permanent then
                                Report.Run(51075, true, false, PaymentHeader)
                            else
                                if PaymentHeader."Employee Type" = PaymentHeader."employee type"::"Part-Timer" then
                                    Report.Run(51078, true, false, PaymentHeader)
                end;
            }
            action("Print CBA Report")
            {
                ToolTip = 'Executes the Print CBA Report action.';
            }
            action("Statutory statement")
            {
                Image = Report2;
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Statutory statement action.';

                trigger OnAction()
                begin
                    prPeriodTransactions.Reset();
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", Rec."Payroll Period");
                    prPeriodTransactions.SetRange(prPeriodTransactions."Reference No", Rec."No.");
                    if prPeriodTransactions.Find('-') then
                        Report.Run(70135587, true, false, prPeriodTransactions);
                end;
            }
            action("Process salaries")
            {
                Image = PersonInCharge;
                Promoted = true;
                ToolTip = 'Executes the Process salaries action.';

                trigger OnAction()
                begin
                    //reset table****************
                    prPeriodTransactions.Reset();
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", Rec."Payroll Period");
                    prPeriodTransactions.SetRange(prPeriodTransactions."Reference No", Rec."No.");
                    if prPeriodTransactions.Find('-') then
                        prPeriodTransactions.DeleteAll();
                    //**********************basic Amount
                    if Confirm(ConfirmProcess, true, 'ALL  staff') then begin
                        Progress.Open('Processing Salary for casual no. #1#######');
                        Casualline.Reset();
                        Casualline.SetRange(Casualline."Document No.", Rec."No.");
                        if Casualline.Find('-') then
                            repeat

                                prPeriodTransactions.Init();
                                prPeriodTransactions."Transaction Code" := 'BPAY';
                                prPeriodTransactions."Employee Code" := Casualline."Employee No";
                                prPeriodTransactions."Period Month" := Date2dmy(Rec."Payroll Period", 2);
                                prPeriodTransactions."Period Year" := Date2dmy(Rec."Payroll Period", 3);
                                prPeriodTransactions.Membership := Rec."No.";
                                prPeriodTransactions."Reference No" := Casualline."Document No.";
                                prPeriodTransactions."Group Text" := 'BASIC PAY';
                                prPeriodTransactions."Transaction Name" := 'Basic Salary' + ' ' + Format(Rec."Payroll Period");
                                prPeriodTransactions.Amount := Casualline."Basic Amount";
                                prPeriodTransactions."Group Order" := 1;
                                prPeriodTransactions."Sub Group Order" := 1;
                                prPeriodTransactions."Payroll Period" := Rec."Payroll Period";
                                if CasualEmployees.Get(Casualline."Employee No") then
                                    prPeriodTransactions."Department Code" := CasualEmployees.Department;
                                //prPeriodTransactions."Payment Mode":="Payment Method";
                                if prPeriodTransactions.Amount <> 0 then
                                    prPeriodTransactions.Insert();
                                ///**********************taxable*************
                                prPeriodTransactions.Init();
                                prPeriodTransactions."Transaction Code" := 'TXBP';
                                prPeriodTransactions."Employee Code" := Casualline."Employee No";
                                prPeriodTransactions."Period Month" := Date2dmy(Rec."Payroll Period", 2);
                                prPeriodTransactions."Period Year" := Date2dmy(Rec."Payroll Period", 3);
                                prPeriodTransactions.Membership := Rec."No.";
                                prPeriodTransactions."Reference No" := Casualline."Document No.";
                                prPeriodTransactions."Group Text" := 'TAX CALCULATIONS';
                                prPeriodTransactions."Transaction Name" := 'Taxable' + ' ' + Format(Rec."Payroll Period");
                                //IF Casualline."Pay Stutatories"=Casualline."Pay Stutatories"::Yes THEN BEGIN
                                //prVitalSetupInfo.GET;
                                if Casualline."PAYE Amount" > 0 then
                                    prPeriodTransactions.Amount := Casualline."Basic Amount" - Casualline."NSSF Amount"
                                else
                                    prPeriodTransactions.Amount := 0;
                                //END ELSE
                                //IF Casualline."Pay Stutatories"=Casualline."Pay Stutatories"::No THEN
                                //prPeriodTransactions.Amount:=0;
                                prPeriodTransactions."Group Order" := 6;
                                prPeriodTransactions."Sub Group Order" := 6;
                                prPeriodTransactions."Payroll Period" := Rec."Payroll Period";
                                if CasualEmployees.Get(Casualline."Employee No") then
                                    prPeriodTransactions."Department Code" := CasualEmployees.Department;
                                //prPeriodTransactions."Payment Mode":="Payment Method";
                                if prPeriodTransactions.Amount <> 0 then
                                    prPeriodTransactions.Insert();
                                ///************************************** * ***PAYE*******************

                                prPeriodTransactions.Init();
                                prPeriodTransactions."Transaction Code" := 'PAYE';
                                prPeriodTransactions."Employee Code" := Casualline."Employee No";
                                prPeriodTransactions."Period Month" := Date2dmy(Rec."Payroll Period", 2);
                                prPeriodTransactions."Period Year" := Date2dmy(Rec."Payroll Period", 3);
                                prPeriodTransactions.Membership := Rec."No.";
                                prPeriodTransactions."Reference No" := Casualline."Document No.";
                                prPeriodTransactions."Group Text" := 'STATUTORIES';
                                prPeriodTransactions."Transaction Name" := 'PAYE' + ' ' + Format(Rec."Payroll Period");
                                //IF Casualline."Pay Stutatories"=Casualline."Pay Stutatories"::Yes THEN BEGIN
                                //prVitalSetupInfo.GET;
                                PAYEAmount := Casualline."Basic Amount" - prVitalSetupInfo."NSSF Employee";
                                //relief=1408
                                prPeriodTransactions.Amount := Casualline."PAYE Amount";//fnGetEmployeePaye(PAYEAmount)-prVitalSetupInfo."Tax Relief";
                                                                                        //END ELSE
                                                                                        //IF Casualline."Pay Stutatories"=Casualline."Pay Stutatories"::No THEN
                                                                                        // prPeriodTransactions.Amount:=0;
                                prPeriodTransactions."Group Order" := 1;
                                prPeriodTransactions."Sub Group Order" := 1;
                                prPeriodTransactions."Payroll Period" := Rec."Payroll Period";
                                if CasualEmployees.Get(Casualline."Employee No") then
                                    prPeriodTransactions."Department Code" := CasualEmployees.Department;
                                if prPeriodTransactions.Amount <> 0 then
                                    prPeriodTransactions.Insert();
                                //************************personal Relief
                                prPeriodTransactions.Init();
                                prPeriodTransactions."Transaction Code" := 'PSNR';
                                prPeriodTransactions."Employee Code" := Casualline."Employee No";
                                prPeriodTransactions."Period Month" := Date2dmy(Rec."Payroll Period", 2);
                                prPeriodTransactions."Period Year" := Date2dmy(Rec."Payroll Period", 3);
                                prPeriodTransactions.Membership := Rec."No.";
                                prPeriodTransactions."Reference No" := Casualline."Document No.";
                                prPeriodTransactions."Group Text" := 'TAX CALCULATIONS';
                                prPeriodTransactions."Transaction Name" := 'Personal Relief' + ' ' + Format(Rec."Payroll Period");
                                if Casualline."Pay Stutatories" = Casualline."pay stutatories"::Yes then begin
                                    prVitalSetupInfo.Get();
                                    if Casualline."PAYE Amount" > 0 then
                                        prPeriodTransactions.Amount := prVitalSetupInfo."Tax Relief"
                                    else
                                        prPeriodTransactions.Amount := 0;
                                end else
                                    prPeriodTransactions.Amount := 0;
                                prPeriodTransactions."Group Order" := 6;
                                prPeriodTransactions."Sub Group Order" := 9;
                                prPeriodTransactions."Payroll Period" := Rec."Payroll Period";
                                if CasualEmployees.Get(Casualline."Employee No") then
                                    prPeriodTransactions."Department Code" := CasualEmployees.Department;

                                if prPeriodTransactions.Amount <> 0 then
                                    prPeriodTransactions.Insert();
                                //**************************NSSF*****************************
                                prPeriodTransactions.Init();
                                prPeriodTransactions."Transaction Code" := 'NSSF';
                                prPeriodTransactions."Employee Code" := Casualline."Employee No";
                                prPeriodTransactions."Period Month" := Date2dmy(Rec."Payroll Period", 2);
                                prPeriodTransactions."Period Year" := Date2dmy(Rec."Payroll Period", 3);
                                prPeriodTransactions.Membership := Rec."No.";
                                prPeriodTransactions."Reference No" := Casualline."Document No.";
                                prPeriodTransactions."Group Text" := 'STATUTORIES';
                                prPeriodTransactions."Transaction Name" := 'N.S.S.F' + ' ' + Format(Rec."Payroll Period");
                                if Casualline."Pay Stutatories" = Casualline."pay stutatories"::Yes then begin
                                    prVitalSetupInfo.Get();
                                    prPeriodTransactions.Amount := Casualline."NSSF Amount";
                                end else
                                    prPeriodTransactions.Amount := 0;
                                prPeriodTransactions."Group Order" := 7;
                                prPeriodTransactions."Sub Group Order" := 1;
                                prPeriodTransactions."Payroll Period" := Rec."Payroll Period";
                                if CasualEmployees.Get(Casualline."Employee No") then
                                    prPeriodTransactions."Department Code" := CasualEmployees.Department;

                                if prPeriodTransactions.Amount <> 0 then
                                    prPeriodTransactions.Insert();
                                ///********************NHIF***************************
                                prPeriodTransactions.Init();
                                prPeriodTransactions."Transaction Code" := 'NHIF';
                                prPeriodTransactions."Employee Code" := Casualline."Employee No";
                                prPeriodTransactions."Period Month" := Date2dmy(Rec."Payroll Period", 2);
                                prPeriodTransactions."Period Year" := Date2dmy(Rec."Payroll Period", 3);
                                prPeriodTransactions.Membership := Rec."No.";
                                prPeriodTransactions."Reference No" := Casualline."Document No.";
                                prPeriodTransactions."Group Text" := 'STATUTORIES';
                                prPeriodTransactions."Transaction Name" := 'N.H.I.F' + ' ' + Format(Rec."Payroll Period");
                                //***
                                curBaseAmount := Casualline."Basic Amount";
                                prNHIF.Reset();
                                prNHIF.SetCurrentkey(prNHIF."Tier Code");
                                if prNHIF.FindFirst() then
                                    repeat
                                        if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then
                                            NHIF := prNHIF.Amount;
                                    until prNHIF.Next() = 0;
                                if Casualline."Pay Stutatories" = Casualline."pay stutatories"::Yes then
                                    prPeriodTransactions.Amount := NHIF
                                else
                                    prPeriodTransactions.Amount := 0;
                                prPeriodTransactions."Group Order" := 7;
                                prPeriodTransactions."Sub Group Order" := 2;
                                prPeriodTransactions."Payroll Period" := Rec."Payroll Period";
                                if CasualEmployees.Get(Casualline."Employee No") then
                                    prPeriodTransactions."Department Code" := CasualEmployees.Department;

                                if prPeriodTransactions.Amount <> 0 then
                                    prPeriodTransactions.Insert();
                                //****************Total deduction---
                                PAYE := 0;
                                prPeriodTransactions.Init();
                                prPeriodTransactions."Transaction Code" := 'TOT-DED';
                                prPeriodTransactions."Employee Code" := Casualline."Employee No";
                                prPeriodTransactions."Period Month" := Date2dmy(Rec."Payroll Period", 2);
                                prPeriodTransactions."Period Year" := Date2dmy(Rec."Payroll Period", 3);
                                prPeriodTransactions.Membership := Rec."No.";
                                prPeriodTransactions."Reference No" := Casualline."Document No.";
                                prPeriodTransactions."Group Text" := 'DEDUCTIONS';
                                prPeriodTransactions."Transaction Name" := 'Total ded' + ' ' + Format(Rec."Payroll Period");
                                PAYE := fnGetEmployeePaye(PAYEAmount);
                                if Casualline."Pay Stutatories" = Casualline."pay stutatories"::Yes then begin
                                    prVitalSetupInfo.Get();
                                    prPeriodTransactions.Amount := PAYE + NHIF + prVitalSetupInfo."NSSF Employee";
                                end else
                                    prPeriodTransactions.Amount := 0;
                                prPeriodTransactions."Group Order" := 8;
                                prPeriodTransactions."Sub Group Order" := 9;
                                prPeriodTransactions."Payroll Period" := Rec."Payroll Period";
                                if CasualEmployees.Get(Casualline."Employee No") then
                                    prPeriodTransactions."Department Code" := CasualEmployees.Department;
                                if prPeriodTransactions.Amount <> 0 then
                                    prPeriodTransactions.Insert();
                                // KUSU*****************************************************
                                //************************************NET PAY
                                PAYE := 0;
                                prPeriodTransactions.Init();
                                prPeriodTransactions."Transaction Code" := 'NPAY';
                                prPeriodTransactions."Employee Code" := Casualline."Employee No";
                                prPeriodTransactions."Period Month" := Date2dmy(Rec."Payroll Period", 2);
                                prPeriodTransactions."Period Year" := Date2dmy(Rec."Payroll Period", 3);
                                prPeriodTransactions.Membership := Rec."No.";
                                prPeriodTransactions."Reference No" := Casualline."Document No.";
                                prPeriodTransactions."Group Text" := 'NETPAY';
                                prPeriodTransactions."Transaction Name" := 'NET PAY' + ' ' + Format(Rec."Payroll Period");
                                //PAYE:=fnGetEmployeePaye(PAYEAmount);
                                if Casualline."Pay Stutatories" = Casualline."pay stutatories"::Yes then begin
                                    prVitalSetupInfo.Get();
                                    prPeriodTransactions.Amount := Casualline."Basic Amount" - (Casualline."PAYE Amount" - Casualline."NSSF Amount" - Casualline."NHIF Amount");
                                end else
                                    prPeriodTransactions.Amount := Casualline."Net Pay";
                                prPeriodTransactions."Group Order" := 9;
                                prPeriodTransactions."Sub Group Order" := 0;
                                prPeriodTransactions."Payroll Period" := Rec."Payroll Period";
                                if CasualEmployees.Get(Casualline."Employee No") then
                                    prPeriodTransactions."Department Code" := CasualEmployees.Department;
                                if prPeriodTransactions.Amount <> 0 then
                                    prPeriodTransactions.Insert();
                            until Casualline.Next() = 0;
                        Progress.Close();
                    end;
                    Message('Casual salaries successfully processed');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.Posted = true then
            editablegrp := false
        else
            editablegrp := true;
    end;

    var
        CasualEmployees: Record "Casual Employees";
        PaymentHeader: Record "Casual Payment Header";
        Casualline: Record "Casual Payment Lines";
        // CashMgtSetup: Record UnknownRecord70135412;
        GenJnlLine: Record "Gen. Journal Line";
        prNHIF: Record prNHIF;
        prPeriodTransactions: Record "prPeriod Transactions-Casuals";
        prVitalSetupInfo: Record "prVital Setup Info";
        UserSetup: Record "User Setup";
        editablegrp: Boolean;
        JournalBatch: Code[50];
        JournalTemplate: Code[50];
        curBaseAmount: Decimal;
        NHIF: Decimal;
        PAYE: Decimal;
        PAYEAmount: Decimal;
        TotalWage: Decimal;
        Progress: Dialog;
        ConfirmProcess: label 'Process Casual Salaries %1';

    local procedure "Post CasualSalaries`"()
    begin

        //....... DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JournalBatch);
        GenJnlLine.DeleteAll();
        JournalTemplate := 'GENERAL';
        JournalBatch := 'CASUAL';
        //.................INSERT THE NET AMOUNT TRANSACTION................

        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JournalTemplate;
        GenJnlLine."Journal Batch Name" := JournalBatch;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
        GenJnlLine."Account No." := Rec."Salary Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Amount := -(Rec."Net Payable");

        GenJnlLine.Validate(GenJnlLine.Amount);

        if Rec.Remarks <> '' then
            GenJnlLine.Description := Rec.Remarks
        else
            GenJnlLine.Description := Rec.Payee + ': Casual Net Payee -' + Rec."No.";
        if GenJnlLine.Amount <> 0 then
            GenJnlLine."Reason Code" := 'CASUAL';
        GenJnlLine."Source Code" := 'CASUAL';
        Casualline.Reset();
        Casualline.SetRange(Casualline."Document No.", Rec."No.");
        if Casualline.Find('-') then begin
            GenJnlLine."Shortcut Dimension 1 Code" := Casualline."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Casualline."Shortcut Dimension 2 Code";
        end;
        //Validate dimensionsSH
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.Insert();
        //*************** INSERT PAYE Transactions**************************
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JournalTemplate;
        GenJnlLine."Journal Batch Name" := JournalBatch;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
        GenJnlLine."Account No." := Rec."P.A.Y.E Acc";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Amount := -(Rec."Total PAYE");

        GenJnlLine.Validate(GenJnlLine.Amount);

        if Rec.Remarks <> '' then
            GenJnlLine.Description := Rec.Remarks
        else
            GenJnlLine.Description := Rec.Payee + ': Casual PAYE -' + Rec."No.";
        if GenJnlLine.Amount <> 0 then
            GenJnlLine."Reason Code" := 'CASUAL';
        GenJnlLine."Source Code" := 'CASUAL';
        Casualline.Reset();
        Casualline.SetRange(Casualline."Document No.", Rec."No.");
        if Casualline.Find('-') then begin
            GenJnlLine."Shortcut Dimension 1 Code" := Casualline."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Casualline."Shortcut Dimension 2 Code";
        end;
        //Validate dimensionsSH
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.Insert();
        //************INSERT NHIF TRANSACTIONS ***********
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JournalTemplate;
        GenJnlLine."Journal Batch Name" := JournalBatch;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
        GenJnlLine."Account No." := Rec.NHIFAccount;
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Amount := -(Rec."Total NHIF");

        GenJnlLine.Validate(GenJnlLine.Amount);

        if Rec.Remarks <> '' then
            GenJnlLine.Description := Rec.Remarks
        else
            GenJnlLine.Description := Rec.Payee + ': Casual NHIF -' + Rec."No.";
        if GenJnlLine.Amount <> 0 then
            GenJnlLine."Reason Code" := 'CASUAL';
        GenJnlLine."Source Code" := 'CASUAL';
        Casualline.Reset();
        Casualline.SetRange(Casualline."Document No.", Rec."No.");
        if Casualline.Find('-') then begin
            GenJnlLine."Shortcut Dimension 1 Code" := Casualline."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Casualline."Shortcut Dimension 2 Code";
        end;
        //Validate dimensionsSH
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.Insert();
        //*******************Insert NSSF Transactions***********
        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JournalTemplate;
        GenJnlLine."Journal Batch Name" := JournalBatch;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
        GenJnlLine."Account No." := Rec."NSSF Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        GenJnlLine.Amount := -(Rec."Total NSSF");

        GenJnlLine.Validate(GenJnlLine.Amount);

        if Rec.Remarks <> '' then
            GenJnlLine.Description := Rec.Remarks
        else
            GenJnlLine.Description := Rec.Payee + ': Casual NSSF -' + Rec."No.";
        if GenJnlLine.Amount <> 0 then
            GenJnlLine."Reason Code" := 'CASUAL';
        GenJnlLine."Source Code" := 'CASUAL';
        Casualline.Reset();
        Casualline.SetRange(Casualline."Document No.", Rec."No.");
        if Casualline.Find('-') then begin
            GenJnlLine."Shortcut Dimension 1 Code" := Casualline."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Casualline."Shortcut Dimension 2 Code";
        end;
        //Validate dimensionsSH
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.Insert();
        ///************************Insert Balancing Transactions******************

        GenJnlLine.Init();
        GenJnlLine."Journal Template Name" := JournalTemplate;
        GenJnlLine."Journal Batch Name" := JournalBatch;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Posting Date";
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Line No." := GenJnlLine."Line No." + 1000;
        GenJnlLine."Document Type" := GenJnlLine."document type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
        GenJnlLine."Account No." := Rec."Salaries&Wages A/c";
        GenJnlLine.Validate(GenJnlLine."Account No.");
        TotalWage := 0;
        Rec.CalcFields("Total NHIF", "Total Basic Amount", "Total NSSF", "Total PAYE");
        TotalWage := Rec."Total NHIF" + Rec."Total NSSF" + Rec."Total PAYE" + Rec."Net Payable";
        GenJnlLine.Amount := (TotalWage);

        GenJnlLine.Validate(GenJnlLine.Amount);

        if Rec.Remarks <> '' then
            GenJnlLine.Description := Rec.Remarks
        else
            GenJnlLine.Description := Rec.Payee + ': Total casual Payment -' + Rec."No.";
        if GenJnlLine.Amount <> 0 then
            GenJnlLine."Reason Code" := 'CASUAL';
        GenJnlLine."Source Code" := 'CASUAL';
        Casualline.Reset();
        Casualline.SetRange(Casualline."Document No.", Rec."No.");
        if Casualline.Find('-') then begin
            GenJnlLine."Shortcut Dimension 1 Code" := Casualline."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := Casualline."Shortcut Dimension 2 Code";
        end;
        //Validate dimensionsSH
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.Insert();
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JournalTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JournalBatch);
        if GenJnlLine.Find('-') then
            //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnlLine);
            Casualline.Reset();
        Casualline.SetRange(Casualline."Document No.", Rec."No.");
        if Casualline.Find('-') then
            Casualline.Status := Casualline.Status::Fulfilled
    end;

    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record prPAYE;
        prVitalSetupInfo: Record "prVital Setup Info";
        curTempAmount: Decimal;
        KeepCount: Integer;
    begin
        KeepCount := 0;
        prVitalSetupInfo.Get();
        curTaxablePay := Casualline."Basic Amount" - prVitalSetupInfo."NSSF Employee";
        prPAYE.Reset();
        if prPAYE.FindFirst() then begin
            if curTaxablePay < prPAYE."PAYE Tier" then
                exit;
            repeat
                KeepCount += 1;
                curTempAmount := curTaxablePay;
                if curTaxablePay = 0 then
                    exit;
                if KeepCount = prPAYE.Count then   //this is the last record or loop
                    curTaxablePay := curTempAmount
                else
                    if curTempAmount >= prPAYE."PAYE Tier" then
                        curTempAmount := prPAYE."PAYE Tier"
                    else
                        curTempAmount := curTempAmount;

                PAYE := PAYE + (curTempAmount * (prPAYE.Rate / 100));
                curTaxablePay := curTaxablePay - curTempAmount;
            until prPAYE.Next() = 0;
        end;
    end;

    procedure fnGetEmployeeNHIF(curBaseAmount: Decimal) NHIF: Decimal
    begin
    end;
}
