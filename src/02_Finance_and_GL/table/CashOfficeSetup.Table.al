Table 85081 "Cash Office Setup"

{
    LookupPageId = "Cash Office Setup UP";
    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
        }
        field(50001; "Normal Payments No"; Code[10])
        {
            Caption = 'Receipts No';
            TableRelation = "No. Series";
        }
        field(50002; "Cheque Reject Period"; DateFormula)
        {
        }
        field(50003; "Petty Cash Payments No"; Code[10])
        {
            Caption = 'Petty Cash Payments No';
            TableRelation = "No. Series";
        }
        field(50004; "Current Budget"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(50005; "Current Budget Start Date"; Date)
        {
        }
        field(50006; "Current Budget End Date"; Date)
        {
        }
        field(50007; "Surrender Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50008; "Surrender  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Surrender Template"));
        }
        field(50009; "Payroll Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50010; "Payroll  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(50011; "Payroll Control A/C"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50012; "PV Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50013; "PV  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("PV Template"));
        }
        field(50014; "Contract No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50015; "Receipts No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50016; "Petty Cash Voucher  Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(50017; "Petty Cash Voucher Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(50018; "Max. Petty Cash Request"; Decimal)
        {
        }
        field(50019; "Imprest Req No"; Code[20])
        {
            Caption = 'Receipts No';
            TableRelation = "No. Series";
        }
        field(50020; "Quatation Request No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50021; "Tender Request No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50022; "Transport Pay Type"; Code[20])
        {
            TableRelation = Temp;
        }
        field(50023; "Minimum Chargeable Weight"; Decimal)
        {
        }
        field(50024; "Imprest Surrender No"; Code[20])
        {
            Caption = 'Imprest Surrender No';
            TableRelation = "No. Series";
        }
        field(50025; "Bank Deposit No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50026; "InterBank Transfer No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50027; "PA Payment Vouchers Nos"; Code[20])
        {
            Caption = 'Farmers Payment Vouchers Nos.';
            TableRelation = "No. Series".Code;
        }
        field(50028; "Cash Request Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50029; "Cash Issue Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50030; "Cash Receipt Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50031; "Cash Transfer Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50032; "Cash Transfer Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Cash Transfer Template"));
        }
        field(50033; "Enable AutoTeller Monitor"; Boolean)
        {
        }
        field(50034; "Alert After ?(Mins)"; Integer)
        {
        }
        field(50035; "Transporter Depot"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50036; "Transporter Department"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50037; "Transporter Cashier"; Code[20])
        {
            TableRelation = "Cash Office User Template";
        }
        field(50038; "Transporter PayType"; Code[20])
        {
            TableRelation = "Receipts and Payment Types".Code where(Type = filter(Payment));
        }
        field(50039; "Cashier Transfer Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50040; "Interim Transfer Account"; Code[20])
        {
            TableRelation = "Bank Account" where("Bank Type" = const(Cash));
        }
        field(50041; "Default Bank Deposit Slip A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50042; "Staff Claim No"; Code[20])
        {
            Caption = 'Staff Claim No';
            TableRelation = "No. Series".Code;
        }
        field(50043; "Other Staff Advance No"; Code[20])
        {
            Caption = 'Other Staff Advance No';
            TableRelation = "No. Series".Code;
        }
        field(50044; "Staff Advance Surrender No"; Code[20])
        {
            Caption = 'Staff Adv. Surrender No';
            TableRelation = "No. Series".Code;
        }
        field(50045; "Prompt Cash Reimbursement"; Boolean)
        {
        }
        field(50046; "Payment Schedule No"; Code[20])
        {
            Caption = 'Payment Schedule No';
            TableRelation = "No. Series".Code;
        }
        field(50047; "Stores Requisition No"; Code[20])
        {
            Caption = 'Stores Requisition No';
            TableRelation = "No. Series".Code;
        }
        field(50048; "Items issue Template"; Code[10])
        {
            TableRelation = "Item Journal Template";
        }
        field(50049; "Items Issue Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Items issue Template"));
        }
        field(50050; "Quotation Request No"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50051; "Vote Transfer"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50052; "Item Cash Purchase Control Ac."; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50053; "Requisition Default Vendor"; Code[20])
        {
            TableRelation = "Vendor"."No.";
        }
        field(50054; "Casual Payment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50055; "Casual Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50056; "Parttimers Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50057; "Invoice Dispatch Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
