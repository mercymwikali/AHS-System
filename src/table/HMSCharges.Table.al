Table 85180 "HMS Charges"
{
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "HMS Charges";
    LookupPageID = "HMS Charges";

    fields
    {
        field(50000; "Code"; Code[150])
        {
        }
        field(50001; Description; Text[150])
        {
        }
        field(50002; "Income G/L Account No"; Code[20])
        {
            TableRelation = if ("Account type" = filter("G/L Account")) "G/L Account"."No."
            else
            if ("Account type" = filter(Vendor)) Vendor."No.";
        }
        field(50003; Amount; Decimal)
        {
        }
        field(50004; Drugs; Boolean)
        {
        }
        field(50005; "Applicable Section"; Enum "Charges Applicable Section")
        {
            
            // OptionCaption = 'Standing Charge,Registration,Triage,Appointment,Observation Room,Consultation Fee,Laboratory,Radiology,Pharmacy,Physiotheraphy';
            // OptionMembers = "Standing Charge",Registration,Triage,Appointment,"Observation Room","Consultation Fee",Laboratory,Radiology,Pharmacy,Physiotheraphy;
        }
        field(50006; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(50007; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(50008; "Account type"; Option)
        {
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = "G/L Account",Vendor;
        }
        field(50009; "Billing Type"; Option)
        {
            OptionCaption = 'Once,Reccuring';
            OptionMembers = Once,Reccuring;
        }
        field(50010; "Reccuring Type"; Option)
        {
            OptionCaption = ' ,Daily,Hourly';
            OptionMembers = " ",Daily,Hourly;
        }
        field(50011; "Transaction Type"; Code[50])
        {
            Editable = true;
            TableRelation = "HMS Transactions code"."Transaction Type";
        }
        field(50012; "Percentage Rate"; Decimal)
        {
            Description = '% Rate at which the insurance per on top of the (Amount)';
        }
        field(50013; "Expense G/L Account No"; Code[20])
        {
            TableRelation = if ("Account type" = filter("G/L Account")) "G/L Account"."No."
            else
            if ("Account type" = filter(Vendor)) Vendor."No.";
        }
        field(50014; "Doctor Percentage"; Decimal)
        {
        }
        field(50015; "Insurance Amount"; Decimal)
        {
        }
        field(50016; "Branch2 Amount"; Decimal)
        {
        }
        field(50017; "Branch3 Amount"; Decimal)
        {
        }
        field(50018; "Allow Deletion"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
        key(Key3; Amount)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
        fieldgroup(Brick; "Code", Description, Amount)
        {
        }
    }
}
