Table 85002 Committment
{
    DrillDownPageID = "Commitment Entries";
    LookupPageID = "Commitment Entries";

    fields
    {
        field(50000; "Line No."; Integer)
        {
        }
        field(50001; Date; Date)
        {
        }
        field(50002; "Posting Date"; Date)
        {
        }
        field(50003; "Document Type"; Option)
        {
            OptionCaption = 'LPO,Requisition,Imprest,Payment Voucher,PettyCash,PurchInvoice,StaffClaim,StaffAdvance,StaffSurrender,Salary Advance';
            OptionMembers = LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance,StaffSurrender,"Salary Advance";
        }
        field(50004; "Document No."; Code[30])
        {
        }
        field(50005; Amount; Decimal)
        {
        }
        field(50006; "Month Budget"; Decimal)
        {
        }
        field(50007; "Month Actual"; Decimal)
        {
        }
        field(50008; Committed; Boolean)
        {
        }
        field(50009; "Committed By"; Code[20])
        {
        }
        field(50010; "Committed Date"; Date)
        {
        }
        field(50011; "Committed Time"; Time)
        {
        }
        field(50012; "Committed Machine"; Text[100])
        {
        }
        field(50013; Cancelled; Boolean)
        {
        }
        field(50014; "Cancelled By"; Code[20])
        {
        }
        field(50015; "Cancelled Date"; Date)
        {
        }
        field(50016; "Cancelled Time"; Time)
        {
        }
        field(50017; "Cancelled Machine"; Text[100])
        {
        }
        field(50018; "Shortcut Dimension 1 Code"; Code[20])
        {
        }
        field(50019; "Shortcut Dimension 2 Code"; Code[20])
        {
        }
        field(50020; "Shortcut Dimension 3 Code"; Code[20])
        {
        }
        field(50021; "Shortcut Dimension 4 Code"; Code[20])
        {
        }
        field(50022; "G/L Account No."; Code[20])
        {
        }
        field(50023; Budget; Code[20])
        {
        }
        field(50024; "Vendor/Cust No."; Code[20])
        {
        }
        field(50025; Type; Option)
        {
            OptionMembers = " ",Vendor,Customer;
        }
        field(50026; "EXist GL"; Integer)
        {
            CalcFormula = count("G/L Entry" where("Document No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50027; "Exist Posted Inv"; Integer)
        {
            CalcFormula = count("Purch. Inv. Header" where("Order No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50028; Description; Text[250])
        {
        }
        field(50029; "Uploaded Manually"; Boolean)
        {
        }
        field(50030; "Budget Check Criteria"; Option)
        {
            OptionMembers = "Current Month","Whole Year";
        }
        field(50031; "Actual Source"; Option)
        {
            OptionMembers = "G/L Entry","Analysis View Entry";
        }
        field(50032; "Document Line No."; Integer)
        {
        }
        field(50033; "Item No."; code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Budget, "G/L Account No.", "Posting Date", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "G/L Account No.", "Posting Date", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code", "Shortcut Dimension 4 Code")
        {
            SumIndexFields = Amount;
        }
        key(Key4; "G/L Account No.", Cancelled, "Shortcut Dimension 2 Code", Date)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}
