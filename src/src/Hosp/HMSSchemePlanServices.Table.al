Table 52202545 "HMS Scheme Plan Services"
{
    fields
    {
        field(1; "Code"; Code[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Charges".Code;

            trigger OnValidate()
            begin
                Charge.Get(Code);
                Description := Charge.Description;
                Amount := Charge.Amount;
                "Applicable Section" := Charge."Applicable Section";
                "Shortcut Dimension 1 Code" := Charge."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code" := Charge."Shortcut Dimension 2 Code";
                "Account type" := Charge."Account type";
                "Billing Type" := Charge."Billing Type";
                "Reccuring Type" := Charge."Reccuring Type";
                "Transaction Type" := Charge."Transaction Type";
                "Percentage Rate" := Charge."Percentage Rate";
                "Expense G/L Account No" := Charge."Expense G/L Account No";
                "Doctor Percentage" := Charge."Doctor Percentage";
                "Insurance Amount" := Charge."Insurance Amount";
                "Branch3 Amount" := Charge."Branch3 Amount";
                "Branch2 Amount" := Charge."Branch2 Amount";
            end;
        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Insurance; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(4; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Drugs; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Applicable Section"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Standing Charge,Registration,Triage,Appointment,Observation Room,Consultation Fee,Laboratory,Radiology,Pharmacy,Physiotheraphy';
            OptionMembers = "Standing Charge",Registration,Triage,Appointment,"Observation Room","Consultation Fee",Laboratory,Radiology,Pharmacy,Physiotheraphy;
        }
        field(7; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(8; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(9; "Account type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = "G/L Account",Vendor;
        }
        field(10; "Billing Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Once,Reccuring';
            OptionMembers = Once,Reccuring;
        }
        field(11; "Reccuring Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Daily,Hourly';
            OptionMembers = " ",Daily,Hourly;
        }
        field(12; "Transaction Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "HMS Transactions code"."Transaction Type";
        }
        field(13; "Percentage Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = '% Rate at which the insurance per on top of the (Amount)';
        }
        field(14; "Expense G/L Account No"; Code[20])
        {
            Caption = 'Account No';
            DataClassification = ToBeClassified;
            TableRelation = if ("Account type" = filter("G/L Account")) "G/L Account"."No."
            else
            if ("Account type" = filter(Vendor)) Vendor."No.";
        }
        field(15; "Doctor Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Insurance Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Branch2 Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Branch3 Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Insurance Name"; Text[100])
        {
            CalcFormula = lookup(Customer."Search Name" where("No." = field(Insurance)));
            FieldClass = FlowField;
        }
        field(20; "Branch"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".code where("Global Dimension No." = filter(1));
        }
    }

    keys
    {
        key(Key1; "Code", Insurance, Branch)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Charge: Record "HMS Charges";
}
