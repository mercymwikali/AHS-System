Table 85107 "InterBank Transfers"
{
    DrillDownPageID = "Interbank Transfer";
    LookupPageID = "Interbank Transfer";

    fields
    {
        field(50000; No; Code[20])
        {
            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    CashOfficeSetup.Get();
                    NoSeriesMgt.TestManual(CashOfficeSetup."InterBank Transfer No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(50001; Date; Date)
        {
        }
        field(50002; "Pay Mode"; Option)
        {
            OptionMembers = " ",Cash,Cheque,EFT,"Custom 1","Custom 2","Custom 3","Custom 4","Custom 5";
        }
        field(50003; "Receiving Account"; Code[20])
        {
            TableRelation = if ("Receiving Transfer Type" = const("Intra-Company")) "Bank Account"
            else
            if ("Receiving Transfer Type" = const("Inter-Company")) "IC Partner";

            trigger OnValidate()
            begin
                "Amount 2" := 0;
                "Exch. Rate Destination" := 0;
                "Request Amt LCY" := 0;
                "Reciprical 2" := 0;
                Remarks := '';
                "Receiving Bank Account Name" := '';

                if "Receiving Transfer Type" = "receiving transfer type"::"Intra-Company" then begin
                    BankAcc.Reset();
                    if BankAcc.Get("Receiving Account") then begin
                        "Receiving Bank Account Name" := BankAcc.Name;
                        "Currency Code Destination" := BankAcc."Currency Code";
                    end;
                end
                else
                    if "Receiving Transfer Type" = "receiving transfer type"::"Inter-Company" then begin
                        ICPartner.Reset();
                        if ICPartner.Get("Receiving Account") then begin
                            "Receiving Bank Account Name" := ICPartner.Name;
                            "Currency Code Destination" := ICPartner."Currency Code";
                        end;
                    end;
            end;
        }
        field(50004; "Received From"; Text[100])
        {
        }
        field(50005; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50006; "Receiving Bank Account Name"; Text[150])
        {
        }
        field(50007; Posted; Boolean)
        {
        }
        field(50008; "Date Posted"; Date)
        {
        }
        field(50009; "Time Posted"; Time)
        {
        }
        field(50010; "Posted By"; Code[20])
        {
        }
        field(50011; Remarks; Text[50])
        {
        }
        field(50012; "Transaction Name"; Text[100])
        {
        }
        field(50013; Amount; Decimal)
        {
            trigger OnValidate()
            begin
                if "Currency Code Source" = '' then
                    "Request Amt LCY" := Amount;

                if "Exch. Rate Source" <> 0 then
                    Validate("Exch. Rate Source");
                BankAcc.Reset();
                BankAcc.SetRange("No.", "Receiving Account");
                if BankAcc.Find('-') then begin
                    BankAcc.CalcFields(Balance);
                    if BankAcc."Maximum Cashier Holding" > 0 then begin
                        if Amount > BankAcc."Maximum Cashier Holding" then Error('Amount exceed maximum holding for this account %1', BankAcc."Maximum Cashier Holding" - (Amount));
                        if (Amount + BankAcc.Balance) > BankAcc."Maximum Cashier Holding" then Error('Amount exceed maximum holding for this account by %1', BankAcc."Maximum Cashier Holding" - (Amount + BankAcc.Balance));
                    end;
                end;
            end;
        }
        field(50014; "Paying Account"; Code[20])
        {
            TableRelation = if ("Source Transfer Type" = const("Intra-Company")) "Bank Account"
            else
            if ("Source Transfer Type" = const("Inter-Company")) "IC Partner";

            trigger OnValidate()
            begin
                Amount := 0;
                "Exch. Rate Source" := 0;
                "Reciprical 1" := 0;
                "Exch. Rate Source" := 0;
                "Pay Amt LCY" := 0;
                "Paying  Bank Account Name" := '';

                if "Source Transfer Type" = "source transfer type"::"Intra-Company" then begin
                    BankAcc.Reset();
                    if BankAcc.Get("Paying Account") then begin
                        "Paying  Bank Account Name" := BankAcc.Name;
                        "Currency Code Source" := BankAcc."Currency Code";
                    end;
                end
                else
                    if "Source Transfer Type" = "source transfer type"::"Inter-Company" then begin
                        ICPartner.Reset();
                        if ICPartner.Get("Paying Account") then begin
                            "Paying  Bank Account Name" := ICPartner.Name;
                            "Currency Code Source" := ICPartner."Currency Code";
                        end;
                    end;
            end;
        }
        field(50015; "Bank Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(50016; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin

                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Global Dimension 1 Code");
                if DimVal.Find('-') then
                    "Branch Name" := DimVal.Name
            end;
        }
        field(50017; "Source Department Code"; Code[20])
        {
            Caption = 'Source Budget Center Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50018; "Branch Name"; Text[50])
        {
            Caption = 'Source Depot Name';
        }
        field(50019; "Receiving Depot Code"; Code[20])
        {
            Caption = 'Receiving Depot Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin

                DimVal.Reset();
                DimVal.SetRange(DimVal."Global Dimension No.", 2);
                DimVal.SetRange(DimVal.Code, "Receiving Depot Code");
                if DimVal.Find('-') then
                    "Receiving Depot Name" := DimVal.Name
            end;
        }
        field(50020; "Receiving Department Code"; Code[20])
        {
            Caption = 'Receiving Department Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50021; "Receiving Depot Name"; Text[50])
        {
        }
        field(50022; "Receiving Department Name"; Text[50])
        {
        }
        field(50023; "Source Department Name"; Text[50])
        {
            Caption = 'Source Department Name';
        }
        field(50024; "Paying  Bank Account Name"; Text[50])
        {
        }
        field(50025; "Inter Bank Template Name"; Code[20])
        {
            Caption = 'Inter Bank Template Name';
            NotBlank = true;
            TableRelation = "Gen. Journal Template";
        }
        field(50026; "Inter Bank Journal Batch"; Code[20])
        {
            Caption = 'Inter Bank Journal Batch';
            NotBlank = true;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Inter Bank Template Name"));
        }
        field(50027; "Receiving Transfer Type"; Option)
        {
            OptionMembers = "Intra-Company","Inter-Company";
        }
        field(50028; "Source Transfer Type"; Option)
        {
            OptionMembers = "Intra-Company","Inter-Company";
        }
        field(50029; "Currency Code Destination"; Code[20])
        {
            Editable = false;
            TableRelation = Currency;
        }
        field(50030; "Currency Code Source"; Code[20])
        {
            Editable = false;
            TableRelation = Currency;
        }
        field(50031; "Amount 2"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Currency Code Destination" = '' then
                    "Request Amt LCY" := "Amount 2";

                if "Exch. Rate Destination" <> 0 then
                    Validate("Exch. Rate Destination");
            end;
        }
        field(50032; "Exch. Rate Source"; Decimal)
        {
            BlankZero = false;
            DecimalPlaces = 0 : 15;
            MinValue = 0;

            trigger OnValidate()
            begin
                "Reciprical 1" := 1 / "Exch. Rate Source";
                Validate("Reciprical 1");
            end;
        }
        field(50033; "Exch. Rate Destination"; Decimal)
        {
            DecimalPlaces = 0 : 15;
            MinValue = 0;

            trigger OnValidate()
            begin
                "Reciprical 2" := 1 / "Exch. Rate Destination";
                Validate("Reciprical 2");
            end;
        }
        field(50034; "Reciprical 1"; Decimal)
        {
            DecimalPlaces = 5 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                "Pay Amt LCY" := ROUND(Amount * "Reciprical 1");
            end;
        }
        field(50035; "Reciprical 2"; Decimal)
        {
            DecimalPlaces = 5 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                "Request Amt LCY" := ROUND("Amount 2" * "Reciprical 2");
            end;
        }
        field(50036; "Balance 1"; Decimal)
        {
        }
        field(50037; "Balance 2"; Decimal)
        {
        }
        field(50038; "Current Source A/C Bal."; Decimal)
        {
        }
        field(50039; "Register Number"; Integer)
        {
        }
        field(50040; "From No"; Integer)
        {
        }
        field(50041; "To No"; Integer)
        {
        }
        field(50042; "Shortcut Dimension 3 Code"; Code[20])
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
        field(50043; "Shortcut Dimension 4 Code"; Code[20])
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
        field(50044; Dim3; Text[250])
        {
        }
        field(50045; Dim4; Text[250])
        {
        }
        field(50046; "Shortcut Dimension 3 Code1"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                DimVal.Reset();
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 3 Code1");
                if DimVal.Find('-') then
                    Dim31 := DimVal.Name
            end;
        }
        field(50047; "Shortcut Dimension 4 Code1"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                DimVal.Reset();
                //DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SetRange(DimVal.Code, "Shortcut Dimension 4 Code1");
                if DimVal.Find('-') then
                    Dim41 := DimVal.Name
            end;
        }
        field(50048; Dim31; Text[250])
        {
        }
        field(50049; Dim41; Text[250])
        {
        }
        field(50050; "Sending Responsibility Center"; Code[10])
        {
            Caption = 'Sending Responsibility Center';
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin

                TestField(Posted, false);
                // if not UserMgt.CheckRespCenter(1, "Sending Responsibility Center") then
                //   Error(
                //     Text001,
                //      RespCenter.TableCaption, UserMgt.GetPurchasesFilter);

                Amount := 0;
                "Exch. Rate Source" := 0;
                "Reciprical 1" := 0;
                "Exch. Rate Source" := 0;
                "Pay Amt LCY" := 0;
                "Paying  Bank Account Name" := '';
                "Sending Resp Centre" := '';
                "Paying Account" := '';
                "Currency Code Source" := '';

                if RespCenter.Get("Sending Responsibility Center") then
                    "Sending Resp Centre" := RespCenter.Code;
            end;
        }
        field(50051; "Reciept Responsibility Center"; Code[10])
        {
            Caption = 'Reciept Responsibility Center';
            TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin

                TestField(Posted, false);
                // if not UserMgt.CheckRespCenter(1, "Sending Responsibility Center") then
                //    Error(
                //       Text001,
                //       RespCenter.TableCaption, UserMgt.GetPurchasesFilter);

                "Amount 2" := 0;
                "Exch. Rate Destination" := 0;
                "Request Amt LCY" := 0;
                "Reciprical 2" := 0;
                Remarks := '';
                "Receiving Bank Account Name" := '';
                "Receipt Resp Centre" := '';
                "Receiving Account" := '';
                "Currency Code Destination" := '';

                if RespCenter.Get("Reciept Responsibility Center") then
                    "Receipt Resp Centre" := RespCenter.Code;
            end;
        }
        field(50052; "Sending Resp Centre"; Text[60])
        {
            Editable = false;
        }
        field(50053; "Receipt Resp Centre"; Text[60])
        {
            Editable = false;
        }
        field(50054; Status; Option)
        {
            Description = 'Stores the status of the record in the database';
            OptionMembers = Pending,Posted,Cancelled,"Pending Approval",Approved;
        }
        field(50055; "Created By"; Code[30])
        {
        }
        field(50056; "Request Amt LCY"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(50057; "Pay Amt LCY"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(50058; "External Doc No."; Code[20])
        {
        }
        field(50059; "Transfer Release Date"; Date)
        {
        }
        field(50060; "Cancelled By"; Code[30])
        {
        }
        field(50061; "Date Cancelled"; Date)
        {
        }
        field(50062; "Time Cancelled"; Time)
        {
        }
        field(50063; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Interbank Transfer Lines".Amount where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(50064; "Transactions Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Cash,Cheque,Mobile Money';
            OptionMembers = " ",Cash,Cheque,Mobile;
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
            CashOfficeSetup.Get();
            CashOfficeSetup.TestField(CashOfficeSetup."InterBank Transfer No.");
            No := NoSeriesMgt.GetNextNo(CashOfficeSetup."InterBank Transfer No.", 0D, true);
        end;
    end;

    var
        BankAcc: Record "Bank Account";
        CashOfficeSetup: Record "Cash Office Setup";
        DimVal: Record "Dimension Value";
        ICPartner: Record "IC Partner";
        RespCenter: Record "Responsibility Center BR";
        NoSeriesMgt: Codeunit "No. Series";
}
