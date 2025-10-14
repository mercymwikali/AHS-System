Table 52202873 "Bank Transactions Buffer"
{
    fields
    {
        field(1; "Transaction Code"; Code[50])
        {
            NotBlank = true;
        }
        field(2; Date; DateTime)
        {
            NotBlank = true;
        }
        field(3; Description; Text[150])
        {
        }
        field(4; Amount; Decimal)
        {
            NotBlank = true;
        }
        field(5; Posted; Boolean)
        {
        }
        field(6; "Receipt No"; Code[50])
        {
        }
        field(7; "Student No."; Code[50])
        {
            TableRelation = Customer;
            ValidateTableRelation = false;
        }
        field(8; Unallocated; Boolean)
        {
        }
        field(9; "Cheque No"; Code[50])
        {
        }
        field(10; "Stud Exist"; Integer)
        {
            CalcFormula = count(Customer where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(12; Name; Text[100])
        {
        }
        field(13; IDNo; Code[30])
        {
        }
        field(14; "Transcation Date"; DateTime)
        {
        }
        field(15; "Bank Code"; Code[30])
        {
        }
        field(19; Type; Code[20])
        {
        }
        field(20; "Batch Receipt No"; Code[20])
        {
            TableRelation = "Receipts Header"."No.";
        }
        field(21; "Unidentified Type"; Option)
        {
            OptionCaption = ' ,Student,Application,Miscilenous';
            OptionMembers = " ",Student,"Application",Miscilenous;
        }
        field(22; "Misc G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(23; UserID; Code[50])
        {
        }
        field(24; "Receipted Bank"; Code[20])
        {
            CalcFormula = lookup("Bank Account Ledger Entry"."Bank Account No." where("Document No." = field("Receipt No")));
            FieldClass = FlowField;
        }
        field(25; "Admission No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Names; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Student No.")));
            FieldClass = FlowField;
        }
        field(28; "Posted Count"; Integer)
        {
            CalcFormula = count("Bank Account Ledger Entry" where("External Document No." = field("Transaction Code")));
            FieldClass = FlowField;
        }
        field(29; "Posted Receipt No"; Code[20])
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
