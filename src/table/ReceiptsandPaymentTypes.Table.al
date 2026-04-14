Table 85132 "Receipts and Payment Types"
{
    DrillDownPageID = "Receipt an Payment Types L UP";
    LookupPageID = "Receipt an Payment Types L UP";

    fields
    {
        field(50000; "Code"; Code[50])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[100])
        {
        }
        field(50002; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Staff,None';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Staff,"None";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::"G/L Account" then
                    "Direct Expense" := true
                else
                    "Direct Expense" := false;
            end;
        }
        field(50003; Type; Option)
        {
            NotBlank = true;
            OptionCaption = ' ,Receipt,Payment,Imprest,Claim,Advance';
            OptionMembers = " ",Receipt,Payment,Imprest,Claim,Advance;
        }
        field(50004; "VAT Chargeable"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(50005; "Withholding Tax Chargeable"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(50006; "VAT Code"; Code[20])
        {
            TableRelation = "Tariff Codes";
        }
        field(50007; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Tariff Codes";
        }
        field(50008; "Default Grouping"; Code[20])
        {
            TableRelation = if ("Account Type" = const(Customer)) "Customer Posting Group"
            else
            if ("Account Type" = const(Vendor)) "Vendor Posting Group"
            else
            if ("Account Type" = const("Bank Account")) "Bank Account Posting Group"
            else
            if ("Account Type" = const("Fixed Asset")) "FA Posting Group"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner";
        }
        field(50009; "G/L Account"; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"."No."
            else
            if ("Account Type" = const(Vendor)) Vendor."No.";

            trigger OnValidate()
            begin
                GLAcc.Reset();
                if GLAcc.Get("G/L Account") then begin
                    if Type = Type::Payment then
                        GLAcc.TestField(GLAcc."Budget Controlled", true);
                    if GLAcc."Direct Posting" = false then
                        Error('Direct Posting must be True');
                end;
                /*
                IF (Type=Type::Receipt) AND NOT (GLAcc."Account Category"=GLAcc."Account Category"::Income) THEN BEGIN
                ERROR('You Only Select the Income Category Accounts');
                  END;
                */
            end;
        }
        field(50010; "Pending Voucher"; Boolean)
        {
        }
        field(50011; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if "Account Type" <> "account type"::"Bank Account" then
                    Error('You can only enter Bank No where Account Type is Bank Account');
            end;
        }
        field(50012; "Transation Remarks"; Text[250])
        {
            NotBlank = true;
        }
        field(50013; "Payment Reference"; Option)
        {
            OptionMembers = Normal,"Farmer Purchase";
        }
        field(50014; "Customer Payment On Account"; Boolean)
        {
        }
        field(50015; "Direct Expense"; Boolean)
        {
            Editable = false;
        }
        field(50016; "Calculate Retention"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(50017; "Retention Code"; Code[20])
        {
            TableRelation = "Tariff Codes";
        }
        field(50018; Blocked; Boolean)
        {
        }
        field(50019; "Retention Fee Code"; Code[20])
        {
            TableRelation = "Tariff Codes";
        }
        field(50020; "Retention Fee Applicable"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(50021; "Subsistence?"; Boolean)
        {
        }
        field(50022; "Lecturer Claim?"; Boolean)
        {
        }
        field(50023; "VAT Withheld Code"; Code[20])
        {
            TableRelation = "Tariff Codes".Code;
        }
        field(50024; "Council Claim?"; Boolean)
        {
        }
        field(50025; "Telephone Allowance?"; Boolean)
        {
        }
        field(50026; "PAYE Tax Chargeable"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(50027; "PAYE Tax Code"; Code[20])
        {
            TableRelation = "Tariff Codes";
        }
        field(50028; "Use PAYE Table"; Boolean)
        {
        }
        field(50029; "Allow Receipt Disbursment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Require Admission No"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Not Vatable"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if Type = Type::Imprest then begin
            ImprestLine.SetRange(ImprestLine."Advance Type", Code);
            if ImprestLine.Find('-') then
                Error('You cannot delete this imprest type because it is already in use');
        end;

        if Type = Type::Receipt then begin
            RecLine.SetRange(RecLine.Type, Code);
            if RecLine.Find('-') then
                Error('You cannot delete this Receipt type because it is already in use');
        end;

        if Type = Type::Payment then begin
            PayLine.SetRange(PayLine.Type, Code);
            if PayLine.Find('-') then
                Error('You cannot delete this Payment type because it is already in use');
        end;

        if Type = Type::Claim then begin
            ClaimLine.SetRange(ClaimLine."Advance Type", Code);
            if ClaimLine.Find('-') then
                Error('You cannot delete this Claim type because it is already in use');
        end;
    end;

    var
        GLAcc: Record "G/L Account";
        ImprestLine: Record "Imprest Lines";
        PayLine: Record "Payment Line";
        RecLine: Record "Receipt Line q";
        ClaimLine: Record "Staff Claim Lines";
}
