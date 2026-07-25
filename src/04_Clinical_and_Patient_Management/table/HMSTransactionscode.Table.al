Table 85260 "HMS Transactions code"
{
    DrillDownPageID = "HMS Transaction code List";
    LookupPageID = "HMS Transaction code List";

    fields
    {
        field(50000; "Transaction Type"; Code[30])
        {
        }
        field(50001; Description; Text[200])
        {
        }
        field(50002; "Income G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50003; "Expense G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50004; "Calculate Doctor Fee"; Boolean)
        {
        }
        field(50005; "Calculate Insurance Fee"; Boolean)
        {
        }
        field(50006; "Patient No Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "HMS Patient"."Patient No.";
        }
        field(50007; Amount; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Transaction Type" = field("Transaction Type"),
                                                                          "Patient No." = field("Patient No Filter"),
                                                                          Date = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50008; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50009; "Patient Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,Corporate,Cash';
            OptionMembers = " ",Corporate,Cash;
        }
        field(50010; "Receipt Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Line q"."Total Amount" where(Date = field("Date Filter"),
                                                                     "HSM Transaction Type" = field("Transaction Type")));
            FieldClass = FlowField;
        }
        field(50011; "Posted Amount"; Decimal)
        {
            CalcFormula = - sum("G/L Entry".Amount where("G/L Account No." = field("Income G/L Account"),
                                                         "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50012; "Invoice Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Transaction Type" = field("Transaction Type"),
                                                                          "Patient No." = field("Patient No Filter"),
                                                                          Date = field("Date Filter"),
                                                                          Posted = filter(true),
                                                                          "Insurance No" = filter(<> ''),
                                                                          "Exist In GL" = filter(true)));
            FieldClass = FlowField;
        }
        field(50013; "Cash Amount"; Decimal)
        {
            CalcFormula = sum("HMS Patient Charges"."Total Amount" where("Transaction Type" = field("Transaction Type"),
                                                                          "Patient No." = field("Patient No Filter"),
                                                                          Date = field("Date Filter"),
                                                                          Posted = filter(true),
                                                                          "Insurance No" = filter('')));
            FieldClass = FlowField;
        }
        field(50014; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50015; "Hide InReport"; Boolean)
        {
        }
        field(50016; "Insurance Percentage"; Decimal)
        {
        }
        field(50017; "Department Code"; code[20])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = const(2));
        }
        field(50018; "NHIF Capitation Covered"; Boolean)
        {
        }
        field(50019; "Disable Manual Billing"; Boolean)
        {
        }
        field(50020; "Capitation Cost G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50021; "Require Doctor ID"; Boolean)
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
