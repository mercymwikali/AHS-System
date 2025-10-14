Table 52202886 "Imprest Lines"
{
    fields
    {
        field(1; No; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                // IF Pay.GET(No) THEN
                // "Imprest Holder":=Pay."Account No.";
            end;
        }
        field(2; "Account No:"; Code[10])
        {
            TableRelation = if ("Imprest Type" = filter(Imprest)) "G/L Account"."No."
            else
            if ("Imprest Type" = filter(ItemCash)) Item."No.";

            trigger OnValidate()
            begin
                TestField(Committed, false);
                if GLAcc.Get("Account No:") then
                    GLAcc.Validate(GLAcc."No.");
                "Account Name" := GLAcc.Name;
                GLAcc.TestField("Direct Posting", true);
                "Budgetary Control A/C" := GLAcc."Budget Controlled";
                Pay.SetRange(Pay."No.", No);
                if Pay.FindFirst() then
                    if Pay."Account No." <> '' then
                        "Imprest Holder" := Pay."Account No."
                    else
                        Error('Please Enter the Customer/Account Number');

                if "Imprest Type" = "imprest type"::ItemCash then
                    if Items.Get("Account No:") then begin
                        "Account Name" := Items.Description;
                        "Unit of Measure" := Items."Base Unit of Measure";
                    end;
            end;
        }
        field(3; "Account Name"; Text[80])
        {
            Editable = false;
        }
        field(4; Amount; Decimal)
        {
            trigger OnValidate()
            begin
                if "Currency Factor" <> 0 then
                    "Amount LCY" := Amount / "Currency Factor"
                else
                    "Amount LCY" := Amount;
            end;
        }
        field(5; "Due Date"; Date)
        {
        }
        field(6; "Imprest Holder"; Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(7; "Actual Spent"; Decimal)
        {
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Unit of Measure".Code;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                if "Imprest Type" = "imprest type"::ItemCash then begin
                    Amount := "Unit Cost (LCY)" * Quantity;
                    "Amount LCY" := "Unit Cost (LCY)" * Quantity;
                    Validate(Amount);
                end;
            end;
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField(No);
                TestField(Quantity);

                if "Imprest Type" = "imprest type"::ItemCash then begin
                    Amount := "Unit Cost (LCY)" * Quantity;
                    "Amount LCY" := "Unit Cost (LCY)" * Quantity;
                    Validate(Amount);
                end;
            end;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(41; "Apply to"; Code[20])
        {
        }
        field(42; "Apply to ID"; Code[20])
        {
        }
        field(44; "Surrender Date"; Date)
        {
        }
        field(45; Surrendered; Boolean)
        {
        }
        field(46; "M.R. No"; Code[20])
        {
        }
        field(47; "Date Issued"; Date)
        {
        }
        field(48; "Type of Surrender"; Option)
        {
            OptionMembers = " ",Cash,Receipt;
        }
        field(49; "Dept. Vch. No."; Code[20])
        {
        }
        field(50; "Cash Surrender Amt"; Decimal)
        {
        }
        field(51; "Bank/Petty Cash"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(52; "Surrender Doc No."; Code[20])
        {
        }
        field(53; "Date Taken"; Date)
        {
        }
        field(54; Purpose; Text[250])
        {
        }
        field(56; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(79; "Budgetary Control A/C"; Boolean)
        {
            Editable = true;
        }
        field(81; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(82; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the fourth global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(83; Committed; Boolean)
        {
        }
        field(84; "Advance Type"; Code[20])
        {
            TableRelation = "Receipts and Payment Types".Code where(Type = const(Imprest));

            trigger OnValidate()
            begin
                ImprestHeader.Reset();
                ImprestHeader.SetRange(ImprestHeader."No.", No);
                if ImprestHeader.Find('-') then
                    if (ImprestHeader.Status <> ImprestHeader.Status::Pending) then
                        Error('You Cannot Insert a new record when the status of the document is not Pending');

                RecPay.Reset();
                RecPay.SetRange(RecPay.Code, "Advance Type");
                RecPay.SetRange(RecPay.Type, RecPay.Type::Imprest);
                if RecPay.Find('-') then begin
                    "Account No:" := RecPay."G/L Account";
                    Validate("Account No:");
                end;

                //MODIFY;
            end;
        }
        field(85; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Currency Factor" <> 0 then
                    "Amount LCY" := Amount / "Currency Factor"
                else
                    "Amount LCY" := Amount;
            end;
        }
        field(86; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = true;
            TableRelation = Currency;
        }
        field(87; "Amount LCY"; Decimal)
        {
        }
        field(88; "EFT Bank Account No"; Code[20])
        {
        }
        field(89; "EFT Bank Code"; Code[20])
        {
        }
        field(90; "EFT Account Name"; Text[50])
        {
        }
        field(91; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(92; "Employee Job Group"; Code[10])
        {
            Editable = false;
        }
        field(93; "Daily Rate(Amount)"; Decimal)
        {
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(481; "Destination Code"; Code[20])
        {
            trigger OnValidate()
            begin
                getDestinationRateAndAmounts();
            end;
        }
        field(482; "No of Days"; Decimal)
        {
            trigger OnValidate()
            begin
                getDestinationRateAndAmounts();
            end;
        }
        field(50001; "Budgeted Amount"; Decimal)
        {
            CalcFormula = sum("G/L Budget Entry".Amount where("Global Dimension 1 Code" = field("Global Dimension 1 Code"),
                                                               "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                               "G/L Account No." = field("Account No:"), Date = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50002; "Actual Expenditure"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Account No:"),
                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Code"),
                                                        "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                        "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50003; "Committed Amount"; Decimal)
        {
            CalcFormula = sum(Committment.Amount where("Shortcut Dimension 1 Code" = field("Global Dimension 1 Code"),
                                                        "Shortcut Dimension 2 Code" = field("Shortcut Dimension 2 Code"),
                                                        "G/L Account No." = field("Account No:"), "Posting Date" = field("Date Filter"), Cancelled = const(False)));
            FieldClass = FlowField;
        }
        field(50004; "Budget Name"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;

            trigger OnValidate()
            begin
                CalcFields("Budgeted Amount");
                CalcFields("Actual Expenditure");
                CalcFields("Committed Amount");
                ImprestHeader.Reset();
                ImprestHeader.SetRange(ImprestHeader."No.", No);
                if ImprestHeader.Find('-') then begin
                    ImprestHeader."Budgeted Amount" := "Budgeted Amount";
                    ImprestHeader."Committed Amount" := "Committed Amount";
                    ImprestHeader."Actual Expenditure" := "Actual Expenditure";
                    ImprestHeader."Budget Balance" := "Budget Balance";
                end;
            end;
        }
        field(50005; "Budget Balance"; Decimal)
        {
        }
        field(50006; "Imprest Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Imprest,ItemCash';
            OptionMembers = Imprest,ItemCash;
        }
        field(50007; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(50008; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; No, "Advance Type", "Shortcut Dimension 2 Code", "Account No:", "Imprest Type")
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount LCY";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        ImprestHeader.Reset();
        ImprestHeader.SetRange(ImprestHeader."No.", No);
        if ImprestHeader.FindFirst() then
            if (ImprestHeader.Status = ImprestHeader.Status::Approved) or
            (ImprestHeader.Status = ImprestHeader.Status::Posted) or
            (ImprestHeader.Status = ImprestHeader.Status::"Pending Approval") then
                if "Account No:" <> '' then
                    Error('You Cannot Delete this record its status is not Pending');
        TestField(Committed, false);
    end;

    trigger OnInsert()
    begin
        ImprestHeader.Reset();
        ImprestHeader.SetRange(ImprestHeader."No.", No);
        if ImprestHeader.FindFirst() then begin
            "Date Taken" := ImprestHeader.Date;
            "Global Dimension 1 Code" := ImprestHeader."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
            "Due Date" := Today;
            "Date Issued" := Today;

            //ImprestHeader.TESTFIELD("Responsibility Center");
            ImprestHeader.TestField("Global Dimension 1 Code");
            ImprestHeader.TestField("Shortcut Dimension 2 Code");
            //"Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
            //"Shortcut Dimension 2 Code":=ImprestHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
            "Currency Factor" := ImprestHeader."Currency Factor";
            "Currency Code" := ImprestHeader."Currency Code";
        end;
    end;

    trigger OnModify()
    begin

        ImprestHeader.Reset();
        ImprestHeader.SetRange(ImprestHeader."No.", No);
        if ImprestHeader.FindFirst() then begin
            if (ImprestHeader.Status = ImprestHeader.Status::Approved) or
                (ImprestHeader.Status = ImprestHeader.Status::Posted) or
                (ImprestHeader.Status = ImprestHeader.Status::"Pending Approval") then
                Error('You Cannot Modify this record its status is not Pending');

            "Date Taken" := ImprestHeader.Date;
            // "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
            //"Shortcut Dimension 2 Code":=ImprestHeader."Shortcut Dimension 2 Code";
            "Shortcut Dimension 3 Code" := ImprestHeader."Shortcut Dimension 3 Code";
            "Shortcut Dimension 4 Code" := ImprestHeader."Shortcut Dimension 4 Code";
            "Currency Factor" := ImprestHeader."Currency Factor";
            "Currency Code" := ImprestHeader."Currency Code";
        end;

        TestField(Committed, false);
    end;

    var
        // objDestRateEntry: Record "HMS Observation Form Line Proc";
        objCust: Record Customer;
        GLAcc: Record "G/L Account";
        objEmp: Record "HR-Employee";
        ImprestHeader: Record "Imprest Header";
        Pay: Record "Imprest Header";
        Items: Record Item;
        RecPay: Record "Receipts and Payment Types";
        DimMgt: Codeunit DimensionManagement;
        CustNo: Code[50];
        EmpGrade: Code[50];
        EmpNo: Code[50];

    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', 'Imprest', "Line No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure getDestinationRateAndAmounts()
    begin
        //Reset the brare fields
        "Daily Rate(Amount)" := 0;
        Amount := 0;

        //Get the customer no
        Pay.Reset();
        Pay.SetRange(Pay."No.", No);
        if Pay.Find('-') then
            CustNo := Pay."Account No.";

        //Get the Emp No
        objCust.Reset();
        objCust.SetRange(objCust."No.", CustNo);
        if objCust.Find('-') then;
            //     EmpNo:=objCust."Employee Job Group"

        // get the grade
        objEmp.Reset();
        objEmp.SetRange(objEmp."No.", EmpNo);
        if objEmp.Find('-') then
            EmpGrade := objEmp.Grade;
        /*
//get the destination rate for the grade
  objDestRateEntry.RESET;
  objDestRateEntry.SETRANGE(objDestRateEntry."Employee Job Group",EmpGrade);
  objDestRateEntry.SETRANGE(objDestRateEntry."Destination Code","Destination Code");
  objDestRateEntry.SETRANGE(objDestRateEntry."Advance Code","Advance Type");
  IF objDestRateEntry.FIND('-') THEN BEGIN
   "Daily Rate(Amount)":=objDestRateEntry."Daily Rate (Amount)";
   Amount:=objDestRateEntry."Daily Rate (Amount)"*"No of Days";
  END;
         */
    end;
}
