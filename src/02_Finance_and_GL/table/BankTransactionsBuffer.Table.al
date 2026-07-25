Table 85073 "Bank Transactions Buffer"
{
    fields
    {
        field(50000; "Transaction Code"; Code[50])
        {
            NotBlank = true;
        }
        field(50001; Date; DateTime)
        {
            NotBlank = true;
        }
        field(50002; Description; Text[150])
        {
        }
        field(50003; Amount; Decimal)
        {
            NotBlank = true;
        }
        field(50004; Posted; Boolean)
        {
        }
        field(50005; "Receipt No"; Code[50])
        {
        }
        field(50006; "Student No."; Code[50])
        {
            TableRelation = Customer;
            ValidateTableRelation = false;
        }
        field(50007; Unallocated; Boolean)
        {
        }
        field(50008; "Cheque No"; Code[50])
        {
        }
        field(50009; "Stud Exist"; Integer)
        {
            CalcFormula = count(Customer where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(50010; Name; Text[100])
        {
        }
        field(50011; IDNo; Code[30])
        {
        }
        field(50012; "Transcation Date"; DateTime)
        {
        }
        field(50013; "Bank Code"; Code[30])
        {
        }
        field(50014; Type; Code[20])
        {
        }
        field(50015; "Batch Receipt No"; Code[20])
        {
            TableRelation = "Receipts Header"."No.";
        }
        field(50016; "Unidentified Type"; Option)
        {
            OptionCaption = ' ,Student,Application,Miscilenous';
            OptionMembers = " ",Student,"Application",Miscilenous;
        }
        field(50017; "Misc G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50018; UserID; Code[50])
        {
        }
        field(50019; "Receipted Bank"; Code[20])
        {
            CalcFormula = lookup("Bank Account Ledger Entry"."Bank Account No." where("Document No." = field("Receipt No")));
            FieldClass = FlowField;
        }
        field(50020; "Admission No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; Names; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(50022; "Posted Count"; Integer)
        {
            CalcFormula = count("Bank Account Ledger Entry" where("External Document No." = field("Transaction Code")));
            FieldClass = FlowField;
        }
        field(50023; "Posted Receipt No"; Code[20])
        {
            CalcFormula = lookup("Bank Account Ledger Entry"."Document No." where("External Document No." = field("Transaction Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Transaction Code")
        {
        }
        key(Key2; Posted, Date, "Student No.")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}
