Table 52202560 "General Set-Up"
{
    fields
    {
        field(1; "Student Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(2; "Registration Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Primary Key"; Code[10])
        {
        }
        field(4; "Receipt Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; "Defered Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(6; "Transaction Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "Over Payment Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Pre-Payment Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Allow Posting From"; Date)
        {
        }
        field(10; "Allow Posting To"; Date)
        {
        }
        field(11; "Unallocated Rcpts Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(12; "Batch Receipts Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(13; "Medical Condition Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(14; "Attachment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(15; "Enquiry Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(16; "Application Fee"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(17; "Clearance Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(18; "Proforma Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(19; "Base Date"; Date)
        {
        }
        field(20; "Max Hours Continiously"; Decimal)
        {
        }
        field(21; "Max Hours Weekly"; Decimal)
        {
        }
        field(22; "Max Days Per Week"; Integer)
        {
        }
        field(23; "Max Lecturer Hours Daily"; Decimal)
        {
        }
        field(24; "Max Lecturer Days Per Week"; Decimal)
        {
        }
        field(25; "Applications Date Line"; Date)
        {
        }
        field(26; "Allow UnPaid Hostel Booking"; Boolean)
        {
        }
        field(28; "Impt. Unit"; Code[20])
        {
        }
        field(29; "Impt. Staff"; Code[20])
        {
        }
        field(30; "Impt. Semester"; Code[20])
        {
        }
        field(31; "Impt. Stage"; Code[20])
        {
        }
        field(32; "Impt. RegID"; Code[20])
        {
        }
        field(33; "Impt. Category"; Code[20])
        {
        }
        field(34; "Impt. Programme"; Code[20])
        {
        }
        field(35; "Pass List Label"; Text[250])
        {
        }
        field(36; "Fail List Label"; Text[250])
        {
        }
        field(37; "Supp List Label"; Text[250])
        {
        }
        field(38; "Allow Units Add. in Posted Sem"; Boolean)
        {
        }
        field(39; "Cons. Marksheet Key1"; Text[250])
        {
        }
        field(40; "Cons. Marksheet Key2"; Text[250])
        {
        }
        field(41; "Bill Supplimentary Fee"; Boolean)
        {
        }
        field(43; "CDF Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(44; "Helb Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(120; lost; Integer)
        {
        }
        field(50000; "Allowed Reg. Fees Perc."; Decimal)
        {
        }
        field(50001; "Allow Online Results Access"; Boolean)
        {
        }
        field(50002; "Current TT Code"; Code[20])
        {
        }
        field(50057; "Class Allocation Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50058; "Bar Code"; Blob)
        {
            SubType = Bitmap;
        }
        field(50059; "Visitor Number"; Code[20])
        {
        }
        field(50060; "Supplimentray Fees"; Decimal)
        {
        }
        field(50061; "Admission Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50062; "Last Bio No"; Integer)
        {
        }
        field(50052; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(50063; "Max Hostel Booking Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Marks Approval Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50066; "Tuition Waiver Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "Programme Cap.Declaration Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Programmes Capacity Declaration Numbers';
            TableRelation = "No. Series";
        }
        field(50067; "Application Fee G/Acc."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50068; "Portal Reports File Path"; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50069; "Portal Attachment File Path"; text[200])
        {
            DataClassification = ToBeClassified;
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
