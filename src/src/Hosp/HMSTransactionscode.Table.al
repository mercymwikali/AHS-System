Table 52202697 "HMS Transactions code"
{
    DrillDownPageID = "HMS Transaction code List";
    LookupPageID = "HMS Transaction code List";

    fields
    {
        field(1; "Transaction Type"; Code[30])
        {
        }
        field(2; Description; Text[200])
        {
        }
        field(3; "Income G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Expense G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(5; "Calculate Doctor Fee"; Boolean)
        {
        }
        field(6; "Calculate Insurance Fee"; Boolean)
        {
        }
        field(7; "Patient No Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(8; Amount; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Transaction Type" = field("Transaction Type"),
                                                                          "Patient No." = field("Patient No Filter"),
                                                                          Date = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(9; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(10; "Patient Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(11; "Receipt Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Line q"."Total Amount" where(Date = field("Date Filter"),
                                                                     "HSM Transaction Type" = field("Transaction Type")));
            FieldClass = FlowField;
        }
        field(12; "Posted Amount"; Decimal)
        {
            CalcFormula = - sum("G/L Entry".Amount where("G/L Account No." = field("Income G/L Account"),
                                                         "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(13; "Invoice Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Transaction Type" = field("Transaction Type"),
                                                                          "Patient No." = field("Patient No Filter"),
                                                                          Date = field("Date Filter"),
                                                                          Posted = filter(true),
                                                                          "Insurance No" = filter(<> ''),
                                                                          "Exist In GL" = filter(true)));
            FieldClass = FlowField;
        }
        field(14; "Cash Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Transaction Type" = field("Transaction Type"),
                                                                          "Patient No." = field("Patient No Filter"),
                                                                          Date = field("Date Filter"),
                                                                          Posted = filter(true),
                                                                          "Insurance No" = filter('')));
            FieldClass = FlowField;
        }
        field(15; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(16; "Hide InReport"; Boolean)
        {
        }
        field(17; "Insurance Percentage"; Decimal)
        {
        }
        field(18; "Department Code"; code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = const(2));
        }
        field(19; "NHIF Capitation Covered"; Boolean)
        {
        }
        field(20; "Disable Manual Billing"; Boolean)
        {
        }
        field(21; "Capitation Cost G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(22; "Require Doctor ID"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
