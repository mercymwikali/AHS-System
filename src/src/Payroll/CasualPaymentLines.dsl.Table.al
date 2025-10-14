Table 52202549 "Casual Payment Lines.dsl"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Editable = false;
            TableRelation = "Casual Payment Header.dsl"."No.";
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(4; "Account Type"; Option)
        {
            Caption = 'Account Type';
            InitValue = Vendor;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Vendor)) Vendor;
        }
        field(6; Description; Text[50])
        {
            Editable = true;
        }
        field(7; "Cheque No."; Code[20])
        {
        }
        field(8; "Posting Date"; Date)
        {
        }
        field(50008; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            InitValue = New;
            OptionCaption = 'New,Approval Pending,Transfer Budget Pending,Approved,Disapproved,Committed,,,,,Fulfilled,Canceled';
            OptionMembers = New,"Approval Pending","Transfer Budget Pending",Approved,Disapproved,Committed,,,,,Fulfilled,Canceled;
        }
        field(50010; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(50011; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(50012; "Basic Amount"; Decimal)
        {
        }
        field(50013; "PAYE Amount"; Decimal)
        {
        }
        field(50014; "NSSF Amount"; Decimal)
        {
        }
        field(50015; "NHIF Amount"; Decimal)
        {
        }
        field(50016; "Employee No"; Code[10])
        {
            TableRelation = if ("Employee Type" = filter(Permanent)) "HR-Employee"."No."
            else
            if ("Employee Type" = filter(Casual)) "Casual Employees.Dsl"."Casual No";

            trigger OnValidate()
            begin
                Empob.Reset();
                Empob.SetRange(Empob."Casual No", "Employee No");
                if Empob.Find('-') then begin
                    "Employee Name" := Empob."Full  Name";
                    "Bank Code" := Empob."Bank Code";
                    "Bank Name" := Empob."Bank Name";
                    "Bank Account No" := Empob."Bank Account Number";
                    Occupation := Empob."Task Code";
                    "Rate per Date" := Empob."Rate per Day";
                    "Rate per Month" := Empob."Rate Per Month";
                    "No of Days" := Empob."No of Days value";
                    "Shortcut Dimension 1 Code" := Empob."Revenue Division";
                    "Shortcut Dimension 2 Code" := Empob.Department;
                    "Basic Amount" := Empob."No of Days value" * Empob."Rate per Day";
                end else
                    HREmployeex.Reset();
                HREmployeex.SetRange(HREmployeex."No.", "Employee No");
                if HREmployeex.Find('-') then begin
                    "Employee Name" := HREmployeex."First Name" + ' ' + HREmployeex."Middle Name" + ' ' + HREmployeex."Last Name";
                    "Bank Code" := HREmployeex."Branch Bank";
                    "Bank Name" := HREmployeex."Branch Bank Name";
                    "Bank Account No" := HREmployeex."Bank Account Number";
                    Occupation := HREmployeex."Job Title";
                    "Rate per Date" := HREmployeex."Basic Salary" / 21;
                    "Rate per Month" := HREmployeex."Basic Salary";
                    "No of Days" := 30;
                    //"Shortcut Dimension 1 Code":=HREmployeex.;
                    "Shortcut Dimension 2 Code" := HREmployeex."Shortcut Dimension 2 Code";
                    "Basic Amount" := HREmployeex."Basic Salary";
                end;
            end;
        }
        field(50017; "Employee Name"; Text[50])
        {
        }
        field(50018; "Bank Code"; Code[50])
        {
            TableRelation = "Pr Bank Branches"."Bank Code";

            trigger OnValidate()
            begin
                if prBankStructure.Get("Bank Code") then
                    "Bank Name" := prBankStructure."Bank Name";
            end;
        }
        field(50019; "Bank Name"; Text[50])
        {
        }
        field(50020; "Bank Account No"; Code[30])
        {
        }
        field(50050; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnLookup()
            begin
                //ShowDocDim;
            end;
        }
        field(50051; "Rate per Month"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "No of Days"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Basic Amount" := "No of Days" * "Rate per Date";
            end;
        }
        field(50053; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Pay Stutatories"; Option)
        {
            BlankZero = true;
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;

            trigger OnValidate()
            begin
                TaxablePAYE := 0;
                ReliefAmount := 0;
                TotalPAYE := 0;
                NSSReliefSetUp.Get();
                if "Pay Stutatories" = "pay stutatories"::Yes then begin
                    TaxablePAYE := "Basic Amount" - NSSReliefSetUp."NSSF Employee";
                    ReliefAmount := NSSReliefSetUp."Tax Relief";
                    TotalPAYE := fnGetEmployeePaye(TaxablePAYE);
                    if TotalPAYE > 0 then
                        "PAYE Amount" := TotalPAYE - ReliefAmount
                    else
                        "PAYE Amount" := 0;
                    "NHIF Amount" := fnGetEmployeeNHIF("Basic Amount");
                    "NSSF Amount" := NSSReliefSetUp."NSSF Employee";
                    "Net Pay" := "Basic Amount" - ("PAYE Amount" + "NHIF Amount" + "NSSF Amount");
                end else
                    if "Pay Stutatories" = "pay stutatories"::No then begin
                        "Net Pay" := "Basic Amount";
                        "PAYE Amount" := 0;
                        "NSSF Amount" := 0;
                        "NHIF Amount" := 0;
                    end;
            end;
        }
        field(50055; Occupation; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50056; "Rate per Date"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Pay Rate"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',per Day,Per Month';
            OptionMembers = ,"per Day","Per Month";

            trigger OnValidate()
            begin
                Noofdays := 0;
                CasualObject.Reset();
                CasualObject.SetRange(CasualObject."Casual No", "Employee No");
                if CasualObject.Find('-') then
                    if "Pay Rate" = "pay rate"::"per Day" then
                        "Basic Amount" := "Rate per Date" * "No of Days"
                    else
                        if "Pay Rate" = "pay rate"::"Per Month" then begin
                            Noofdays := ROUND(("No of Days" / 30), 1, '<');
                            if Noofdays > 0 then
                                "Basic Amount" := "Rate per Month" * Noofdays
                            else
                                "Basic Amount" := "Rate per Month";
                            "Period (Month)" := Noofdays;
                        end;
            end;
        }
        field(50058; "Period (Month)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Net Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "ID Number"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Empob.Reset();
                Empob.SetRange(Empob."ID Number", "ID Number");
                if Empob.Find('-') then begin
                    Init();
                    Copy(Rec);
                    if Delete() then begin
                        "Employee Name" := Empob."Full  Name";
                        "Bank Code" := Empob."Bank Code";
                        "Bank Name" := Empob."Bank Name";
                        "Bank Account No" := Empob."Bank Account Number";
                        Occupation := Empob."Task Code";
                        "Rate per Date" := Empob."Rate per Day";
                        "Rate per Month" := Empob."Rate Per Month";
                        "No of Days" := Empob."No of Days value";
                        "Shortcut Dimension 1 Code" := Empob."Revenue Division";
                        "Shortcut Dimension 2 Code" := Empob.Department;
                        "Basic Amount" := Empob."No of Days value" * Empob."Rate per Day";
                        Insert();
                    end;
                end;
            end;
        }
        field(50062; "Pension Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "KUSU Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "UASU Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Employee Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Casual,Part-Timer,Permanent';
            OptionMembers = ,Casual,"Part-Timer",Permanent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Employee No", "Payroll Period", "ID Number", "Line No.", "Employee Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CasualObject: Record "Casual Employees.Dsl";
        Empob: Record "Casual Employees.Dsl";
        HREmployeex: Record "HR-Employee";
        prBankStructure: Record "Pr Bank Branches";
        NSSReliefSetUp: Record "prVital Setup Info";
        ReliefAmount: Decimal;
        TaxablePAYE: Decimal;
        TotalPAYE: Decimal;
        Noofdays: Integer;

    procedure DeleteEncumCommitLines(ThisReqLine: Record "Casual Payment Lines")
    begin
        //Delete Encumbrances & Commitments
        //IF Status = Status::New THEN
        //BudgetManagerer.PayVoucherDeleteEncumberLines(Rec,0)
        //ELSE ERROR(Text5000,"Document No.");
        //Delete Encumbrances & Commitments
    end;

    procedure fnGetEmployeePaye(curTaxablePay: Decimal) PAYE: Decimal
    var
        prPAYE: Record prPAYE;
        curTempAmount: Decimal;
        KeepCount: Integer;
    begin
        KeepCount := 0;
        curTaxablePay := "Basic Amount" - 200;
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
    var
        prNHIF: Record prNHIF;
    begin
        curBaseAmount := "Basic Amount";
        prNHIF.Reset();
        prNHIF.SetCurrentkey(prNHIF."Tier Code");
        if prNHIF.FindFirst() then
            repeat
                if ((curBaseAmount >= prNHIF."Lower Limit") and (curBaseAmount <= prNHIF."Upper Limit")) then
                    NHIF := prNHIF.Amount;
            until prNHIF.Next() = 0;
    end;
}
